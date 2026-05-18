Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A01A3E3165
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094072; cv=none; b=GawGS4mSMugooZ+2zBk9ZxR7pA/HlZPEKBdMVOnf4Q92X9zTYMypATVjFOn5Pk2MQJ7lJzW46fkPHL9caolEawo8wZRh3yCF8QmQNOS7QVlU45t8rMlfZFt573eQjHp2ka0fPaovePBALzSW9IDVamIbJemHHjc3Xuhu/BuDP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094072; c=relaxed/simple;
	bh=0qRH9Nsr/xu9OrME//6ARZYnL/aUIzDzazLKmvHwfcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJ9xG3tbul6+6ZlzAR1X/dr17Rx4nWKYxqpaGqDvDfz3m6Kqbo+BFAf93sWJiL/fQKx1A9tZ7dbvMtbvPeVcOdBSR3kHwIIUW8j0IGz6q6FmHSuEdRuOfAdpkiY6dAr/8ek1PQi/kyO2pdKJ4dsngGSGUxcRhcWgUIYuMYChusA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3vhCxMW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3vhCxMW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779094070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4kSUq6PvVtts3x2WfBMp3XrKrkFsyfjW9wSgqKO7OPM=;
	b=L3vhCxMWsUHcT/vam9BY0Aw3abfKIjvWmu+qbhd9JyiHCzzqH1SfVHq9HIFjcm51FTwAdA
	scQxLqYrg27Je0WLy64asj1YUEgY54lePpZco0+rVa3xhhlC/6xyZFSDDiiLN7xSNO5n6f
	7YJ9XxixMCrhYeOMY3wjRYaKgYnXKv4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-FecINXfoPVKCNg_6Mhkt2w-1; Mon, 18 May 2026 04:47:48 -0400
X-MC-Unique: FecINXfoPVKCNg_6Mhkt2w-1
X-Mimecast-MFC-AGG-ID: FecINXfoPVKCNg_6Mhkt2w_1779094067
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44ffa15dc8cso1088213f8f.1
        for <mptcp@lists.linux.dev>; Mon, 18 May 2026 01:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779094067; x=1779698867;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kSUq6PvVtts3x2WfBMp3XrKrkFsyfjW9wSgqKO7OPM=;
        b=EHLDd4o07FbD5T4SQ5J8mSoolp/KFvWSyfRozfg2ci5HXikvGGqq6OmoIbtmOQ+Lbp
         0g8rJ5WN/fyus1ZGv7511y/q26zaOfhtNRmpOw3tYhf+RggG2Tw0h9RRTMMCbxDXBQzp
         PkgG/WlbWj7PggrfF0s1FlT+wbqiAg5ups4oAs7hawuLVdg+5qDW3jdY8mLD6Kudg90/
         iCwAATgJU4344KLFzdHmB/4D79/7FEnMPvOBNQB7rF4SqB8/bReh03e7Wm+phxNIMgP+
         +FOo989ehEcG/VvI85T7z4+zOWRcrEBcyosAsvFc4q2m4TIjOLsbpk3FvCJrq0kZ3MQK
         sadg==
X-Forwarded-Encrypted: i=1; AFNElJ8Q5FBAoVN2fU45aSCPFMZDBSMM/uy/Fs7jK5RLzahj+N97fAo1mTpv/jZufNJcKCz89kH3Fw==@lists.linux.dev
X-Gm-Message-State: AOJu0YydFLjjT/qWgRmfvsLdh5Hs8xXxZFyTqx/O+jf5Dp+BHj6JYXei
	bDIZbytQfpwN5/fAMLraTRgFgZpK3vqT7elnirPhkQYxOzIN/6au8snvPe82jSBlxKUFuYb4Ouf
	i2Z4Yz2sIfpsnMmBR240W00orP9ttNmvMNNpBEKGiAwiiRBwUP05BmkV6W8lJVolo
X-Gm-Gg: Acq92OF6+uEABZPAod01AtjhBXrCzcTIhPJoYYpq5UjCPmv4Zb+3x1HH2BfknW+2Sz9
	ASyF3abOu83rXlQ7KDCUMfWxUEafMpz+zkkdTyFv/nwiswsCRmUF6BfLHqQwVdJjL1t59fJlC0P
	q73FaBCJsI/SkTqV6ziSa5NdRLfdlCjvBxMqHmNv6vNpm/g/khjyozHNPk7hxclZo+mTdxkRC7u
	NoK982i0Ci7O+nVpz2epE+K3slp+n2Zd912AJMUdaB8JWDHcxDEEGm32WJ95WOPSUwhEpNuyVFP
	8z6cGqnBVWRkyjOxK3hZajZSZBhSTUtQ6ikmK0ch+9noJg42sbb6z9ytgQi/HI60oMfTXZbUxT1
	UhsMSjDKE1fT7f7n2siK17WpUrOv8R9CmuQ4MPfxdDBZoeLlS+l2DyJ8=
X-Received: by 2002:a05:6000:18c6:b0:45e:73a1:8db5 with SMTP id ffacd0b85a97d-45e73a18e91mr6396039f8f.40.1779094066978;
        Mon, 18 May 2026 01:47:46 -0700 (PDT)
X-Received: by 2002:a05:6000:18c6:b0:45e:73a1:8db5 with SMTP id ffacd0b85a97d-45e73a18e91mr6396007f8f.40.1779094066555;
        Mon, 18 May 2026 01:47:46 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm38261136f8f.10.2026.05.18.01.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 01:47:46 -0700 (PDT)
Message-ID: <46d5b8f3-4360-4743-bbc9-27b126531639@redhat.com>
Date: Mon, 18 May 2026 10:47:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] mptcp: prevent stale backlog references to closing
 subflows
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, matttbe@kernel.org,
 martineau@kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: shardul.b@mpiricsoftware.com, janak@mpiric.us, kalpanjani009@gmail.com,
 shardulsb08@gmail.com
References: <20260518050048.161374-1-kalpan.jani@mpiricsoftware.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260518050048.161374-1-kalpan.jani@mpiricsoftware.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UFRJYfVZWHdUqRqTUlLaNHo8QU4TP5H9tCbPyxjO5RE_1779094067
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/18/26 7:00 AM, Kalpan Jani wrote:
> @@ -2549,6 +2566,22 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  	 */
>  	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
>  	subflow->closing = 1;
> +
> +	/* Remove any reference from the backlog to this ssk; backlog skbs
> +	 * consume space in the msk receive queue, no need to touch
> +	 * sk->sk_rmem_alloc. Serialize with mptcp_data_ready() under
> +	 * mptcp_data_lock() while the ssk lock is still held, so the
> +	 * cleanup is exhaustive: no new skb can be enqueued after this point.
> +	 */
> +	mptcp_data_lock(sk);
> +	list_for_each_entry(skb, &msk->backlog_list, list) {
> +		if (skb->sk != ssk)
> +			continue;
> +
> +		atomic_sub(skb->truesize, &skb->sk->sk_rmem_alloc);
> +		skb->sk = NULL;
> +	}
> +	mptcp_data_unlock(sk);

Here you should use the just defined helper, and only when `flags &
MPTCP_CF_PUSH`, otherwise the backlog cleanup is already performed by
the caller.

>  
>  	/* Borrow the fwd allocated page left-over; fwd memory for the subflow
>  	 * could be negative at this point, but will be reach zero soon - when
> @@ -2587,6 +2620,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  		__mptcp_subflow_disconnect(ssk, subflow, msk->fastclosing);
>  		release_sock(ssk);
>  
> +		mptcp_cleanup_ssk_backlog(sk, ssk);

Why are you cleaning the backlog again?

Why you did not use the code I suggested?

For the next iteration, please go trough the mptcp ML only, to reduce
traffic on more busy places.

/P
/P

