Content-Type: multipart/mixed; boundary="===============8277355136215494112=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: don't leak msk in token container
Date: Wed, 10 Jun 2020 16:10:10 -0700
Message-ID: <20200610.161010.1999273694493899789.davem@davemloft.net>
In-Reply-To: f52cfae0ddacd91b37a804f19a6ffa2f79efe56f.1591778889.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4645

--===============8277355136215494112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Wed, 10 Jun 2020 10:49:00 +0200

> If a listening MPTCP socket has unaccepted sockets at close
> time, the related msks are freed via mptcp_sock_destruct(),
> which in turn does not invoke the proto->destroy() method
> nor the mptcp_token_destroy() function.
> =

> Due to the above, the child msk socket is not removed from
> the token container, leading to later UaF.
> =

> Address the issue explicitly removing the token even in the
> above error path.
> =

> Fixes: 79c0949e9a09 ("mptcp: Add key generation and token tree")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Also applied and queued up for v5.6 -stable, thanks.
--===============8277355136215494112==--
