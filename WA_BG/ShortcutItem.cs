using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WAutomator;

namespace WA_BG
{
    [Serializable]
    public struct ShortcutItem
    {
        public KeyEventArgs Shortcut { get { return new KeyEventArgs(Key); } set { Key = value.KeyData; } }
        public Keys Key;
        /// <summary>
        /// Интервал между нажатиями (в секундах).
        /// </summary>
        public double Timeout;
        /// <summary>
        /// Время, оставшееся до нажатия (в миллисекундах).
        /// </summary>
        public double TimeLeft;
        public string Comment;

        public string ShortcutText { get { return ColorAndKeyPair.FormatKey(Shortcut); } }
        public void ResetTimeout()
        {
            TimeLeft = Timeout;
        }
    }
}
