using System;
using System.Collections.Generic;
using System.Text;
using QUT.Gppg;

namespace LuaObfuscator
{
    public class Location : IMerge<Location>
    {
        private int m_tokLin;
        private int m_tokCol;
        private int m_tokELin;
        private int m_tokECol;
        private int m_tokPos;
        private int m_tokEPos;

        public int StartLine { get { return m_tokLin; } }
        public int StartColumn { get { return m_tokCol; } }
        public int EndLine { get { return m_tokELin; } }
        public int EndColumn { get { return m_tokECol; } }
        public int StartPosition { get { return m_tokPos; } }
        public int EndPosition { get { return m_tokEPos; } }

        public Location()
        {
        }

        public Location(int tokLin, int tokCol, int tokELin, int tokECol, int tokPos, int tokEPos)
        {
            m_tokLin = tokLin;
            m_tokCol = tokCol;
            m_tokELin = tokELin;
            m_tokECol = tokECol;
            m_tokPos = tokPos;
            m_tokEPos = tokEPos;
        }

        public Location Merge(Location last)
        {
            return new Location(this.StartLine, this.StartColumn, last.EndLine, last.EndColumn, this.StartPosition, last.EndPosition);
        }
    }
}
