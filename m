Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE11361
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 08:52:21 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-99342a599e9so96485366b.3
        for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689843140; x=1690447940;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qtsBxHRo3A/23SZiP2LzgDbXNGCJAoHo15yVFCxjLk=;
        b=rX3P+T/H8k0tulVoL/mfJbVkj+B+gn65+qyLMcIrxI8MYOADaG3KgDWrjhRHP2hFeX
         wLYQQSq6AvQw8/J2s/MgReQ+LU59wAF90UC1N9/0JtE+24uc6Y1Xc5ejfoYW8c6Hbnf/
         g+PG3P1nYJk1TjeE9fYit4eA5kKXzOHRRWYAhW4Pd7aBEexYMEc0MON0+anRtrXhnA0M
         b++TvAa2oCEYUhYP2qW5F6GG+2NUgB7buuG+X4oNvdN5IaPCa0z4j9hPOiikmQ7LqwhD
         1f+7wnflEo0JowSuG8JNMxjm70cCFhBjuLNEqvbhYFaPJVPwi2KZW1KHaFbj+/SezEZc
         4obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689843140; x=1690447940;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qtsBxHRo3A/23SZiP2LzgDbXNGCJAoHo15yVFCxjLk=;
        b=Yx8THj0LgS39w8YBiajlo48pDdJax7zxbgauqNdf0BHyigv2BRWVlnmsNYoJy6/y3f
         ZzH1qjqC3WGLgPtWJ+L6bZ3ZHRdFXXK8cyD3p6p/e/q+nqXKYeIUbp1WpKqZAMgX3A69
         HJapUuCN6QY09EYVBCebelB0AdxWJWYWLMluf9cOHzyYby7UBiW9nGQJip6ipsrD/4IE
         Wq69Bi6PCEIUF1ksBToLceax4qWG+1nvEnylpVqq0PJjVExTkNeRvDTs/aOvYUyBsR6c
         jusKIt/NHc4X0xcqv59VdI0YUba9bPgPwoUX9wFLO7XvgBhqf55NetNG7EbtI3PnNUt2
         JUAw==
X-Gm-Message-State: ABy/qLZQ5+AL1XDMPZfpbw48QLQiIj0VyEStDoEdditBeYgEwJwtry25
	r8Raxfhm3mw+0BKFoQossXvy+xRI18m5fHjFEwqGEA==
X-Google-Smtp-Source: APBJJlH6QJxFI6XIkzyKDKa20gZVUPfbh0VVvHYyQmhRZ6QiuGyhg+dZ9CMsUInftb8Ef4/WaAMzQA==
X-Received: by 2002:a17:906:64ce:b0:991:bf04:2047 with SMTP id p14-20020a17090664ce00b00991bf042047mr2012451ejn.14.1689843139498;
        Thu, 20 Jul 2023 01:52:19 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e9fe:3ca8:d533:2e78? ([2a02:578:8593:1200:e9fe:3ca8:d533:2e78])
        by smtp.gmail.com with ESMTPSA id a5-20020a170906274500b009932337747esm370516ejd.86.2023.07.20.01.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 01:52:19 -0700 (PDT)
Message-ID: <333c6239-bb59-abf1-b2a3-ba3d89520b9f@tessares.net>
Date: Thu, 20 Jul 2023 10:52:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mptcp-next] mptcp: fix rcv buffer auto-tuning.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <099977f9fe49d41ee0aa2eddefe5e2e09da3a3f1.1689836587.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <099977f9fe49d41ee0aa2eddefe5e2e09da3a3f1.1689836587.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 20/07/2023 09:03, Paolo Abeni wrote:
> The MPTCP code uses the assumption that the tcp_win_from_space() helper
> does not use any TCP-specific field, and thus works correctly operating
> on an MPTCP socket.
> The commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale") broke
> such assumption, and as a consequence most MPTCP connections stall on
> zero-window event due to auto-tuning changing the rcv buffer size quite
> randomly.
> Address the issue synching again the MPTCP auto-tuning code with the TCP
> one. To achieve that, factor out the windows size logic in socket
> independent helpers, and reuse them in mptcp_rcv_space_adjust(). The MPTCP
> level scaling_ratio is selected as the minimum one from the all the subflows,
> as a worst-case estimate.

Thank you for having shared this patch!

> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> I still see quite frequent failures on mptcp_join tests 19 && 20:
> 020 multi flows, signal, bidi, link fail
>       Info: Test file (size 12288 KB) for server
>       syn                                 [ ok ]
>       synack                              [ ok ]
>       ack                                 [ ok ]
>       add                                 [ ok ]
>       echo                                [ ok ]
>       stale                               [fail] got 0 stale[s] 0 recover[s],   expected stale in range [1..-1],  stale-recover delta 1
> 
> I *think* such failures are still caused by dfa2f0483360 ("tcp: get
> rid of sysctl_tcp_adv_win_scale") because it should change (increase?) the
> rcv buffer/adv win size, and such tests depends on the transferred files
> being significantly larger then the adv win. Since the current breakage is
> pretty bad and the above needs more investigation, sharing it now.

I agree, fine to delay the fix of this test.

> @Matttbe: fill free to adjust the tag whatever it fit you better!!!

Thank you for having mixed the two versions :)
Tags look good to me (with the Fixes one)

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9f00a0288a0a..3ab67e0dfda9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -90,6 +90,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
>  	if (err)
>  		return err;
>  
> +	msk->scaling_ratio = tcp_sk(ssock->sk)->scaling_ratio;
>  	WRITE_ONCE(msk->first, ssock->sk);
>  	subflow = mptcp_subflow_ctx(ssock->sk);
>  	list_add(&subflow->node, &msk->conn_list);
> @@ -1906,6 +1907,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
>  {
>  	struct mptcp_subflow_context *subflow;
>  	struct sock *sk = (struct sock *)msk;
> +	u8 scaling_ratio = 255;

Small detail: can I set it to U8_MAX when applying the patch?

(...)

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 1b4457c44fe8..86cd4d9e8432 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -293,6 +293,7 @@ struct mptcp_sock {
>  	bool		csum_enabled;
>  	bool		allow_infinite_fallback;
>  	u8		mpc_endpoint_id;
> +	u8		scaling_ratio;

Small detail: should we declare that in "rcvq_space"?

  msk->rcvq_space.scaling_ratio

It's up to you, I'm suggesting that because it is linked to the rcv
space stuff and I see we put variables linked to that there.

(I can also do the modification when applying the patch)

Once applied on our side, do you prefer to send it directly to netdev?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
