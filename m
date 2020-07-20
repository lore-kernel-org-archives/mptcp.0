Content-Type: multipart/mixed; boundary="===============4039014103210469266=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] Squash-to: "mptcp: make msk established at
 remote key reception time"
Date: Mon, 20 Jul 2020 17:51:37 +0200
Message-ID: <31f4cbc2-1abe-a11f-a45e-c1b2ec9141fe@tessares.net>
In-Reply-To: 672ee216582b6b67960fd618c3ed8d75497e0cd6.1595242203.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5126

--===============4039014103210469266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 20/07/2020 12:50, Paolo Abeni wrote:
> Commit message should be rewritten enterily, comprising the title:
> '''
> mptcp: explicitly track the fully established status
> =

> Currently accepted msk sockets become established only after
> accept() returns the new sk to user-space.
> =

> As MP_JOIN request are refused as per RFC spec on non fully
> established socket, the above causes mp_join self-tests
> instabilities.
> =

> This change lets the msk entering the established status
> as soon as it receives the 3rd ack and propagates the first
> subflow fully established status on the msk socket.
> =

> Finally we can change the subflow acceptance condition to
> take in account both the sock state and the msk fully
> established flag.
> =

> '''
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> v1 -> v2:
>   - add missing read_once/write_once on fully_established access

Thank you for the patch and the review!

- e405018681d0: "squashed" in "mptcp: make msk established at remote key =

reception time"
- 86cc99a3e2bd: tg:msg: rewrote commit message
- b8a0c13ffff2..72a81073a595: result

Tests + export are going to be started soon!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4039014103210469266==--
