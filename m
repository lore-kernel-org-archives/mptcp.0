Content-Type: multipart/mixed; boundary="===============4100502667747324261=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC 10/11] mptcp: enable JOIN requests even if
 cookies are in use
Date: Wed, 15 Jul 2020 17:14:02 +0200
Message-ID: <2e429ba0e48baa93a33c52c51abed51eb2ca56d5.camel@redhat.com>
In-Reply-To: 20200714182514.25250-11-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5020

--===============4100502667747324261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-07-14 at 20:25 +0200, Florian Westphal wrote:
> JOIN requests do not work in syncookie mode -- for HMAC validation,
> the remote peers nonce is required, but this nonce is only present
> in the SYN.
> =

> This makes the subflow request initialisation to store the request
> socket even when syncookies are used.
> =

> Following restrictions apply:
> 1. The (32bit) token contained in the MP_JOIN SYN packet returns
>    a valid parent connection.
> 2. The parent connection can accept one more subflow.
> =

> To ensure 2), all MP_JOIN requests (new incoming and existing)
> are accounted in the mptcp parent socket.
> =

> If the token is invalid or the parent cannot accept a new subflow,
> no information is stored and TCP fallback path is used.
> =

> XXX: subflow_init_req() sk_listener argument has 'const' qualifier,
> this patch currently uses a 'void *' cast in order to add the rsk to
> the listener socket.
> =

> The parent socket can't be used without further changes in TCP stack,
> because socket creation after 3whs completion checks that the associated
> socket is in LISTEN state.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/pm_netlink.c |  2 +-
>  net/mptcp/protocol.h   |  2 ++
>  net/mptcp/subflow.c    | 57 +++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 57 insertions(+), 4 deletions(-)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index c8820c4156e6..117f794ecc54 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -41,7 +41,7 @@ struct pm_nl_pernet {
>  	unsigned int		next_id;
>  };
>  =

> -#define MPTCP_PM_ADDR_MAX	8
> +#define MPTCP_PM_ADDR_MAX	MPTCP_SUBFLOWS_MAX
>  =

>  static bool addresses_equal(const struct mptcp_addr_info *a,
>  			    struct mptcp_addr_info *b, bool use_port)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index cf74305c1d42..847dfa597809 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -154,6 +154,8 @@ enum mptcp_pm_status {
>  	MPTCP_PM_SUBFLOW_ESTABLISHED,
>  };
>  =

> +#define MPTCP_SUBFLOWS_MAX	8
> +
>  struct mptcp_pm_data {
>  	struct mptcp_addr_info local;
>  	struct mptcp_addr_info remote;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 943fa650f1e9..c06e16f9cc8e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -126,6 +126,46 @@ static int __subflow_check_options(const struct mptc=
p_options_received *mp_opt,
>  	return 0;
>  }
>  =

> +static bool mptcp_join_store(struct mptcp_subflow_request_sock *req, str=
uct sock *sk_listener)
> +{
> +	struct mptcp_sock *msk =3D req->msk;
> +	struct inet_connection_sock *icsk;
> +	struct sock *sk;
> +
> +	icsk =3D &msk->sk;
> +	sk =3D &icsk->icsk_inet.sk;
> +
> +	if (inet_csk_reqsk_queue_len(sk) >=3D MPTCP_SUBFLOWS_MAX)
> +		return false;

Isn't this test a little too relaxed? e.g. shouldn't we check something
alike:

	if (inet_csk_reqsk_queue_len(sk) + READ_ONCE(pm->subflows) >
	    READ_ONCE(pm->subflows_max))

Possibly we can account the pending MP_JOIN subflows in a new PM field,
so we could do the above check and the follow-up increment in a
consistent way with a single atomic opetation (the pm spinlock)

/P

--===============4100502667747324261==--
