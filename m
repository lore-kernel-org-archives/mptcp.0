Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C753EC2F4
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779874850; cv=none; b=eqS/NyTSL3kNFVHvLhedICK96fpE+GysXONIfH0nbX1d6TuVIKV1NUiZgickkDixFpabb0rLuVD0vBVMgqX+dLFbmWdGH7OdhquN8nRVL7ireeqSKTFPbXgMXj5vT6MmHmF08tcXZqgFxEDxKBAPD2TRvOrKjQoVhM5YXZGNLBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779874850; c=relaxed/simple;
	bh=Tmi25aOXa0nMPrmi8p1RdJV5W23w7eYfXMvwUD6GwFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDul2IcAno+72Lv/Y3uPMlNCaXe5k0eVM/RTbbvmAp33iMp0SFwoDcRCMwsW86HFIuVMhwkQTT5M/5IXK+39FDsy4S3vldWnK8EZps2Bb8BKwP0irPvhNAXPDhLgdh0qHlhBh7uLN5pxsHFQSPQwXJTGtkDSh2lM7/nRM2dN/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSRgD2HG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSRgD2HG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779874847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tmi25aOXa0nMPrmi8p1RdJV5W23w7eYfXMvwUD6GwFQ=;
	b=QSRgD2HGdpDDjoTcxramQPS7j+fWL+MBSBgtj9s37onFbgd7EB12MudTk3jI+aMgzGB/EJ
	ei0J2Zei++LUxuB9YmevDyIV6ieIoEDhelTYtoz+Bayzvg0nv2qLchooKc2QMv71MB7ZeS
	eIMdg1lBQ18uDRl7AZ7YS3WRcu6MjXo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-m2RWy8mLMLGz3m48wDIahA-1; Wed, 27 May 2026 05:40:45 -0400
X-MC-Unique: m2RWy8mLMLGz3m48wDIahA-1
X-Mimecast-MFC-AGG-ID: m2RWy8mLMLGz3m48wDIahA_1779874844
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fd64c32e8so79048805e9.3
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 02:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779874844; x=1780479644;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tmi25aOXa0nMPrmi8p1RdJV5W23w7eYfXMvwUD6GwFQ=;
        b=KEL/ok65rjDx09PrFw8ZDMLUR78UevnpKEGBKR1pNpCmgOYZNlmMP5Jqxdauz0RjgT
         RzW6ClaVJQIsSUQW0SNLj4N+HTdlXcm1oWWOOX2A+GN+t2LvHepHwXeuQjwbS+IwTRIj
         SDgWQCI2k8Nsr/4MRTCJbSVLvo1zEy70csQrOjQu7PRUAlvwH1Fu5iO5w/hibiXZQdbm
         HndZ3mvVmOPLqNlozagsVp1cySOOjWAwvy/fJi8qgWUTxRF/LYvKZApxWVi9SJLAiK7C
         39StDaVAVEcmur8VwXCCw5gusblnnBq8yT0N5amRaVEh0KJyepoBFQcDQoFnqP8t0dLG
         qDNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4Kivap5DaoQMvLUZPqVGdkXZOAzQWMzqsytsmFzIPnFiIITNGGUhaa1GqzpqeKs3Ec0y+jg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJRTZ6XTSLPx2SBJdEQC5nM88o3HAXqL5igyOcEMP+QK2/f2Fe
	W8EJLkPGxyNJih54hKBUAJnIgRk6IFXX9G5AvT0ML5aNBmdx67Wp7MHMcsuumz+v2qz8XTyZW6n
	wGzegBWFeuL4Yvy3siSEz3YbRxrhdLyvcsjnie1P291RiaJJCmvB5xSv2
X-Gm-Gg: Acq92OGn6E3tg3s5UN8LUbIFqdv1URJ9BsXvLpTCvlwJU1YimiPJebDVjZX/pcEpJMj
	OLyvyX1lZX/J/fjXYnjAe5KUZhFw4NXidRINGZwHu0+ggHRdMSjNNutNdVBzNDpxa5lxV4iEz8G
	95FpbAWWpzJ/oyn8x/WYNSKhVWf96n+dubOnZKnDXAZr+kSA54ceg3CDsEc8idnbZ/89YhChnZ+
	ufDyCTLFhBNdti8ZT3jhi/qgEyllt09shPwc0/GJ3R1jq3tZTj3zJpfx3LLZ/DW07WeW5h1COdj
	AFeMoTLFdF3YGE7WJYSYmxleem/RUY66VyppCck3gmmZUIYK8NjQiG3k1f3PuA42uwQk4dgU5ib
	5P1pUuDJWdAPjor1UQK+IbZ1DhoRr87csJbvhPIeufst+8pohJ8IB0AFEpWkOQp7SyPux
X-Received: by 2002:a05:600c:8b12:b0:490:5191:6e1a with SMTP id 5b1f17b1804b1-490519170d7mr336363225e9.24.1779874844434;
        Wed, 27 May 2026 02:40:44 -0700 (PDT)
X-Received: by 2002:a05:600c:8b12:b0:490:5191:6e1a with SMTP id 5b1f17b1804b1-490519170d7mr336362745e9.24.1779874844011;
        Wed, 27 May 2026 02:40:44 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454cfcaesm379486155e9.4.2026.05.27.02.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 02:40:43 -0700 (PDT)
Message-ID: <08d590f7-b825-47ce-bc68-c3ad2bd78bc2@redhat.com>
Date: Wed, 27 May 2026 11:40:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] mptcp: fix stale skb->sk reference on subflow
 close
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
 mptcp <mptcp@lists.linux.dev>, matttbe <matttbe@kernel.org>
Cc: "shardul.b" <shardul.b@mpiricsoftware.com>, janak <janak@mpiric.us>,
 kalpanjani009 <kalpanjani009@gmail.com>
References: <20260519092243.1242351-1-kalpan.jani@mpiricsoftware.com>
 <19e67fb067f.1c11e928628417.8560610860929896581@mpiricsoftware.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <19e67fb067f.1c11e928628417.8560610860929896581@mpiricsoftware.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _IDeeF-h2UFl0oZaiF6W9PWLZpvruYZalIy4P8fXn_c_1779874844
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/26 7:49 AM, Kalpan Jani wrote:
> Gentle ping on this patch sent on 19 May 2026 — I haven't seen any review feedback yet. If anyone has had a chance to look, I'd appreciate comments; otherwise I'm happy to rebase or resend if it slipped through.

Note that maintainers are under an ever increasing influx of AI
generated contents that make processing incoming patches more
challenging every day.

FTR this revision LGTM.

/P


