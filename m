Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C691C1C02
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 15:33:15 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id q5so15727314wmo.4
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681831994; x=1684423994;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rPxQpoMC3Gf2e39oPTpbLwEq3skInK5koLqUQR0BE5Y=;
        b=9IaBP8gZtXqiI5UMz/v3KVvFhWNrCQQ4Cyy0Co1pQrMxviDGgqLHEOnCRN3vsUK6RC
         cHRUtAfZWvsPNNof9UDElJxn8drPrwTHujhKuI7VTS/SoVDPP011qzNsXECa/CBRWmzj
         66vcO8eK0ZHqh9bkoILRFNMfDfqgJPf+SynrHvTuW7XWSoxsUqqfR4chpYPpI3RcFbt/
         ZW0ikgxDKOPesxmjTSZogQwGzQsfMR28sthF6wHuaHnfrByXJ42IDkntAMJtHp1ciASS
         XL18hQOUyRsT+LW3e0JTToySYd1h7dRnWPxn9TfPA4urJxnZ909Sz/eX6Ur8UkkBKutr
         K3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831994; x=1684423994;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPxQpoMC3Gf2e39oPTpbLwEq3skInK5koLqUQR0BE5Y=;
        b=ckE6Q35hVgHWer1A9OlPhQp+CtfVdgLT6lEdWc1T8eV0VY6AMYLT/P+hSB8FSE3Zn3
         mBVXUWtK2zADiyvtF0D7KhYfl9ZrRIieW2Wynce8ytGCMePBBE1u4tRNNMQyWreYzHoO
         OsamFcSHNSu3nHo528kIsCXWllK9RHd03spMZyTQMqveKWjGSHW1aRblZbz1fZfd5Xys
         1GUwCrs2TD9CflzrgN/Pd0luAKsFR82N7CsbvOlrD4jYYw4X4FpO/Nrc/SMcuPMqEu61
         uTTUN6PnhgypxBsb6PXz0wlRxbguLpH1UI3jEn8+jNG4SPHsAFHJhdMJZqYSaQuKQBOX
         kQQw==
X-Gm-Message-State: AAQBX9e4gIrea8LkgvmRRY2SInfcvUjHfjZ7ZIqbUCNgMAFp5OR8Kt6d
	eI1GTq93LL5Ov0ZxZB6vw8CmCssr2dfhWmG9cGe8HA==
X-Google-Smtp-Source: AKy350abVi9HeZdFionIoW9df9a6lPGq0UxfrhKwnxVhsiq0xrHHRg+tbATB6gRol6TdtF80xrcKaw==
X-Received: by 2002:a7b:ce07:0:b0:3f0:373d:c32b with SMTP id m7-20020a7bce07000000b003f0373dc32bmr14076591wmc.30.1681831994008;
        Tue, 18 Apr 2023 08:33:14 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1b76:be36:72bc:27e0? ([2a02:578:8593:1200:1b76:be36:72bc:27e0])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c471500b003ef5bb63f13sm19017025wmo.10.2023.04.18.08.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:33:13 -0700 (PDT)
Message-ID: <66d0f41c-28e6-ed8b-1961-f3a0b5cc12c6@tessares.net>
Date: Tue, 18 Apr 2023 17:33:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v7 1/7] mptcp: pass addr to
 mptcp_pm_alloc_anno_list
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1681463340.git.geliang.tang@suse.com>
 <d0d80bd0407f27ae087ad7e37eb2f58b11b7d15e.1681463340.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d0d80bd0407f27ae087ad7e37eb2f58b11b7d15e.1681463340.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for this patch!

On 14/04/2023 11:11, Geliang Tang wrote:
> Pass addr to mptcp_pm_alloc_anno_list() instead of entry.

Do you mind just adding the reason why you need that please?

We can easily see you are changing the signature of the function but it
is harder to find why. We can understand that when looking at the patch
4/7 but when looking at this patch alone -- especially later, out of
this context -- it will be hard to guess why this patch was needed.

Also, if you don't mind, may you just say that we can reduce the scope,
e.g. in mptcp_pm_alloc_anno_list(), we only access "entry->addr", we can
then restrict to the pointer to "addr" then.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
