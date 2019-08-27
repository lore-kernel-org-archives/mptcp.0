Content-Type: multipart/mixed; boundary="===============5272733566906220201=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 08/10] mptcp: token: add error handling for
 token_new_accept
Date: Tue, 27 Aug 2019 18:59:45 +0200
Message-ID: <90a07742-4a1a-a3b7-56fd-9fbaf884e944@tessares.net>
In-Reply-To: 20190825185939.21596-9-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1716

--===============5272733566906220201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

Just a detail :)

On 25/08/2019 20:59, Florian Westphal wrote:
> Insertion into radix tree might fail, so add error handling for this.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.h |  2 +-
>  net/mptcp/subflow.c  |  5 ++++-
>  net/mptcp/token.c    | 31 +++++++++++++++----------------
>  3 files changed, 20 insertions(+), 18 deletions(-)
> =

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7db59830a02a..a1e207db6703 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -232,7 +232,7 @@ bool mptcp_token_join_valid(const struct request_sock=
 *req,
>  			    const struct tcp_options_received *rx_opt);
>  void token_destroy_request(u32 token);
>  int mptcp_token_new_connect(struct sock *sk);
> -void token_new_accept(struct sock *sk);
> +int mptcp_token_new_accept(u32 token);
>  void mptcp_token_update_accept(struct sock *sk, struct sock *conn);
>  struct mptcp_sock *mptcp_token_get_sock(u32 token);
>  void token_release(u32 token);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index a57bb6546261..85fb7a52e274 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -217,7 +217,10 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
>  			goto close_child;
>  =

>  		if (ctx->mp_capable) {
> -			token_new_accept(child);
> +			int ret =3D mptcp_token_new_accept(ctx->token);
> +
> +			if (ret)

Detail: do we really need "ret" here? I mean maybe you added the
variable to use it somewhere else?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============5272733566906220201==--
