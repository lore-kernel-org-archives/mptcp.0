Content-Type: multipart/mixed; boundary="===============9043409748487698285=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Fwd: [martineau:kbuild-mptcp 22/38] subflow.c:undefined
 reference to `__crypto_memneq'
Date: Mon, 20 Jan 2020 22:44:33 +0100
Message-ID: <8a3cccf1-a88e-37a5-1f83-fee8d4df0337@tessares.net>
In-Reply-To: 20200120162041.GD795@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3436

--===============9043409748487698285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 20/01/2020 17:20, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>>> I prefer selecting CRYPTO over copy/paste.
>>>
>>> I agree with 'select CRYPTO=3Dy'
>>
>> Me too.
>>
>> Florian: do you ask the question because you think we can have issues or
>> comments from net maintainers when forcing the selection of CRYPTO for
>> MPTCP?
> =

> I think its fine, tcpmd5 and ipsec select it too.

Good point, thank you for your reply.
Many are doing that, e.g. in net: bluetooth, ceph, mac80211, mac802154, =

rxrpc, sctp, tipc, tls, xfrm.

>> Do we plan to do this modification in "mptcp: Add handling of incoming
>> MP_JOIN requests" commit (part 3) or before (part 2, when starting using
>> functions from CRYPTO, e.g. "mptcp: Add key generation and token tree")?
> =

> I'm currently travelling so I can't comment which commit makes the most
> sense.  It should be added when the first crypto functions are used, I
> think.

Here is what I saw:

- "mptcp: Add key generation and token tree" commit introduces crypto.c =

but it only uses functions from lib/: sha_init(), sha_transform()

- "mptcp: move from sha1 (v0) to sha256 (v1)" commit is using sha256 =

primitives from include/crypto/sha.h, e.g. sha256_init() instead of =

function from crypto module. Paolo already added CRYPTO_LIB_SHA256 (and =

not CRYPTO_SHA256).

- "mptcp: Add handling of incoming MP_JOIN requests" commit is using =

"crypto_memneq" which needs CRYPTO.

So if I'm not mistaken, we need CRYPTO only for part 3.

Please tell me if I miss something :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============9043409748487698285==--
