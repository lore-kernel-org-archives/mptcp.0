Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612365A
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 07:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662708723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUDoiLupNKmFl9BYssfEKfHmmYPAACgsE3JfBkBxD6Q=;
	b=Ipdw7p58EFIh6noiY4Bd7DpKWf2sj/Ix+AecOoNX9jQVpishKQguD9W494P/Vh7zjJKjZ0
	UgF5re6uaTVUiFA49jVboUXxtnZmztorhRN8HAbLQD83ZDpDbekqaSvFkwy9+q9cSBy+iN
	U7MAFKtHNCWPkT71exkR6qjK/wLT3zo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-61-2TK5Vy-iOZGxSoNYmTTQBQ-1; Fri, 09 Sep 2022 03:32:02 -0400
X-MC-Unique: 2TK5Vy-iOZGxSoNYmTTQBQ-1
Received: by mail-qt1-f198.google.com with SMTP id s2-20020ac85cc2000000b00342f8ad1f40so860394qta.12
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 00:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=QUDoiLupNKmFl9BYssfEKfHmmYPAACgsE3JfBkBxD6Q=;
        b=anH0zoM3SBETzgSpwCyqrTpsilYs8ezvjqYKpwHLaVSIW2B0+Jj1h/s/1VDnEe6TXH
         ijjQ1mRWUJJmGHAQHsF49FQ8b/dSQBRGqcmJi80NCMiAc4PxFAfXN86Ma2lDozTeCktr
         Yvqpx+hEnv5/fnvGI6xSGtfT92U8rh0qP+ITyTj3ky/7j7mPmhzik9YPnT+qgmu7Ehvh
         n3fwjMwQ7eplN+uHIFttmxNiHblIriu9OaxyZmPmYMkmUTkf+toDZe+4IJ6zDHRIOVw3
         GNC9bonw49mBJYhLl6FjKvYwQXyKHYdcqVxuQSKsKjS8EGchKDOoahdeHgxyNJOY+mqq
         3W3g==
X-Gm-Message-State: ACgBeo3eG4odCSJMxUt0k7AimWcmMTu1sNW9Yv3e3W2VmSRcmqK4Kwr1
	tDt7FYXV/S3L1u2UlecL5E4sUV1qi5E50/wRqUb03maxl99+yAQVdVh/qYidbJ5QdyrysIUfMeS
	gz4g00x81I3PJ1BQ=
X-Received: by 2002:a05:622a:130c:b0:343:6753:127f with SMTP id v12-20020a05622a130c00b003436753127fmr11617103qtk.88.1662708722343;
        Fri, 09 Sep 2022 00:32:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ALbRid9atfaq0ITF9dAHAEnz/Tv1dTOp7J7X9Sx6/ul/JOi1o0C4r5uZ18J6urNaAkOCqgw==
X-Received: by 2002:a05:622a:130c:b0:343:6753:127f with SMTP id v12-20020a05622a130c00b003436753127fmr11617090qtk.88.1662708722090;
        Fri, 09 Sep 2022 00:32:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-119-112.dyn.eolo.it. [146.241.119.112])
        by smtp.gmail.com with ESMTPSA id do14-20020a05620a2b0e00b006cbd60c14c9sm875628qkb.35.2022.09.09.00.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 00:32:01 -0700 (PDT)
Message-ID: <e5ccdd9584523641866dbbe906cd7ad4e2f1c43f.camel@redhat.com>
Subject: Re: [PATCH net v4 1/3] net: mptcp: factor out __mptcp_close()
 without socket lock
From: Paolo Abeni <pabeni@redhat.com>
To: menglong8.dong@gmail.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>, Jiang Biao
	 <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
Date: Fri, 09 Sep 2022 09:31:58 +0200
In-Reply-To: <20220909054932.246221-2-imagedong@tencent.com>
References: <20220909054932.246221-1-imagedong@tencent.com>
	 <20220909054932.246221-2-imagedong@tencent.com>
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

Hello,

overall the series LGTM, but there are a few small cosmetic changes I
I'd  like to suggest, see below and the other patches for the details.

On Fri, 2022-09-09 at 13:49 +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Factor out __mptcp_close() from mptcp_close(). The caller of
> __mptcp_close() should hold the socket lock, and cancel mptcp work when
> __mptcp_close() return true.
> 
> This function will be used in the next commit.
> 
> Reviewed-by: Jiang Biao <benbjiang@tencent.com>
> Reviewed-by: Mengen Sun <mengensun@tencent.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  net/mptcp/protocol.c | 19 ++++++++++++++-----
>  net/mptcp/protocol.h |  1 +
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d398f3810662..1cfb4f1ff4e4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2796,13 +2796,12 @@ static void __mptcp_destroy_sock(struct sock *sk)
>  	sock_put(sk);
>  }
>  
> -static void mptcp_close(struct sock *sk, long timeout)
> +bool __mptcp_close(struct sock *sk, long timeout)
>  {
>  	struct mptcp_subflow_context *subflow;
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	bool do_cancel_work = false;
>  
> -	lock_sock(sk);
>  	sk->sk_shutdown = SHUTDOWN_MASK;
>  
>  	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
> @@ -2833,7 +2832,6 @@ static void mptcp_close(struct sock *sk, long timeout)
>  	}
>  	sock_orphan(sk);
>  
> -	sock_hold(sk);

If you don't remove this line you can avoid adding a sock_hold(sk) in
mptcp_close() and an additional one in patch 3. The diff will be
smaller and the patch clearer.

>  	pr_debug("msk=%p state=%d", sk, sk->sk_state);
>  	if (mptcp_sk(sk)->token)
>  		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
> @@ -2844,10 +2842,21 @@ static void mptcp_close(struct sock *sk, long timeout)
>  	} else {
>  		mptcp_reset_timeout(msk, 0);
>  	}
> +
> +	return do_cancel_work;
> +}
> +
> +static void mptcp_close(struct sock *sk, long timeout)
> +{
> +	bool cancel_work;

I think this variable name is a bit confusing, as we already have a
global function with the same name. I think 'do_cancel_work' will be
better (and again will produce a smaller diff and a clearer patch).


Thanks,

Paolo

