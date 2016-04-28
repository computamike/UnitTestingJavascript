using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace UnitTestLibrary
{
    [TestFixture ]
    public class NunitTestExample
    {
        [Test]
        public void SampleNunitTest()
        {
            Console.WriteLine("Test Output");
        }
    }
}
