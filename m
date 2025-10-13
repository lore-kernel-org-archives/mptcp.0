Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468A72BEC59
	for <mptcp@lists.linux.dev>; Mon, 13 Oct 2025 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375272; cv=none; b=VK5BDjdFee5ZN6dTXMiVd706X5CMw72sFdjBquVc5iv3LWDe7409LFNYug3j2Ntvmf71W6kFYI2S6EYz4bu+O2Yr3o2rWQjf0YMhEVzLigg0NIUS1pawJIy9/8G3UcGwJ9vT2jE7YMy0RueDJ9p0DrPre+iVo2+/PeV8dtcbqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375272; c=relaxed/simple;
	bh=3+99SEUKYe9PcXlhAY56Bm6WauIG3olRe1PyjdB3ysM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=WgeIOJkW2DQoP6GGn3sgpsKQBrXyXfbCAm6mNcTk8pxAriN2NvstDcbdOGTPBRTNTfJzmaQ/oA7JCI4xaO1zvh5WPgEZRu1UJ5CSZtTkpKHVmyc7gAEskq4u+X2ZvNHfGija1TXDpq3WDoOJwuTKkwprFrsyfeOXdf+EHbNISrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7Ehp4QY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7Ehp4QY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760375268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMUll/J9gBgAt9qH6GhXDo5wKDcEjwIWYtZfJ5UtWcc=;
	b=I7Ehp4QYMuyBamNKk2dMHQoEmhPwhRHdHzTFe5JN/X8VzBf2oLCU8eypmxxOw5gNVNMjyW
	F1Ko8cHz6OkrWGgtKoYodET4BtNB69T/b/DMDdQnhbCUpMUglof6/KyutgMqdS7lAVMqop
	hS5LG3WcwJMAYgWCanIlhP+6zKGz/cI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-oOvhuCj6PVGR2k67BwBqhg-1; Mon, 13 Oct 2025 13:07:46 -0400
X-MC-Unique: oOvhuCj6PVGR2k67BwBqhg-1
X-Mimecast-MFC-AGG-ID: oOvhuCj6PVGR2k67BwBqhg_1760375266
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e3dcb36a1so35548535e9.2
        for <mptcp@lists.linux.dev>; Mon, 13 Oct 2025 10:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760375265; x=1760980065;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMUll/J9gBgAt9qH6GhXDo5wKDcEjwIWYtZfJ5UtWcc=;
        b=N82e8mIIsq9zzmY8eOWPcfAXQGuqqmHOGYym4VKVLPkHJ87E6foRKcsJtiFJfNdxoB
         H80APo64gWzbZ3Fq5uStnElfITw815gMKpBlHZjc2eHuBIa/hjztd8fF/B2rkhgpLXx/
         0t85EwpXxZ17GLIXacI7NXnKw6MuWBF8YkYXhpU+dpBFPC2+Fgmvh6rOey34ggiL6+XY
         o8kwfoj3/qMjdyRDWUmWS+DGRZF1OuFpeCMMI8C6OQeZUtuAprdaCDSIf7NsaH/8EnI3
         JYVgdJuUkhyv+pfT4QfCq5bm4T70KYW8eP6jmOGNV//nHQB4YXtcZsuCTLa1rHioOzAU
         1Geg==
X-Forwarded-Encrypted: i=1; AJvYcCVtPweu/hXm+bOtX84FqcGC1CWHdKFNWHn5x4lKwbMuzGySTdSMxtnaXW+fBA9+tqO14GqXbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAgqMNjdwoqfZtM6nl3ZHsuiDUA1HYNBXBy0yGF+N8IQFPZ40c
	WCPuM9yRgGi/94HC2hrRtMfpC42u+vTwiQUCF3PD01UN4K78gSzzmOTFE/mlalgRBLDN+eXIQjm
	/U35+QxtkSgVzbgGr40EFLUI2aW1xaqmfhUfuTvmVP66b7llqR91N3DCCvjZBylHy
X-Gm-Gg: ASbGncs86vIOjD6ZkrKtQDtiomrec9HIUtvhOzKG3r7ZzNsgFqFqFOAf7KYME8l1487
	o8d5pH1SQ3iRbZ8s6KXwdUSJ1gP8lvf47lPrHr9mwDTSrIiz9Gi057rJW5Zsh/5VmMBNtcFmfo1
	1ba/QBHtmWCBkddXXCDlyeEtZc0R7LQQESpfvVFTvj+061dVrcNHBSQA80JXkFCg5sS6pHDKN+u
	j31qnSjpBwOlwl7F2ykSbtpeO8pzQpeAJp4zYCiO/DyBI3cVe+ODYhH4DVRu+pOYAHnU8c4hbD6
	cy5usu7tv97g+x0iwWlnPGChmRVomWSmO/Jro/T/KmF9cikCxkjY661ri5vNsQJleU+A8K+YzEG
	Mq7GCa9bjkGcg
X-Received: by 2002:a05:600c:46c9:b0:46d:27b7:e7ff with SMTP id 5b1f17b1804b1-46fa9b18289mr146818015e9.36.1760375265397;
        Mon, 13 Oct 2025 10:07:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeMf5BKUiOhX4WzYnJDey4KIko9YyURysZSJKfigG3zqPj17rbYBSZNOJ9+NB39OoGpk29aA==
X-Received: by 2002:a05:600c:46c9:b0:46d:27b7:e7ff with SMTP id 5b1f17b1804b1-46fa9b18289mr146817795e9.36.1760375264947;
        Mon, 13 Oct 2025 10:07:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49d0307sm193515515e9.18.2025.10.13.10.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 10:07:44 -0700 (PDT)
Message-ID: <e1e1959c-9090-4911-8f10-829ef3156bcd@redhat.com>
Date: Mon, 13 Oct 2025 19:07:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 mptcp-next 00/10] mptcp: introduce backlog processing
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 mptcp@lists.linux.dev
References: <cover.1759737859.git.pabeni@redhat.com>
 <2c9f131e-ef34-4916-8aab-e1420e1ae90b@kernel.org>
 <d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org>
 <b90e5899-6473-4b3b-a239-9202c2e2cb03@redhat.com>
 <2389029f56a9fa496b59be7655987e6d9c6362f2.camel@kernel.org>
 <8a8feb1d-ad10-4ba4-a448-db8a0e45c7c3@redhat.com>
 <c53540268cb422a14d38745c6d0bdb440deb7c11.camel@kernel.org>
 <6d3545fc-f342-4532-b1c3-fb96d9c79fe6@redhat.com>
 <e759f7f6-b90f-4663-9ab4-040f76c2bbba@redhat.com>
 <53ed629a-d364-470f-8a52-5a34692f0da7@redhat.com>
 <20a3df573803203df6b672d1ecd606e242e84b20.camel@kernel.org>
 <ef0495fe4e1012bb4b68a72361bdeb39872d96b6.camel@kernel.org>
 <050ac2a0-0f8f-4f95-acd5-1a8f58f0d9d4@redhat.com>
In-Reply-To: <050ac2a0-0f8f-4f95-acd5-1a8f58f0d9d4@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fe7sALSRzJ5wyb_L_G2obs7H7CD977IEB6MO9U_Z-eg_1760375266
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/13/25 3:29 PM, Paolo Abeni wrote:
> On 10/13/25 11:07 AM, Geliang Tang wrote:
>> On Fri, 2025-10-10 at 20:22 +0800, Geliang Tang wrote:
>>> On Fri, 2025-10-10 at 10:21 +0200, Paolo Abeni wrote:
>>>> - Can you please share a pcap capture _and_ the selftest text
>>>> output
>>>> for
>>>> the same failing  test?
>>
>> The pcap captures (gQQ13x-ns1-ns3-MPTCP-MPTCP-dead:beef:3::2-10013-
>> connector.pcap, gQQ13x-ns1-ns3-MPTCP-MPTCP-dead:beef:3::2-10013-
>> listener.pcap) and the selftest text output (selftest_output) are
>> attached.
> 
> I'm possibly low on coffee, but I see a single attachment here?

Please ignore my previous message PEBKAC here somehow.

/P

