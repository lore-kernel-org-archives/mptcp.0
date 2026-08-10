Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B4D397937
	for <mptcp@lists.linux.dev>; Mon, 10 Aug 2026 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355645; cv=none; b=VMx+zNc69TVPf5mGOGLAQvNfeF0PEby7V75YoFrl0zTy8yCsnRtBq0KGCDP2qlFees9mg8KvYEyFo5cmp6stUNkESCREs9NfrjCMKPBYWDJZ6cedyowGH0KispbV1z6UVXz8KRp+VG3z0J5uUwiy0CzcUV6aeBNMS7xypOwtvMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355645; c=relaxed/simple;
	bh=Mb4lvJxt8iKQt1y/jBs2g60GBPvMmVnC/pCTUP5gl4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rupAa6KCgEMmoXV6i1RsFhsnM8kqvhDUK1EfklKuYr53baqq0p+6LnXLOabRozl4RP18MsNDO5yJY3j30mRfzBHtyWtlbZjuxs0Qtnys8HmY3VynbPxczPbaD5mvTsTxySyJFBM1Irm+RBgvBS4IsmYEvWp3PKaf77ihT9aqY0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6DpxqXe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6DpxqXe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786355642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJJrhudqMOZrjDcA0TeIkS5YE0ogalmKFNSGe7iwfdE=;
	b=P6DpxqXevK+SOqijSFJEGg+xXFPR6E+HQ6aHXmF+5VnGvvQJFN9C8WDERbGLXDuCc+AEGW
	sn7NrMFV72ttjwhZf1PPQ9IA0VqPKQ1KNRlluEbPLjMmwu7TZ8MPr8inFCd3oVZ6EMwXcA
	dDFttYkHWoNE0j/pCeMuAusDE5500CM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-Klcm8wfXPm-DhC4erfuTow-1; Mon, 10 Aug 2026 05:54:01 -0400
X-MC-Unique: Klcm8wfXPm-DhC4erfuTow-1
X-Mimecast-MFC-AGG-ID: Klcm8wfXPm-DhC4erfuTow_1786355640
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so17788835e9.1
        for <mptcp@lists.linux.dev>; Mon, 10 Aug 2026 02:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786355640; x=1786960440;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kJJrhudqMOZrjDcA0TeIkS5YE0ogalmKFNSGe7iwfdE=;
        b=Cfd5Y+5hK4dNsRcEMOcps5ZvygOunN7yiYDYxFFagoEGdbieA+SUlkMRVm5MmjkDUg
         Ipa05b7WssyqUJbPGzKcXSvDVMi7IFDY0GsEKtZfVfgqjBq90qzzDNDueqhFKN6mWlVE
         eWAegfJVOeanSqqdr5YDL1RFJnAtJOa4PDh1XvY2ckKpkq2KxK9ZQJPKVG/ZOKnbPi+4
         NixjHdqbh3V+J0wLsxPRkLu8u1VJei4UzB6RPWXUwcUb7UFdmZYZDKW4P/dEShdxM/nd
         0TEITezrfATKfmt9Grn5fljG461SAt6QMcEfOte3w3VNJrFhxPBIdASNH30+o18LI2WW
         sJEg==
X-Forwarded-Encrypted: i=1; AHgh+Rqa68RHUecI5E4IfcRvrj6uWS48m0qIRHE36qkcsg2CKC4+5dLwduZqcVMOC7aBy8hEO2gTgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDb2XHX+x2rTRgDouVpjSzax/BjMubqvkbgwvrq9DhMAi9ZrCz
	9mP5IDMoP+wlmxYP5z1WkBnL69RYjHUdKbWodOeLTQC/rM/GS3wVd8G1FdiTIATH7jSuM2ri0XI
	2/bGTolSq8y/wjf9SumqeemICRcnQds9xm4UI2QwuIqI4sIMBZMGUpxKh
X-Gm-Gg: AR+sD111ZCe2lXgRJDXtNVuiur/ZvODRZXk6AeVLsF5TH+VBsoX3X/SMYI8gjMRDz2H
	i/WWlGE6uFmaJiALlfb96bZx5KE8esGrj9HNH5/ErTv85uOJnOEpaPmHh41d1KlW+jstTH/PFto
	RgUNEfnEYXqFBeZKkIWuwDB+mQ4NbbZPToZye5nayikhtX4yIdQB03mczu1LUcM0aDpZKEaRxuc
	jcX5yQtijG8n9YWnbLj0ARMNrgvpIsxrLlQHAYHvEOzLTsXzFQtvRVEzP7SZpi0n2vnjya9n24N
	x1X0+vqt79cBubdc8C1LgMySxskWtk0dhXEUp71XneSQDK7TjBHey9o/t+982Fuh6W1hrmkZuxc
	vNiwlaRbBUxRXinQK+KueamgDwL9MErT8Ad6h7oO84p0+mnd/nIgDFhP6DXwJBmwZ+YZv4QeUCr
	E=
X-Received: by 2002:a05:600c:530d:b0:495:52db:7e8 with SMTP id 5b1f17b1804b1-499727fd550mr7974355e9.19.1786355640066;
        Mon, 10 Aug 2026 02:54:00 -0700 (PDT)
X-Received: by 2002:a05:600c:530d:b0:495:52db:7e8 with SMTP id 5b1f17b1804b1-499727fd550mr7973505e9.19.1786355639597;
        Mon, 10 Aug 2026 02:53:59 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c777sm295239355e9.2.2026.08.10.02.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 02:53:58 -0700 (PDT)
Message-ID: <9f7f0fa7-52e9-4640-9264-13c98ed4d602@redhat.com>
Date: Mon, 10 Aug 2026 11:53:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/7] mptcp: out-of-order queue pruning
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Gang Yan <yangang@kylinos.cn>
References: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y9lfTrr60FRO3FTdnopGzkFBgSX10UmARXa5e6vCiXc_1786355640
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 3:49 PM, Matthieu Baerts (NGI0) wrote:
> Under memory pressure, a pruning of the MPTCP-level OoO queue might be
> required as last resort, to avoid too long recoveries, or even stalls.
> Geliang and Gang managed to reproduce this behaviour, and Paolo
> improved the situation thanks to the following patches:
> 
> - Patches 1-3: improve the MPTCP-level retransmission schema to make
>   recoveries from memory pressure/after MPTCP-level drop significantly
>   faster.
> 
> - Patches 4-5: make the admission check way stricter for incoming
>   packets exceeding the memory limits, with some exceptions for fallback
>   sockets.
> 
> - Patches 6-7: implement OoO queue pruning for MPTCP.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Sashiko has a few comments on this series, but IMHO only patches 2 and 7
really need some adjustment, and changes there (fix the stale/retrans
race, wrong unlikely, and too early OoO prune) should be handled as
follow-ups.

/P


