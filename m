Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654E2135AD
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846048; cv=none; b=Qvu/gchzNjCar/i72A8BKtLaekp5GAC+QrCoS2TNUCoRtZdlQykpeFAm1eHLFlv8TrddATygdU880pNx+/Mt111eCDhfty69RgQp4Ocmp8CrJvjZGc9iyUoS+iIc5nDiVsnoHygY2onkRf06INyxIlkv08PrYQS6E5OhvH2ZR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846048; c=relaxed/simple;
	bh=75/DT0oFxaHnopa7QmWiViq7rSO0H8jKsbrADXIFHTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2sj8q0HSuTHir5CFstOY04AFHx8LIUdtbpX3Z+vn5dBE9yTJHFIUTvl81CEnaHfD8KzCGp+OFR1QIjrNpOWn4WAI0ur4A9AGuRqz9wN+Ywee5RChFAMYY6wSgSSU8YL8LENsmiGQmHtjhg5pK73COSnTiUwgX7b8qdQIo91L1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQqNPJDd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQqNPJDd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762846046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06vKWTkw651duewD2IobGBWx2yKtoVcgzXYTwbJymhY=;
	b=JQqNPJDdTaRTSDubYuZzYXERHLXyVW0vTj7o0174Ka2HiSMulWa1z53BrUiYeI5c2OOVLf
	zUSgZaAARmMshMvky4G/wSswb1nGLRJYX08gdzbQdctzZV0Zwy6fsHSttSECRuDywq7NgW
	VgWVZygAufcKTKgthBN5gxJgwbjCwXU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-Xi9z5206POKKhoRwskITTQ-1; Tue, 11 Nov 2025 02:27:25 -0500
X-MC-Unique: Xi9z5206POKKhoRwskITTQ-1
X-Mimecast-MFC-AGG-ID: Xi9z5206POKKhoRwskITTQ_1762846044
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2f79759bso1956665f8f.2
        for <mptcp@lists.linux.dev>; Mon, 10 Nov 2025 23:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762846043; x=1763450843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06vKWTkw651duewD2IobGBWx2yKtoVcgzXYTwbJymhY=;
        b=IUVI3BXKfn1vanYki2hPKwFCHNXbF2PUvT++trjQU/xhQ+zjeEijhc5xYNubH8aY2p
         YT+vJQGhyTTW0y3YVSFwDADgrGBBdl5RAzCvRPrUCWjXyhjp0nC0Z9NT7cZ+RklqAzsM
         c5P0kEN0buye+lJNpIC8NZm/BhVx4uaTua8GyphvFl/tYNjSoT+Cp8aDgzQeN97K2y2c
         KJEFzEfmqlz/dHIkD2x846uP4YmDm6lJiHcgAwvnzKNLDGlGw0cVxMvO3MvehCXXEPL2
         E5ZeaDu/XjlMP6b3Vca7Vy36LM4MQgxD6wpyapVfGf20z/PxsC/Nm0zh/gT6DNKteJsS
         ZQoA==
X-Gm-Message-State: AOJu0YyHMzM2GHgclxNtQsben9yxL4ah5Nz8WNV3b3bcYIken0An7oQL
	Gc7kOUMgK7gCEE72sVapfPfGetg70Z4KUo3UqW8klYefGjQu+GBOfS0CzhvWH1k/wwdcCDGIiNQ
	4y7QmLX7YWrIl5xiGzheCnTf8qJm6TlX77C3J/KW4Z0KIf6xV8MlsP54yhLpjoSmv
X-Gm-Gg: ASbGnctnrsLfhbG1yxt+r4V7/fGsrym+vhrf3gfHcZQjFR5VIDdUEGv1aea/L2UxXwm
	eh5oKLnHXJl1QaLuKIwxuJK5i1gQZEvRIhETJVbpb/z2aasjHGhj7xNayQUE/9rNaJe2HFywkFx
	i45fcIxWOffMFygL1sE28/+hR//A9Ki8Pb7wwKTn8yvyZ4HJaqutq1K2uciZHdSbcwYPR8XR4Yy
	bZOG4Cx+M3v9TygSoisUnQrXIKQc4gH0K8oQPyCof6ky8RqbQhJY4ZYsHj1TgZK3hhtYDG0GFMd
	L+p2OyHrnSkodekkpW9mI4ImVWure800wQlRRgdrCciY+FM6CY+IttI4QmVW5Tqe5NVHxtfCUjJ
	8lA==
X-Received: by 2002:a05:6000:64d:b0:429:dc9a:ed35 with SMTP id ffacd0b85a97d-42b2dc9f1b5mr7395783f8f.43.1762846043543;
        Mon, 10 Nov 2025 23:27:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVbf0tJrC4BU8njtJf9n5LmgitVW6FyUJZ4VnyuePeMs0PeXJgFTeFIEy+kmMKsqaW1LPgzw==
X-Received: by 2002:a05:6000:64d:b0:429:dc9a:ed35 with SMTP id ffacd0b85a97d-42b2dc9f1b5mr7395763f8f.43.1762846043115;
        Mon, 10 Nov 2025 23:27:23 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm25635074f8f.35.2025.11.10.23.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 23:27:22 -0800 (PST)
Message-ID: <e2ee6526-a092-4034-8977-1104ccee1fea@redhat.com>
Date: Tue, 11 Nov 2025 08:27:21 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: fix duplicate reset on fastclose
To: Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1762500073.git.pabeni@redhat.com>
 <32586f43554a4837f39d534676c5ad957dc10dd5.1762500073.git.pabeni@redhat.com>
 <5a0c227a3a2b660492af391af65eaae8afe31ad0.camel@kernel.org>
 <be209b04-d721-4f75-a05c-56899eb2942f@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <be209b04-d721-4f75-a05c-56899eb2942f@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uwmj_lfu8Vx2fNuVj2lPZhcbOvY0KibW6_5aNpT2BKc_1762846044
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/11/25 7:14 AM, Matthieu Baerts wrote:
> 11 Nov 2025 02:59:28 Geliang Tang <geliang@kernel.org>:
>> On Fri, 2025-11-07 at 08:23 +0100, Paolo Abeni wrote:
>>> @@ -2448,7 +2447,7 @@ static void __mptcp_subflow_disconnect(struct
>>> sock *ssk,
>>>                        unsigned int flags)
>>
>> nit:
>>
>> The 3rd argument "flags" of __mptcp_subflow_disconnect is useless now.
>> We can drop it.
> 
> I don't think it is useless: __mptcp_close_ssk() is still called with either
> the push flag or no flag (0).
> 
> Because this patch is for net, we should avoid unnecessary modifications:
> we should not change the type or the name of the function argument for
> "cosmetic" reasons.

FWIW, I agree with Mat.

>>> @@ -2511,20 +2510,13 @@ static void __mptcp_close_ssk(struct sock
>>> *sk, struct sock *ssk,
>>>     if (dispose_it)
>>>         list_del(&subflow->node);
>>>  
>>> -   if ((flags & MPTCP_CF_FASTCLOSE) &&
>>> !__mptcp_check_fallback(msk)) {
>>> -       /* be sure to force the tcp_close path
>>> -        * to generate the egress reset
>>> -        */
>>> -       ssk->sk_lingertime = 0;
>>> -       sock_set_flag(ssk, SOCK_LINGER);
>>> -       subflow->send_fastclose = 1;
>>> -   }
>>> +   if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
>>> +       tcp_set_state(ssk, TCP_CLOSE);
>>>  
>>>     need_push = (flags & MPTCP_CF_PUSH) &&
>>> __mptcp_retransmit_pending_data(sk);
>>>     if (!dispose_it) {
>>>         __mptcp_subflow_disconnect(ssk, subflow, flags);
>>>         release_sock(ssk);
>>> -
> 
> (This line should not be removed but this can be fixed when applying the patch.)

Thanks!

/P

