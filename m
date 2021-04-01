Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F2870
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 16:21:26 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id h10so2576332edt.13
        for <mptcp@lists.linux.dev>; Thu, 01 Apr 2021 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fv5HpdVmnGdAuI8rN9mVDckU3RqGpAIkhN3wpuwZ9lQ=;
        b=EDvmMUN2iCkp0QWaeLVdU7EwE9cb0quburlBckqd66GvjSE1+MKJmG5oNglO/C3cpy
         +5XFbT8LVfDVTTPBzS2aFxteYUkK+iiv/69o5Cyz/A0WXaAD/9eibc9HEuBYzg13xvN2
         QGqwYktkSBXAloOaYP8un2kCQ8nKa79IrUsdWsucczGh5n+Zi45+p05hgGpkVMHPpalO
         Nbb07JNGzNxce5UHetI+e6Q1OQqRX0UmmFx8vLbyBpWJNg9YkJ8r72itsK+fue7rOyse
         Nh3DQgaZb5/HZznKg9XcaI1tSn+UIfZ/n1gCnA6Zxpp0GkSzkqfvHSPGDQGBxPKXr/+s
         qZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fv5HpdVmnGdAuI8rN9mVDckU3RqGpAIkhN3wpuwZ9lQ=;
        b=pQGaM5fJdwoKfyguv2bI1YxsU332zo4SMbHabioJX8RGDQdQfSSB6JIzXFx+LLkUgK
         8zJWozlL0+UPAa8xi5ksa90IxOfcd0nOlhH2X0klOPnZ5qx6DjBxpGHR+ccT0T0tvU5a
         3v8iRXabAPyaMI/EOMu3zK1cGAR3zpuaM2jkkLa/jPrN07pypw3uYv45mRyFKxycDpCP
         JRb41q9x6A6d/FZDJiDL1lCPWoGQXbKFLEpejXlNjLVQ026aIFi80K3KJt+kSzv4JmQX
         7E8dkMlgPehBcoQfsoyqnpcg2hyWBsPY48dSOFZzFmiVYOyTFvEzIQTmf53Z/HGOx4KE
         gcwA==
X-Gm-Message-State: AOAM530ULsq76DT03eAbkbpwLMqy87T++xyjnanee7OQZIc46O2OYrAZ
	pQoW/5SIchrejpU6opYOPpyr/izKJA3dUg==
X-Google-Smtp-Source: ABdhPJxbmQtU0CYQSRxCtzf8S9hmRVapTwDETjfR41qA4UEapZIIVjTka+26sD9RnXKwAA6InHaYqQ==
X-Received: by 2002:a05:6402:270e:: with SMTP id y14mr10753685edd.283.1617294084679;
        Thu, 01 Apr 2021 09:21:24 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:7e1:37f3:1d27:f09e])
        by smtp.gmail.com with ESMTPSA id s20sm2993123ejj.38.2021.04.01.09.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 09:21:24 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>, Paolo Abeni <pabeni@redhat.com>
References: <cover.1617175133.git.geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [MPTCP][PATCH v4 mptcp-next 0/5] add tracepoints
Message-ID: <1268005a-9a91-45b9-94b1-91b466863984@tessares.net>
Date: Thu, 1 Apr 2021 18:21:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1617175133.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang, Paolo,

On 31/03/2021 09:23, Geliang Tang wrote:
> v4:
>   - add back patch 1.
>   - use sk_fullsock in patch 2.
> 
> v3:
>   - update the patch set as Paolo suggested.
>   - drop the patch "mptcp: export mptcp_subflow_active".
> 
> v2:
>   - add two new patches.
> 
> This patchset addressed issues 131, replace some/most pr_debug with trace
> events. As Paolo suggested, we should add the tracepoints at "the packet
> scheduler and the mapping status" first.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/131

I already closed it, even if there is still one pending squash-to patch.

> Geliang Tang (5):
>    mptcp: export mptcp_subflow_active
>    mptcp: add tracepoint in mptcp_subflow_get_send
>    mptcp: add tracepoint in get_mapping_status
>    mptcp: add tracepoint in ack_update_msk
>    mptcp: add tracepoint in subflow_check_data_avail

Thank you for the patches and reviews!

Just applied in our tree with Paolo's ACK + a modification of the 
MAINTAINERS file in patch 2/5

- 00ed6f03febe: mptcp: export mptcp_subflow_active
- e4421bbffd09: mptcp: add tracepoint in mptcp_subflow_get_send
- 12abe4c31032: mptcp: add tracepoint in get_mapping_status
- 88a550c12ce4: mptcp: add tracepoint in ack_update_msk
- 769badb3d5a3: mptcp: add tracepoint in subflow_check_data_avail

Tests + export are in progress!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
