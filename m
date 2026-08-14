Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A625D1E5207
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786707223; cv=none; b=LzYxJ8wQHf/a+v3tjzeJk/nK7ujLnWM4FtHO0rrHZUuWzQz7jXMs//Xuf5S8hPSm3QxatVUKpLGNJgA4NQjYFC3hezMA8C9z6kr4AmZJsoKHPIvL/0rGCsUyv1WoBrdY85FIhddnr2kBWBtsJb6vz6GfGHk1lzpymf2GeptUY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786707223; c=relaxed/simple;
	bh=c6gXXrRT214m5ieMxMOpXYT6AvqfgHozcfbOJIkL5Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shX/UW6Qudgk6CgEsiVxuza6HFvlSKFD+dz8bBmq3kNg7mQ752yMQHCRULoQ+4Ch+FCdh6YbXiIZBSbIPIrGXEGHQtu3q431MWfxxYb9jF8TOEzIVAO7MJ5oSoMqjFCwvPrpYcuCI6FBsja1YzNPgaxQSfpQrAl9DLEtsaDb4C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rs6IDeLn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rs6IDeLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786707219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Nuud+GDfUjhf/1c81hPf2Va1K/CzT0BQCNz43df8/s=;
	b=Rs6IDeLnm8eRgdSV/gxo2KVpqgLB1WuV6b3cbCxNxIR4i6sjeIyMiGZnEXUKshVgJU+vuG
	ISQm86aASd+XPl91kwJxtqv9jb3fvLshKMS0B5lmHD3gKV+7JYymgglMiYkRgp4O/tD76O
	ZzoRBHvLR4X4l7xY0QwY7avaAK3XiKA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-rADHNR6TPwOw_21bjEJwmg-1; Fri, 14 Aug 2026 07:33:38 -0400
X-MC-Unique: rADHNR6TPwOw_21bjEJwmg-1
X-Mimecast-MFC-AGG-ID: rADHNR6TPwOw_21bjEJwmg_1786707217
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f84ac1990so539594f8f.2
        for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 04:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786707217; x=1787312017;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Nuud+GDfUjhf/1c81hPf2Va1K/CzT0BQCNz43df8/s=;
        b=XcRstq+XH1aDlzmctHUlNHPZJ1+RB0r2bDiuk5NkVVSKXeNGXCybOsjdWnBFE3Yg0z
         /jaT8YnroTOmFIbCnpuqAk0tDUlwHMPb2YKHeqDKNWpvneSAZblbyFohzT0ygL8hIQue
         LOzpspF7J6orb+q8CcwGdsVvUujB2YqjXk455fvaNMk0liwkQI4RPGdhVOA3njkBQWWS
         +1fWSGIUOBcRoB64J/YmiQDbwCBAom1w7XMNqw+XFdbPCBPpmW+GkzvlOHkIwP98YxPI
         DiPehJdDGMNfF2uQm3Qiw8/tKIhHxy6F8yGSyLHQIVb8PFScSplZjw1n88ss2tJkK9y5
         L38A==
X-Gm-Message-State: AOJu0YzPwMQEsOOqeMRUuxcuBYsmrH7sAnVadUs4/AzzONT7hGLnANYe
	PyAAxoEqeEByWpEQTZemsjZpcfdKLz9H/GRiEKztqj1NKahBm+3KOViW8/c5dTnU78pyKPwttvk
	TYlegIVjN1B8uyacJiBqIMgBXXknO7Uz1op8DiSTqGAKppSrCY6drFGTy
X-Gm-Gg: AR+sD12jZoWrLSogUxwuc3AOQhO/NdnYHJYgZcT3an6tD3/n9hwUCaspQnAhs3txysI
	0twkwg3rEQeZrCaBmcAEbdcDKLbioAX4I99WkefX/RWbk7RpdStVtcCYzMP8J1xpiKldf5nr1ZZ
	rVO1y+hzOT6qhnCX4QtdmhW4OSAmd861EA9eIDHd9uqZpiVafirj6YewFxJygLhylhvT3xDzFrG
	6P1BfNYwcsSaXzeZHDf4017kEfi7WIF/YLx+ODKPWy00TNl2YpkSGxZEMX/cNpefhyorfonKyXi
	pTh1o1FsQfW2xEIWnVSA7yFDBz1hiASYeoN7Z/Ajxyutafa86GiWbwWuS4a1VcNPppiYehWBaLw
	Fw4DC2Bg2xwbwCiDPGOeYH4EnTpFsDZ41nsYQQ5VbcClWACZoSExBlNLXsKI4wTyPUO8pCqGgP9
	g=
X-Received: by 2002:a05:6000:2903:b0:47f:cb30:8591 with SMTP id ffacd0b85a97d-48160723c0bmr8352681f8f.6.1786707216767;
        Fri, 14 Aug 2026 04:33:36 -0700 (PDT)
X-Received: by 2002:a05:6000:2903:b0:47f:cb30:8591 with SMTP id ffacd0b85a97d-48160723c0bmr8352624f8f.6.1786707216280;
        Fri, 14 Aug 2026 04:33:36 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c1307sm7713704f8f.27.2026.08.14.04.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 04:33:35 -0700 (PDT)
Message-ID: <dab17176-51d7-40be-ae95-bfed9ab6691a@redhat.com>
Date: Fri, 14 Aug 2026 13:33:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CI failures on nipa
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, Gang Yan <gang.yan@linux.dev>
References: <02830f64-bb5f-41fc-8211-5f7aa36b828e@redhat.com>
 <07b78c7e-f628-4f0f-b351-89064c6218d2@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <07b78c7e-f628-4f0f-b351-89064c6218d2@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qlj9A6L7rPTjaTrO9K3ghvp50nmFGbfEz799k1yZoiE_1786707217
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 11:15 AM, Matthieu Baerts wrote:
> On 13/08/2026 09:57, Paolo Abeni wrote:
>> Also I think mptcp_lib_wait_timeout completes too late (after ~60 secs),
>> when the listener already bailed out due to accept timeout (after ~30
>> secs), so it does not show any info on the listener side. I fear it may
>> also race with the actuall `timeout` command completion showing socket
>> states after the user-space program completion.
> 
> Do you mean you would like to have mptcp_lib_wait_timeout wait for less
> than the accept timeout?

Ideally yes, but I'm not sure which time would be ideal...

ATM likely it's better not applying changes there. I also agree Gang's
patch (good catch! many thanks!) should fix the issue.

/P

