Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573428BAB9
	for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660260; cv=none; b=Yca+qdLIl60xn0deEwtUT0w0jO1qXIFnPY0ZAp1wB1wZTbE8NqHHT7Xp24Rly4cImFmkqGr2JI/vPcGcIrPcSU3drb0XOptUFs1KYcPebihYd2k3cAPyz58t80iAYaDgrbOusHpzEpAtp8VqhS3Pdbk8LlynST6M/+9ynOwRJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660260; c=relaxed/simple;
	bh=vExqsQuY0TOh0C4OqHS5ONqjXZPb4O5dkQOinRtjo/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/DaW7e9OIIuPk8kHUOO8mRuU4q+jzW6CsmTcPVB2JYYBvNPjhrUu0xNYDElYvtoINctnaod81imiBj4Atv6fydGeZadLZDwJEGp3n/EkKGcLw0eF3LL7Nmqfi3F/cv3RaugOZ9qkj5TRfWqrSlsUCnc/IFnIT+p5Uo3617NQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6Fqyz5I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6Fqyz5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773660258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9hWHpx6fXvQ6tiAS+Vx6gKKziz7E3xCqMnpnyHx+ks=;
	b=B6Fqyz5IVSt3GT1ulMlu9mvzM+CA70XjObXe+5Gd8yBnDbRV3zsSgLTfcMrhOcE/J71QOG
	Zx2eMifGvjFmI/YyF4iMbpGml7mir8HQ2GfFjhBHsP4haMNshDJt7b35DI7za79IwcDZdm
	EbzAGhVf3jD+0u46sDwYtQzxdKLcTbs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-BsEnBltcMCiDXUqDMYsaRw-1; Mon, 16 Mar 2026 07:24:17 -0400
X-MC-Unique: BsEnBltcMCiDXUqDMYsaRw-1
X-Mimecast-MFC-AGG-ID: BsEnBltcMCiDXUqDMYsaRw_1773660256
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48532df52c5so64751085e9.1
        for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 04:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660256; x=1774265056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9hWHpx6fXvQ6tiAS+Vx6gKKziz7E3xCqMnpnyHx+ks=;
        b=A1c1hqqWV/t7VPQbwDAiKr2C7HwKK+X44lOa9ga71MTv4zyMxjbT8tKIplPWfpjU1d
         z6mVvBsGwGOiXuUXhvpDjUiGEG9rB8qMgnlR1xDUGAn0VgOXE6U0fRkc8U/R0iqfrlbL
         1C5wdNXvDIwJ4W3VPctG33rzd0JWXEd8bCrcPLB0fcGYT8wALTm3V2gLR09u780/fbIi
         HNbCPAOUS+H/+x8EACJTbRpJC6TR9Cc+vL7UoNbsjaZXmHF3f4emQTwp6zBQeaYn5s2m
         AdDV0cjDR7pW04z+4elfEuiZNU8hKNjKeooWwKhk6u9cZNBLt5eHVMSUuZB5r3KfOdZM
         LPgg==
X-Forwarded-Encrypted: i=1; AJvYcCUro5PsyO0Lox3xWT0Kh1YKa9FNO13iwlzzGufcQMnPs422WDHxBKPih3mxY/8+dlMEq98zlg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywk/I6F9TdJNxojZYQ/lvTxxHlOIk0bup7QNk/m8GL1RUKgyq+G
	bvmEbQxHMblqhtaKotlQzDBuygDlIsD9WZNsLgak2C0hJLBRUMq/sXzGOS529u6PV44DI7cks64
	FdCxlln2iCtLNyyuSZCDde3TR5Dv47Wfg8pHLcXTph0BE9xkDNndhSRzJ
X-Gm-Gg: ATEYQzxxfN03OpRyvVxsH+mygn9fQKD9r4a8uolA+4siNa4Z0AOq/CYq8swqfe8Yk4+
	HSISrvO3DE3J5QqTGK7W8egr15YmCdqHexMXPxaRwFCS7gX4DortOeU1VUXYOvKl5cvUdJqx27U
	RCYb/z9i7QiygBKurlGjuKUDpW0jowW1J9ATj+ITJ6l9sgILGwAc1XMsyHVUirWR2CLMOFAjLv7
	jIEu0lbbSGSYMzbL9vTeBBXxo9p8+TZ7udpSgajxuLQhjUyNV1hy48vi6bAexnC4DZrYjGQyzhI
	4cPYlTtxm7TMA3ZBFc2GjAFPbM7nuc+LTluFGd7f44XVPVlBiQFtGWnqltQt9JVlC7sub8VZ+NK
	APy+4V+YdDa/40oUb/rL3kL9u2h+F4Aj1ycaPqYHS5FJJiKUzuo5Ejjs=
X-Received: by 2002:a05:600c:468e:b0:485:3f58:d9d with SMTP id 5b1f17b1804b1-48556714b67mr207129395e9.32.1773660256095;
        Mon, 16 Mar 2026 04:24:16 -0700 (PDT)
X-Received: by 2002:a05:600c:468e:b0:485:3f58:d9d with SMTP id 5b1f17b1804b1-48556714b67mr207128715e9.32.1773660255574;
        Mon, 16 Mar 2026 04:24:15 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73dasm1215197765e9.2.2026.03.16.04.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:24:15 -0700 (PDT)
Message-ID: <2551cc98-5280-4a9f-8345-0a39e0e09dac@redhat.com>
Date: Mon, 16 Mar 2026 12:24:13 +0100
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
X-Mimecast-MFC-PROC-ID: bAWVY9A8uwnza0TH669dZZCJxPde4z2I3mbWTCcOZBs_1773660256
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
> + * their own struct socket, 

AFAICS, the above statement is false, see sk_set_socket() in sk_clone()

> so only sockets that point back to themselves
> + * should autotune receive-buffer backing.
> + */
> +static inline bool tcp_rcvbuf_grow_allowed(const struct sock *sk)
> +{
> +	struct socket *sock = READ_ONCE(sk->sk_socket);

You can just check `sk->sk_socket`. Also you could re-use this helper in
tcp_data_queue_ofo().

/P

