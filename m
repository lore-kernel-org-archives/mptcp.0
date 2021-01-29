Content-Type: multipart/mixed; boundary="===============1607928246378584802=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3] mptcp: fix length of MP_PRIO suboption
Date: Fri, 29 Jan 2021 18:08:22 +0100
Message-ID: <2db70998-7504-c244-9feb-0abe3055918e@tessares.net>
In-Reply-To: 07135f8a644672e1847788341e39f6dd25b1c32c.1611852408.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7535

--===============1607928246378584802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Mat,

On 28/01/2021 18:34, Davide Caratti wrote:
> With version 0 of the protocol it was legal to encode the 'Subflow Id' in
> the MP_PRIO suboption, to specify which subflow would change its 'Backup'
> flag. This has been removed from v1 specification: thus, according to RFC
> 8684 =C2=A73.3.8, the resulting 'Length' for MP_PRIO changed from 4 to 3 =
byte.
> =

> Current Linux generates / parses MP_PRIO according to the old spec, using
> 'Length' equal to 4, and hardcoding 1 as 'Subflow Id'; RFC compliance can
> improve if we change 'Length' in other to become 3, leaving a 'Nop' after
> the MP_PRIO suboption. In this way the kernel will emit and accept *only*
> MP_PRIO suboptions that are compliant to version 1 of the MPTCP protocol.

Thank you for this new version!

Just added in our tree, at the bottom, with Mat and my RvB tag.

- 91384be37ad9 mptcp: fix length of MP_PRIO suboption

Tests + export have been almost a success! Simult Flow selftest with a =

debug kernel was unstable but it is not new, see:

   https://github.com/multipath-tcp/mptcp_net-next/issues/137

So feel free to send this patch to netdev when you have the opportunity  ;-)
It doesn't conflict with other pending patches from Geliang that have =

been recently sent by Mat.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1607928246378584802==--
