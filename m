Content-Type: multipart/mixed; boundary="===============4441882348534297680=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: don't leak msk in token container
Date: Wed, 10 Jun 2020 12:04:04 +0200
Message-ID: <88f6e442-44a7-c33f-33ab-f88c90c35514@tessares.net>
In-Reply-To: f52cfae0ddacd91b37a804f19a6ffa2f79efe56f.1591778889.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4633

--===============4441882348534297680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 10/06/2020 10:49, Paolo Abeni wrote:
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
--===============4441882348534297680==--
