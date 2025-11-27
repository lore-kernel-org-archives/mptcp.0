Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CB52E6CA0
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264019; cv=none; b=d7pt+UEUS0xAm3cplMJ9Gm/AO4dWd+MZAwdyzl1r74XAp484Q1RWJAZtspEe08N3P25NLVDdGQcGk8gw9z6XSCOSntVubMRl0IXKaczb/mBOZEHKswbp0BhJ3/usDecrO6UlQhDJKmflVl6CcWXxFurg1Njg0jpBy2U4PgbBVPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264019; c=relaxed/simple;
	bh=vNX04ONxwxMuRoke/UL/jKVdso6MiYWYyLjixCvsgOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vGBCrgm9F/3yJ7AjpDNoNspANkospJLcawPRycniA+mdjPplEW5PYZUHM12MGmrqI/r/+FlJgJL3tz+5dcffjY3g69ReXi/l4aKN729JQJo92pjfAig06Zc/tYL5+/TL/tQsVIGNtq0C4I7BzWzduGMmCxJlqI6DQNJ5x/+p9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQkidCFj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQkidCFj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764264016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2uwbToqmuxtXz1h7z2MITNfUNyzBri2ba2JN7g0XZc=;
	b=aQkidCFj/iNxk8TChsz+6ciln3Z2zAjXxzpwLDxLT2UZ8Ts5NTj5tAcc62ETlJOxxuYJ8l
	1QOY/5pSxZCuSM69VoIlIeA8PXAm+7l6L2vS/9TRNohpMtc16XmAez0vmDnBE+HHvVG6Pr
	Yn2+kgOeFs19XH6/uJwD/llpJAmWfb8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-5kuf-C7aN2WLCg5HN2CuWw-1; Thu, 27 Nov 2025 12:20:15 -0500
X-MC-Unique: 5kuf-C7aN2WLCg5HN2CuWw-1
X-Mimecast-MFC-AGG-ID: 5kuf-C7aN2WLCg5HN2CuWw_1764264014
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775d110fabso8162625e9.1
        for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 09:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764264013; x=1764868813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2uwbToqmuxtXz1h7z2MITNfUNyzBri2ba2JN7g0XZc=;
        b=So71iFNUh0ij1VRuARafkedtL5PTA36q5YPbD5JqVZpm64Ln+ddaSLb+GwYoVC1z7G
         xrJq0DEm01RYbi7kO9TRMMNXeh622Z2z4wIuULr3PuGSby+WgDT+mMxxEtbrb1vLjPc6
         efvU0Qc32mU7kJO5+lU3HLiIeY/QEFzVVfNDnEkfxIbgD0OV+W3mt+xCGBVc8xbz2qnQ
         /68qw5paIrvW9qmT/VegTVFqnhTuKa0mmGA9djeqosdonyABmFN1txvf1s0twRNFV3vA
         wW1HKAj4JPBEsPL0ABKmewPG6AlkIgbfAfdilwECdbo/6KUs6eBRc3ck0F3cMaB4pvCg
         Lt5g==
X-Forwarded-Encrypted: i=1; AJvYcCXklw0JApIxE+AUmbQlRLCLKBeeScnE/lNWcPI+nXp9dRncMsM17og9U7IRRYFiF3t0IP9FkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm7UhA/tNDP00pv89Tn1fRflL5V2l3/quZZwk2e9c3Wbr1BYGt
	gVwkc4AaCPAj3nFCXpKld7zfaWC+2JXDaBN5zsNgtPLMZKd1Ed3LDoK7hPK+CyAxp139W70rg1g
	HyAr470JrugJOywj8K4W/6nhdEVYv+MPMFHk9KlNN4r5ZcagHO1D3JMdgaJ6f+J6U
X-Gm-Gg: ASbGnctnVy/33at6othtCpcEZUuXKbG/e31mEb+qZnb+rudFO7CR14JXn9IsjMWKccq
	sKG074X3xf10ui2oqZ9FCz4bU4UgEkiHKEeYa+0d2kSLvqCNRnCzywKhhsSbakdDEp62HH3Fkrr
	GKlWxBth8UHJx0zsE1+l6S2NYrtb9oKciRJyT4ZO1gjZCRD0pWdariYKrsr5CYLewg0JEHqmeOx
	4cPMj3rPe7qRFJ91CTvgwuVehuu0u2A/KqHrDSXz8hn4z7iP4gHbJKb1+LFsYFEhTKYj/RfNTCE
	cQdHMZRebjHwbSYYw2nSmZMqjUGLQyH1l22TYNX1BcQ0GKjjspemz4op1tiVoa80AIWwGmJs31g
	TeqhpXZkCymQkiA==
X-Received: by 2002:a05:600c:1f94:b0:46e:4a30:2b0f with SMTP id 5b1f17b1804b1-47904b2b3f5mr114305295e9.29.1764264013713;
        Thu, 27 Nov 2025 09:20:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBE2BrIbL+SpJnIxQyYcGU16kheu8p8wLH5EgJTrBmus2zKOt1Ho6gwwgEtUV6k6ZfOVGbqw==
X-Received: by 2002:a05:600c:1f94:b0:46e:4a30:2b0f with SMTP id 5b1f17b1804b1-47904b2b3f5mr114305025e9.29.1764264013301;
        Thu, 27 Nov 2025 09:20:13 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47911143bb6sm47637675e9.3.2025.11.27.09.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 09:20:12 -0800 (PST)
Message-ID: <acd76564-d636-4fc5-9fdb-f39deb9be41d@redhat.com>
Date: Thu, 27 Nov 2025 18:20:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC mptcp-next] mptcp: support net.ipv4.tcp_rcvbuf_low_rtt
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251127-mptcp-tcp_rcvbuf_low_rtt-v1-1-fa080d67f2e5@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251127-mptcp-tcp_rcvbuf_low_rtt-v1-1-fa080d67f2e5@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IeLnyJ-wedU33nOfsNU-pOWohz7h-v7bPtbxF5TQTfg_1764264014
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/25 4:58 PM, Matthieu Baerts (NGI0) wrote:
> This is a follow up of commit ecfea98b7d0d ("tcp: add
> net.ipv4.tcp_rcvbuf_low_rtt"), but adapted to MPTCP.
> 
> MPTCP has mptcp_rcvbuf_grow(), which is similar to tcp_rcvbuf_grow, but
> adapted for the MPTCP-level socket.
> 
> The idea here is similar to what has been done on TCP side: not let
> mptcp_rcvbuf_grow() grow sk->sk_rcvbuf too fast for small RTT flows.
> Quoting Eric: If sk->sk_rcvbuf is too big, this can force NIC driver to
> not recycle pages from their page pool, and also can cause cache
> evictions for DDIO enabled cpus/NIC, as receivers are usually slower
> than senders.
> 
> If RTT if smaller than the new net.ipv4.tcp_rcvbuf_low_rtt sysctl value,
> use the RTT / tcp_rcvbuf_low_rtt ratio to control sk_rcvbuf inflation.

Instead of duplicating the TCP math, I suggest factoring it out in an
helper and use it in both the TCP and MPTCP code.

/P

