Content-Type: multipart/mixed; boundary="===============8437997021294836072=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Fwd: [martineau:kbuild-mptcp 22/38] subflow.c:undefined
 reference to `__crypto_memneq'
Date: Mon, 20 Jan 2020 10:49:13 +0100
Message-ID: <48a83812-3670-ed88-7a75-7ea0a1c86438@tessares.net>
In-Reply-To: e630651f1e645b5b7fa24c79630d7edf97b79a47.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3425

--===============8437997021294836072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat, Paolo,

On 19/01/2020 15:07, Paolo Abeni wrote:
> On Fri, 2020-01-17 at 16:27 -0800, Mat Martineau wrote:
>> On Sat, 18 Jan 2020, Florian Westphal wrote:
>>
>>> ----- Forwarded message from kbuild test robot <lkp(a)intel.com> -----
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux=
.git kbuild-mptcp
>>> head:   c4ccdd8177fb3d8123dd294ae93ee2dac1f43f32
>>> commit: ccd5b6ef8fd4b37a7721231a55482523b07d7ef9 [22/38] mptcp: Add han=
dling of incoming MP_JOIN requests
>>> config: xtensa-common_defconfig (attached as .config)
>>> compiler: xtensa-linux-gcc (GCC) 7.5.0
>>> reproduce:
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         git checkout ccd5b6ef8fd4b37a7721231a55482523b07d7ef9
>>>         # save the attached .config to linux build tree
>>>         GCC_VERSION=3D7.5.0 make.cross ARCH=3Dxtensa
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kbuild test robot <lkp(a)intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    net/mptcp/subflow.o: In function `subflow_ulp_release':
>>>>> subflow.c:(.text+0x41c): undefined reference to `__crypto_memneq'
>>>    net/mptcp/subflow.o: In function `subflow_syn_recv_sock':
>>>    subflow.c:(.text+0x53a): undefined reference to `__crypto_memneq'
>>>
>>> Hmpf.  The .config has CONFIG_CRYPTO=3Dn and then the symbol doesn't
>>> exist.
>>>
>>> So we have two choices:
>>> - select CRYPTO from Kconfig
>>> - use plain memcmp as before (might reveal info about key though)
>>> - copypaste a similar function into mptcp.
>>>
>>> What do you think?
>>
>> I prefer selecting CRYPTO over copy/paste.
> =

> I agree with 'select CRYPTO=3Dy'

Me too.

Florian: do you ask the question because you think we can have issues or =

comments from net maintainers when forcing the selection of CRYPTO for =

MPTCP?

Do we plan to do this modification in "mptcp: Add handling of incoming =

MP_JOIN requests" commit (part 3) or before (part 2, when starting using =

functions from CRYPTO, e.g. "mptcp: Add key generation and token tree")?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8437997021294836072==--
