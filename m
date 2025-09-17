Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855152DF6E3
	for <mptcp@lists.linux.dev>; Wed, 17 Sep 2025 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126914; cv=none; b=hBNw5XRSSWi4X25FcIDAtVovR2yJ5xntt5XsR01jIaG8P93S+qKIGdfp4hDE7hT4Kg1f3fRMjvrD+rasP6ZhEAO6le61+ND9oFrRv5vy/oqy4o9YHOaQ/N3laAh+KKOFNJMeDolRnrPN1EQjOErl+azDhdo65aFvYxXOZ5FIkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126914; c=relaxed/simple;
	bh=AF/XyO3JTmwxcvR9Z83HIIMcqtIA4M+mF5LB1GV2Tjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UgPRH3unyvQaHyc8I91KPTJjWcMwf9rtD5R++VMWekCpns7n+w8k3VAmuOBXzbAvR02uUbmgbs/TtNfmvWaY5CQuQpZM4QFdJ+lXIbTD1anT+OGpFWCoFHAHqbp7QJy3S3kwoenX7HO41u/XZnpZNvxJZF1RI7mXgCRYafhvQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JiZsIx7j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiZsIx7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758126912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPnQf0Orubl6LY1z68Wp6RtEDEQZyWCIqCHotCcuCow=;
	b=JiZsIx7jKfLTWosdeIS1UDdeoGvhZDHluIVS0VxO832C4N92m2GxuM+QKVSp+IkMMkQwau
	wEnq41gAyRnVjL8UHdiSVyk4/gFY42CMNmRoi2b5eUrSpPrEcfAecJ1vf441ZZNCWCAMoN
	h3X22af1Mmu1FBZwjm8IeAqNyngiqR0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-iYY43vTXODm9Vadk-Rksjg-1; Wed, 17 Sep 2025 12:35:10 -0400
X-MC-Unique: iYY43vTXODm9Vadk-Rksjg-1
X-Mimecast-MFC-AGG-ID: iYY43vTXODm9Vadk-Rksjg_1758126910
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f2b9b958aso28705905e9.3
        for <mptcp@lists.linux.dev>; Wed, 17 Sep 2025 09:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758126909; x=1758731709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPnQf0Orubl6LY1z68Wp6RtEDEQZyWCIqCHotCcuCow=;
        b=MpIMmCa4FfD9jMOZM/2HrzRe9LTP3izSVyIyZgTi0k78nFMx1wC0ihYlgjbhPqspay
         cFus7neIYyiFzw8yuPBQLyBXu48KGHy/mCZQlWbBpALvrafVfwlWG77nng9x9AyHLCxW
         /rgi96ITLK6w5lKfwUv7EYKoUZavRVDaO7Lp6RA37kAhpeMm6Hb61W8yHtmaxwkPLXdm
         WEE66PLAdk18kV5Gt2rrwQ5wL0zAs52CTaphltW46gLOwg1ffuRLvd0xMrKzIHFaNy+T
         OfYzjLXe0mljoNomjmdMnpmaC13ehRv3YzuxjNMg97w7SmPFZT6fa4fB2iqhAKoFYqtH
         Wd7A==
X-Forwarded-Encrypted: i=1; AJvYcCWEz/nOGifzUNeg+tndyxZHTbPx5Vr44tC9tQ8SK+wvQ1WzQl7T12BcxnfDo8Iu45mucmhfyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPQ6kbBwhFxSx5EUWW3CRVZ7X9gGotnpcHYI81tc9nyKzNnKaW
	NZV70Y/5huAbNthVkeUDy+4SW4z3LhkQ9IU/CQfsEUaNglMb6bQUpxr6+WuoYhCGuKjlO7+Jb/j
	rlwfkzqM2c6XsQ9TsQpYbm/igkZtF/b4TDbpnzMF9BQT6rXEUzq+Mmte3
X-Gm-Gg: ASbGncvUvchUv2FTUPw9TB16cw2fA73Oy9K+dUMbnrYp8O0/BfjVUWjlleh5LMEsfiI
	obCQRwXfnmgbmydk3zmw5m6IXyLCy59ESxdm57XzIt7Sf/kccmau6ZvQKXyKCg9EDGvuvJd5RUn
	uklfD8cXBYD0yCs89wsjDAjqphQsLz5SuZtf5Jt+2z6RryWKuTGjuSzpl3ssRYPiDaFbJOAKaPp
	7eGSme1lROhVGk5lTbs3fX+PaHkkbIjo5GLkEKx0M6R/GJ4gZsMlUsch2YfR2XeK2du19OETL/9
	G/4eFUpFhygwRxMQGb1gAWOgMpeTVoTjpeLaxKdH4BWbBkRWlGxxPz4jBnttC4ZnsYRZMen3oY3
	CPoEVIcvNyUKA
X-Received: by 2002:a05:600c:138b:b0:45f:2828:6a69 with SMTP id 5b1f17b1804b1-46206b2e15dmr28158575e9.28.1758126909650;
        Wed, 17 Sep 2025 09:35:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdEcVqowWt979uKl4LwU7G+tXju1ftEahVLYbjAdGF94w2ApnT0DtsFm7uQ9oqNWi0hkjZ4A==
X-Received: by 2002:a05:600c:138b:b0:45f:2828:6a69 with SMTP id 5b1f17b1804b1-46206b2e15dmr28158405e9.28.1758126909179;
        Wed, 17 Sep 2025 09:35:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461eefee9f3sm35664175e9.1.2025.09.17.09.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 09:35:08 -0700 (PDT)
Message-ID: <92f47332-97fe-4a8b-adbf-7796aecffd34@redhat.com>
Date: Wed, 17 Sep 2025 18:35:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [MPTCP next 09/12] mptcp: leverage the sk backlog for RX packet
 processing.
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1758039775.git.pabeni@redhat.com>
 <aa6e34c45c507061a316f29d075f050cbbbdbe2d.1758039775.git.pabeni@redhat.com>
 <8e688f56dcd264805bac777f1612241f6b2eb836.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <8e688f56dcd264805bac777f1612241f6b2eb836.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yb-UpAQaKB071vX-jtjUhmeJ4qFVzP0gdwxtbdOs9t0_1758126910
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/25 12:07 PM, Geliang Tang wrote:
> On Tue, 2025-09-16 at 18:27 +0200, Paolo Abeni wrote:
>> This streamline the RX path implementation and improves the RX
>> performances by reducing the subflow-level locking and the amount of
>> work done under the msk socket lock; the implementation mirror
>> closely
>> the TCP backlog processing.
>>
>> Note that MPTCP needs now to traverse the existing subflow looking
>> for
>> data that was left there due to the msk receive buffer full, only
>> after
>> that recvmsg completely empties the receive queue.
> 
> This patch breaks my "implement mptcp read_sock v11" test case in
> patchwork, and I haven't figured out the reason yet.

Thanks for the head-up. On top of this patch, statement alike:

	if (skb_queue_empty(&sk->sk_receive_queue))
		__mptcp_move_skbs(sk);

should be changed into:

	if (skb_queue_empty(&sk->sk_receive_queue)) {
		__sk_flush_backlog(sk);
		if (skb_queue_empty(&sk->sk_receive_queue))
			__mptcp_move_skbs(sk))
	}

Possibly an helper for the above could help

/P

