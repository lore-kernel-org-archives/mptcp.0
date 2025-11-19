Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151028B415
	for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763564456; cv=none; b=tvC6yNjqfU6nddzMziQrnL7a9rCTcw5rL1mr3cxMTSpQNYP0eiDv/Wg63h45veUXRULd/wv2t+Ib2LigJCcK+MrP6LvYKZtevZNNv07v+EI0uklBlzrsVOhzPgNpj6QAfDu3ZjWpsWMzM0ItsArt9r3YsIm5iJYkaVq3gsLdYoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763564456; c=relaxed/simple;
	bh=etaIFKLY1aDX6iClFujWTHnr6l00nRZ1DMRWo+azT0A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oKJgEH9AzzZKrBdVEZ70fLMbpq6w8YQo786iuLNyRULhMijy1htBrxpSmqA3O3NJ7iQTaX3lPnmKCtRowcbxGT7DIcB9hlJH6m8UuaX5sUvuE2MfqARvkjBeasyNMGW5Q8Y0fo32SYYvOhWNayGWSTCjf6rdzbdjsnj2+q481hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bxm3IH5Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bxm3IH5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763564453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzHl2TGGYim5ng4Qo3CRFAAtrskrBOdfMHD0E2CelSw=;
	b=Bxm3IH5QHOk6D2PDkkaTuTUsGEhNPQIzPzrd5dbHbxbI3XvJVGV2DHJdvKjx1obKzSJkye
	SlZNoIo5EFDNpeMkfNWLmkRk4VXVTi+FE0yZBuBRRWeCOZlgf4UhesfQglM2lVn+XVsh1n
	I1Fn/MgarFXxpFABRQkJmvAL92IjiUg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-DksQy19mMru79wA9mhLfvw-1; Wed, 19 Nov 2025 10:00:52 -0500
X-MC-Unique: DksQy19mMru79wA9mhLfvw-1
X-Mimecast-MFC-AGG-ID: DksQy19mMru79wA9mhLfvw_1763564451
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477a027877eso39428175e9.2
        for <mptcp@lists.linux.dev>; Wed, 19 Nov 2025 07:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763564450; x=1764169250;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzHl2TGGYim5ng4Qo3CRFAAtrskrBOdfMHD0E2CelSw=;
        b=QW2J1uYwCaHX4qBLvoA1g1joQkIqUbtZe1lgkDXGhqLBqXt3Bn1aKY2bGCvqIYf3kN
         NFTKXyhYiK9sy8yKpAhXMeN+pYQSf7T49Ld/vXqf4S00DAuuOjNzACNe6pN7KhIWVkvg
         Va77i9QqFsXwSs6WX9Z7KnBHbVwaVBfKK73BkVShjC+cbMhezsFHZnaWEYE2HSA/kchw
         NLo6xHxsC9n3GznV+hOQs6ZL23IJ7DNhdGd7mBcA3hJYgtX6+M4aAzgbscWA/O1xM2xM
         WLdheg3Pd7Evz7N6mzClaEGBwwBq1qsKan7bJ0VrU/bds9/FVMLm5HDQJCc+Ac+OYZzJ
         nltQ==
X-Gm-Message-State: AOJu0Yxk6Yq/LQWV/DyYv7dVCosdjlvlhQfAgzHTR/vbgIkXMvxIqPcJ
	auzVCxCRVHNZb4cGTPl+3R0b0BQWidtnel2hjqrToIQyQsPLoHjVYQPCUmSoR3llWHiLL0OfocY
	dUqHpSrk0RW1Jy6I2L3A6aefeUkB89uTfYF4lHBB/pPU4jXrnvz7dkHkuR/ytlJTQIoV+XkViaY
	XCjF3AF0YcE4Wosyx8ROXn7QAGtZlO4t69NckZPA==
X-Gm-Gg: ASbGnctwXNJx37/YZq9RX+5iUMdpnQNMnQ8Yp3s6p9PbjKbTPdPDGDXFL9UGFI3DH1t
	+QT05ESBQ625b0R1D84si+XyhfEGpfsOFn8KtUK+cie9wvw7JTNXNGAhepmO1yO7xxTdLncdIvn
	kBRKqojIXJsD9rE5fnRdOKMkZGwu3+z0/JR+hmkbgZVNdW++dkdwzLa8fy/P5FqDz9rKAKxQpEY
	kxGy0DhSV582KEgkkSig/mrcWvpa3klW2/69zAqwl6cjusL+mtxoH19Esf+0abn76AIhGHJFu4B
	ErLPWDXo8APME16yOAudTZ1OuE87EHmfUhHRsQ5bf8rtoMHiSPJKE/lF0rauIrEc5E/n8JnRLHU
	wC1xBoX0Efkup
X-Received: by 2002:a05:6000:1849:b0:42b:394a:9e0 with SMTP id ffacd0b85a97d-42b5937879bmr18189129f8f.32.1763564449064;
        Wed, 19 Nov 2025 07:00:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJmwJ5Oabi79G0WvYh/OYcsoE9gCoahTBXPIZYv6+kVp34DWoglsFp81tRgVXv6Lqx3rO9xg==
X-Received: by 2002:a05:6000:1849:b0:42b:394a:9e0 with SMTP id ffacd0b85a97d-42b5937879bmr18189012f8f.32.1763564447804;
        Wed, 19 Nov 2025 07:00:47 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae5bsm38454069f8f.8.2025.11.19.07.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 07:00:47 -0800 (PST)
Message-ID: <4b55af18-6c98-4691-be34-6224d2b919ef@redhat.com>
Date: Wed, 19 Nov 2025 16:00:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 0/5] mptcp: autotune related improvement
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: martineau@kernel.org
References: <cover.1763553361.git.pabeni@redhat.com>
In-Reply-To: <cover.1763553361.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E4uw164KFgDeeGjhrDbISt8MEyizcD3iP0YqLeHrL8Q_1763564451
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 1:12 PM, Paolo Abeni wrote:
> This series collects a few follow-up for the backlog refactor, with some
> of them posing as fixes just to confuse the enemy.
> 
> Targeting net-next as the issues addressed are very old, the change
> is quite invasive and, as mentioned, based on the BL refactor.
> 
> Overall this:
> - introduces a tracepoint similar to tcp useful to track down the issues
>   addressed here
> - avoid rx drop in corner case scenarios, improving tput stability and
>   peak tput over fast link
> - refactor the rcv space and rtt estimator, overall making DRS more
>   correct and avoiding rcv buffer drifting to tcp_rmem[2], which in
>   turn makes the tput more stable and less bursty

I forgot to mention that after this upstream series will be merged:

https://patchwork.kernel.org/user/todo/netdevbpf/?series=1025209

we want to introduce similar changes in mptcp, too.

/P

