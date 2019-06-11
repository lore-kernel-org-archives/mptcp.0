Content-Type: multipart/mixed; boundary="===============3182819233986565166=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 2/2] mptcp: Refactor mptcp_established_options()
 to single hook
Date: Tue, 11 Jun 2019 14:59:16 +0200
Message-ID: <9a0cdb47-2e5c-b230-5034-7c54e6aa6108@tessares.net>
In-Reply-To: 20190608004040.3426-3-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1331

--===============3182819233986565166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo, Mat,

On 08/06/2019 02:40, Peter Krystad wrote:
> Make there be only one callout from tcp_output.c for this hook.
> Includes refactoring from the first patch of the MP_JOIN RFC.
> =

> squashto: Write MPTCP DSS headers

Thank you for the new version of the patch and the reviews!

- 98555b04a8d9: "squashed" in "mptcp: Write MPTCP DSS headers to
outgoing data packets"
- da0f223d5698: signed-off
- no conflicts
- 7311dd424a7e..fc816436135c: result

Note that I had to do an extra modification to fix a compilation issue
when CONFIG_MPTCP is not set, see 6e78ea220386 (mptcp: fix compilation
without CONFIG_MPTCP) or below:

> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>  include/net/mptcp.h   | 21 ++++++---------------
>  net/ipv4/tcp_output.c | 20 +++++---------------
>  net/mptcp/options.c   | 40 +++++++++++++++++++++++++++++++---------
>  3 files changed, 42 insertions(+), 39 deletions(-)
> =

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index d84489adbd86..ec3d7f7e5f45 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -57,13 +57,11 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
>  bool mptcp_syn_options(struct sock *sk, unsigned int *size,
>  			       struct mptcp_out_options* opts);
>  void mptcp_rcv_synsent(struct sock *sk);
> -bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
> -				   unsigned int *size, unsigned int remaining,
> -				   struct mptcp_out_options* opts);
>  bool mptcp_synack_options(const struct request_sock *req, unsigned int *=
size,
>  			  struct mptcp_out_options *opts);
> -bool mptcp_established_options(struct sock *sk, unsigned int *size,
> -				       struct mptcp_out_options *opts);
> +bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> +			       unsigned int *size, unsigned int remaining,
> +			       struct mptcp_out_options* opts);
>  =

>  void mptcp_attach_dss(struct sock *sk, struct sk_buff *skb,
>  		      struct tcp_options_received *opt_rx);
> @@ -106,15 +104,6 @@ static inline void mptcp_rcv_synsent(struct sock *sk)
>  {
>  }
>  =

> -static inline bool mptcp_established_options_dss(struct sock *sk,
> -						 struct sk_buff *skb,
> -						 unsigned int *size,
> -						 unsigned int remaining,
> -						 struct mptcp_out_options* opts)
> -{
> -	return false;
> -}
> -
>  static inline bool mptcp_synack_options(const struct request_sock *req,
>  					unsigned int *size,
>  					struct mptcp_out_options *opts)
> @@ -123,8 +112,10 @@ static inline bool mptcp_synack_options(const struct=
 request_sock *req,
>  }
>  =

>  static inline bool mptcp_established_options(struct sock *sk,
> +					     struct sk_buff *skb,
>  					     unsigned int *size,
> -					     struct mptcp_out_options *opts)
> +					     unsigned int remaining,
> +					     struct mptcp_out_options* opts);

I had to remove the semi-colon at the end of this line to fix a
compilation issue.

Please also note that I saw checkpatch.pl forces us to place the star
next to the variable name:

   struct mptcp_out_options *opts

instead of

   struct mptcp_out_options* opts

I will try to fix a maximum of these checkpatch.pl issues once the
MP_JOIN support is added in our repo and before sending patches to Eric.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============3182819233986565166==--
