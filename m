Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E7531F983
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001986; cv=none; b=hGnTLvsJdsKpPzyWvtm7TJZQ8mwMhG3hVmj9C/K71Q+a3KzPgsbrPcpv2oIJrmnR2g/nfNFvgSJONNe7lfat7kNw9lBvigen1AtEJ3MXbPRxj5TofwyJUMnChWSl9ZIIDhsz6im1QOkZqTiBBHVgqpYleS2oYHeUjt3mh3S2D9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001986; c=relaxed/simple;
	bh=9cXrHUkSeqyzWYvQw5/2gpshDNTptJm3lBi5YrqyStI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=MSoEZF5crGsEVxvBwLZoE1djZ0eHbUsV8D5ugx7n8UOjDTP7/WywA1Jiud0nwgpUqPeX4yxhe4bHdbrtS0qmEWKt0aXs4Q66iydmBW4IGY82ou5uY1mQ8Knp0HY6zcZCY5bD7WSG+mwZsEkskg3qgFQi8DPiCWkUhJVPnDoqfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9daDkTG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9daDkTG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786001981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FUOYZm7oxVpQQZwCZctLOhPVh0C2lEzrSxVX+5/UodE=;
	b=f9daDkTGne78TpCgDM7E6xJoXfVi5bfT7Ih3oGn2RWDv/5g9RspDHAh7KmID7isGt8P1rf
	IzFEvhVvmCYjGXPCo22MR8k9D0XfUDpwrmOHBrOuTNDZHjjrO0Y+xq2Bjm7q5GeylJ8QtB
	a35Bpr+RS3vlZAl5xwPDFijxQr3boTs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-MnrS2pYuMuObI3fKsGTUBQ-1; Thu, 06 Aug 2026 03:39:39 -0400
X-MC-Unique: MnrS2pYuMuObI3fKsGTUBQ-1
X-Mimecast-MFC-AGG-ID: MnrS2pYuMuObI3fKsGTUBQ_1786001979
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495569acf8dso11133205e9.1
        for <mptcp@lists.linux.dev>; Thu, 06 Aug 2026 00:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786001979; x=1786606779;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FUOYZm7oxVpQQZwCZctLOhPVh0C2lEzrSxVX+5/UodE=;
        b=qNjWIC62k3lb651SjdkIIPBL7BguDTiAbneIUNF2guP0Zh29slGkbuCdd6ecu0YlbE
         vhTwpGg0SlSEktQ9pTLhFX9aik/rzVhC+iTblQOypOrQLfhYjB8R3Q5f9dNyPA24IBjL
         GJ0WdsoOpdPpouNytHO+awN3h6H0mNEfc8OkQ/fDRENIQ6BbeV+g6zZshPKbRiTfpxCG
         gy6bA1YDi1tc8JTWgNxeSu48VCLwLrjkqrKSBHVmOI1PwMK3nIBRf9zJJjNE7xvWSTrX
         i++1DxzFGBVM//Z1Fi8WpDEvesfKjZyXfFI2369k6a3v8ferOE/kYdLMxyr/pAQMIya1
         HEaQ==
X-Gm-Message-State: AOJu0YxQQYGzfLIVfu5hn6Pd1YL08eC7JmkjzIlowl6J0v4RCOohnlZq
	OCsnHGkKNVGnaVCTjJlCncRYEt8uqGnLz/5MJl9MdzJ9Foh/5iyjh8dr5ZtGtnvdcStr7CpsOXf
	83HJ9uw7ACHMZEQrvbtJGRpyH+YJk365Qmm+0PMnXTv1D57eBY0nuWgWHJZge0Jng3wl4inevub
	vYK0Hi+RQ8WHJIfszPXHx/lPGBYZ2859EBPZjc0g==
X-Gm-Gg: AR+sD11fIrOhFHPgkTI6Yb4ss16unYH8Ay1bpJ4mulohgY9vzyiUXGVoZINDq2616Gp
	8/25Xghec+DPQwcy+K2xR1UUwEx0Xw9BQvUolBRUpsjLugeJ4DEHR+kUXoiiHX3SeiWqGpMJa9y
	euAg1YEMhF/QIMEN0MiCy5wTkDMUcCEuV3wgXwC4CqcK3uUEsVeiFnHkyYlgrwBVrYyW/r3tqFN
	xU8XsbNSuLEPKvmBGc1lClZgnKdM7Z5bP2zOyloOSCLT5v0PkMAvpmToFxU96p7YPktnIf3eHla
	mmhy6Ld4mDcbf7Jlf/fISRQFRr9Eoa+Mdd10Pk6OhfRsOdoaAY0ZOdPUwf+1nlxZGXTlUDxy+Gy
	/IJ0nALyggRxkjuVNlkutssEjtEXvsXbfGVRWxNJ6oz1Jh4OdiHtVBZm3Y87f/U54SK3D5q8Uz1
	I=
X-Received: by 2002:a05:600c:8b51:b0:495:6b55:f938 with SMTP id 5b1f17b1804b1-4994e7ba99emr181915845e9.10.1786001978653;
        Thu, 06 Aug 2026 00:39:38 -0700 (PDT)
X-Received: by 2002:a05:600c:8b51:b0:495:6b55:f938 with SMTP id 5b1f17b1804b1-4994e7ba99emr181914935e9.10.1786001978065;
        Thu, 06 Aug 2026 00:39:38 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421934asm42647065e9.5.2026.08.06.00.39.37
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 00:39:37 -0700 (PDT)
Message-ID: <e0061681-7355-4c4e-96df-030ac8123eb7@redhat.com>
Date: Thu, 6 Aug 2026 09:39:36 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 3/7] mptcp: let the retrans scheduler do its
 job
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
References: <cover.1785943854.git.pabeni@redhat.com>
 <362268703ac205e887e5bbc50f92f9099792a3d8.1785943854.git.pabeni@redhat.com>
In-Reply-To: <362268703ac205e887e5bbc50f92f9099792a3d8.1785943854.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kGcuL93EYpFChJhWFQWlviGpl0EDm9WDI7bKWRGBWDQ_1786001979
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 6:17 PM, Paolo Abeni wrote:
> @@ -2856,15 +2854,60 @@ static void __mptcp_retrans(struct sock *sk)
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct mptcp_subflow_context *subflow;
>  	struct mptcp_data_frag *dfrag;
> +	u64 retrans_seq, sent_seq;
> +	bool need_retrans;
>  	int err, len;
>  
>  	mptcp_pm_chk_stale(msk);
>  
> -	mptcp_clean_una_wakeup(sk);
> +	for (;;) {
> +		/* Get an updated and consistent rtx queue status. */
> +		mptcp_data_lock(sk);
> +		__mptcp_clean_una_wakeup(sk);
> +		retrans_seq = msk->snd_una;
> +		dfrag = mptcp_rtx_head(sk);
> +		need_retrans = !!dfrag;
> +		mptcp_data_unlock(sk);

too much cleanup here. This needs more work

/P

