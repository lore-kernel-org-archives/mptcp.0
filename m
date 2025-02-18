Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F7C197A76
	for <mptcp@lists.linux.dev>; Tue, 18 Feb 2025 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895876; cv=none; b=P2db0ymfJrx2ws4er4rBMftLZpnWXbjjE6wc7ZiJOPMjomWedwMscy2XE5ixZYN35DcUDJtsdO5H/q4eqQdx9Nozsv2/ZYMypL+WwtaLlHAqog3tzw6Pfss0YSeI94uzFMElpVmurr+33SZ2JrH5ZX+NJueChFIHtkA68XpNkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895876; c=relaxed/simple;
	bh=N6GMPw1KU4bLnUF5X9cxRjjKVbrS7+VfAOmfeBXpiUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jCdYMrZaZyEhAV/r4gk+2AEOR0Fv6kktg5dVM31DotyCIPYIvCApjNETqS50hKrxRfVuaH035vks0xcBt+rDVtqMQxn9H3Y/9+P47J6L7vfY24Qbl8itmi/uEkLYu2s7FvCfqTWDa3lnkrXGv+TDMPOBPXWsFUz4868vMTFraHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UoLHxuY/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoLHxuY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739895873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iTVIVdLspWX7ic0QljcqAiAohGEh766CXTJMZ0Gavo4=;
	b=UoLHxuY/Fhy/qsjVbXzR62wAgOqGi1VA+w4z0NKtbuyGPh2jr2WTzPauYAPJQLuDnxxS4P
	Uo/9z880UDnoA6csErihD/jGpzR8YL8m7fX9LFI7lvvihER3L6Vmw1HGQqXR12eErYIDov
	Y0M+HR3Rr3aGEjgeUYywyXfzDsJBy80=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-bpLwxCO1POO8lBjy9vG6Pw-1; Tue, 18 Feb 2025 11:24:32 -0500
X-MC-Unique: bpLwxCO1POO8lBjy9vG6Pw-1
X-Mimecast-MFC-AGG-ID: bpLwxCO1POO8lBjy9vG6Pw_1739895871
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4388eee7073so33784685e9.0
        for <mptcp@lists.linux.dev>; Tue, 18 Feb 2025 08:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739895870; x=1740500670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTVIVdLspWX7ic0QljcqAiAohGEh766CXTJMZ0Gavo4=;
        b=aECHKQYcFQVU9cstcAVY7hnUl+OLalzkdTndFV2xTk9b0fecPds1NB9LEnUCPBRO80
         mu6SFj2J7qHbLm7UY9ewF8IfxbQW1GeiUcDr/PF9BehgwwGnuwX8PPHNwo6hzf7c3inr
         Ha7zDnUXHyWM5K5/ar6el4QpSqzpV83996EXn/aGOXO2ZqmhZNrDnTBzepCC/04T47Gf
         6lvpdqm8B92/QKAiwSA7l1piyLr8mFO3pX53RQHdn70b+eUAi8iQWHKZNdAZYqWCorc9
         rSlfzXgbI761VUBJfzt69FOHl2ia7wvPMYc3MPc0M8eJNxqwmrKfy8mEIIha5sHB2hNj
         ZHWA==
X-Forwarded-Encrypted: i=1; AJvYcCVUlqj1Jg22bUygNjS5qhVehRr0wGumTMPPOmUeTsdtw61WRi5bCH8FZKEJoEZK1FW18ZCOog==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvDu7y7y8Po+EMedreK0MoBMdrmajzeGW81Yw8sJbvUeCqlSLJ
	68beFMihV5YHkttyHu0oDHupxJjZNao34IlI4SJgKsNZxZdbwXSA2ymSUJoLhSU2mRIrrXxyvA8
	TIBCWI/uunI5272YZXEBEeIAOnJVVe0UHY7EdKTTnKD/dGV2/hisdi25iTtO+
X-Gm-Gg: ASbGncsLFEIBQIgQ4456+TMExu1+aKWTjY0113kgST9DfpPLJMaN/vHC4CTrEVn3QT5
	ozFAyD08D3iWN+LILoKiE/r8n73LXWmkcPw38zuBAgvVPlCLZOE7RmdRpBDuJHHTPzS6oBi1YlC
	uEe1gyMBeqSNnpvqT/MguwmSx5NmbvSMdySf6e517SWQibcAkfxHfJgRFx03djvGuHqUTKKuarm
	FtJRnc5PzO0LVO/Ae/6CSNI83Pm/e+CfutCly4RReyRnhv4E6zkTQ1IkBkGeIHhIHdA0nNUNt3r
	UwHgSK2352g5Q0Tr/evmluqWNmVjNZDSJ3o=
X-Received: by 2002:a5d:64e9:0:b0:38d:d59c:c9d6 with SMTP id ffacd0b85a97d-38f57d78c92mr422943f8f.21.1739895870553;
        Tue, 18 Feb 2025 08:24:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVO4+JaA/TggcMHzJFIZ3ajAGB6IG7L+SXcFGGaDUk0xwuuN5Cn9PJlXaa8kFgoRkEujmhfg==
X-Received: by 2002:a5d:64e9:0:b0:38d:d59c:c9d6 with SMTP id ffacd0b85a97d-38f57d78c92mr422921f8f.21.1739895870174;
        Tue, 18 Feb 2025 08:24:30 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5ee2sm15194422f8f.80.2025.02.18.08.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 08:24:29 -0800 (PST)
Message-ID: <9e83a37d-993a-4766-a1c7-e19aedfa072b@redhat.com>
Date: Tue, 18 Feb 2025 17:24:28 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: reset when MPTCP opts are dropped
 after MPJ
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: "Chester A. Unal" <chester.a.unal@xpedite-tech.com>
References: <20250218-mptcp-dss-drop-mpj-v2-0-0c6caa10ec52@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250218-mptcp-dss-drop-mpj-v2-0-0c6caa10ec52@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lnc_6ANDgXbTz91yXq1nUNdHqtWEsq0D29nrAaWiqzI_1739895871
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 12:24 PM, Matthieu Baerts (NGI0) wrote:
> - Patch 1: fix issue #544 where a middlebox drops MPTCP options after a
>   3WHS on the additional subflow.
> 
> - Patch 2: a safety check is added when asking to do a fallback to do so
>   only when allowed. If not, a new warning will be emitted.
> 
> Note that two new packetdrill tests have been added in a PR to cover
> this case:
> 
>   https://github.com/multipath-tcp/packetdrill/pull/160
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Acked-by: Paolo Abeni <pabeni@redhat.com>

