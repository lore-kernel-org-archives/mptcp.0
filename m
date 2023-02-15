Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09E97B
	for <mptcp@lists.linux.dev>; Wed, 15 Feb 2023 17:53:08 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id d40so22690878eda.8
        for <mptcp@lists.linux.dev>; Wed, 15 Feb 2023 09:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tv1CEyWoU+bXcAc0SBzmGezsqD52vZhdtDtcvpgbxDg=;
        b=wgUtnCP40Jt7j3wyJz5Zf36d3ho6jVxhgVr4eqgylzs9PXzc22U+tcbNA//zYBX6vN
         0NuMtUOgM70zzKlrXh0jXeUBIN39sm+NVDltDWs0PTRdDZ1j2cWmlIyH/wDO7lixGfL/
         qRE24sbDOvEmqpwr8KUc+f4UpZYIbZmnvFYNidUl/dF6QvnuA7ktN/24+2ytUM+2af3B
         BRtgd5t43xJrfCbed/m3L2Pw+/aYHkSUGSgU6+VZkLkjBA06a/2YSwqyjeRznHaYeIez
         yvcFG2yZROY97lpNxcnRy/Nb1o4KtJxLvPWB6Iog0MauOuVlNRYz6Ph0ViG2VMOWdqtI
         bRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tv1CEyWoU+bXcAc0SBzmGezsqD52vZhdtDtcvpgbxDg=;
        b=xKlZuouu4X4pQjNR9aJdZOLm5us2drwuX7E8oOr77gnHvJ/1dZP9ULCpEm6guxPWVq
         RPcn9JsVlyME08bYHBqhvZELVq44K/5EXzNN7/F9YPi0HzKVL+r5FTihghf3kCRzoat+
         AGe5dnLtP+La2i/vBd3mJTk/LCNYTr0SIoiZosiURaJ7yfbflxotLf7V2WXRL+LYjxim
         2Z9Kculv7XVn9XyfbnLHl8LsDNaZZlVEtfKAnA14jk2VRQVPo4FDyW5/0d5gUG+L2Rdv
         KYYrWwoK2U5CgwKned/mB73/F2UrKDgltWOJlxHl5zD0I6KzeHJ9gtsXGkc9VZ/R9w6E
         mExw==
X-Gm-Message-State: AO0yUKVWKe4JB9IHi5sjnv/mySx2U5/n9ll7RRE4iCT83iWnLQfSIg/v
	CmGFbD2/zVh4oluTSfC7cD2EwhGMprsP1G1WoIM=
X-Google-Smtp-Source: AK7set8nHF8WeEnlqAM8P+xjwkJpN89xqiR43bi8ISum1KnbUrAc8I80Thya6+PmRU0kDEtVZXX4HA==
X-Received: by 2002:a17:906:9f0f:b0:8aa:c5d9:cabf with SMTP id fy15-20020a1709069f0f00b008aac5d9cabfmr241419ejc.3.1676483586570;
        Wed, 15 Feb 2023 09:53:06 -0800 (PST)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id g16-20020a1709063b1000b008b1390ad11esm1781289ejf.216.2023.02.15.09.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 09:53:06 -0800 (PST)
Message-ID: <3e0bda7b-d05b-7e9c-4862-d93d120ac86c@tessares.net>
Date: Wed, 15 Feb 2023 18:53:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 mptcp-net 1/2] mptcp: use the workqueue to destroy
 unaccepted sockets.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <b5b35cfd2d10179fc81643e601e125aa881f7c79.1675968499.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b5b35cfd2d10179fc81643e601e125aa881f7c79.1675968499.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 09/02/2023 19:48, Paolo Abeni wrote:
> Christoph reported a UaF at token lookup time:
> 
> BUG: KASAN: use-after-free in __token_bucket_busy+0x253/0x260
> Read of size 4 at addr ffff88810698d5b0 by task syz-executor653/3198
> 
> CPU: 1 PID: 3198 Comm: syz-executor653 Not tainted 6.2.0-rc59af4eaa31c1f6c00c8f1e448ed99a45c66340dd5 #6
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x6e/0x91
>  print_report+0x16a/0x46f
>  kasan_report+0xad/0x130
>  __token_bucket_busy+0x253/0x260
>  mptcp_token_new_connect+0x13d/0x490
>  mptcp_connect+0x4ed/0x860
>  __inet_stream_connect+0x80e/0xd90
>  tcp_sendmsg_fastopen+0x3ce/0x710
>  mptcp_sendmsg+0xff1/0x1a20
>  inet_sendmsg+0x11d/0x140
>  __sys_sendto+0x405/0x490
>  __x64_sys_sendto+0xdc/0x1b0
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> We need to properly clean-up all the paired MPTCP-level
> resources and be sure to release the msk last, even when
> the unaccepted subflow is destroyed by the TCP internals
> via inet_child_forget().
> 
> We can re-use the existing MPTCP_WORK_CLOSE_SUBFLOW infra,
> explicitly checking that for the critical scenario: the
> closed subflow is the MPC one, the msk is not accepted and
> eventually going through full cleanup.
> 
> With such change, __mptcp_destroy_sock() is always called
> on msk sockets, even on accepted ones. We don't need anymore
> to transiently drop one sk reference at msk clone time.

Thank you for the patch, I just have one question below if you don't mind :)

(...)

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 546df81c162f..d7588535bf6d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2444,9 +2444,10 @@ static unsigned int mptcp_sync_mss(struct sock *sk, u32 pmtu)
>  	return 0;
>  }
>  
> -static void __mptcp_close_subflow(struct mptcp_sock *msk)
> +static void __mptcp_close_subflow(struct sock *sk)
>  {
>  	struct mptcp_subflow_context *subflow, *tmp;
> +	struct mptcp_sock *msk = mptcp_sk(sk);
>  
>  	might_sleep();
>  
> @@ -2460,7 +2461,15 @@ static void __mptcp_close_subflow(struct mptcp_sock *msk)
>  		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
>  			continue;
>  
> -		mptcp_close_ssk((struct sock *)msk, ssk, subflow);
> +		mptcp_close_ssk(sk, ssk, subflow);
> +	}
> +
> +	/* if the MPC subflow has been closed before the msk is accepted,
> +	 * msk will never be accept-ed, close it now
> +	 */
> +	if (!msk->first && msk->in_accept_queue) {
> +		sock_set_flag(sk, SOCK_DEAD);
> +		sk->sk_state = TCP_CLOSE;

Would it make sense to call inet_sk_state_store() here, mainly for the
tracing?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
