Content-Type: multipart/mixed; boundary="===============4392849290312976186=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 0/4] mptcp: refactor token container
Date: Fri, 26 Jun 2020 16:22:31 -0700
Message-ID: <20200626.162231.1590461076613614486.davem@davemloft.net>
In-Reply-To: cover.1593192442.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4837

--===============4392849290312976186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Fri, 26 Jun 2020 19:29:58 +0200

> Currently the msk sockets are stored in a single radix tree, protected by=
 a
> global spin_lock. This series moves to an hash table, allocated at boot t=
ime,
> with per bucker spin_lock - alike inet_hashtables, but using a different =
key:
> the token itself.
> =

> The above improves scalability, as write operations will have a far later=
 chance
> to compete for lock acquisition, allows lockless lookup, and will allow
> easier msk traversing - e.g. for diag interface implementation's sake.
> =

> This also introduces trivial, related, kunit tests and move the existing =
in
> kernel's one to kunit.
> =

> v1 -> v2:
>  - fixed a few extra and sparse warns

Series applied, thanks Paolo.
--===============4392849290312976186==--
