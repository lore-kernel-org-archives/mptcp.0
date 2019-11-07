Content-Type: multipart/mixed; boundary="===============8446449094343907218=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/2] mptcp: parse and emit MP_CAPABLE option
 according to v1 spec.
Date: Thu, 07 Nov 2019 16:54:34 +0100
Message-ID: <d18c4fe0322f7f7bdc302a30bdca4a920b019dda.camel@redhat.com>
In-Reply-To: 20191107152827.54549-2-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2439

--===============8446449094343907218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2019-11-07 at 07:28 -0800, Christoph Paasch wrote:
> @@ -356,28 +387,66 @@ void mptcp_rcv_synsent(struct sock *sk)
>  	}
>  }
>  =

> -static bool mptcp_established_options_mp(struct sock *sk, unsigned int *=
size,
> +static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff=
 *skb,
> +					 unsigned int *size,
>  					 unsigned int remaining,
>  					 struct mptcp_out_options *opts)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> +	struct mptcp_ext *mpext;
> +	unsigned int data_len;
> +
> +	pr_debug("subflow=3D%p fourth_ack=3D%d seq=3D%x:%x remaining=3D%d", sub=
flow,
> +		 subflow->fourth_ack, subflow->snd_isn,
> +		 skb ? TCP_SKB_CB(skb)->seq : 0, remaining);
> +
> +	if (subflow->mp_capable && !subflow->fourth_ack && skb &&
> +	    subflow->snd_isn =3D=3D TCP_SKB_CB(skb)->seq) {
> +		/* When skb is not available, we better over-estimate the
> +		 * emitted options len. A full DSS option is longer than
> +		 * TCPOLEN_MPTCP_MPC_ACK_DATA, so let's the caller try to fit
> +		 * that.
> +		 */
>  =

> -	if (subflow->mp_capable && !subflow->fourth_ack &&
> -	    remaining >=3D TCPOLEN_MPTCP_MPC_ACK) {
> -		opts->suboptions =3D OPTION_MPTCP_MPC_ACK;
> -		opts->sndr_key =3D subflow->local_key;
> -		opts->rcvr_key =3D subflow->remote_key;
> -		*size =3D TCPOLEN_MPTCP_MPC_ACK;
> -		subflow->fourth_ack =3D 1;
> -		pr_debug("subflow=3D%p, local_key=3D%llu, remote_key=3D%llu",
> -			 subflow, subflow->local_key, subflow->remote_key);
> -		return true;
> +		mpext =3D mptcp_get_ext(skb);
> +		data_len =3D mpext ? mpext->data_len : 0;
> +		/* Section 3.1.
> +		 * The MP_CAPABLE option is carried on the SYN, SYN/ACK, and ACK
> +		 * packets that start the first subflow of an MPTCP connection,
> +		 * as well as the first packet that carries data
> +		 */
> +		if (data_len > 0 && remaining >=3D TCPOLEN_MPTCP_MPC_ACK_DATA) {

It's not clear to me which is the expected behavior when we can't fit
MPTCP options inside the TCP header. As the maximum MP_CAPABLE/MP_JOIN
opt len is 24 bytes, and we have at most 16 bytes in the previous opt
(tstamp, md5) it looks like this can't ever happen, so could emit a
WARN_ON_ONCE() here?

BTW we currently emit a warn if DSS exceeds the TCP option space, and
that can actually happen (max DSS without csum is 26 bytes, with csum
28). Perhaps we could switch to 32 bits seq if we hit such condition?

Cheers,

Paolo

--===============8446449094343907218==--
