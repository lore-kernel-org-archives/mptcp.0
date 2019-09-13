Content-Type: multipart/mixed; boundary="===============3919334118020559460=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: remove token_release
Date: Fri, 13 Sep 2019 17:34:19 +0200
Message-ID: <f2c9dd39-d305-b5a6-c763-e99e1e88b00d@tessares.net>
In-Reply-To: 20190910155348.23244-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1844

--===============3919334118020559460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Sorry for the delay.

On 10/09/2019 17:53, Florian Westphal wrote:
> This patch removes token_release and gets rid of the extra sock_put/hold
> calls in token.c.
> =

> Instead its the responsibility of the subflow to make sure that the master
> mptcp socket (referenced via subflow_ctx->conn) can't go away and is
> released once the subflow is being destroyed.
> =

> Also, switch mptcp_shutdown to sk_common_release to plug a reference leak,
> this part is taken from Paolos early patch
> "mptcp: fix mptcp socket cleanup", this proposal is an alternative.
> =

> Token destruction is moved to mptcp_close -- the rationale is that
> we want to remove the token as soon as we know we can't accept any more
> subflows.
> =

> NB: I suspect we eventually need to extend join operations to check
> that the mptcp socket obtained from looking up has following properties:
>  - nonzero refcount (refcount_inc_not_zero instead of sock_hold)
>  - is still in established state.
> =

>  But at this time I feel its better to wait until we support DATA_FIN
>  before worrying about this.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>

Do you want me to add it at the end of squash in another commit?
I was going to add it at the end but the commit message seems to show
that it should be squashed in another commit.

Paolo proposed cd2d4eeca99b ("mptcp: Add key generation and token tree")
in his initial commit. Should I do that too?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============3919334118020559460==--
