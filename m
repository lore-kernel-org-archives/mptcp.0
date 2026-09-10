Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FCA38A73B
	for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055830; cv=none; b=na6JpVFG+Gd+3KorEtPl7MplgEfeg9TIQ8FFwGFbg1WYX4SNPkwLWsN75DjQlcUB6u3GMj9+ySt4+A78scOPTZj+1ZblswkzpH5B9Zac9H1o3nyGSfPI49wPeBHnIdWlFXnPfDjGv8/gOiuzLCRvGMTApUcHawN+a/vF5gmN5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055830; c=relaxed/simple;
	bh=BkSk1UaoFA2REBq3iIZceLv4sf/SG8Kvm8pX48wn67E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hWERzvUvdJC0VYNr3AzT6OzEMj9jl1Vm/Oj/OijuD6+T7qS+rEKb6u6OBQckH0s5JRZEsMMmk9e1wu2zbRygGY0BfgND98zLpLBo/xOwXic4pAPZJw3iZxhMDYuU5zNcZau/TNDj0pR4KNbdY2WfKNEvbcMu1JRNSCQYIShHQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzwnQxMj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzwnQxMj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789055828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OEj4hC8Y49cDpkKBujyt6Yg8fnoYLzZx9fhbsi43bqI=;
	b=NzwnQxMjr/OWRuiNdn0m9DPbyLHxKEYTd6t13ViXaBis130Al4SrLIp9jvPCZT/6utW+Ih
	m0ZYGdh6VRikdIJZ6huQD/lXfJ+BmAloa5gk9VqmdF8b+h0wuDY5CnR3F64e0VNxIqU+dP
	LDgBqTSZxvK9WBYRoNaHKuojL3JGLac=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-ref-R949N5aGwJNy9CRVmA-1; Thu, 10 Sep 2026 11:57:06 -0400
X-MC-Unique: ref-R949N5aGwJNy9CRVmA-1
X-Mimecast-MFC-AGG-ID: ref-R949N5aGwJNy9CRVmA_1789055825
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49991beee7aso66440355e9.2
        for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 08:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789055825; x=1789660625;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OEj4hC8Y49cDpkKBujyt6Yg8fnoYLzZx9fhbsi43bqI=;
        b=gZAjaMzhJEtQcZbVy2V8ldDmSeVAbkvvKbYQ86j8uOtAJiqObDJyOR7MiyDWgHumZD
         ldOMXCkb3dl4m6UuA5Cn4ap2Qn3/RkE7AvuONwoem5NGcWZxtawF/YyNUkGQGu5COnOI
         VK+nXgpNSY5DrYsoufd/HX/kFzWG6JNvzhXcpyy2/pnQZ2pnW0QlaelYitTLG8IxwDeh
         cK+SiJF4X8Brwg0+0m28C2qnPRFjiB1g/WKVSZYfRpQh6w28h968eSp2GPxaqWjjN35z
         eIFeCvZ6Xd/5t+MnZm1CvocI5FYRrP6fQeSKXm2kbbKLB6kk+Ti9ox5YwPJKtsn3aaus
         bD8A==
X-Forwarded-Encrypted: i=1; AKwUvBzu5ZAzUYDwdiZ7BaI1ZeZ7hPqDI0eCpc2bh1cBwrbcUVSd8KRyJSKdtQrJVcrwQqma5l/u6Q==@lists.linux.dev
X-Gm-Message-State: AFuF++nXrkXEVU3IJMdorAHxQKix5VyAGKRy3CzUgwefll573vGKhWZ3
	+izUy6GQ5siZqJ/+S5X3bIzwDYQTYzFYVlOQ/7o797w+YmPIi3qYAO/Bp29tf8ZkO7GsCQeIIet
	1Cp4DWA1qUyEfjZpuUzzYZSWXIVx0L+avTyIS6pxQtmY72I3fjrQ6g5u5fFEsaHrg
X-Gm-Gg: AYBFou3u3HyBSgxn2ToNklJAnuqPxPdInaDHi2ulhFjhQiCpAXVTs6heFGJKdYVRQRx
	WV0S8I1nnx/KyqT4Z1EAxl/mGRhX+7f5ovbwHAcJkDwVUySZMY6WVzfEM6UvV9rEPi5R4eSUO/w
	nZYa0RO92jDc6Gof1kFiR+bd5XK6MFxZahnZGGPC7LH7UCATqFuQvaYQiyJOxXNKedFvXumrFTl
	CvaFa1R4+zUedT6DeAImc6m745MBYKx/edRNFB+1k5phfkEAMcx3+n1d0gmdoPW9M9jUgGtVeni
	sVMjEwgNdo+gc2ID8mXp7QwUW1JY8dgHlSl6/7gLcUwl9HnNiw0q6jpLC5PkNEWzzMIFZCYOfuP
	SpRpyOXyXoYnuxNZnkA7E+Mz+4+XhyMhksWI1AHfdf2V+lf5vIh1uVjQZA8ZgN0CtCjdFnYGnSw
	==
X-Received: by 2002:a05:600c:8b88:b0:49c:f512:2361 with SMTP id 5b1f17b1804b1-49d2593842emr186879865e9.14.1789055825333;
        Thu, 10 Sep 2026 08:57:05 -0700 (PDT)
X-Received: by 2002:a05:600c:8b88:b0:49c:f512:2361 with SMTP id 5b1f17b1804b1-49d2593842emr186878825e9.14.1789055824902;
        Thu, 10 Sep 2026 08:57:04 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60aba026sm4176925e9.3.2026.09.10.08.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 08:57:04 -0700 (PDT)
Message-ID: <b2107d7d-6202-42ec-a431-ec2fae7db53e@redhat.com>
Date: Thu, 10 Sep 2026 17:57:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 1/2] mptcp: reset msk state on early connect
 failure
To: quanyeyang@proton.me, mptcp@lists.linux.dev
References: <20260910-mptcp-connect-undo-net-v1-0-446e4a4ae3e7@proton.me>
 <20260910-mptcp-connect-undo-net-v1-1-446e4a4ae3e7@proton.me>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260910-mptcp-connect-undo-net-v1-1-446e4a4ae3e7@proton.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D_kSDCYU1658VsvQ9RD1BovBBfGUTG7D73sY1dXGSjg_1789055825
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/26 2:23 PM, Quanye Yang via B4 Relay wrote:
> mptcp_connect() can fall back before the subflow SYN is sent, for
> example when the netns is in an MPTCP blackhole, token allocation
> fails, or MD5SIG is in use. If the subsequent subflow connect()
> fails immediately (EAFNOSUPPORT, ENETUNREACH, ...),
> __inet_stream_connect() returns while the socket is still
> SS_UNCONNECTED and never calls ->disconnect().
> 
> The error path only dropped the token and moved the msk back to
> TCP_CLOSE. MPTCP_FALLBACK_DONE, allow_subflows and
> request_mptcp were left as after early fallback, so a later
> connect() on the same fd stayed TCP-only.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/633
> Fixes: 0235d075a592 ("mptcp: mark as fallback even early ones")
> Signed-off-by: Quanye Yang <quanyeyang@proton.me>
> ---
>  net/mptcp/protocol.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e1f08f71cdb1..ad476d29bf3d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4129,6 +4129,24 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
>  	return 0;
>  }
>  
> +static void mptcp_connect_undo(struct sock *sk)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sock *ssk = msk->first;
> +
> +	mptcp_token_destroy(msk);
> +	mptcp_set_state(sk, TCP_CLOSE);
> +
> +	spin_lock_bh(&msk->fallback_lock);
> +	msk->allow_subflows = true;
> +	msk->allow_infinite_fallback = true;
> +	clear_bit(MPTCP_FALLBACK_DONE, &msk->flags);
> +	spin_unlock_bh(&msk->fallback_lock);
> +
> +	if (ssk)
> +		mptcp_subflow_ctx_reset(mptcp_subflow_ctx(ssk));

Overall LGTM, but I think ssk should always be != NULL. Also it possibly
make sense to avoid entirely the additional helper, just open code it
into the mptcp_connect() error path.

/P

