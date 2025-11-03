Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19B1A3165
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187004; cv=none; b=kwbokAUwe0KsyhvkkTa5bWPbujSCEoPSb0SLUhQRh7ExNplWxjpDjbmUUfCjErD+VAKkACoJV1afUFEaB+BDIUiqduG7uvNVQctqbWXCWXi4ZmN3k8L3TnbfcfdXRYvAPJiMEpURO/pCDiHSsZcwbPLDIt4Bjaqghs6mww/HwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187004; c=relaxed/simple;
	bh=yVctG7WPmWjBnJD0lZLD5tCLo4t7wLL1CJ65iunbOwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgVb19noTLhI7qc0awqRcPLWKmloy1ygYwLrojKdaGiB7KU3h9rHbBiRrBXXvP4C3QjS8vlsdcOvK6s1VsqWFm8dIZKQguFuBxXYhLj/BVnnIEAPTui/zJ0PnXvxt4LSEcGLIYaw5SGAGY0GOdb1aemgwIHG12L/xU+uK8GNWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7dIvWV2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7dIvWV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762187001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D72R4zDsX97feWbz+5m0KgXGpW2q6ls/7WagKEcSdA8=;
	b=V7dIvWV2y9D4Drc7VmBcH+jfnNVYLiV3lh/QDv/lRPKU8WOsn3+5Jf4K586bVJklweo8Is
	J90UrdsE4sOBq1jqtETvXawGm4u1/MBwbJy7cWw9czKTwzaLvkT4/rd0qwl4GZnM4HesU5
	k/se1smcYUdDl7K5442qnZFkLO0DAls=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-H1RRRTq-OviP8g7hBeZsjQ-1; Mon, 03 Nov 2025 11:23:19 -0500
X-MC-Unique: H1RRRTq-OviP8g7hBeZsjQ-1
X-Mimecast-MFC-AGG-ID: H1RRRTq-OviP8g7hBeZsjQ_1762186998
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4770eded72cso17266995e9.0
        for <mptcp@lists.linux.dev>; Mon, 03 Nov 2025 08:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186998; x=1762791798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D72R4zDsX97feWbz+5m0KgXGpW2q6ls/7WagKEcSdA8=;
        b=bCSsFd2mOgnrE3Dwp/gaL/x0i7axPlb4fpYvok/7ENdmJjtS7QpvmuqoEs0WYbNMNy
         qW5pH4ur4xJOiSnqWVkrUWrs2t3hXbDnxAY+Ew8oZeqXg2alHEY5qjJrNvl/2p0UcNEv
         xL9avfdVvU7R8MCgqKhXoQ8gZDxCNAf2dpENjh3Q+iH0nGcTPxqQvTelva5foAv1pSu/
         9LFf/g+ppB/Fbf6oSeUKTdWJF3Xgs4sBG2Qbmt2sP4IF2OVHVyYx4XrkFd4tg0mlowPL
         JbBA+LByY8OgGYtMaRrjYBLiNudwfeGg62gP2+Owfi88ZQOdGvwT26dSuKOeL4GtT8fR
         KIYw==
X-Gm-Message-State: AOJu0YzOrnfFsz6t4ejOOPOHOoWhbhJQpbEX+UcgLvG8pA8U7XjGnISe
	2vG39z/QL2s0n+l7mhuINaF7bsDgbsnrySqCtuh5wp0ye8idp1e5W1i9ik0EKf2erCnua5u/sTk
	bhWpTfzNUKLf4pxHJJki6XXofwylcLWwZKpaiQARCvve5tIzKIqSvtZDnumEPxQmw
X-Gm-Gg: ASbGnctb3Ocr3Bq7c5G1Ovxh7lsxhPY8NDN6GMORpxOGSNc8fkz6LtdYUGsRnePmDMf
	R17Oj2lBE70R9bW6eqzjPAm3WRqzWx87Cor2yrpj/C6KtdW/Ci9K56sgUN4Vg7dUGqgUvHRNnPS
	tAKFBQh9Te2jKJzUANeoDL3ErN64xJdvO7l1ei1uvzWFkDBYD5oljmXFJWUrLWuDIC71K11FSR3
	s2M9RsnaS1ZUg8YETOqeoept9g3knPk98KtFOnavk9HkdB6Kj94Z/j35N/6Icagl9ygqsHcvi4n
	aAf2d7LJbEOEUUMzMrGZ77loNnXBP8RurV7/EI2GamuHZYMou4CbrmcrYSOpnA8fyPlSTbYhK71
	DrpuoZeIlFWYqtY28+MT1s/AvCVZYOhY8gCzlLf2gaT4l
X-Received: by 2002:a05:600c:4503:b0:477:bf1:8c82 with SMTP id 5b1f17b1804b1-4775303f943mr13111645e9.15.1762186998129;
        Mon, 03 Nov 2025 08:23:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6iXhYTc9YcFaHjWEel5k4s4KFbcqRB91mkyY8cF08QoVQhqkC1068/26Gmtfi7rV1A2UwdQ==
X-Received: by 2002:a05:600c:4503:b0:477:bf1:8c82 with SMTP id 5b1f17b1804b1-4775303f943mr13111425e9.15.1762186997738;
        Mon, 03 Nov 2025 08:23:17 -0800 (PST)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fcf6c05sm93550955e9.4.2025.11.03.08.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:23:17 -0800 (PST)
Message-ID: <bf160603-cfb4-4945-81d2-c958043078cf@redhat.com>
Date: Mon, 3 Nov 2025 17:23:16 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESENT v7 mptcp-next 4/4] mptcp: leverage the backlog for
 RX packet processing
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, geliang@kernel.org
References: <cover.1761576117.git.pabeni@redhat.com>
 <08f8e227a749a28a88ce245fa36870173e32c54f.1761576117.git.pabeni@redhat.com>
 <6fb0d5aa-8140-505d-c40f-1dc40fff352f@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6fb0d5aa-8140-505d-c40f-1dc40fff352f@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Nwa19FUGaoWs883P9jpUmWbYKwkXQv1INsxHm57YdYU_1762186998
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/25 1:04 AM, Mat Martineau wrote:
> On Mon, 27 Oct 2025, Paolo Abeni wrote:
>> @@ -3573,6 +3586,8 @@ static void mptcp_release_cb(struct sock *sk)
>>
>> 		cond_resched();
>> 		spin_lock_bh(&sk->sk_lock.slock);
>> +		if (spool_bl)
>> +			mptcp_backlog_spooled(sk, moved, &skbs);
> 
> Hi Paolo -
> 
> Given the discussion in v5, to address the "wild producer" scenario this 
> loop can keep track of total_moved and exit the loop when that gets too 
> large.
> 
> The question is what the total limit would be - available rcvbuf when 
> entering the loop, or some multiple of that?

I spent a lot of time around that choice. Limiting the loop here is
quite tricky. Stopping the loop after sk_rcvbuf bytes causes mptcp-level
OoO and adds additional complexity to the code (as the receiver will
need to check the backlog even when the receive queue is not empty.

Note that the code proposed in this series is as robust as the current
(i.e. release_cb() can already be bothered by a wild producer in exactly
the same way).

I propose to decouple the wild producer problem solution from these patches.

/P

