Content-Type: multipart/mixed; boundary="===============6334591836940291502=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] diag: fix use-after-free Read in
 inet_diag_lock_handler
Date: Fri, 03 Jul 2020 21:21:52 +0200
Message-ID: <34e3c4b5-38cb-9fc9-d476-17badf1736c3@tessares.net>
In-Reply-To: 20200703190656.2611535-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4911

--===============6334591836940291502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph, Paolo

On 03/07/2020 21:06, Matthieu Baerts wrote:
> From: Christoph Paasch <cpaasch(a)apple.com>
> =

> Syzkaller reported this:
> =

> (...)
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/44
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Thank you for the patch and the review!

Just applied:

- 679d6f510486: "squashed" in "inet_diag: support for wider protocol =

numbers"
- 2596401ff92a: "Signed-off-by" + "Co-developed-by"
- 2740cccad3aa + 27bff9d83d8c + 1be53f1b75d5 + 098f1c381adc: tg:msg: =

signoff of the author at the end
- 2051bf32b07e..0ec7680b7e39: result

Tests + export are in progress.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6334591836940291502==--
