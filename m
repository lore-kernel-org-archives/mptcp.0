Content-Type: multipart/mixed; boundary="===============1342217363992096002=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 11/13] mptcp: allow picking different
 xmit subflows
Date: Fri, 11 Sep 2020 19:34:58 +0200
Message-ID: <1cf4fa90e9e459901598207261423cc9d88dd9d0.camel@redhat.com>
In-Reply-To: 3b8e364293d3cbb0348f20ca14301200aa43bc24.1599832097.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5823

--===============1342217363992096002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-09-11 at 15:52 +0200, Paolo Abeni wrote:
 [...]
> +#define MPTCP_SEND_BURST_SIZE		((1 << 16) - \
> +					 sizeof(struct tcphdr) - \
> +					 MAX_TCP_OPTION_SPACE - \
> +					 sizeof(struct ipv6hdr) - \
> +					 sizeof(struct frag_hdr))
> +
> +struct subflow_send_info {
> +	struct sock *ssk;
> +	uint64_t ratio;
> +};
> +
>  static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
>  					   u32 *sndbuf)
>  {
> +	struct subflow_send_info send_info[2];
>  	struct mptcp_subflow_context *subflow;
> -	struct sock *sk =3D (struct sock *)msk;
> -	struct sock *backup =3D NULL;
> -	bool free;
> +	int i, nr_active =3D 0;
> +	int64_t ratio, pace;
> +	struct sock *ssk;
>  =

> -	sock_owned_by_me(sk);
> +	sock_owned_by_me((struct sock *)msk);
>  =

>  	*sndbuf =3D 0;
>  	if (!mptcp_ext_cache_refill(msk))
>  		return NULL;
>  =

> -	mptcp_for_each_subflow(msk, subflow) {
> -		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> -
> -		free =3D sk_stream_is_writeable(subflow->tcp_sock);
> -		if (!free) {
> -			mptcp_nospace(msk);
> +	if (__mptcp_check_fallback(msk)) {
> +		if (!msk->first)
>  			return NULL;
> +		*sndbuf =3D msk->first->sk_sndbuf;
> +		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
> +	}
> +
> +	/* re-use last subflow, if the burst allow that */
> +	if (msk->last_snd && msk->snd_burst > 0 &&
> +	    sk_stream_memory_free(msk->last_snd) &&
> +	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
> +		mptcp_for_each_subflow(msk, subflow) {
> +			ssk =3D  mptcp_subflow_tcp_sock(subflow);
> +			*sndbuf =3D max(tcp_sk(ssk)->snd_wnd, *sndbuf);
>  		}
> +		return msk->last_snd;
> +	}
> +
> +	/* pick the subflow with the lower wmem/wspace ratio */
> +	for (i =3D 0; i < 2; ++i) {
> +		send_info[i].ssk =3D NULL;
> +		send_info[i].ratio =3D -1;
> +	}
> +	mptcp_for_each_subflow(msk, subflow) {
> +		ssk =3D  mptcp_subflow_tcp_sock(subflow);
> +		if (!mptcp_subflow_active(subflow))
> +			continue;
>  =

> +		nr_active +=3D !subflow->backup;
>  		*sndbuf =3D max(tcp_sk(ssk)->snd_wnd, *sndbuf);
> -		if (subflow->backup) {
> -			if (!backup)
> -				backup =3D ssk;
> +		if (!sk_stream_memory_free(subflow->tcp_sock))
> +			continue;
>  =

> +		pace =3D READ_ONCE(ssk->sk_pacing_rate);
> +		if (!pace)
>  			continue;
> -		}
>  =

> -		return ssk;
> +		ratio =3D (int64_t)READ_ONCE(ssk->sk_wmem_queued) << 32 / pace;

Kbuild bot on our devel branch just noted that the above division
breaks 32 bits build.

I'll fix that in v2.

Cheers,

Paolo

--===============1342217363992096002==--
