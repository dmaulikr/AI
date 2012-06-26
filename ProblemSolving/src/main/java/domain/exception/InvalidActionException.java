package domain.exception;

public class InvalidActionException extends RuntimeException {

	private static final long serialVersionUID = -1625050432695754220L;

	public InvalidActionException(String arg0, Throwable arg1) {
		super(arg0, arg1);
	}

	public InvalidActionException(String arg0) {
		super(arg0);
	}
	
}
