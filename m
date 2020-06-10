Content-Type: multipart/mixed; boundary="===============8347043715777401310=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix races between shutdown and recvmsg
Date: Wed, 10 Jun 2020 12:04:00 +0200
Message-ID: <f9ae8422-583f-24d3-c5f4-776f24e788dc@tessares.net>
In-Reply-To: 766c50ce4e7e0415adaf0c63e3f92e75abb8470c.1591778786.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4632

--===============8347043715777401310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 10/06/2020 10:47, Paolo Abeni wrote:
> The msk sk_shutdown flag is set by a workqueue, possibly
> introducing some delay in user-space notification. If the last
> subflow carries some data with the fin packet, the user space
> can wake-up before RCV_SHUTDOWN is set. If it executes unblocking
> recvmsg(), it may return with an error instead of eof.
> =

> Address the issue explicitly checking for eof in recvmsg(), when
> no data is found.
> =

> Fixes: 59832e246515 ("mptcp: subflow: check parent mptcp socket on subflo=
w state change")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Thank you for the patch, it looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8347043715777401310==--
