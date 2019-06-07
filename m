Content-Type: multipart/mixed; boundary="===============0100073075549293291=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 3/7] mptcp: reduce number of pr_debug() calls.
Date: Fri, 07 Jun 2019 13:23:10 +0200
Message-ID: <de4ed870-bd2d-1e02-99a5-3cd02bdcf337@tessares.net>
In-Reply-To: 20190606003632.2863-4-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1309

--===============0100073075549293291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 06/06/2019 02:36, Peter Krystad wrote:
> squash to: Create SUBFLOW socket for incoming connections

Thank you for the patch and the review!

- 17c4b4cad16d: "squash" in "mptcp: Create SUBFLOW socket for incoming
connections": I didn't take one diff, see below
- signed-off was already there
- 5d1039667868: "squash" (part 2) in "mptcp: accept: don't leak mptcp
socket structure"
- no conflict
- 0569a65aca45..eec1d25d9283: result

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>  net/mptcp/options.c  | 6 +++---
>  net/mptcp/protocol.c | 5 +----
>  2 files changed, 4 insertions(+), 7 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 7475c1d5c15f..b259c4343f36 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -339,14 +339,14 @@ bool mptcp_synack_options(const struct request_sock=
 *req, unsigned int *size,
>  {
>  	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
>  =

> -	pr_debug("subflow_req=3D%p", subflow_req);
>  	if (subflow_req->mp_capable) {
>  		opts->suboptions =3D OPTION_MPTCP_MPC_SYNACK;
>  		opts->sndr_key =3D subflow_req->local_key;
>  		opts->rcvr_key =3D subflow_req->remote_key;
>  		*size =3D TCPOLEN_MPTCP_MPC_SYNACK;
> -		pr_debug("local_key=3D%llu", subflow_req->local_key);
> -		pr_debug("remote_key=3D%llu", subflow_req->remote_key);
> +		pr_debug("subflow_req=3D%p, local_key=3D%llu, remote_key=3D%llu",
> +			 subflow_req, subflow_req->local_key,
> +			 subflow_req->remote_key);
>  		return true;
>  	}
>  	return false;
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 902b6c994f00..78ce42b1617a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -596,9 +596,7 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
>  		return NULL;
>  =

>  	subflow =3D subflow_ctx(new_sock->sk);
> -	pr_debug("new subflow=3D%p", subflow);
> -
> -	pr_debug("new msk=3D%p", msk);
> +	pr_debug("msk=3D%p, new subflow=3D%p, ", msk, subflow);
>  =

>  	if (subflow->mp_capable) {
>  		struct sock *new_mptcp_sock;
> @@ -623,7 +621,6 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
>  		msk->remote_key =3D subflow->remote_key;
>  		msk->local_key =3D subflow->local_key;
>  		msk->token =3D subflow->token;
> -		pr_debug("token=3D%u", msk->token);

This pr_debug() has been added after, in "mptcp: Implement MPTCP receive
path". I then moved this change to the next patch (4/7).

Cheers,
Matt

>  		token_update_accept(new_sock->sk, new_mptcp_sock);
>  		msk->subflow =3D NULL;
>  =

> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0100073075549293291==--
