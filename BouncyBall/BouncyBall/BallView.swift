import ScreenSaver

class PongView: ScreenSaverView {

    private var ballPosition: CGPoint = .zero
    private var ballPosition1: CGPoint = .zero
    private var ballVelocity: CGVector = .zero
    private var ballVelocity1: CGVector = .zero
    private var paddlePosition: CGFloat = 0
    private let ballRadius: CGFloat = 50
    private let ballRadius1: CGFloat = 50

    // MARK: - Initialization
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        ballPosition = CGPoint(x: CGFloat.random(in: (0 + ballRadius)...(bounds.width - ballRadius)), y: CGFloat.random(in: (0 + ballRadius)...(bounds.height - ballRadius)))
        ballPosition1 = CGPoint(x: CGFloat.random(in: (0 + ballRadius1)...(bounds.width - ballRadius1)), y: CGFloat.random(in: (0 + ballRadius1)...(bounds.height - ballRadius1)))
        ballVelocity = initialVelocity()
        ballVelocity1 = initialVelocity()
    }

    @available(*, unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func draw(_ rect: NSRect) {
        drawBackground(.black)
        drawBall()
        drawBall1()
    }

    override func animateOneFrame() {

        let oobAxes = ballIsOOB()
        if oobAxes.xAxis {
            ballVelocity.dx *= -1
        }
        if oobAxes.yAxis {
            ballVelocity.dy *= -1
        }
        
        let oobAxes1 = ballIsOOB1()
        if oobAxes1.xAxis {
            ballVelocity1.dx *= -1
        }
        if oobAxes1.yAxis {
            ballVelocity1.dy *= -1
        }
        
        let colli = collision();
        if colli {
            
            var newVelX1 = (ballVelocity.dx * (ballRadius - ballRadius1) + (2 * ballRadius1 * ballVelocity1.dx)) / (ballRadius + ballRadius1)
            var newVelY1 = (ballVelocity.dy * (ballRadius - ballRadius1) + (2 * ballRadius1 * ballVelocity1.dy)) / (ballRadius + ballRadius1)
            var newVelX2 = (ballVelocity1.dx * (ballRadius1 - ballRadius) + (2 * ballRadius * ballVelocity.dx)) / (ballRadius1 + ballRadius)
            var newVelY2 = (ballVelocity1.dy * (ballRadius1 - ballRadius) + (2 * ballRadius * ballVelocity.dy)) / (ballRadius1 + ballRadius)
            
            ballVelocity.dx = newVelX1
            ballVelocity.dy = newVelY1
            ballVelocity1.dx = newVelX2
            ballVelocity1.dy = newVelY2
            
        }
        
        
            
        ballPosition.x += ballVelocity.dx
        ballPosition.y += ballVelocity.dy
        ballPosition1.x += ballVelocity1.dx
        ballPosition1.y += ballVelocity1.dy
        
        super.animateOneFrame()
        setNeedsDisplay(bounds)

        
    }

    // MARK: - Helper Functions
    private func drawBackground(_ color: NSColor) {
        let background = NSBezierPath(rect: bounds)
        color.setFill()
        background.fill()
    }
    private func drawBall() {
        let ballRect = NSRect(x: ballPosition.x - ballRadius,
                              y: ballPosition.y - ballRadius,
                              width: ballRadius * 2,
                              height: ballRadius * 2)
        let ball = NSBezierPath(roundedRect: ballRect,
                                xRadius: ballRadius,
                                yRadius: ballRadius)
        NSColor.orange.setFill()
        ball.fill()
    }
    
    private func drawBall1() {
        let ballRect = NSRect(x: ballPosition1.x - ballRadius1,
                              y: ballPosition1.y - ballRadius1,
                              width: ballRadius * 2,
                              height: ballRadius * 2)
        let ball = NSBezierPath(roundedRect: ballRect,
                                xRadius: ballRadius1,
                                yRadius: ballRadius1)
        NSColor.red.setFill()
        ball.fill()
    }

    private func initialVelocity() -> CGVector {
        let desiredVelocityMagnitude: CGFloat = 10
        let xVelocity = CGFloat.random(in: 2.5...7.5)
        let xSign: CGFloat = Bool.random() ? 1 : -1
        let yVelocity = sqrt(pow(desiredVelocityMagnitude, 2) - pow(xVelocity, 2))
        let ySign: CGFloat = Bool.random() ? 1 : -1
        return CGVector(dx: xVelocity * xSign, dy: yVelocity * ySign)
    }

    private func ballIsOOB() -> (xAxis: Bool, yAxis: Bool) {
        let xAxisOOB = ballPosition.x - ballRadius <= 0 ||
            ballPosition.x + ballRadius >= bounds.width
        let yAxisOOB = ballPosition.y - ballRadius <= 0 ||
            ballPosition.y + ballRadius >= bounds.height
        return (xAxisOOB, yAxisOOB)
    }
    
    private func ballIsOOB1() -> (xAxis: Bool, yAxis: Bool) {
        let xAxisOOB = ballPosition1.x - ballRadius1 <= 0 ||
            ballPosition1.x + ballRadius1 >= bounds.width
        let yAxisOOB = ballPosition1.y - ballRadius1 <= 0 ||
            ballPosition1.y + ballRadius1 >= bounds.height
        return (xAxisOOB, yAxisOOB)
    }
    
    private func collision() -> Bool {
        let colliding = sqrt( square(num: Double(ballPosition.x - ballPosition1.x)) + square(num: Double(Int(ballPosition.y - ballPosition1.y)))) <= Double(ballRadius+ballRadius1)
        
        return colliding
    }
    
    private func square(num: Double) -> Double {
        return num * num
    }

}
