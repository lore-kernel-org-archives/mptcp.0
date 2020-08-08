Content-Type: multipart/mixed; boundary="===============3629602713948969822=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix warn at shutdown time for
 unaccepted msk sockets
Date: Fri, 07 Aug 2020 17:26:41 -0700
Message-ID: <20200807.172641.1534600180926439646.davem@davemloft.net>
In-Reply-To: 2458c1210f1a164c615e3aa3b9613b085a6c8326.1596819537.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5525

--===============3629602713948969822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Fri,  7 Aug 2020 19:03:53 +0200

> With commit b93df08ccda3 ("mptcp: explicitly track the fully
> established status"), the status of unaccepted mptcp closed in
> mptcp_sock_destruct() changes from TCP_SYN_RECV to TCP_ESTABLISHED.
> =

> As a result mptcp_sock_destruct() does not perform the proper
> cleanup and inet_sock_destruct() will later emit a warn.
> =

> Address the issue updating the condition tested in mptcp_sock_destruct().
> Also update the related comment.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/66
> Reported-and-tested-by: Christoph Paasch <cpaasch(a)apple.com>
> Fixes: b93df08ccda3 ("mptcp: explicitly track the fully established statu=
s")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Also applied, thank you.
--===============3629602713948969822==--
