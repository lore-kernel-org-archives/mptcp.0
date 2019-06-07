Content-Type: multipart/mixed; boundary="===============3244707393601104607=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 7/7] mptcp: Refactor mptcp_established_options()
 to single hook
Date: Fri, 07 Jun 2019 14:42:32 -0700
Message-ID: <alpine.OSX.2.21.1906071427180.31255@prwest-mobl2.amr.corp.intel.com>
In-Reply-To: 20190606003632.2863-8-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1315

--===============3244707393601104607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 5 Jun 2019, Peter Krystad wrote:

> Make there only be one callout from tcp_output.c for this.
> Includes refactoring from the first patch in the MP_JOIN RFC.
>
> squash to: Write MPTCP DSS headers
>
> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
> include/net/mptcp.h   | 21 ++++++---------------
> net/ipv4/tcp_output.c | 21 ++++++---------------
> net/mptcp/options.c   | 36 ++++++++++++++++++++++++++++++------
> 3 files changed, 42 insertions(+), 36 deletions(-)
>

...

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 98d582207cb0..f06ca0c48e57 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c

...

> @@ -338,6 +341,27 @@ bool mptcp_established_options_dss(struct sock *sk, =
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
> +	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts)) {
> +		*size +=3D opt_size;
> +		remaining -=3D opt_size;
> +		return true;
> +	}
> +	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
> +					       opts)) {
> +		*size +=3D opt_size;
> +		remaining -=3D opt_size;
> +		return true;
> +	}

Given that the code for both clauses is the same, maybe

if (mptcp_established_options_mp(...) ||
     mptcp_established_options_dss(...)) {
     *size +=3D opt_size;
     remaining -=3D opt_size;
     return true;
}

would reduce duplication.

Since the DSS variant is the common case, I was tempted to suggest =

collapsing all the MP and DSS code in to this one function. I don't think =

that makes a real difference since the compiler will probably inline =

everything anyway.

I agree with Paolo's suggestion to do a single, early mp_capable check.

> +
> +	return false;
> +}
> +
> bool mptcp_synack_options(const struct request_sock *req, unsigned int *s=
ize,
> 			  struct mptcp_out_options *opts)
> {


--
Mat Martineau
Intel

--===============3244707393601104607==--
