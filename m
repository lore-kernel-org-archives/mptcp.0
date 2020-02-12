Content-Type: multipart/mixed; boundary="===============4020639518349170988=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] subflow.c:undefined reference to `__crypto_memneq' (fwd)
Date: Tue, 11 Feb 2020 16:10:26 -0800
Message-ID: <alpine.OSX.2.22.394.2002111530220.16674@echiprou-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3622

--===============4020639518349170988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


I pushed the current export branch to my git.kernel.org repo, which =

triggered the following result.

We've seen this before from a kbuild in January:

https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/thread/65P5YLV2JE=
R3QGQIM2746SFK6NGTV2DS/

The conclusion was to add a "select CRYPTO" to the mptcp Kconfig in =

"mptcp: Add handling of incoming MP_JOIN requests", but we haven't updated =

the code yet. I'll send a patch.

The .config does have CONFIG_MPTCP=3Dy, even though that's not in the nios2 =

defconfig. I think that means the kbuild team is setting CONFIG_MPTCP in =

their builds.

Mat


---------- Forwarded message ----------
Date: Tue, 11 Feb 2020 15:06:40
From: kbuild test robot <lkp(a)intel.com>
Subject: [martineau:kbuild-mptcp 3/19] subflow.c:undefined reference to
     `__crypto_memneq'

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git=
 kbuild-mptcp
head:   e4b7e3a8c3a2f84c554b656bbb7ce0b96de6c33f
commit: 98c5c4c35ea6464188e8c343f0441e231e000d2e [3/19] mptcp: Add handling=
 of incoming MP_JOIN requests
config: nios2-3c120_defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 7.5.0
reproduce:
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin=
/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         git checkout 98c5c4c35ea6464188e8c343f0441e231e000d2e
         # save the attached .config to linux build tree
         GCC_VERSION=3D7.5.0 make.cross ARCH=3Dnios2

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp(a)intel.com>

All errors (new ones prefixed by >>):

    net/mptcp/subflow.o: In function `subflow_syn_recv_sock':
>> subflow.c:(.text+0x790): undefined reference to `__crypto_memneq'
    subflow.c:(.text+0x790): relocation truncated to fit: R_NIOS2_CALL26 ag=
ainst `__crypto_memneq'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============4020639518349170988==--
