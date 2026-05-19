Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A1407CE1
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207507; cv=none; b=kLIZhkikSS04BrgJ2/mOiTLyyVKdi32JDW79Wrm4UVu55AuFAfO9X1q4fvuBE0Vm/u5Ui/C1ecFXkCUlWnXt0Y/WEMTrWO8cNRvHDOskiUg0fdP2sL1mmB4f1bF/B2hpORb+4ToLyvK64WBGlJQ08hJWxLZqlYBYRXNfqqmD9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207507; c=relaxed/simple;
	bh=CbXcBhRGuASgbLsIrXjJjewH1ADj3nOAaLEFaT/X1lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5M01XsaYixZg1G9q4uFAcBcpnST4AnGV+ImpqVeH+ZseKa69NCU7+O9GXWur+7p0OghZ7dP6QGteNg/qC/9wMMkmsHjFSmnouZgAW2txGM1GNcvHP3OdLXwU0hAAyEizzu+IKXFlYHGocrWiCNcmCFSL5b7Dy0jsY+lc5fn+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZZNOGse; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZZNOGse"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779207505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFuhxLO8/mMraUh0ucxygR4eDpy4xAAk7HR0yXVZXN8=;
	b=GZZNOGseDnTAepOr4BWI68fQ16elPoItkHyUAplcS9Yg/hWObwQ2QQzpvl5+Gdus79W73t
	mSIa1fxaCzyW8WbeLoCpuh6yn7V8Rzt1b24nMxpI6sa/ZejbTLvpiRJcU6Umlz2mcMic2f
	1tqxpBeHxrysz+smzu98W9f1p7xJhY4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7--w3UNcYuObuPHDNV_ycr0Q-1; Tue, 19 May 2026 12:18:22 -0400
X-MC-Unique: -w3UNcYuObuPHDNV_ycr0Q-1
X-Mimecast-MFC-AGG-ID: -w3UNcYuObuPHDNV_ycr0Q_1779207501
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4900f69197fso11365135e9.2
        for <mptcp@lists.linux.dev>; Tue, 19 May 2026 09:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207501; x=1779812301;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFuhxLO8/mMraUh0ucxygR4eDpy4xAAk7HR0yXVZXN8=;
        b=A21jjgKAYyREUJXAR0YVNjWR+EEDMyHt0asrzSsEL7MYrFi7BmMLsEvT07g+YCBKvg
         L4r+7XZw1E76vHIcqu8QJ6aA63GQ9ON38FZnsGF3VTOtWW41F/OdKX3pVy5V+lmmltEZ
         BwXlGFtJ9cFx+PZI8NzWj2awOxzrtWZiuQSYt6b6omsK+J6LGkshck3w+sO827/hZUjC
         3pgKXUjt4WRyhatDHnx4oBxtyQkImrFvXWfS9PkYPxNKEUhV6jPg6Gg/mzzk2QBsanwM
         4J29hOTqtGLDbLx8zF7j2/mszNRnwg/G4SGs550LxStVVlEyJEf7s5JAgJiPFbTsiC9N
         kXdg==
X-Forwarded-Encrypted: i=1; AFNElJ9dxWTv5VVvJOEo0qBnFISiW9KcE5DKo6EsRLduRKmIyyd7gaFARyyzL4oCMSOfuV0ggEgtSA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7wk76/M/Uu4xguIUbUXsSq6x3iUMvPaDI7QcepIrtMTlDPSMQ
	StG97XPcwa4XOIt0+RheBtXM9WkbZlqtCeDoDZ3MauL3IDG9Jn2UT+8P1rO1oCm+6fdHf3owDFF
	9A+HSIiJXJf/6LwLq7w8rM5MOc1G1agCj5UejDs2JwySCOHljPI2XMoFY
X-Gm-Gg: Acq92OGMjalpfIGRqUTiQIfcViOero5UmJPEmyR5oGEAfxlrctwHhPaMXbH8l0HMixk
	Rs+G5p+5APx4rJSYv59UDtbvGaY0Y6vQWMa11FtSKHiutZ5z/th2n8Nw3UPyimnJvcdU+mqc/RN
	gYpnSYyG+mJ/AoQT7q8D6IXW+mC1Bck6gahMlr/7I7m1qsuvsiRpDkpWMYvtzJbeVYolqAtEQ7M
	i/8tZzd7I5RuhSvluqD4ofMbnleUX4QdFTVt84EaqNdiTyoMsQOfePvsOdrgpaJXXx+krQ0z+qL
	YXI7JhSoEIbUj90aUbKwKFJ1E+4zEJayxYDvkNgUIuN3Ins3TKapDw6dAY5fgEbPU7BwFP6vWuH
	Ygymw1DaX6uBAq00B/H39TYc0YtAaA1XzboIzcQ505kMOAyawWM6WGog=
X-Received: by 2002:a05:600c:871b:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-48fe6613ac0mr304964855e9.29.1779207501422;
        Tue, 19 May 2026 09:18:21 -0700 (PDT)
X-Received: by 2002:a05:600c:871b:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-48fe6613ac0mr304964525e9.29.1779207501020;
        Tue, 19 May 2026 09:18:21 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6b60csm161463255e9.6.2026.05.19.09.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 09:18:20 -0700 (PDT)
Message-ID: <e4e361eb-e98e-446d-b55f-21f5c502fa34@redhat.com>
Date: Tue, 19 May 2026 18:18:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 mptcp-next 0/7] mptcp: address stall under memory
 pressure
To: gang.yan@linux.dev, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
References: <cover.1778835009.git.pabeni@redhat.com>
 <4a38eef7-0143-4980-b856-42591e521b13@redhat.com>
 <a3331544d24acc69090b43bb44fa5087c33a6092@linux.dev>
 <7f816ee8-6119-47ff-a10d-bbfa61a24e6a@redhat.com>
 <83a3de2bffbecbad544544e77019cbae1ebd913f@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <83a3de2bffbecbad544544e77019cbae1ebd913f@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yt1zXfWeeLvU3z2CY919D2CR47xrD5tz8FraxqmvnPA_1779207501
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/26 10:50 AM, gang.yan@linux.dev wrote:
> May 19, 2026 at 12:30 AM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@redhat.com?to=%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:
>> On 5/18/26 10:13 AM, gang.yan@linux.dev wrote:
>>>  Thanks a lot for the new patch set. We have encountered some issues during
>>>  our testing. It will take us some time to analyze and locate the root cause.
>>>  We will post updates on the mailing list as soon as we make progress.
>>>
>> I run a few hundred iterations of the mptcp_data test without observing
>> any issue (still running). Can you please share which issue are you
>> observing, the relevant tests case and the build type (debug/non debug)?
>
> Sorry for not providing the specific details earlier in my first message.
> The issue we are seeing occurs specifically when KTLS is enabled.
> 
> Today I ran several sets of comparative tests (many hundreds iterations), and the
> current results suggest that the integration framework between KTLS and MPTCP
> may need some adjustments. We are investigating the root cause.

Reading the above, I understand that testing vs plain MPTCP gives good
results, am I correct? In any case I'll post a v7 to deal with some of
the feedback reported by sashiko on v6.

Thanks,

Paolo

