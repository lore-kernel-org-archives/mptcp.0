Content-Type: multipart/mixed; boundary="===============7471305074391857538=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: be careful on subflow creation
Date: Wed, 05 Aug 2020 12:25:08 -0700
Message-ID: <20200805.122508.1983611145468632689.davem@davemloft.net>
In-Reply-To: 61e82de664dffde9ff445ed6f776d6809b198693.1596558566.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5493

--===============7471305074391857538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Tue,  4 Aug 2020 18:31:06 +0200

> Nicolas reported the following oops:
 ...
> on some unconventional configuration.
> =

> The MPTCP protocol is trying to create a subflow for an
> unaccepted server socket. That is allowed by the RFC, even
> if subflow creation will likely fail.
> Unaccepted sockets have still a NULL sk_socket field,
> avoid the issue by failing earlier.
> =

> Reported-and-tested-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>
> Fixes: 7d14b0d2b9b3 ("mptcp: set correct vfs info for subflows")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied and queued up for v5.7+ -stable, thank you.
--===============7471305074391857538==--
