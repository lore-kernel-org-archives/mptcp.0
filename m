Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C420766C
	for <mptcp@lists.linux.dev>; Tue,  8 Jul 2025 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986347; cv=none; b=F58EGTZexErQ081FvqRZF0nvR4UwJJHaaKU2SlqGm4++ZzbT0Zynv1acXk9hAR7biTJev9WxfHHFJ62MLboWOfJlmSErLDVk7MgTxfyaMv5k4PwUZGh8D1LTMTbblRZWGIlI65wAcFxU3otcMdAEzTgBB1B9CP6CEr1YKfHI9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986347; c=relaxed/simple;
	bh=1oWf6IQEoN6deQ+2zC2ySDfM/BBCToxhKWIT6O7Q+d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zu5TI1f1oFYCsgHhoH228VpaaWS3AVTNPtIpF+u7vLSAIjGYxRY+JNFIEmTcELbOxLYT/D/U8KzhgwJqd7+DIYg1hrNEKcG5CnLvoPApyigTrRWHp36h1n+5UrF472pPELHOczmww3jDXmOJppRa+7CCoIWdORYi2oyvbMif95w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHFE7S+G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHFE7S+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751986344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vecfay4tDubNW2N1y6zD5/FutJPkPv8Qf8FJ01eOQKw=;
	b=fHFE7S+G60sxk/laJXVWQAJm9gS9vSvtljtqL+ZJ44U4OPXCHHkVDWci4eIY1qNlieFG39
	hbwwG0m5LLiE4IpH2l2CL5imhHSRrFy40yANiHguTpGTT3yNgnpPsR808mfDFv+tbmgVna
	Y5qOI0Nm3LPLRlUNzjUMdQfF3wRoLRE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-O9ufMgVJPuePSLM1MXa6_Q-1; Tue, 08 Jul 2025 10:52:23 -0400
X-MC-Unique: O9ufMgVJPuePSLM1MXa6_Q-1
X-Mimecast-MFC-AGG-ID: O9ufMgVJPuePSLM1MXa6_Q_1751986342
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f65a705dso2628931f8f.2
        for <mptcp@lists.linux.dev>; Tue, 08 Jul 2025 07:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986342; x=1752591142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vecfay4tDubNW2N1y6zD5/FutJPkPv8Qf8FJ01eOQKw=;
        b=deAvdFHw34zVJCKlo/qLbD3Z2q8Fs+qgWS8/VEof/1hOnp1wyTf3doo7U74jtG3pwr
         Tp6I/n1Tb1AXGh3BcC9P34YzkCUPokoJdVc0A0Fao316og8lsVBZbUaiMT7Z8Iw4YC3j
         Pl2snzhhTl3ybBQhm0notXamkKvPgCwkb9F4LGcGhGTmGyhmRT1KoormElXa7N9nYE1G
         4LejY+LWfZFgjBiRq5z3HZWx+RmYfXEK0oSAmKiviCqYdtslUDSUx+EunzJX37YT/kvG
         N8GIFOLJfocqsAQcutchqphKEwbF2oE+z96uMPlxb+dkoDtJun7SVdSvZ8xZ87jhZUl/
         RnXw==
X-Forwarded-Encrypted: i=1; AJvYcCVOnDZWaf4wzzuiKVGCemT22Unv1dLbXFfYTah+vBIeNnTCG0Zim6n9ZYG99WQqlrBkvea2Sg==@lists.linux.dev
X-Gm-Message-State: AOJu0YydwqoeAmPbD3tL6NpOaWewy3FsVZoAOG4eoenVjNZJiowt0Vmj
	jGamfxu3hZ1piYst0meCv7Yom2UEzGqOGctWwT+PHd3CtBweev/IFdaNYQAHG2VdVQKO4DZQ1++
	zpq9tBUnftc3z4s3Fkbbh8BQDqL/Rv9Q4xBmC7fgB0lIehOVU6quFD1A6
X-Gm-Gg: ASbGnctpk8Q3NYB3hL0byBSePrbGZcaBKc99RjgxizjM960XFBckWQxIeSwZLEm7Usa
	tPz+EvH2VkJE7z276ZyFxtVtnbrkjZHVBOyNPTx7k3H3XDVtVlOY5uEyiKC4w/HtkSo2fYgCsRS
	0JAB3UVj5V37B4JSaO57mLgp2CqAWH7Pe+CU3De3KoeARJZ88J6vkAT9pZxRFQw/hH+SujGitlb
	TqfhTiWKGvOMfwcOdENE0oZQ2S4FXg+tFtafElmi1NvR1CORsFuGc3I6qwhg9eDBU7oGqAA229m
	86gEB9Jqop95B5fMB9Pqo7+vBGky3yruiUOeGl8mMswpNTU2pCHLzF81lXlfKnRKEDuaCQ==
X-Received: by 2002:a05:6000:470f:b0:3b2:fe46:9812 with SMTP id ffacd0b85a97d-3b497015268mr11468796f8f.19.1751986341799;
        Tue, 08 Jul 2025 07:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK8SujYCWqTrx2oFqdAlrReSQiDIY7vh3xLYWs2p1nXz8G5Buiz2xqaXeHe75m9csSJSctJg==
X-Received: by 2002:a05:6000:470f:b0:3b2:fe46:9812 with SMTP id ffacd0b85a97d-3b497015268mr11468773f8f.19.1751986341297;
        Tue, 08 Jul 2025 07:52:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2717:8910:b663:3b86:247e:dba2? ([2a0d:3344:2717:8910:b663:3b86:247e:dba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b470caa1b3sm13010438f8f.43.2025.07.08.07.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:52:20 -0700 (PDT)
Message-ID: <63354366-79aa-4799-9af3-5f5a379ea4eb@redhat.com>
Date: Tue, 8 Jul 2025 16:52:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v7 3/4] mptcp: implement .splice_read
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1751880561.git.tanggeliang@kylinos.cn>
 <7c269511e2ff8cf2a44934cb0f12554770c5c7c6.1751880561.git.tanggeliang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <7c269511e2ff8cf2a44934cb0f12554770c5c7c6.1751880561.git.tanggeliang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -T1e24Sha3CgHuG19TBGkwczQ6S6BQve-FJJBr8ndVk_1751986342
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/7/25 11:34 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch implements .splice_read interface of mptcp struct proto_ops
> as mptcp_splice_read() with reference to tcp_splice_read().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/protocol.c | 136 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index fc429d175ede..4638d4be2b98 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4023,6 +4023,140 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
>  	return copied;
>  }
>  
> +/*
> + * MPTCP splice context
> + */
> +struct mptcp_splice_state {
> +	struct pipe_inode_info *pipe;
> +	size_t len;
> +	unsigned int flags;
> +};
> +
> +static int mptcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
> +				  unsigned int offset, size_t len)
> +{
> +	struct mptcp_splice_state *mss = rd_desc->arg.data;
> +	int ret;
> +
> +	ret = skb_splice_bits(skb, skb->sk, offset, mss->pipe,
> +			      min(rd_desc->count, len), mss->flags);
> +	if (ret > 0)
> +		rd_desc->count -= ret;
> +	return ret;
> +}

I have mixed feeling WRT the above. I'm wondering if we should reuse the
same code already existing in TCP, moving tcp_spice_state definition in
some shared hdr and macking tcp_splice_data_recv not static.

> +static int __mptcp_splice_read(struct sock *sk, struct mptcp_splice_state *mss)
> +{
> +	/* Store MPTCP splice context information in read_descriptor_t. */
> +	read_descriptor_t rd_desc = {
> +		.arg.data = mss,
> +		.count	  = mss->len,
> +	};
> +
> +	return mptcp_read_sock(sk, &rd_desc, mptcp_splice_data_recv);
> +}
> +
> +/**
> + *  mptcp_splice_read - splice data from MPTCP socket to a pipe
> + * @sock:	socket to splice from
> + * @ppos:	position (not valid)
> + * @pipe:	pipe to splice to
> + * @len:	number of bytes to splice
> + * @flags:	splice modifier flags
> + *
> + * Description:
> + *    Will read pages from given socket and fill them into a pipe.
> + *
> + **/
> +static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
> +				 struct pipe_inode_info *pipe, size_t len,
> +				 unsigned int flags)
> +{
> +	struct mptcp_splice_state mss = {
> +		.pipe = pipe,
> +		.len = len,
> +		.flags = flags,
> +	};
> +	struct sock *sk = sock->sk;
> +	ssize_t spliced;
> +	long timeo;
> +	int ret;
> +
> +	/*
> +	 * We can't seek on a socket input
> +	 */
> +	if (unlikely(*ppos))
> +		return -ESPIPE;
> +
> +	spliced = 0;
> +	ret = 0;
> +
> +	lock_sock(sk);
> +
> +	timeo = sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
> +	while (mss.len) {
> +		ret = __mptcp_splice_read(sk, &mss);
> +		if (ret < 0) {
> +			break;
> +		} else if (!ret) {
> +			if (spliced)
> +				break;
> +			if (sock_flag(sk, SOCK_DONE))
> +				break;
> +			if (sk->sk_err) {
> +				ret = sock_error(sk);
> +				break;
> +			}
> +			if (sk->sk_shutdown & RCV_SHUTDOWN) {
> +				if (__mptcp_move_skbs(sk))
> +					continue;
> +				break;
> +			}
> +			if (sk->sk_state == TCP_CLOSE) {
> +				ret = -ENOTCONN;
> +				break;
> +			}
> +			if (!timeo) {
> +				ret = -EAGAIN;
> +				break;
> +			}
> +			/* if __mptcp_splice_read() got nothing while we have
> +			 * an skb in receive queue, we do not want to loop.
> +			 * This might happen with URG data.
> +			 */
> +			if (!skb_queue_empty(&sk->sk_receive_queue))
> +				break;
> +			ret = sk_wait_data(sk, &timeo, NULL);
> +			if (ret < 0)
> +				break;
> +			if (signal_pending(current)) {
> +				ret = sock_intr_errno(timeo);
> +				break;
> +			}

I think that moving the above if statement before the queue empty check
will not change the overall behavior.

With that in place you could factor out an

bool mptcp_recv_should_stop(struct sock *sk, int err)

helper from mptcp_recvmsg() and use it verbatim in both in
mptcp_recvmsg() and here.

Side note: suggestions for a better helper name welcome!

/P

