Content-Type: multipart/mixed; boundary="===============4318281502721477074=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Fwd: [martineau:kbuild-mptcp 22/38] subflow.c:undefined
 reference to `__crypto_memneq'
Date: Fri, 17 Jan 2020 16:27:41 -0800
Message-ID: <alpine.OSX.2.21.2001171618020.68065@sjshaw-mobl.amr.corp.intel.com>
In-Reply-To: 20200118000536.GY795@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3415

--===============4318281502721477074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Sat, 18 Jan 2020, Florian Westphal wrote:

> ----- Forwarded message from kbuild test robot <lkp(a)intel.com> -----
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.g=
it kbuild-mptcp
> head:   c4ccdd8177fb3d8123dd294ae93ee2dac1f43f32
> commit: ccd5b6ef8fd4b37a7721231a55482523b07d7ef9 [22/38] mptcp: Add handl=
ing of incoming MP_JOIN requests
> config: xtensa-common_defconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 7.5.0
> reproduce:
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin=
/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        git checkout ccd5b6ef8fd4b37a7721231a55482523b07d7ef9
>        # save the attached .config to linux build tree
>        GCC_VERSION=3D7.5.0 make.cross ARCH=3Dxtensa
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp(a)intel.com>
>
> All errors (new ones prefixed by >>):
>
>   net/mptcp/subflow.o: In function `subflow_ulp_release':
>>> subflow.c:(.text+0x41c): undefined reference to `__crypto_memneq'
>   net/mptcp/subflow.o: In function `subflow_syn_recv_sock':
>   subflow.c:(.text+0x53a): undefined reference to `__crypto_memneq'
>
> Hmpf.  The .config has CONFIG_CRYPTO=3Dn and then the symbol doesn't
> exist.
>
> So we have two choices:
> - select CRYPTO from Kconfig
> - use plain memcmp as before (might reveal info about key though)
> - copypaste a similar function into mptcp.
>
> What do you think?

I prefer selecting CRYPTO over copy/paste. Plain memcmp does not seem =

suitable.

--
Mat Martineau
Intel
--===============4318281502721477074==--
