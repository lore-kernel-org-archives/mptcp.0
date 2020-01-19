Content-Type: multipart/mixed; boundary="===============5343012848969032646=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Fwd: [martineau:kbuild-mptcp 22/38] subflow.c:undefined
 reference to `__crypto_memneq'
Date: Sun, 19 Jan 2020 15:07:38 +0100
Message-ID: <e630651f1e645b5b7fa24c79630d7edf97b79a47.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.2001171618020.68065@sjshaw-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3422

--===============5343012848969032646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-01-17 at 16:27 -0800, Mat Martineau wrote:
> On Sat, 18 Jan 2020, Florian Westphal wrote:
> =

> > ----- Forwarded message from kbuild test robot <lkp(a)intel.com> -----
> > =

> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux=
.git kbuild-mptcp
> > head:   c4ccdd8177fb3d8123dd294ae93ee2dac1f43f32
> > commit: ccd5b6ef8fd4b37a7721231a55482523b07d7ef9 [22/38] mptcp: Add han=
dling of incoming MP_JOIN requests
> > config: xtensa-common_defconfig (attached as .config)
> > compiler: xtensa-linux-gcc (GCC) 7.5.0
> > reproduce:
> >        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
> >        chmod +x ~/bin/make.cross
> >        git checkout ccd5b6ef8fd4b37a7721231a55482523b07d7ef9
> >        # save the attached .config to linux build tree
> >        GCC_VERSION=3D7.5.0 make.cross ARCH=3Dxtensa
> > =

> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp(a)intel.com>
> > =

> > All errors (new ones prefixed by >>):
> > =

> >   net/mptcp/subflow.o: In function `subflow_ulp_release':
> > > > subflow.c:(.text+0x41c): undefined reference to `__crypto_memneq'
> >   net/mptcp/subflow.o: In function `subflow_syn_recv_sock':
> >   subflow.c:(.text+0x53a): undefined reference to `__crypto_memneq'
> > =

> > Hmpf.  The .config has CONFIG_CRYPTO=3Dn and then the symbol doesn't
> > exist.
> > =

> > So we have two choices:
> > - select CRYPTO from Kconfig
> > - use plain memcmp as before (might reveal info about key though)
> > - copypaste a similar function into mptcp.
> > =

> > What do you think?
> =

> I prefer selecting CRYPTO over copy/paste. =


I agree with 'select CRYPTO=3Dy'

/P

--===============5343012848969032646==--
