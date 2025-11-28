Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1102309B2
	for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764341643; cv=none; b=bSMkL+FYJ+b2Ua0pOCxZLwIxEhS0kK96CMzJCDvhoaZIUk/uNrDE0q89mvgcMQz3RKNtaL6fm7mVmQVrnHweBugxPjBctEjI4o3X3HFahvrxD9abbcrSmbMF60kE1rPGGg/5vM6YZY7gcrh81rt85GoO2oVqpHHGnW3EdFPsn58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764341643; c=relaxed/simple;
	bh=vNl6bBQ0vIsBAWKJFhX9zRg2RLcDTJWtYzvQAlxQrBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvpKZ0GR+Wp3f5cJWs5JHmAiQjjtyJW4FGz1+6mcMuSuuaCcx0xvrzWV+cm7s/8u+1jCOOGyqC9QuXpsjoNtJftB1Ms4vz4jL7mKU0mWSfpgMI8LT2pLnm6bkqZf5XaKPolLeWQkM7Yop+U/OU1s5SEzli5IFul40kiy5NV8ukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZM94GxWu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZM94GxWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764341639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udwIR6x9elGZ6IYdlhIi4otawQKBps7wokoZANi1XCQ=;
	b=ZM94GxWuvKG/GBcJGcsbNWM6Wby6Wx0ZpFSpHiXJPyCwCFCDkXuL1+7V90N74CR+91fDkv
	+6NAZQP4K5QltHMD5zrJg/KLqVUVNBbCee/5ZY5wpEoMY4EvohK+0r9/2260QDzGFtqCq0
	JDlvQ28uU6kkEClrfUKQ1B0KYqU/UJc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-ttvgmKT5M0iHqGm9v4spvw-1; Fri, 28 Nov 2025 09:53:57 -0500
X-MC-Unique: ttvgmKT5M0iHqGm9v4spvw-1
X-Mimecast-MFC-AGG-ID: ttvgmKT5M0iHqGm9v4spvw_1764341637
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779da35d27so21535935e9.3
        for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 06:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764341636; x=1764946436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udwIR6x9elGZ6IYdlhIi4otawQKBps7wokoZANi1XCQ=;
        b=lutJNdLg9QdL7JL09bWalbD2wL+I3tIwHmouJWEaGl9o7dhaGbIeZEzNNtwOZUh1No
         kPrfufWQfrC1Axz8VrvaCufePtS26a1Q6Ze9EeWE/lsuAFyrczsfQm1rjTj1Ej8YRRRB
         h2bsB2H7s4N7rsGws51LTNLuq5B6w/gwkJjnGlaAruot2l8I/yiR7+nsB72oVOOg2/VB
         TrCc0X2CwLLuQGNl93ZU3x9eGxNMuToDXZfUc+uVMTNfghxeOfMohJDM8HlXv27U5/bm
         SUU7hKdJzULhm8+z2nSVGkGMD7em7scFdrPACcV+QOhlT9LiyiI6lvQF57oxs9+wddkO
         vNbA==
X-Forwarded-Encrypted: i=1; AJvYcCW0kRnyjs9MZ5UkuHp44VoB+vL53+pxd+3r2BlYwQgNJIsADAMPrZZxmmoLo+hmtVAJvlkb4w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw53OiIBxxMpFG+J5iRyJWFkL2gctkiSbqpuu3u+sbRFlA03SbP
	o/mjXg0MdRjNduJq5qKv1PG9Q5JCLePs8P90npLjvO+9CihVnvMUkPzHlot2BbfMZSyLZr6EYkI
	fVpiV9ag3PcDPVUD77wM2U/3pmGwmiRGXazvvhtGJ4hVD3c0jSr4J8Revk7dkXn/3
X-Gm-Gg: ASbGnct3iwrUauWiY95ixgXlvlBSbYBCGqwGSBCHllMoEmoMGVsfBbAdXY8muv1Yc5Y
	zY4aoYoRIkDKuWJpx3Y14sP9y8dqoKYB4JIm7HxUjBjBoC30Khyd9CSYEIgUiabsH9foJLJCHdt
	HsPTXDa/kWVmpiIc9NZDXwOQql6bIneRWHNxHEWhR+Ec4B1dywVBN78Os0yhW6h5veglpQHPxMq
	RY3e0jxzXUqWu2thuAye7BPDJNd0LFAyTW1wU2u8YE66qFIoYiAmEJGsVrJNxz2jZ4exqOpq91y
	DqKAs/M8AZ4LNvB0DIoJI8PnHCyGWLwIA9Xn7AMjQnWmwXWmE4Tb58hqWVRTKEqZLkr0e51pokN
	wF1ZPykr+j2NBDQ==
X-Received: by 2002:a05:600c:3b97:b0:477:9e8f:dae8 with SMTP id 5b1f17b1804b1-47904a685c0mr176692265e9.0.1764341636305;
        Fri, 28 Nov 2025 06:53:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpkWqYDaUVZ37zQyb1mHzaqoSneCxk1B4j7u/LBU5uaXqhbu0tW8vw5LFDOW8tHiO/C+CWSA==
X-Received: by 2002:a05:600c:3b97:b0:477:9e8f:dae8 with SMTP id 5b1f17b1804b1-47904a685c0mr176691925e9.0.1764341635896;
        Fri, 28 Nov 2025 06:53:55 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790adc8bbbsm162887565e9.3.2025.11.28.06.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 06:53:55 -0800 (PST)
Message-ID: <a6f9f6e8-8a41-4b5c-a72f-1351f53cb631@redhat.com>
Date: Fri, 28 Nov 2025 15:53:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: sync the msk->sndbuf at accept() time
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
References: <20251128094417.14463-1-gang.yan@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251128094417.14463-1-gang.yan@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UDIOQ-KY__ENFxIEQikHXmOBqnN5WS9NhKUAIioZlP0_1764341637
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/25 10:44 AM, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> After an MPTCP connection is established, the sk_sndbuf of client's msk
> can be updated through 'subflow_finish_connect'. However, the newly
> accepted msk on the server side has a small sk_sndbuf than
> msk->first->sk_sndbuf:
> 
> '''
> MPTCP: msk:00000000e55b09db, msk->sndbuf:20480, msk->first->sndbuf:2626560
> '''

How do you observe the above exactly? subflow-level rcvbuf increases -
in tcp_new_space() -  are propagated to the msk via:

ssk->sk_write_space -> subflow_write_space -> mptcp_propagate_sndbuf.

> This means that when the server immediately sends MSG_DONTWAIT data to
> the client after the connection is established, it is more likely to
> encounter EAGAIN.

It's unclear to me how the subflow rcvbuf can be greater than default
before sending any data.

/P

