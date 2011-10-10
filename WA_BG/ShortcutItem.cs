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
        public int Timeout;
        public int TimeLeft;
        public string Comment;

        public string ShortcutText { get { return ColorAndKeyPair.FormatKey(Shortcut); } }
    }
}
