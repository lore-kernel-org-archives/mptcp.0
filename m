Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170B72868AC
	for <mptcp@lists.linux.dev>; Fri,  4 Jul 2025 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618471; cv=none; b=NkzWTFZ0ky2D7zUCBuCHeeMxhE6GBWHR3KpwSWZAkZD9zhTA/dAYwK7e11jgwFilFpj8vHu/y3vtxU7isnMQk8I6mt0Y0VGGH2XJ75SuSupS/2GE7tmz7yuCCMHUPU/8yyuez9OSbjrVz1s0kvoNFxLKRGCfyO5IXz1s/LeBXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618471; c=relaxed/simple;
	bh=9zwrQJiQ3UU48m5z+jTjRLv6NcZal1lNbG9y4u5YO5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/QpzvEu+N2boXemI9SYqBepB0dp+6750DGEtWuooSNGLoK8aX8khCviqyWx45Hktt5JYyATBifOOQaktCdbuFr0MjJS36WN1t0e8gGuU3HWpbdv+vI6ySOxj0PBkmeT+kWxJSJ3dgKcvGKv8g/2rYW5Qk5SirxiT+Wzo4Ufk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2oqo7wj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2oqo7wj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751618469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lrxq3lnfV9LDCoMCcP8viJrozxvPFBG655VM7NQRycw=;
	b=S2oqo7wjr5Dje+KundjJGHegl5O246PG3sBRXuK5n2MnMyh6HxeHNLn7tUVDLLA2a1Dema
	TMyaScpztXlanIEbg3p1Dos7ACAu93UDqJWKzDjbeujvUDbooAtxmWbhfFr9P0RDnbu+oc
	Wy/74JhxRmT0v+uVrQQG4Ms00V4CBwE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-x31Uix_nOp-Qmrf4wdR3dQ-1; Fri, 04 Jul 2025 04:41:06 -0400
X-MC-Unique: x31Uix_nOp-Qmrf4wdR3dQ-1
X-Mimecast-MFC-AGG-ID: x31Uix_nOp-Qmrf4wdR3dQ_1751618466
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a5058f9ef4so282430f8f.2
        for <mptcp@lists.linux.dev>; Fri, 04 Jul 2025 01:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751618465; x=1752223265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lrxq3lnfV9LDCoMCcP8viJrozxvPFBG655VM7NQRycw=;
        b=dW19nVMeaPsOiQKTh3LbESOCfiZ0cuyIABN/z/IFwb16hksonpG8iM0RVaBjyWaBP3
         FCFqf+ivNQalAGtIc1JyV3Oh8RZ31LapZx3HJsbSiOFsRR3s0EYi8WANoGz/HI7NCFZ6
         RBVrdiXzwaDbkwHF/JG8p/zKpfydF0xnQqyAfMbnGyvkCyh9tj+juC01l4i2Yo+CmyZf
         Hm7mpA3z8Mg4jz0PLhFTCU0SrfqQDxbDmI5m/6vor7kh0FW5mKtkR+QAlRGcComTFG/g
         dkZrmawqeIDNi1hiR5aBoOHJcoPoipOQOxLylj9jwbSEdOHuK/87ahgurWb2sBQEI2lS
         8/7g==
X-Forwarded-Encrypted: i=1; AJvYcCV9g30VG69ov7eQK8p1FxTtfXDtcBkARKF3JS4YMiHST9moopeIGVTBaEMrI5r2kPk3iPjXtw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywqg2+DB+iKcmTzzzYBQ/2DxReoMSWbfGt4yn6pVC1qEmlwhqUh
	PORUfRC7QNOfDl5fCNfzmSm6bo0hKODN72E8KcRWgeAZs23557XlWbAS20c9+ZYSe6ziJqGXkwL
	CXXzlIvUtaWlK+nNOQwOtEGZybdjtMTnKiQTrwYSFDml2RNVorvQIozWt
X-Gm-Gg: ASbGncuJL2nwrS+JtPlqGwWFXbko6zKHLkDd3xdLk8FzaprM2Xma9zdqLlo7DXEb8Je
	wPqPVbOa1EkBO0lw1zdCyoR+PpP/wNw1jNIA5UPSjpqGjp5r8dlCWBnAFnTQiRZIYmZxiSkIrnf
	xrDJ7qqYkhBPJYwqhmjocxu6BGHA7U4U5kPe4NH+Qw9AoCqycrReyvoCNbSKfBYaHAKSPDiL0eQ
	uYpvVUjjodiEfLXYdxINJqEtLoSWQM4XE0eYpK3bEq/UaygS6UiVwoUJDWy3Jkr8mgsMrbqPb7F
	Q5uqocA6bA8oNXh3uCHXBkpw7NarC84rVn9rtU6Oiwl2Fr8o0o775J2ubLPNscU3Zrw=
X-Received: by 2002:a05:6000:2086:b0:3a5:2d42:aa25 with SMTP id ffacd0b85a97d-3b4966024d1mr1244634f8f.50.1751618465453;
        Fri, 04 Jul 2025 01:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8iGhVYyjc0ZREvsg/PVdzRXLCuJIyJ/8B9epXnzHEhnXK9sDuMiH1uem92igz7QaVeFTTeQ==
X-Received: by 2002:a05:6000:2086:b0:3a5:2d42:aa25 with SMTP id ffacd0b85a97d-3b4966024d1mr1244601f8f.50.1751618464822;
        Fri, 04 Jul 2025 01:41:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a99693f2sm50136885e9.5.2025.07.04.01.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 01:41:04 -0700 (PDT)
Message-ID: <16884178-3746-48d0-8f02-c443d0702086@redhat.com>
Date: Fri, 4 Jul 2025 10:41:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v4 2/4] mptcp: implement .read_sock
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1751039657.git.tanggeliang@kylinos.cn>
 <886fea2d7d2d71ace157bacc1b38dc7ce2e4573a.1751039657.git.tanggeliang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <886fea2d7d2d71ace157bacc1b38dc7ce2e4573a.1751039657.git.tanggeliang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3D-twFVNdfP_nBPHhGeGZ2qFlo3YdyrBieQUfMECJQw_1751618466
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 5:59 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> nvme_tcp_try_recv() needs to call .read_sock interface of struct
> proto_ops, but it is not implemented in MPTCP.
> 
> This patch implements it with reference to __mptcp_recvmsg_mskq().
> 
> v2:
>  - first check the sk_state (Matt), but not look for the end of the
> end of a connection like TCP in __tcp_read_sock():
> 
> 	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
> 		break;
> 
> This will cause a use-after-free error:
> 
> 	BUG: KASAN: slab-use-after-free in mptcp_read_sock.
> 
> v3:
>  - Use sk->sk_rcvbuf instead of INT_MAX as the max len.
> 
> v4:
>  - invoke __mptcp_move_skbs.
> 
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/protocol.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2f747ab730e5..10cc8756877e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3956,6 +3956,68 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
>  	return mask;
>  }
>  
> +/*
> + * Note:
> + *	- It is assumed that the socket was locked by the caller.
> + */
> +static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> +			   sk_read_actor_t recv_actor)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct scm_timestamping_internal tss;
> +	size_t len = sk->sk_rcvbuf;
> +	struct sk_buff *skb, *tmp;
> +	int copied = 0;
> +
> +	if (sk->sk_state == TCP_LISTEN)
> +		return -ENOTCONN;
> +	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> +		u32 offset = MPTCP_SKB_CB(skb)->offset;
> +		u32 data_len = skb->len - offset;
> +		u32 size = min_t(size_t, len - copied, data_len);
> +		int count;
> +
> +		count = recv_actor(desc, skb, offset, size);
> +		if (count <= 0) {
> +			if (!copied)
> +				copied = count;
> +			break;
> +		}
> +
> +		if (MPTCP_SKB_CB(skb)->has_rxtstamp)
> +			tcp_update_recv_tstamps(skb, &tss);

Looking at tcp_read_sock() as the reference, I'm wondering why the above
is needed? likely at least a comment is deserved - or drop the statement.

> +
> +		copied += count;
> +
> +		if (count < data_len) {
> +			MPTCP_SKB_CB(skb)->offset += count;
> +			MPTCP_SKB_CB(skb)->map_seq += count;
> +			msk->bytes_consumed += count;
> +			break;
> +		}
> +
> +		/* avoid the indirect call, we know the destructor is sock_wfree */
> +		skb->destructor = NULL;
> +		atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
> +		sk_mem_uncharge(sk, skb->truesize);
> +		sk_eat_skb(sk, skb);
> +		msk->bytes_consumed += count;
> +
> +		if (copied >= len)
> +			break;
> +	}
> +
> +	mptcp_rcv_space_adjust(msk, copied);
> +
> +	if (copied > 0) {
> +		if (skb_queue_empty(&sk->sk_receive_queue))
> +			__mptcp_move_skbs(sk);

This is needed even in the main loop.

It's probably better to code a mptcp_recv_skb() that will take care of
that (and of offset adjust), and use such helper here and in the main loop.

/P

