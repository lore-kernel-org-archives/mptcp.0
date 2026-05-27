Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C383CF689
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875604; cv=none; b=GMP2qaraRlZtV2wWV6uO9w3wqZbLhqhnr/zdB724ZOV900EbARAUtDAkk5/gHFktntMKVJsCeQHNXy1W/uOVSs8tgR3x/GT9lFk5PUF8T7OT4KDnPbpSUwtCwEFCWvbmlNvJFCfJIOYuAB75extsPt1F9Ir+E6SmzAImXgDvnbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875604; c=relaxed/simple;
	bh=sxdexjuTnGPZsfnS26M2a6rpwMDn9tQa+sRqvC3pwtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyE/UsopUYmOnzwUCy5d6eiYf4wPNTNUGsujcWVnEpPzB/W1x+mjQ5Enrof+5FAdwyWOfULFTsuGzB9kiEgfLoSXHV/h8tWcCGoXnCoXti4UXvWC5GOiokDtNP7OeGXmD6qBCUq1NDIYPZK3WSLd1Yy+DOYi+sfWtYwwAYb3tCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glunPdMz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glunPdMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779875602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxadH/W7JWxXgtelN+rdwWlMqFVU0EgJ+yNyQN9IVRw=;
	b=glunPdMzvIkncbA/xAbjlfLuMMZucE0lTBoOLWmfXfTQ0O0KZ1ISqalaLff7KIvm6SzO0R
	V7NIoN4JwWwKTv61WZTb+dg/W8M4JVVaGr74RTi2xw6Kj4N0fOruW0rF8NBTdGGZ0Cw5NK
	mWER89ReIb+MQ7ZxRp+iYXFx9A7pUDc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-tEX7_z-TNzGOOGuNybSUnQ-1; Wed, 27 May 2026 05:53:19 -0400
X-MC-Unique: tEX7_z-TNzGOOGuNybSUnQ-1
X-Mimecast-MFC-AGG-ID: tEX7_z-TNzGOOGuNybSUnQ_1779875599
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4905428aad6so35571515e9.1
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 02:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875598; x=1780480398;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxadH/W7JWxXgtelN+rdwWlMqFVU0EgJ+yNyQN9IVRw=;
        b=L0C+4JEYhtln+x5fCNQGK4i0HLqyEG/nhbtrWeU/BQvQ9CxPyNTfZk6NjR6anMMUWa
         +eweVDVv8XjDKRvRSlu0W2DE5P/8TybqX4Wwn8d44/b20m97Aj33UdC1kYafTRKALdLI
         Vtzf0fhh9lTm6TxlruL60JoCjnqfbBtpomCPS9tOrDPI5cBvpbV8WWOg79unbbVcMnmE
         UzGbdfkCoOXSq1o6sswPCHfs59yD9O/2H1TjoHKZliTLUeO95KFplRSesjAv0Ml7AaBj
         ZuQallFDBTKG3CxhdVtw9jZD2jrgTGWEPbrs50tQ/F3FrhWWAuBUCRFPeDZmc/wIeMjQ
         UISQ==
X-Forwarded-Encrypted: i=1; AFNElJ/UcEc8yTUcQt/N5sryJBsME83ZqXNdw83761Hbgs2awyLGWtSbtwX5tOoljXPQHXyiajhzEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyB7s2zciWfgzgUAIn8rbS08u4xT0udasrGXUql6ZYlrzUanWc7
	kRL58/d9uk2lZXCdixKLAxGbkA/Wgnh2VcCcUQE3b8BqKQNKIBdEpkPSfffsWJUqlSzRyI+1YXo
	GVcHs6idU7NI4l1SX76CYYmltELb5OZhS1aNWgSFNmKOSmYCtaZ4wSfXs
X-Gm-Gg: Acq92OH1Mh1PsAKSAQ+wd+kx9H/PA6COmwITycJmQf2BKy40+oAuFH/zzkXvn9xgaYK
	pCuppl57mKtPUP2GmgCY8KzmjQf8sZTmZODKsJwQjaxY8uyPP5wCExVNlqUmVKSV8+nfV7qm+kw
	SnVVppeuuZ0J3CJBYvVB04c3W8IOX7PXi4mkgst6NKMfexif8qw2S+gHxzsRgD3lmnRxKZKNKyL
	RX9/j+1Q19uCDpW2/S1NoeDjD0yOI66CbE4CFLbIAyW8Uc4vIa+VDBb9Q1y0jBXQrEFWWxO9tOe
	tjDS8ENLUJfDzZscOMvkFoKmyoE26Znw4D4hoYWO8sT8Ct0Akv+MbZt7SEFAz84PXpiWC4LqR5S
	+yzuPzR8Q9rSooslG3LiGkv0f3R+XnpEZ5Q1aDykn2oCuWHRw8DL/wEbnFH17Mu8Gwx11
X-Received: by 2002:a05:600c:1550:b0:490:48a0:b87a with SMTP id 5b1f17b1804b1-49048a0b90dmr352891875e9.9.1779875598573;
        Wed, 27 May 2026 02:53:18 -0700 (PDT)
X-Received: by 2002:a05:600c:1550:b0:490:48a0:b87a with SMTP id 5b1f17b1804b1-49048a0b90dmr352891535e9.9.1779875598097;
        Wed, 27 May 2026 02:53:18 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490452765f5sm402464055e9.5.2026.05.27.02.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 02:53:16 -0700 (PDT)
Message-ID: <b7bd5870-c2b3-44ba-b59d-fb1cff546893@redhat.com>
Date: Wed, 27 May 2026 11:53:15 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 4/6] mptcp: reject sockopt requiring ssks'
 lock in BPF context
To: gang.yan@linux.dev, MPTCP Linux <mptcp@lists.linux.dev>
Cc: Gang Yan <yangang@kylinos.cn>
References: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
 <20260522-sockopt_lock-v5-4-108629a46e98@kylinos.cn>
 <0887aa80-13c0-47eb-9178-a7f1cf9ba5e5@redhat.com>
 <ab405d42521cb862e62d652ce0f400a5ab73d7b7@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ab405d42521cb862e62d652ce0f400a5ab73d7b7@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 13SdImx75QGDkYG1CeWtqR43oWT7VimJXcLBVQVdygg_1779875599
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/25/26 11:01 AM, gang.yan@linux.dev wrote:
> Would you mind reviewing patch 1 separately? I noticed that patch 1 is doing
> something different from the rest. Patches 2–6 focus on MPTCP sockopt issues
> in BPF context — they should really be a separate series, and I'll iterate on
> a new version for them later.
> 
> My current idea is to build on patch 5 and patch 6 to try supporting a subset
> of setsockopt operations in BPF environment. For operations that need to take
> the subflow lock (including the first subflow), we can use has_current_bpf_ctx
> to return -EOPNOTSUPP.
> 
> WDYT?

I'm fine with the above plan. I think patch 2, 4 are almost ready to be
merged, with the minor change already noted.

/P

