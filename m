Content-Type: multipart/mixed; boundary="===============8407889313767832598=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 2/2] mptcp: Refactor mptcp_established_options()
 to single hook
Date: Mon, 10 Jun 2019 16:24:55 -0700
Message-ID: <alpine.OSX.2.21.1906101621110.6965@mjmartin-mac01.local>
In-Reply-To: 20190608004040.3426-3-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1325

--===============8407889313767832598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 7 Jun 2019, Peter Krystad wrote:

> Make there be only one callout from tcp_output.c for this hook.
> Includes refactoring from the first patch of the MP_JOIN RFC.
>
> squashto: Write MPTCP DSS headers
>
> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
> include/net/mptcp.h   | 21 ++++++---------------
> net/ipv4/tcp_output.c | 20 +++++---------------
> net/mptcp/options.c   | 40 +++++++++++++++++++++++++++++++---------
> 3 files changed, 42 insertions(+), 39 deletions(-)

...

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cad1702323a3..a5a6772f1268 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c

...

> @@ -339,6 +338,29 @@ bool mptcp_established_options_dss(struct sock *sk, =
struct sk_buff *skb,
> 	return true;
> }
>
> +bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> +			       unsigned int *size, unsigned int remaining,
> +			       struct mptcp_out_options *opts)
> +{
> +	unsigned int opt_size =3D 0;
> +
> +	if (!subflow_ctx(sk)->mp_capable)
> +		return false;
> +
> +	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts)) {
> +		*size +=3D opt_size;
> +		remaining -=3D opt_size;
> +		return true;
> +	} else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
> +					       opts)) {
> +		*size +=3D opt_size;
> +		remaining -=3D opt_size;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> bool mptcp_synack_options(const struct request_sock *req, unsigned int *s=
ize,
> 			  struct mptcp_out_options *opts)
> {

Given that you're thinking of introducing changes in the mp vs. dss code =

blocks above, and have consolidated the mp_capable check, this looks ready =

to merge. Thanks, Peter.

--
Mat Martineau
Intel

--===============8407889313767832598==--
