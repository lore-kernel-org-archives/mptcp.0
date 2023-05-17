Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE318B16
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 14:26:36 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-30786c87cdaso824487f8f.2
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684333594; x=1686925594;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6P9kK8o9DSUf5VKWSwRJBtmhab/49dni84ZZs5CXUM4=;
        b=LIGc7BajH1HkXjR33W1JeY4NHOkoD3wguoLxaLAqYKhU6u6St4sxWn0unXgKCF61Jz
         fS1ZO9cNSWVuibcoZ5T/xhkT9g2lvZdJ7UGddkzNTA22NzfL7ksxholkb8M7Zy6Tq7BT
         MT+JmXRKa2X1FsDV9V9ekatpo6udo69FpI4xvHBvfEq+hzc4+R6f2Cg1S3hKjbUoLWbc
         8ZrNbu/v0t7hbqx5GL4bERUJhw4qu2mzo8k/CEMqlV1cMDEbiJzzUYK3eqLQC8AvesLY
         WXacbbA/Mg8gGHbrGNhf+FLKefLrZsezDq6pZNQOdmlDfEdSHvma7D0SJJCZYQkbDNEI
         Kmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333594; x=1686925594;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6P9kK8o9DSUf5VKWSwRJBtmhab/49dni84ZZs5CXUM4=;
        b=VF3aP6swsRuuVPAN/sYURc4Y5GdQF9WYNQnPEdPXAZH6Y9Habm2mXsKf608KiNRli/
         woYP57iJuICP2y2iKsoHef657JncaGWpAX2+ghlMkokrZXKftlVrKZB5AJsSFctT6ebc
         SpqC0FdD/TY3qe7PoAXS+xq/nj2iGXwlV3PST/oJ/1xcBx5QuW3qgie//wnERPU1g5zd
         zrLQVjrhjXvgR1qQytqVzCx+37MZKjJP7TwqcBdM0f0Si12rFQyiBY8N1+Xi0d3GDXnl
         e8lHe4JKCUx7FH4QqM3fFdp1aS+9/kFz+j9uIV47Q2uR9qrhfl8d6Oa5NXwzTI51BDio
         PhFA==
X-Gm-Message-State: AC+VfDzPD/2hIyiwhPW1v7DZ3audLzVfaL89rE4K2XNIvxApPjW9h70y
	mnlYj/GXuM9401L46moMat7fFw==
X-Google-Smtp-Source: ACHHUZ5kUTIsySwKuBWR1XOar1ydABcUyE0VixiELblvmNZkNMrk2lsrjBbyRfLTzryJ8f2aZeCIww==
X-Received: by 2002:adf:df81:0:b0:2ff:6906:7169 with SMTP id z1-20020adfdf81000000b002ff69067169mr788188wrl.68.1684333594415;
        Wed, 17 May 2023 07:26:34 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id w12-20020adfcd0c000000b002ffbf2213d4sm3057113wrm.75.2023.05.17.07.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 07:26:34 -0700 (PDT)
Message-ID: <9962f754-1d08-4982-e55e-63e25a7c365b@tessares.net>
Date: Wed, 17 May 2023 16:26:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next 3/4] mptcp: track some aggregate data counters.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1683212362.git.pabeni@redhat.com>
 <df47acfb7e35b28e3eb4f591f182c383bc2076d7.1683212362.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <df47acfb7e35b28e3eb4f591f182c383bc2076d7.1683212362.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 04/05/2023 18:40, Paolo Abeni wrote:
> Currently there are no data transfer counters accounting for all
> the subflows used by a given MPTCP socket. The user-space can compute
> such figures aggregating the subflow info, but that is inaccurate
> if any subflow is closed before the MPTCP socket itself.
> 
> Add the new counters in the MPTCP socket itself and expose them
> via the existing diag and sockopt. While touching mptcp_diag_fill_info(),
> acquire the relevant locks before fetching the msk data, to ensure
> better data consistency
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

(...)

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index d2aa02e28917..2265387a5db2 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -888,7 +888,9 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>  
>  void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>  {
> +	struct sock *sk = (struct sock *)msk;
>  	u32 flags = 0;
> +	bool slow;
>  
>  	memset(info, 0, sizeof(*info));
>  
> @@ -914,11 +916,21 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>  	if (READ_ONCE(msk->can_ack))
>  		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
>  	info->mptcpi_flags = flags;
> -	info->mptcpi_token = READ_ONCE(msk->token);
> -	info->mptcpi_write_seq = READ_ONCE(msk->write_seq);
> -	info->mptcpi_snd_una = READ_ONCE(msk->snd_una);
> -	info->mptcpi_rcv_nxt = READ_ONCE(msk->ack_seq);
> -	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
> +	mptcp_data_lock(sk);
> +	info->mptcpi_snd_una = msk->snd_una;
> +	info->mptcpi_rcv_nxt = msk->ack_seq;
> +	info->mptcpi_bytes_acked = msk->bytes_acked;
> +	mptcp_data_unlock(sk);

Do you know if this could have a "bad" impact on the performances?

I mean mptcp_diag_fill_info() is also used on when dumping all the
connections via Netlink. I guess the lock_sock_fast() should be fine
because it is also used in tcp_get_info() but what about the data lock?
Also OK because that's a spin lock and we only copy fields?

> +
> +	slow = lock_sock_fast(sk);
> +	info->mptcpi_csum_enabled = msk->csum_enabled;
> +	info->mptcpi_token = msk->token;
> +	info->mptcpi_write_seq = msk->write_seq;
> +	info->mptcpi_retransmits = inet_csk(sk)->icsk_retransmits;
> +	info->mptcpi_bytes_sent = msk->bytes_sent;
> +	info->mptcpi_bytes_received = msk->bytes_received;
> +	info->mptcpi_bytes_retrans = msk->bytes_retrans;
> +	unlock_sock_fast(sk, slow);
>  }
>  EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
