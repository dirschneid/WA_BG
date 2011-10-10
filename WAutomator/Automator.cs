using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using System.Diagnostics;
using System.Threading;
using System.Drawing;
using System.Windows.Threading;

namespace WAutomator
{
    public abstract class Automator
    {
        [DllImport("User32.Dll", EntryPoint = "PostMessageA")]
        protected static extern bool PostMessage(IntPtr hWnd, uint msg, uint wParam, uint lParam);

        [DllImport("user32.dll", EntryPoint = "GetDC")]
        private static extern IntPtr GetDC(IntPtr hWnd);

        [DllImport("gdi32.dll", EntryPoint = "GetPixel")]
        private static extern uint GetPixel(IntPtr hWnd, int x, int y);

        [DllImport("user32.dll", EntryPoint = "ReleaseDC")]
        private static extern int ReleaseDC(IntPtr hWnd, IntPtr pDC);

        const int WM_KEYDOWN = 0x100;
        const int WM_KEYUP = 0x101;
        const int WM_CHAR = 0x0102;
        const int WM_LBUTTONDOWN = 0x0201;
        const int WM_LBUTTONUP = 0x0202;
        const int MK_LBUTTON = 0x0001;
        const int MK_RBUTTON = 0x0002;
        const int MK_MBUTTON = 0x0010;

        private const double KEYPRESS_TIMEOUT = 30.0;
        private const double MASTER_TICK_OFFSET = 100.0;
        private const double AFTERCASTE_TICK_OFFSET = 300.0;
        private const double TICK_DELTA = 50.0;
        private const int NOTIFICATION_POINT_X = 1;
        private const int NOTIFICATION_POINT_Y = 1;

        // -----------------------------------

        private Process m_controlledProcess;
        private DispatcherTimer m_timer = new DispatcherTimer();
        private Random m_rand = new Random(DateTime.Now.Millisecond);
        private Action<string> m_logAction;
        private Action m_tickAction;

        // -----------------------------------

        public DispatcherTimer Timer
        {
            get { return m_timer; }
            set { m_timer = value; }
        }

        protected Random Rand { get { return m_rand; } }

        public bool IsEnabled { get { return null != Timer && m_timer.IsEnabled; } }

        protected int KeypressTimeout { get { return (int)Math.Ceiling(KEYPRESS_TIMEOUT + m_rand.NextDouble() * TICK_DELTA); } }
        protected double MasterTickOffset { get { return MASTER_TICK_OFFSET + m_rand.NextDouble() * TICK_DELTA; } }
        protected double AfterCastTickOffset { get { return AFTERCASTE_TICK_OFFSET + m_rand.NextDouble() * TICK_DELTA; } }

        // -----------------------------------

        protected Automator(Process controlledProcess, Action<string> logAction = null, Action tickAction = null)
        {
            m_controlledProcess = controlledProcess;

            m_timer.Interval = TimeSpan.FromMilliseconds(MasterTickOffset);
            m_timer.Tick += new EventHandler(TickHandler);

            m_logAction = logAction;
            m_tickAction = tickAction;
        }

        public void Start()
        {
            if (!IsEnabled)
                m_timer.Start();
        }

        public void Stop()
        {
            if (IsEnabled)
                m_timer.Stop();
        }

        protected void FireLogAction(string message)
        {
            if (null != m_logAction)
                m_logAction(message);
        }

        protected void FireTickAction()
        {
            if (null != m_tickAction)
                m_tickAction();
        }

        // -----------------------------------

        protected abstract void TickHandler(object source, EventArgs args);

        // -----------------------------------

        protected void SendKey(KeyEventArgs key)
        {
            try
            {
                // Нажимаем управляющие клавиши
                if (key.Shift)
                    PostMessage(m_controlledProcess.MainWindowHandle, WM_KEYDOWN, (int)Keys.ShiftKey, 0);
                if (key.Control)
                    PostMessage(m_controlledProcess.MainWindowHandle, WM_KEYDOWN, (int)Keys.ControlKey, 0);
                if (key.Alt)
                    PostMessage(m_controlledProcess.MainWindowHandle, WM_KEYDOWN, (int)Keys.Alt, 0);

                // Нажимаем и отпускаем кнопку
                SendKey(key.KeyCode);

                // Отпускаем управляющие клавиши
                if (key.Shift)
                    PostMessage(m_controlledProcess.MainWindowHandle, WM_KEYUP, (int)Keys.ShiftKey, 0);
                if (key.Control)
                    PostMessage(m_controlledProcess.MainWindowHandle, WM_KEYUP, (int)Keys.ControlKey, 0);
                if (key.Alt)
                    PostMessage(m_controlledProcess.MainWindowHandle, WM_KEYUP, (int)Keys.Alt, 0);
            }
            catch (Exception)
            {
            }
        }

        protected void SendKey(Keys key)
        {
            try
            {
                PostMessage(m_controlledProcess.MainWindowHandle, WM_KEYDOWN, (uint)key, 0);
                Thread.Sleep(KeypressTimeout);
                PostMessage(m_controlledProcess.MainWindowHandle, WM_KEYUP, (uint)key, 0xC0000001);
            }
            catch (Exception)
            {
            }
        }

        protected void SendString(string str)
        {
            try
            {
                foreach (char ch in str)
                {
                    PostMessage(m_controlledProcess.MainWindowHandle, WM_CHAR, (uint)ch, 0);
                    Thread.Sleep(KeypressTimeout);
                }
            }
            catch (Exception)
            {
            }
        }

        protected void SendMouseLButtonClick(int x, int y)
        {
            try
            {
                SendMouseLButtonClick(x, y, m_controlledProcess.MainWindowHandle);
            }
            catch (Exception)
            {
            }
        }

        protected Color GetPixeColor(int x, int y)
        {
            return GetPixeColor(x, y, m_controlledProcess.MainWindowHandle);
        }

        public static Color GetPixeColor(int x, int y, IntPtr hWnd)
        {
            IntPtr pDC = GetDC(hWnd);
            uint pixel = GetPixel(pDC, x, y);
            ReleaseDC(hWnd, pDC);

            return Color.FromArgb(
                ((int)pixel) & 0xFF,
                (int)((pixel >> 8) & 0xFF),
                (int)((pixel >> 16) & 0xFF));
        }

        public static void SendMouseLButtonClick(int x, int y, IntPtr hWnd)
        {
            ulong dw = (((ulong)x & 0xFFFFFFFFL) << 16) | ((ulong)y & 0xFFFFFFFFL);

            //IntPtr pDC = GetDC(hWnd);
            PostMessage(hWnd, WM_LBUTTONDOWN, MK_LBUTTON, (uint)dw);
            PostMessage(hWnd, WM_LBUTTONUP, MK_LBUTTON, (uint)dw);
            //ReleaseDC(hWnd, pDC);
        }
    }
}
