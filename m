Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2B29A9E9
	for <mptcp@lists.linux.dev>; Sun, 10 May 2026 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446268; cv=none; b=OXPcloSDOAEJY/FZk09ANJA29IWwbzaQahr+TUYWLUZD6xfDA8MyyRFklViEzRxD27pK9IhPD+oASItiXgkOVD/1idAL/9laBGbW594eFLbZhs7xyH1g96CteKA87D90Ami2marNrY/SH+B+bgy6q2ARCvTChRGYyLOwQDFaU0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446268; c=relaxed/simple;
	bh=A50e1Y41XxnCNYh2oHSmK062pSGA+AWp0fu4hZ4UJ4w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=C1IG/oKbysL2b/5cl8Wcegqo3cgCAmzcNTbDHwOKi0Uep5afDWMkmFphslhePzx5lzwUarBHGK8+jJ3gQMz56czcVD+PI7apa7ffYQlgLKMJL6hA4l306tbIckUvI2/zqFJmsfKKxNL1ebk2wlOci6mFJMK5ZjYmRlnNE0qKSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOjxEM3/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOjxEM3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778446266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lSusibQIimXAyT9q9jwIXdRlSegbsam6nyPts8zrU5I=;
	b=XOjxEM3/PrEcCR03CHr8+/SWSgl4kMpkA5A55GTUarUQVLZeZu75HX8gl96n1t2XNmN1Xg
	FgRHXnL1mGIEuSMpAeIwvPHdJzj8Ca1U6TS7GwUKqyTaFdtPT/m+/v3d2dfkWFT389Folm
	K7hPYnXA6FSjdVH6XRm3Hr8eLK9oNfE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-HN68ofsDPuWYtEs5cpHR-g-1; Sun, 10 May 2026 16:51:05 -0400
X-MC-Unique: HN68ofsDPuWYtEs5cpHR-g-1
X-Mimecast-MFC-AGG-ID: HN68ofsDPuWYtEs5cpHR-g_1778446264
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44a122a5128so2735767f8f.0
        for <mptcp@lists.linux.dev>; Sun, 10 May 2026 13:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778446264; x=1779051064;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSusibQIimXAyT9q9jwIXdRlSegbsam6nyPts8zrU5I=;
        b=sVdakrj4goBzqRMNaGuql6ecqlmyMG2beS7rw5Yndrt0xiq11D3L2g7Y+sMklp2zGS
         7zljG0CqQGdQJd7scrbDW9UtHxu7c41U7w1PofQ/+RMJNGhc5rCN+I/eG8smW1c/WZOk
         lnj+SN4klI5OfWNn9WF4X7nzwNo3u9CWr5yCai6twkTFth9BcO1L2oT+oMpO4ilEjoH+
         RFH1x0rUxYaeeQKdabOEpeeqwqkCeA3RUI87/qDH/9/jN2B2ifLDV7FOfYjfSOe5KEcu
         EpI0rklGwhd9wEttc0s7wiUi0W9cQHQlxIU/kf6NeCcOLw4l1xiLxucAUU+xOLzPof89
         7OGA==
X-Gm-Message-State: AOJu0YyI6VRAaJGV1p47PjT8Mbx5RgeOc8r5Jji95OC98gEYzkUSCVFu
	D5k1PaTREKU2/YcqjxkSctcZI1/iRKxhcsaRUbI6GL3SuHDJsfE9bIu1SUvBbHblIJOUlKufXoC
	kA/cqEcN1peU2GL8rFWE7/wDk3u4rIiZNByI2BbZwYUp5d8dPIncw8co8XirsSUR6N1LOD18pAu
	VdoGE9/ZrcDRysV75dAz+fiE4orafky1KzdrrJrg==
X-Gm-Gg: Acq92OHW6Ci7yLyU0UB88K2YIkFlH2FKP55nCtUuInehrQCJbkLyvmEBPnuso00X7Jb
	ChsUd3fgc4FwrWm5mzty72GRcQtxXLAoeHAjJtScWjh+Dldt5dX0f4E5gh3pPkdr3m2hvssRFQX
	JoTEE5kHfQuaqGrZXxCPnv64aRUgNaxVD4dU/iCG+/wsy8qcfaL4v9W2eZpgbqRfTWHKhZUTDiw
	5/6h++22Tls/dcebFc7Kcr9NVFkvdsXakAdBhUgAa70vcDuLOQLPUgIlQ9ooLA22dX8QwGjhVhq
	MXIYPlN029VzR+8jRkiMyx97+3jez2pRmZqqG/gT24rbv45vFoNbVlpts3xlw/ploQpgQ2DSIV/
	Xa0UuajrzXZCQzvwkAZdWtzhNMvlGRXxWOau+/yexoWCO7tl/V2bhoB4X
X-Received: by 2002:a05:600c:8594:b0:48a:52ce:a4b1 with SMTP id 5b1f17b1804b1-48e676a4e1fmr135625325e9.15.1778446263766;
        Sun, 10 May 2026 13:51:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8594:b0:48a:52ce:a4b1 with SMTP id 5b1f17b1804b1-48e676a4e1fmr135625115e9.15.1778446263198;
        Sun, 10 May 2026 13:51:03 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db1e945sm48906155e9.36.2026.05.10.13.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 13:51:02 -0700 (PDT)
Message-ID: <5475c74b-f435-4b59-966e-36408cf30a76@redhat.com>
Date: Sun, 10 May 2026 22:51:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 10/12] mptcp: track prune recovery status
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <cover.1778312843.git.pabeni@redhat.com>
 <c9803bc25b3f40f87a3081b00093068ad66fac85.1778312843.git.pabeni@redhat.com>
In-Reply-To: <c9803bc25b3f40f87a3081b00093068ad66fac85.1778312843.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lXUcw-3HwCr3BBPsF0YaID7UtVMXEP4uH-x7j4CUOGo_1778446264
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 9:48 AM, Paolo Abeni wrote:
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index d7e712171d3b..9b8de027848b 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1200,6 +1200,13 @@ static bool mptcp_over_limit(struct sock *sk, struct sock *ssk,
>  		__set_bit(MPTCP_PRUNE, &msk->cb_flags);
>  	}
>  	ret = sk_rmem_alloc_get(sk) + msk->backlog_len > limit;
> +
> +	/* After pruning any packets ensure that MPTCP-driven drops do not
> +	 * cause TCP-level retransmission.
> +	 */
> +	if (before((u32)(msk->ack_seq), READ_ONCE(msk->pruned_seq)))
> +		ret = false;

Sashiko says:

---
Does this read of msk->ack_seq need a READ_ONCE() annotation?
If sock_owned_by_user(sk) is true, a concurrent thread releasing the socket
might modify msk->ack_seq via WRITE_ONCE() during backlog processing where
the lock is intentionally dropped.
Since msk->ack_seq is a 64-bit value, reading it without READ_ONCE()
while it
is being concurrently updated could lead to a torn read or trigger KCSAN
data
race warnings.
It looks like msk->pruned_seq is correctly protected with READ_ONCE() in the
same expression.
---

No, this is under the msk data lock, and msk->ack_seq is updated under
such lock, the access is race-less. (very strange sashiko's miss this one).

/P

