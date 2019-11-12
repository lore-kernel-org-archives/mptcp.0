Content-Type: multipart/mixed; boundary="===============8601022111443120516=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 4/6] options: ack pending sequence
Date: Mon, 11 Nov 2019 16:55:35 -0800
Message-ID: <alpine.OSX.2.21.1911111646501.7818@mjmartin-mac01.local>
In-Reply-To: 20191108220953.30904-5-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2478

--===============8601022111443120516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 8 Nov 2019, Florian Westphal wrote:

> This allows us to include some of the bytes already pending on the subflow
> in the DSS ack instead of having to wait for the next recv (which
> updates msk->ack_seq value).
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/options.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 80dbe7662cea..b488bf07ada5 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -418,13 +418,20 @@ static bool mptcp_established_options_dss(struct so=
ck *sk, struct sk_buff *skb,
> 		ack_size +=3D TCPOLEN_MPTCP_DSS_BASE;
>
> 	if (ack_size <=3D remaining) {
> +		const struct mptcp_subflow_context *subflow;
> 		struct mptcp_sock *msk;
>
> 		dss_size +=3D ack_size;
>
> -		msk =3D mptcp_sk(mptcp_subflow_ctx(sk)->conn);
> +		subflow =3D mptcp_subflow_ctx(sk);
> +		msk =3D mptcp_sk(subflow->conn);
> 		if (msk) {
> -			opts->ext_copy.data_ack =3D msk->ack_seq;
> +			u64 ack_seq =3D READ_ONCE(msk->ack_seq);
> +
> +			if (subflow->map_valid)
> +				ack_seq +=3D subflow->data_avail;

I'm not sure this works well with multiple subflows. It could ack a later =

sequence number on this subflow, then send an earlier sequence number in a =

bare ack on another subflow. They should be close enough that the earlier =

seq would be ignored, but it would be better to send consistent acks.

Mat


> +
> +			opts->ext_copy.data_ack =3D ack_seq;
> 		} else {
> 			mptcp_crypto_key_sha1(mptcp_subflow_ctx(sk)->remote_key,
> 					      NULL, &opts->ext_copy.data_ack);
> -- =

> 2.23.0
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============8601022111443120516==--
