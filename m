Content-Type: multipart/mixed; boundary="===============2971083413744802772=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix races between shutdown and recvmsg
Date: Wed, 10 Jun 2020 16:06:04 -0700
Message-ID: <20200610.160604.1148281043237238325.davem@davemloft.net>
In-Reply-To: 766c50ce4e7e0415adaf0c63e3f92e75abb8470c.1591778786.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4644

--===============2971083413744802772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Wed, 10 Jun 2020 10:47:41 +0200

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

Applied, thanks Paolo.
--===============2971083413744802772==--
