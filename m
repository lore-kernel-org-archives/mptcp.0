Content-Type: multipart/mixed; boundary="===============3919712456539206294=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: refactor shutdown and
 close"
Date: Sat, 17 Oct 2020 09:56:53 +0200
Message-ID: <9cd2d63d-efc4-07a8-5d10-2e9127a2dab5@tessares.net>
In-Reply-To: fffd74384126974bb9f56303948000f11b0b291f.1602794093.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6341

--===============3919712456539206294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat, Christoph,

On 15/10/2020 23:28, Paolo Abeni wrote:
> After the refactor __mptcp_close_ssk() can be invoked on
> orphaned TCP socket, so we can't wait a timeout, or
> sk_stream_wait_close() will oops due to NULL waitqueue.
> =

> We can simply always use a 0 timeout (and clean-up the
> related signature accordingly): the timeout, if any,
> is used before by mptcp_close().

Thank you for the patch, review and validation!

- e3514ae223bd: "squashed" (with conflicts) in "mptcp: refactor shutdown =

and close"
- a563fd15f543: conflict in =

t/mptcp-move-page-frag-allocation-in-mptcp_sendmsg
- Results: b160e00bdf28..a26726f4d29b

Tests + export are going to be started soon!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3919712456539206294==--
