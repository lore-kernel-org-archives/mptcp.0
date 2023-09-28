Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C489CA79
	for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 20:58:35 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1776586866b.1
        for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 13:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695934714; x=1696539514; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X50IyTxJmPObbv+FGbSzhuHA7JhRVqPE0VH1yRJBlso=;
        b=pXXx6IXJ4IwX71tQJH3Z698vagD43toYIlAnFyXT6sOf6/tx8QFFXy0SxkyjkqmX6N
         4aNKIuGAusK8MWOGMsHfrODwxtjUYLfJEHUO2x7RxnBIj4JfAj9NChp4EaGXt6UKxi7U
         Tk69HKqQ5UehB1oOWTDlM//EgGuV/Va0UXsNut4371Q02WqGymMFlCdt/zN8DPwpMrx5
         ItCxd1A9WRoV+tpT59481mh03YoH4KExQOf7kQKkU6XmRtimvbB5IsrmSWrxFkF8bEXs
         UzURc1ixqUH7pHbv0tPSzqDB+bE2Qie9x8QqGPuAnSCeD8rg/l/bI56YCJQNonWiNU2C
         apHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934714; x=1696539514;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X50IyTxJmPObbv+FGbSzhuHA7JhRVqPE0VH1yRJBlso=;
        b=vcw6kw6XB3kCIpi5Kooso2Qv5Np7g83zKBeXy672XbjYSv+m05kbjXhEi0ZxrKIYpM
         YpmHUplL9tzpW1ps4LTKDMhznQBJAN2SMbLRt+gkhWhy4h5W7+M+02pCiS42Ryx9Ni4W
         x7S2YsVM99oiYPbJFc742ZYcEBKILLPTP8TLPcjiA3QxJZXMKA9ydVc8+j/XZMs5gg+V
         2kAKKtoTiTTn+ym/MeVQs9mMtNWHr3Bzbf+FikFy/SW4c+w2hFVtM3MV04yBFhHiL0vC
         rhoKldCiGtceuS7hbfpdlCu+k3KHFr9trynPZAI3I9W0NOnEURCKGt0th65qfgu3h69p
         FIbA==
X-Gm-Message-State: AOJu0YzbI+HW+TPI2BasKVMSMbNPx3W3j5GcAakikf/X8+NgyxFu0G9C
	vXxF9sFHEPZwla48I6J++wSkQw==
X-Google-Smtp-Source: AGHT+IHNHO3EtCW89KHtQ9xzzPQ9k94ukzF2FvzMTDG7oAPiPyjKcxaKkm97jqW5L2mPl1CWzeEn5g==
X-Received: by 2002:a17:906:225b:b0:9ae:7206:963c with SMTP id 27-20020a170906225b00b009ae7206963cmr2234031ejr.15.1695934713754;
        Thu, 28 Sep 2023 13:58:33 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ff86:e30:98cd:120? ([2a02:578:8593:1200:ff86:e30:98cd:120])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090619c900b009ae54eba5casm11410671ejd.102.2023.09.28.13.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 13:58:33 -0700 (PDT)
Message-ID: <5c715ddd-f8de-4b64-8dab-4d3ad10c456e@tessares.net>
Date: Thu, 28 Sep 2023 22:58:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 12/29] selftests: mptcp: userspace pm remove
 id 0 subflow
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <04438bad0ef7459b1a78fa88a6cd2e2c31ebf616.1695631132.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <04438bad0ef7459b1a78fa88a6cd2e2c31ebf616.1695631132.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/09/2023 10:41, Geliang Tang wrote:
> This patch adds a selftest for userpsace PM to remove id 0 subflow. Use
> userspace_pm_add_sf() to add a subflow, and pass initial ip address to
> userspace_pm_rm_sf() to remove id 0 subflow.
> 
> When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
> false, then tcp_disconnect is invoked. This will send a MP_RST to close
> a subflow on the peer too.

I don't think we should have a RST (with MP_TCPRST) when we close the
initial subflow, no? We don't have that when we remove subflows with
other IDs.

I guess we are not handling this case properly on the kernel side. We
should close the initial subflow normally (with FIN) like we would do
with any other subflow IDs (and here, we cannot fully destroy it and we
still need to keep a valid ref for msk->first).

> So chk_rst_nr() is added in this test, and
> chk_all_subflows after closing the initial subflow is '1 1', not '2 1'.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
