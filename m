Content-Type: multipart/mixed; boundary="===============1912145167514540906=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: init mptcp request socket earlier
Date: Wed, 03 Feb 2021 09:26:20 -0800
Message-ID: <20210203172620.GG43803@MacBook-Pro.local>
In-Reply-To: f512d230984510ab2ccbc4e778da4474bd2e1078.1612367293.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7613

--===============1912145167514540906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 02/03/21 - 17:28, Paolo Abeni wrote:
> The mptcp subflow route_req() callback performs the subflow
> req initialization after the route_req() check. If the latter
> fails, mptcp-specific bits of the current request sockets
> are left uninitialized.
> =

> The above causes bad things at req socket disposal time, when
> the mptcp resources are cleared.
> =

> This change addresses the issue by splitting subflow_init_req()
> into the actual initialization and the mptcp-specific checks.
> The initialization is moved before any possibly failing check.
> =

> Reported-by: Christoph Paasch <cpaasch(a)apple.com>
> Fixes: 7ea851d19b23 ("tcp: merge 'init_req' and 'route_req' functions")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> Should fix issues/125 && 130. Even syzkaller would proof the
> opposite, the problem described above looks real.
> @Christoph: could you please... ? (additional free coffee for your
> upcoming holiday in Tuscany ;)

Looking forward to the coffee!!! :-) I hope coffee translates to red wine
later in the day!


Christoph

--===============1912145167514540906==--
