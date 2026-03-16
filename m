Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AA526D4E5
	for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659054; cv=none; b=gjjqarIiNpVbPq7m+rgSlAOplh4Iai1m1BMZUWKvhJw632tIj8LhDkCE2O7p6oGb2DlPeZOjifp+9VZpyorCHmgcMiwiRQ+GQpl5ZkFrmeUpwdCHHgbbOLvspZAw0dQimDcpOGH6iEe61fb++jGYEgSQtDzh3osZJjXA6yPJwSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659054; c=relaxed/simple;
	bh=1Z2K5uAxzV9s8L4/BC8KNuwonWVfjkCKvcQHutx8mBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5H/dUiqG8MQk41Yn8KlVL4qw2hMu/og+jCAhI/fDGfoHgNGwWx/OmKyRThSsYWMk2nwg7ASDpAQFJfGzsSt+qcaJHHUgI1YIzVUwNDKSCYbTFUoOZVag3A/nCYYcfZw3nWOQ2ZsYEKGCfKkvDbyouolALB8Sr18qJZLoUac138=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICET6ahO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICET6ahO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773659051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGzcfaMu1FLaomn7Oe2DL0qLnEzAPj3x2+LI9gIhWi0=;
	b=ICET6ahOcEmeSuifDilNtqfn6IujVNVMITSg+N695hw1weOf/TEE9NR+TROs2JM8Cu8WyD
	4RvKYifVMRb3P80EWCBsRXMRegfvwx5SWgy2H3jwY828vKQ//la3PmWgJus+I2rSKa5ziO
	WH5BvuHC4Pb1QQ9XdxyWwIG0tawGIVI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-LFZAfBLaN966yHdw7k91Cw-1; Mon, 16 Mar 2026 07:04:10 -0400
X-MC-Unique: LFZAfBLaN966yHdw7k91Cw-1
X-Mimecast-MFC-AGG-ID: LFZAfBLaN966yHdw7k91Cw_1773659049
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439af7ba802so5400955f8f.2
        for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 04:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773659049; x=1774263849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGzcfaMu1FLaomn7Oe2DL0qLnEzAPj3x2+LI9gIhWi0=;
        b=Kz6wVhRbYK8Zk0Bna1rfyYW7TBvqloawNSiSKDGPBKK++hdDZwghg3r5GGZvmuUXmV
         JWjnrx72lJ0NJPdUwKzlYEB0SW24uFOWKG4v3c+BAqxvwnHx4fRZ+75SqTUK2OZ6RZSO
         Mj5PgVeJKq2nCJbtDXUK+50VL3ANpZZOTNnenmt5NtpHqnXAqHpijznI6ObxEhGxmIjN
         V4Rx2boY+xz1zSmxkoC1S3FQQItoX3heLSZdmQy3wma20zbthCxxJuP3Uef8sNtZsXN0
         M72fBVY2ZIEvJc1GJlbC1px8MJUdXxpMAgY7mDUqn61GbJKlzayupX+JR8NUcMdCtQyv
         9rlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6Oi1zrKUet4vxSn7/bCXcmFk7RahJlbDjhikFD3V5hjkQvK8j+W2Njd+DmRXgpujNZU30qw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxg69AYd4CEFbK78QAMKLhY35b4PTdFkTESmlmu+sHj/aDfJdus
	xYpzZdhETI3VFL+sm4inIb4KE/Y4rDyaRCGBVpjLI4zEZeoKJzPpWhIW60hglJrG2zTvzAaMxvR
	gpbLrqLiiXg8KLD7TCXUBhncvccdtJ6Uo9RGd9YqXwBiE2z1J57uNes9q
X-Gm-Gg: ATEYQzxIKSaYLPfMLShEdJOqqDRZoDiHBpYcm2fl+/wbA4g10hMxIH10omFpJRRxkD8
	hDrOJvJVzvVVL14om3uPn8zrvxud65Iq+MyfxouK8DZx7HLOZWumX1vUteDzYkU2TvPR9Iyj5fV
	I53SrnnNxJeVIXCY1JWbnBL5fPkNMVdW5bKei07zObFP4+JVoI0W0YYpxszqupqVI0Nt9+Ey0d/
	z+6bApjEbbo1Xhj7E96F9KPiGAxhBsfs/cE0eKW9rLETV5wGxV/grrUvhlI846wBwTcEcXLN8hA
	WFIZxLvazcUYjsjD5eMcdj9IUp3LyxTB0qWUVyGi9llHPI5LczfxCldlvV1OTVSI75xaoXfdFV6
	WERR5yb8JgZhe78in+o0IPFF1GxFLzehi26/spvtAF8eHTLmQxtLqh84=
X-Received: by 2002:a05:6000:2901:b0:439:b3d2:376b with SMTP id ffacd0b85a97d-43a04d86856mr21339373f8f.14.1773659049165;
        Mon, 16 Mar 2026 04:04:09 -0700 (PDT)
X-Received: by 2002:a05:6000:2901:b0:439:b3d2:376b with SMTP id ffacd0b85a97d-43a04d86856mr21339273f8f.14.1773659048589;
        Mon, 16 Mar 2026 04:04:08 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm41595197f8f.4.2026.03.16.04.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:04:08 -0700 (PDT)
Message-ID: <442cfa35-78b1-48f4-9565-e884e7e60d79@redhat.com>
Date: Mon, 16 Mar 2026 12:04:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/14] tcp: grow rcvbuf to back scaled-window
 quantization slack
To: atwellwea@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, ncardwell@google.com
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 dsahern@kernel.org, horms@kernel.org, kuniyu@google.com,
 andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 skhan@linuxfoundation.org, corbet@lwn.net, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 0x7f454c46@gmail.com
References: <20260314201348.1786972-1-atwellwea@gmail.com>
 <20260314201348.1786972-6-atwellwea@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260314201348.1786972-6-atwellwea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UKr-7rktusbCkqkFAwJdo4aa-sGUz6oMGYv7Mxy65zg_1773659049
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/26 9:13 PM, atwellwea@gmail.com wrote:
> From: Wesley Atwell <atwellwea@gmail.com>
> 
> Teach TCP to grow sk_rcvbuf when scale rounding would otherwise expose
> more sender-visible window than the current hard receive-memory backing
> can cover.
> 
> The new helper keeps backlog and memory-pressure limits in the same
> units as the rest of the receive path, while __tcp_select_window()
> backs any rounding slack before advertising it.
> 
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
> ---
>  include/net/tcp.h     | 12 ++++++++++++
>  net/ipv4/tcp_input.c  | 36 ++++++++++++++++++++++++++++++++++--
>  net/ipv4/tcp_output.c | 15 +++++++++++++--
>  3 files changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index fc22ab6b80d5..5b479ad44f89 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -397,6 +397,7 @@ int tcp_ioctl(struct sock *sk, int cmd, int *karg);
>  enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
>  void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
>  void tcp_rcvbuf_grow(struct sock *sk, u32 newval);
> +bool tcp_try_grow_rcvbuf(struct sock *sk, int needed);
>  void tcp_rcv_space_adjust(struct sock *sk);
>  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
>  void tcp_twsk_destructor(struct sock *sk);
> @@ -1844,6 +1845,17 @@ static inline int tcp_rwnd_avail(const struct sock *sk)
>  	return tcp_rmem_avail(sk) - READ_ONCE(sk->sk_backlog.len);
>  }
>  
> +/* Passive children clone the listener's sk_socket until accept() grafts
> + * their own struct socket, so only sockets that point back to themselves
> + * should autotune receive-buffer backing.
> + */
> +static inline bool tcp_rcvbuf_grow_allowed(const struct sock *sk)
> +{
> +	struct socket *sock = READ_ONCE(sk->sk_socket);
> +
> +	return sock && READ_ONCE(sock->sk) == sk;

This is executed under the sk socket lock, ONCE annotation not needed.

> +}
> +
>  /* Note: caller must be prepared to deal with negative returns */
>  static inline int tcp_space(const struct sock *sk)
>  {
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 352f814a4ff6..32256519a085 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -774,6 +774,38 @@ static void tcp_init_buffer_space(struct sock *sk)
>  				    (u32)TCP_INIT_CWND * tp->advmss);
>  }
>  
> +/* Try to grow sk_rcvbuf so the hard receive-memory limit covers @needed
> + * bytes beyond sk_rmem_alloc while preserving sender-visible headroom
> + * already consumed by sk_backlog.len.
> + */
> +bool tcp_try_grow_rcvbuf(struct sock *sk, int needed)
> +{
> +	struct net *net = sock_net(sk);
> +	int backlog;
> +	int rmem2;
> +	int target;
> +
> +	needed = max(needed, 0);
> +	backlog = READ_ONCE(sk->sk_backlog.len);
> +	target = tcp_rmem_used(sk) + backlog + needed;
> +
> +	if (target <= READ_ONCE(sk->sk_rcvbuf))
> +		return true;
> +
> +	rmem2 = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
> +	if (READ_ONCE(sk->sk_rcvbuf) >= rmem2 ||
> +	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK) ||
> +	    tcp_under_memory_pressure(sk) ||
> +	    sk_memory_allocated(sk) >= sk_prot_mem_limits(sk, 0))
> +		return false;
> +
> +	WRITE_ONCE(sk->sk_rcvbuf,
> +		   min_t(int, rmem2,
> +			 max_t(int, READ_ONCE(sk->sk_rcvbuf), target)));
> +
> +	return target <= READ_ONCE(sk->sk_rcvbuf);

Same here, and more cases below.

/P

