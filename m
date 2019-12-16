Content-Type: multipart/mixed; boundary="===============4449519642948964299=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: Handle MP_CAPABLE options for
 outgoing connections"
Date: Mon, 16 Dec 2019 14:05:18 -0800
Message-ID: <alpine.OSX.2.21.1912161358400.6806@mjmartin-mac01.local>
In-Reply-To: 5bc1ab81d4c3eed1a2ad8b5b83069bacc980a8ee.1576531578.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3094

--===============4449519642948964299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Dec 2019, Paolo Abeni wrote:

> mptcp_established_options() definition will be changed in a couple of pat=
ches,
> let's introduce early it's final form
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> include/net/mptcp.h   | 5 ++++-
> net/ipv4/tcp_output.c | 9 ++++-----
> net/mptcp/options.c   | 3 ++-
> 3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index d7af03848f5a..588abcb76da3 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -55,7 +55,8 @@ bool mptcp_syn_options(struct sock *sk, unsigned int *s=
ize,
> void mptcp_rcv_synsent(struct sock *sk);
> bool mptcp_synack_options(const struct request_sock *req, unsigned int *s=
ize,
> 			  struct mptcp_out_options *opts);
> -bool mptcp_established_options(struct sock *sk, unsigned int *size,
> +bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> +			       unsigned int *size, unsigned int remaining,
> 			       struct mptcp_out_options *opts);
>
> void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts);
> @@ -104,7 +105,9 @@ static inline bool mptcp_synack_options(const struct =
request_sock *req,
> }
>
> static inline bool mptcp_established_options(struct sock *sk,
> +					     struct sk_buff *skb,
> 					     unsigned int *size,
> +					     unsigned int remaining,
> 					     struct mptcp_out_options *opts)
> {
> 	return false;
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index a4bf1197f577..d123d67026d5 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -798,11 +798,10 @@ static unsigned int tcp_established_options(struct =
sock *sk, struct sk_buff *skb
> 		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> 		unsigned int opt_size =3D 0;
>
> -		if (mptcp_established_options(sk, &opt_size, &opts->mptcp)) {
> -			if (remaining >=3D opt_size) {

This length check goes away... (see below)

> -				opts->options |=3D OPTION_MPTCP;
> -				size +=3D opt_size;
> -			}
> +		if (mptcp_established_options(sk, skb, &opt_size, remaining,
> +					      &opts->mptcp)) {
> +			opts->options |=3D OPTION_MPTCP;
> +			size +=3D opt_size;
> 		}
> 	}
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 26203dfb6be6..89aef0d0beb1 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -196,7 +196,8 @@ void mptcp_rcv_synsent(struct sock *sk)
> 	}
> }
>
> -bool mptcp_established_options(struct sock *sk, unsigned int *size,
> +bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> +			       unsigned int *size, unsigned int remaining,
> 			       struct mptcp_out_options *opts)
> {
> 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);

...but doesn't get added to mptcp_established_options() until 5 patches =

later. At this point the function only handles MP_CAPABLE, so maybe =

there's not much risk of overrunning the option space anyway.

> -- =

> 2.21.0
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============4449519642948964299==--
