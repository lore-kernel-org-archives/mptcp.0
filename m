Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D08F5A
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 08:22:57 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id sc25so30273502ejc.12
        for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmMDjSY9/PHlaZdprEM1X1N1FJrg2ErNlZAeL3CXkMM=;
        b=wAMO7FGwSKMuhc8NhT/m8igi/vG7Hu/kZ23IvLILkegiZbsfFwV5Qowuf4GzR80F76
         YECJyI7CtolFfwleTZwmporJfAvWzEe8q9M45aWTYkd2Q6M62xlF3td4QX25Eoo2dn1u
         SDt9qSS6qE5e+50auDaSh+BwvBiWVJIBwKpC2uO7AGCHd9UEBogM+yQ6aCwHUeQWTRv0
         PVks3Nfj834kfbbXAXm5IjL3eu0Gw6NPyf8zrTxcN2FCPgD6jTfO8oos8Rch3D7PPNWR
         D+jQasRyzqpThXajkoxqh8u3X87eu3OgZXfdcvhBuRFZiP2uaKXyv+jUpCwrQBxMin4B
         8TZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmMDjSY9/PHlaZdprEM1X1N1FJrg2ErNlZAeL3CXkMM=;
        b=614sg4YTvLsgz8K2DuYKnsNmIo/PdMKaw9en2rZ6sU74n1vBUWAYIWPhnGx6xESYTs
         GtioBvR0Obdxg8enl/nFG85XgMQk8lrCrZfQLOYo87v5S6JOlBMVknetJ6UUDZvwJGFB
         MxY+BdEb5XZqAXkLhA5Pr+H1l6o7ywTKbNKQ9x24Nie84RAaw8LVjsxNwubt58990VBj
         xfI3BrV1M/shBGXemsegyq/gL+zIhfrr3CK+8cSAIgxRGqykN9HrzYbnSZzhjFcybzRV
         aaHvilNNN+IzQbXxo00Kyn9gpiAOxrla0tvaTOJI56ETmidd5mojSDGWmNcuDzexyF92
         mY6g==
X-Gm-Message-State: ACrzQf17ScCFOFxUV8cMiXGiVsqrgUGr+t1cL9BTuvmavieWDpd7NNP9
	OZXwditvcXxayex+Qarj9FbthXhez5axiw==
X-Google-Smtp-Source: AMsMyM7cftS1sogvO/2IOXMLtqi3ndZRH9/2F8uynT69ZXZsWVt4pSlP75XtB99SjkiFPbUl6KN/gg==
X-Received: by 2002:a17:906:5a44:b0:78d:4c17:9856 with SMTP id my4-20020a1709065a4400b0078d4c179856mr22244608ejc.477.1665562975290;
        Wed, 12 Oct 2022 01:22:55 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f07e:bd7a:c3d9:59e6? ([2a02:578:8593:1200:f07e:bd7a:c3d9:59e6])
        by smtp.gmail.com with ESMTPSA id k2-20020aa7c042000000b0045c010d0584sm6517831edo.47.2022.10.12.01.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 01:22:54 -0700 (PDT)
Message-ID: <bbd50fc8-150c-84db-5287-71911a91e9c7@tessares.net>
Date: Wed, 12 Oct 2022 10:22:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-net v2] mptcp: fix abba deadlock on fastopen
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <c23778554e349d0a85a34aba14affdac9f5164c5.1665510026.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c23778554e349d0a85a34aba14affdac9f5164c5.1665510026.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for having caught the issue and already provided the patch!

On 11/10/2022 19:40, Paolo Abeni wrote:
> Our CI reported lockdep splat in the fastopen code:

(...)

> commit ("mptcp: factor out mptcp_connect()") will need some
> mangling on top of this one.
> 
> A possible alternative would be targeting even the above to -net.
> 
> Not strictly required, but it will also make more striaght-forward/
> legit the __inet_stream_connect() invocation here.

Indeed, we can. We would need more work around that anyway, no? (see my
comment below)

> ---
>  net/mptcp/protocol.c | 43 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f599ad44ed24..21f5676a60e8 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1673,6 +1673,31 @@ static void mptcp_set_nospace(struct sock *sk)
>  	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
>  }
>  
> +static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msghdr *msg,
> +				  size_t len, int *copied_syn)
> +{
> +	unsigned int saved_flags = msg->msg_flags;
> +	int ret;
> +
> +	lock_sock(ssk);
> +	msg->msg_flags |= MSG_DONTWAIT;
> +	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);

Would it not be cleaner (and easier to maintain?) if a new parameter is
added to tcp_sendmsg_fastopen() to force passing the O_NONBLOCK flag to
__inet_stream_connect? Not to modify msg->msg_flags to have the
behaviour we want.

> +	msg->msg_flags = saved_flags;
> +	release_sock(ssk);
> +
> +	/* do the blocking bits of inet_stream_connect outside the ssk socket lock*/

(I thought checkpatch.pl was complaining when there was no space before
'*/' but it doesn't, all good :) )

> +	if (ret == -EINPROGRESS && !(msg->msg_flags & MSG_DONTWAIT)) {
> +		ret = __inet_stream_connect(sk->sk_socket, msg->msg_name,
> +					    msg->msg_namelen, msg->msg_flags, 1);

Without the commit ("mptcp: factor out mptcp_connect()"), would we need
to call the -net version of mptcp_stream_connect() but without the lock?

> +
> +		/* On connect hard error fastopen no bytes actually sent. */
> +		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)

The two last ones are there in case the "actual connect()" got
interrupted, right?

> +			*copied_syn = 0;
> +	}
> +
> +	return ret;
> +}
> +
>  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> @@ -1692,24 +1717,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	lock_sock(sk);
>  
>  	ssock = __mptcp_nmpc_socket(msk);
> -	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
> -		struct sock *ssk = ssock->sk;
> +	if (unlikely(ssock && (inet_sk(ssock->sk)->defer_connect ||
> +			       msg->msg_flags & MSG_FASTOPEN))) {

Just above in this mptcp_sendmsg() function, we mention we don't support
MSG_FASTOPEN yet. maybe we don't need to add this additional check now?
(Or maybe you want to discretely remove this previous restriction for
-net as well and support MSG_FASTOPEN? :-D )

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
