Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3CA2572
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 10:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663583757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l77fS51Em7FmiwckZytRv5EyM14xAUbTw7AioMfTCNE=;
	b=V3TwZ/n7Pta65KG6He4j4KC0e0MbnMVhu9UeOn2b4RApT8VkTqJz48QsV5dx4f1xPGw1Ag
	eTry8eJ+Rz3n+6zhl3q4+isBAkLZO6dj9QIcaQjmb/MJcoHVKIgkN8QTS3R6zj9OvpgNeM
	rKK9Y0lb9S6F44QI5BeioMyTVPJZSuU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-496-Xn4N6D7hMgyuPEBExZTcfA-1; Mon, 19 Sep 2022 06:35:56 -0400
X-MC-Unique: Xn4N6D7hMgyuPEBExZTcfA-1
Received: by mail-qt1-f198.google.com with SMTP id fx6-20020a05622a4ac600b0035a70ba1cbcso21474982qtb.21
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 03:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=l77fS51Em7FmiwckZytRv5EyM14xAUbTw7AioMfTCNE=;
        b=teWkE4jr95EGwuQoPQ0Guace/pJmoY9C38+P2TFSeLaLkgrAxi33MHwWu+T4roxRUq
         dsTv1FH8w+d8iK7u1XNdST3jovPbcn5e1b3xH3ajnBQOtjG7ydLOYH0eKdvBypQLCWmi
         yEZ9+VG3aEtfVpFSv/mRE9BMvpvog5jIq8m0ng3RFskLEFzXe8Ki/utCEzzrvWAIwhU6
         h+IiwUKHED8gPwE/ivZPuLu3D4EPHP+bkB4gyC58BwZ/HT0vixrNK21/eKMvIzFiu5DJ
         yp8DnUMN8jIJ4Ez+UokIXL2PgWAkq9cmZlGsiriz3PayU2uKGq4eZ/vzxubObxY+GNeK
         3d7A==
X-Gm-Message-State: ACrzQf2298QVEWUpC0oVfX3mdnFORiTjhGE7b4FTydzL1Bd7drOwdUyX
	8tV1/lcDBciGSWjRA/Lzl1APq6bMmWPBsHP35yplwSLDGsnu/PGPJt2F92wMMrEbaGkcEOpFFjk
	ePjK0uvDbn1Ezlzs=
X-Received: by 2002:a05:622a:1003:b0:344:b4cc:b5f with SMTP id d3-20020a05622a100300b00344b4cc0b5fmr14512368qte.301.1663583755868;
        Mon, 19 Sep 2022 03:35:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6/7HMKoOxz1idlPu+yZ4dB5wuZ8HHXdG9Zyy3sXfxdDdvNG6+PfmjRFJJ4Io244H0eIyOAhg==
X-Received: by 2002:a05:622a:1003:b0:344:b4cc:b5f with SMTP id d3-20020a05622a100300b00344b4cc0b5fmr14512354qte.301.1663583755611;
        Mon, 19 Sep 2022 03:35:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a404a00b006b98315c6fbsm13109111qko.1.2022.09.19.03.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 03:35:55 -0700 (PDT)
Message-ID: <e1e8bfbc5f3ba023e01354e62c4f3a28f69c0bca.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v7 03/11] Initiator: MSG_FASTOPEN
 sendto(). request cookie
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 19 Sep 2022 12:35:52 +0200
In-Reply-To: <20220917222853.2406-4-dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
	 <20220917222853.2406-4-dmytro@shytyi.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
> Initiator: MSG_FASTOPEN in sendto triggers the mptcp_sendsmg_fastopen.
> It requests a MPTFO cookie.
> Suggestion @palbeni(JAN 17): 'split the patch in several small one'.

Minor nit: the above line is not needed here. You can add this
"changelog" related info after the '---' separator, so that they will
not land in git.
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  net/mptcp/fastopen.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.c |  4 ++--
>  net/mptcp/protocol.h |  6 ++++++
>  3 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index 0c9ef6f5d528..9974508e0f4c 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -3,3 +3,53 @@
>   */
>  
>  #include "protocol.h"
> +
> +int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
> +			   size_t len, struct mptcp_sock *msk,

No need to pass both 'sk' and 'msk', they are the same ptr casted to
different types. Just pass 'sk' and then:

	struct mptcp_sock *msk = mptcp_sk(sk);

> +			   size_t *copied)
> +{
> +	const struct iphdr *iph;
> +	struct ubuf_info *uarg;
> +	struct sockaddr *uaddr;
> +	struct sk_buff *skb;
> +	struct tcp_sock *tp;
> +	struct socket *ssk;

The above variable name is misleading. 'ssk' should be a 'struct sock',
you should use 'ssock' for subflow 'struct socket'.

I think it's better to use a 'struct sock', you could do:

	ssk = msk->first;
	if (unlikely(ssk))
		return -EINVAL;

> +	int ret;
> +
> +	ssk = __mptcp_nmpc_socket(msk);
> +	if (unlikely(!ssk))
> +		goto out_EFAULT;

See the above.

> +	skb = tcp_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
> +	if (unlikely(!skb))
> +		goto out_EFAULT;
> +	iph = ip_hdr(skb);
> +	if (unlikely(!iph))
> +		goto out_EFAULT;

Use only lower case for macro names. Also EFAULT is probably not a good
return value. EINVAL should fit better. More importantly, it looks like
this check is not needed ?!?

> +	uarg = msg_zerocopy_realloc(sk, len, skb_zcopy(skb));

We don't support zerocopy yet, so the above is not needed.

> +	if (unlikely(!uarg))
> +		goto out_EFAULT;
> +	uaddr = msg->msg_name;
> +
> +	tp = tcp_sk(ssk->sk);

simply:
	tp = tcp_sk(ssk);

> +	if (unlikely(!tp))
> +		goto out_EFAULT;

Check not needed

> +	if (!tp->fastopen_req)
> +		tp->fastopen_req = kzalloc(sizeof(*tp->fastopen_req),
> +					   ssk->sk->sk_allocation);
> +
> +	if (unlikely(!tp->fastopen_req))
> +		goto out_EFAULT;
> +	tp->fastopen_req->data = msg;
> +	tp->fastopen_req->size = len;
> +	tp->fastopen_req->uarg = uarg;
> +
> +	/* requests a cookie */
> +	ret = mptcp_stream_connect(sk->sk_socket, uaddr,
> +				   msg->msg_namelen, msg->msg_flags);
> +	if (!ret)
> +		*copied = len;
> +	return ret;
> +out_EFAULT:
> +	ret = -EFAULT;
> +	return ret;
> +}
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0e5db0a634d3..af99a03021c9 100644
> 	--- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1672,9 +1672,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	int ret = 0;
>  	long timeo;
>  
> -	/* we don't support FASTOPEN yet */
> +	/* we don't fully support FASTOPEN yet */
>  	if (msg->msg_flags & MSG_FASTOPEN)
> -		return -EOPNOTSUPP;
> +		ret = mptcp_sendmsg_fastopen(sk, msg, len, msk, &copied);

likely:
		return mptcp_sendmsg_fastopen(sk, msg, len, msk, &copied); 

???

>  
>  	/* silently ignore everything else */
>  	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 1e21293bceaa..21f9bf6d2f7e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -837,6 +837,12 @@ void mptcp_event_addr_removed(const struct
> mptcp_sock *msk, u8 id);
>  bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
>  int mptcp_stream_connect(struct socket *sock, struct sockaddr
> *uaddr, int addr_len, int flags);
>  
> +// Fast Open Mechanism functions begin
> +int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
> +			   size_t len, struct mptcp_sock *msk,
> +			   size_t *copied);
> +// Fast Open Mechanism functions end

Plase, do not include the above comments, they are not needed and '//'
should not be used.


Thanks,

Paolo

