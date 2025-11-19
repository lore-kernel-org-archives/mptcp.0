Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773D18E025
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763587825; cv=none; b=mivP9yLmM+mBG01bYZCFWbsu+QkGKRYzEpJ1ae+eyGlQxWf1KwIt7R81+hrELOYM2tJSPVCmgAD4GJfhRTtdtHGEeHGGS92GRhnDuWIAP1P+6Kjxt5RhsWD9pq4fvUeiaqnZbqGWYCL5VbD5sOOrLY5DUE9atWDcrTwU0zossk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763587825; c=relaxed/simple;
	bh=ujJzzhVs7UeP/BtHvcD3JYhKp+nTwm8j9pUd68LpyCQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=vGZm2SFGfQdDrDrJF9RaTkncx08Gc2Gh1rQdGAfmlrf/8TAwWK/1Db85YEK3pg0ULWoLBd53E6wo0XmRHvVUhzDwq3edCmhPG319aB4eeQzcNEuvU/e/hpMgp5fl1Mj59F/0aWBp4X0YZkLtqCh3lbN99Kcl+axmT4dkCH5UjYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iINRsS4E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iINRsS4E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763587822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9R2JQ8mQbdhjJxXuBxcRH8CO76zYpCgDbXsJ1Li9q+E=;
	b=iINRsS4EWNc08tKDDKzvBJ5SaaxSYyiqyVj7Omsu1UR935iIOezVh7GcxxjZCUZy8cW99G
	buY2Y9q2L5KFfwaGrM1hxf3E2zKx8SpCuwg1hd9vNu+f9snuBjtIuNCkKPQBgTXwFF+qyo
	yp8252SS7i954bQlEzfpqkwnRzEe9OA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-CzCPPgYOOjuhzbGZ-jKXoQ-1; Wed, 19 Nov 2025 16:30:21 -0500
X-MC-Unique: CzCPPgYOOjuhzbGZ-jKXoQ-1
X-Mimecast-MFC-AGG-ID: CzCPPgYOOjuhzbGZ-jKXoQ_1763587820
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477a0ddd1d4so2864705e9.0
        for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 13:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763587819; x=1764192619;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9R2JQ8mQbdhjJxXuBxcRH8CO76zYpCgDbXsJ1Li9q+E=;
        b=NHEwPYf3UNiVbqVELDQ2Urk6bvpj/E+vkzqh+FpLl4StfvEU+ZrSRFpRIMjm3cg+x1
         cycjY/01N52HgfePvTXAV7OLu9SusKl0Mt6xePKfUiLUVdJ31h6j38FxpWQGJI/j6Rw1
         Iq6c9p3Jiottd9NP92XSPtsuKPzwsEtPewws4uaQIMSVajoQ21uJOFVNHTftU4p7jdHs
         wiPx5ZV3c5fgRE753gzS6dZvlBP7gy5EMDOUfn38IAY4b+0toY0sjnRxpy4WtzOIERhI
         mTmkKXbgUWDxx0CtQmX4vsnd8g1Ex96u4wtTiPGxvyX4UWyIIj4uqM4IZsWA/8ZgEcl+
         m5Sg==
X-Gm-Message-State: AOJu0Yxq94gFxZxS+ZFqN08rqpKsM6aaGHTlYvBb81UN3mxzqXz0Kzr+
	xkxJp7jmmDYrytNELi6YKcXtzRG4brVDABAMvhq7IgoTfPBF95ytLowL+338r3AGh71tskRPC7S
	vdYldICcjfLc0DH0PeZsDPrQgggBQcVBgbeS8TSuNAOLCcOOsVYy0Dcqa6bEgvuMmAqXL5hSs3y
	3cE8dElHJYW4mI8idchmJZRKXgG48X4Fc/ZsEb8w==
X-Gm-Gg: ASbGncuLElpZTdjJYurSKV3QrLP3mrus7yxzEo86s37iEIgZR9nEz3cxrN/iOaODnuX
	HYJwKY6YpKoZsPT9wMU6S4yYX2QrS3BlvorbuQJYQH5L4GRpuCXKFwM+cF/a8uKOrxAhbBmjbwB
	Yi9DdVhW/vtbNLXzkTb4bCTX1MeWFgvS4JK5+4fMh3Oit3X/tDumxuB5aZAWtgXAHAh8MHO3Z0n
	tT/unX8JSYfVlRc+zTN557wn5duCbowxkmrsA79eXk/DAkkjIU/q638bEqtBDQY+ECUsH1/m5qe
	dCLdjM7zljJMMCO8C7PeUmI+3hwS+mEM8zfcSmfWNePgzQAD8493Kfn8zjIJ1vG0a0Pf8o+UQJB
	MiJboSw8dmN6O
X-Received: by 2002:a05:600c:8b22:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-477b8aa3615mr6836465e9.35.1763587819513;
        Wed, 19 Nov 2025 13:30:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZSRg7p0jhfBCQ+Fgj2/+eMp5GMpV84HTSmQ5cE2zIlLykWl4iVbCcb8YnnwjjEUUTVTkczA==
X-Received: by 2002:a05:600c:8b22:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-477b8aa3615mr6836245e9.35.1763587819048;
        Wed, 19 Nov 2025 13:30:19 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b0ffd37bsm70129355e9.3.2025.11.19.13.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 13:30:18 -0800 (PST)
Message-ID: <2b4384b3-39e7-41e9-a7df-8521067b817b@redhat.com>
Date: Wed, 19 Nov 2025 22:30:17 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 3/5] mptcp: consolidate rcv space init
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: martineau@kernel.org
References: <cover.1763553361.git.pabeni@redhat.com>
 <59152266d5ed10c8b47da33cc5f087f2fcfaeb68.1763553361.git.pabeni@redhat.com>
In-Reply-To: <59152266d5ed10c8b47da33cc5f087f2fcfaeb68.1763553361.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vUD9KSIx8GbyVXm5SbzvEpB8wAjTNsnkQbjDvAM9UHg_1763587820
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 1:12 PM, Paolo Abeni wrote:
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 86ce58ae533d..23f439853a7c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -462,8 +462,6 @@ void __mptcp_sync_state(struct sock *sk, int state)
>  
>  	subflow = mptcp_subflow_ctx(ssk);
>  	__mptcp_propagate_sndbuf(sk, ssk);
> -	if (!msk->rcvspace_init)
> -		mptcp_rcv_space_init(msk, ssk);
>  
>  	if (sk->sk_state == TCP_SYN_SENT) {
>  		/* subflow->idsn is always available is TCP_SYN_SENT state,

My fault, I tested only lightly after removal of old patch 4/6; the
above is buggy, as now rcvspace_init is delayed to recvmsg() and
packets can enter the OoO queue after accept while space is still empty
causing divide by zero in mptcp_rcvwnd_grow.

I'll drop even this patch, the cleanup is minimum.

/P

