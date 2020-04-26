Content-Type: multipart/mixed; boundary="===============4973073517530802584=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix race in msk status update
Date: Sat, 25 Apr 2020 20:40:14 -0700
Message-ID: <20200425.204014.4915249663374846.davem@davemloft.net>
In-Reply-To: 4d5e3c09ca38a0a3ec951fa4f5bfc65d5cd40129.1587725562.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4249

--===============4973073517530802584==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Fri, 24 Apr 2020 13:15:21 +0200

> Currently subflow_finish_connect() changes unconditionally
> any msk socket status other than TCP_ESTABLISHED.
> =

> If an unblocking connect() races with close(), we can end-up
> triggering:
> =

> IPv4: Attempt to release TCP socket in state 1 00000000e32b8b7e
> =

> when the msk socket is disposed.
> =

> Be sure to enter the established status only from SYN_SENT.
> =

> Fixes: c3c123d16c0e ("net: mptcp: don't hang in mptcp_sendmsg() after TCP=
 fallback")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied, thanks.
--===============4973073517530802584==--
