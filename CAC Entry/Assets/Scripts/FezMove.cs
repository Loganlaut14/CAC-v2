using UnityEngine;
using System.Collections;

public class FezMove : MonoBehaviour
{

    private int Horizontal = 0;

    public Animator anim;
    public float MovementSpeed = 5f;
    public float Gravity = 1f;
    float startGravity;
    float oldY;
    public CharacterController charController;
    private FacingDirection _myFacingDirection;
    public float JumpHeight = 0f;
    public bool _jumping = false;
    private float degree = 0;
    [SerializeField] private AnimationCurve jumpFallOff;

    private void Start()
    {
        startGravity = Gravity;
        oldY = transform.position.y;
    }
    public FacingDirection CmdFacingDirection
    {

        set
        {
            _myFacingDirection = value;
        }

    }

    // Update is called once per frame
    void Update()
    {

        if (Input.GetAxis("Horizontal") < 0)
            Horizontal = -1;
        else if (Input.GetAxis("Horizontal") > 0)
            Horizontal = 1;
        else
            Horizontal = 0;

        if (Input.GetKeyDown(KeyCode.Space) && !_jumping && Grounded())
        {
            _jumping = true;
            StartCoroutine(JumpEvent());
        }

        if (anim)
        {

            float moveFactor = MovementSpeed * Time.deltaTime * 10f;
            MoveCharacter(moveFactor);

        }

        transform.rotation = Quaternion.Slerp(transform.rotation, Quaternion.Euler(0, degree, 0), 8 * Time.deltaTime);

    }

    private void MoveCharacter(float moveFactor)
    {
        Vector3 trans = Vector3.zero;
        if (oldY > transform.position.y)
        {
            Gravity = startGravity * 20.5f;
        }
        else
        {
            Gravity = startGravity;
        }
        oldY = transform.position.y;
        if (_myFacingDirection == FacingDirection.Front)
        {
            trans = new Vector3(Horizontal * moveFactor, -Gravity * moveFactor, 0f);
        }
        else if (_myFacingDirection == FacingDirection.Right)
        {
            trans = new Vector3(0f, -Gravity * moveFactor, Horizontal * moveFactor);
        }
        else if (_myFacingDirection == FacingDirection.Back)
        {
            trans = new Vector3(-Horizontal * moveFactor, -Gravity * moveFactor, 0f);
        }
        else if (_myFacingDirection == FacingDirection.Left)
        {
            trans = new Vector3(0f, -Gravity * moveFactor, -Horizontal * moveFactor);
        }

        // Old jumping script \/

        if (_jumping)
        {
            if (!Input.GetButton("Jump"))
            {
                _jumping = false;
                goto Skip;
            }
            //transform.Translate(Vector3.up * JumpHeight * Time.deltaTine);
        }

        Skip:
        charController.SimpleMove(trans);
    }
    public void UpdateToFacingDirection(FacingDirection newDirection, float angle)
    {

        _myFacingDirection = newDirection;
        degree = angle;

    }

    public IEnumerator JumpEvent()
    {
        float timeInAir = 0.0f;

        do
        {
            float jumpForce = jumpFallOff.Evaluate(timeInAir);
            Debug.Log("Here");
            charController.Move(Vector3.up * jumpForce * JumpHeight * Time.deltaTime);
            timeInAir += Time.deltaTime;
            yield return null;

        } while (!charController.isGrounded && Input.GetButton("Jump"));

        _jumping = false;
    }
    public bool Grounded()
    {
        RaycastHit hit;
        if (Physics.Raycast(transform.position, -transform.up, out hit, 1.0f))
        {
            Debug.Log("Grounded");
            return true;
        }
        return false;
    }
}