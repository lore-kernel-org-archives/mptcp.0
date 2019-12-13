Content-Type: multipart/mixed; boundary="===============0500588740018703393=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 0/4] mptcp: [try to] fix armegaddon on late
 tcp fallback
Date: Fri, 13 Dec 2019 15:48:33 +0100
Message-ID: <4d48bf9802a04cefe3d66c10795068135a0d214f.camel@redhat.com>
In-Reply-To: cover.1576247361.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2941

--===============0500588740018703393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-13 at 15:33 +0100, Paolo Abeni wrote:
> Passive connection can fallback to TCP after that the subflow is establis=
hed.
> That leads to disaster in several nasty ways.
> =

> Address the issue explicitly falling back to TCP (converting the socket) =
as
> soon as we notice the unsuccessful MPC hanshake completion.
> =

> Sent as a very early RFC - completely untested yet.
> =

> Paolo Abeni (4):
>   mptcp: add helper to forcefully fallback the msk socket to TCP
>   mptcp: cache the first subflow sock
>   mptcp: late fallback support
>   mptcp: deal with fallback in additional places.
> =

>  net/mptcp/protocol.c | 92 +++++++++++++++++++++++++++++++++++++-------
>  net/mptcp/protocol.h |  1 +
>  2 files changed, 79 insertions(+), 14 deletions(-)

Addendum: the code is split in several patches to hopefully simplify
the review/feedback. Iif there is agreement on that, idea would be
squashing these 4 patches in a single one and append it to part 3 (v1
support), as the issue fixed here arise only with MPTCP v1.

Thanks,

Paolo

--===============0500588740018703393==--
