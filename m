Content-Type: multipart/mixed; boundary="===============3997045212442635322=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: more stable diag self-tests
Date: Fri, 07 Aug 2020 17:25:58 -0700
Message-ID: <20200807.172558.1135066576835187335.davem@davemloft.net>
In-Reply-To: 80f1f6d16da4542e825d9aca1949d6169d77104c.1596817814.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5524

--===============3997045212442635322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Fri,  7 Aug 2020 18:31:00 +0200

> During diag self-tests we introduce long wait in the mptcp test
> program to give the script enough time to access the sockets
> dump.
> =

> Such wait is introduced after shutting down one sockets end. Since
> commit 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state
> machine") if both sides shutdown the socket is correctly transitioned
> into CLOSED status.
> =

> As a side effect some sockets are not dumped via the diag interface,
> because the socket state (CLOSED) does not match the default filter, and
> this cause self-tests instability.
> =

> Address the issue moving the above mentioned wait before shutting
> down the socket.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/68
> Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
> Tested-and-acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied, thanks.
--===============3997045212442635322==--
