Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF821DDEE
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 19:15:20 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3fbea147034so10284205e9.0
        for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689275718; x=1691867718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDKgV+2VhCkNmfJRAQ0+Mm20zEE5dd4L4ZMOisqNIVo=;
        b=yyDaLTL0nnqs0FFm/PP+vO47C63QYA5jimiXGqN9z472SN61qMuPwxxiiLIdaJyLBM
         6EctCJ4ZqtiehfqnQ/J3y2804MPpOGTNl6dVVaAAf0KsGv6XQxFT7h+zXj8CJ0IQ5qRe
         cXpn0uqbFNanayhO8IS1m+KzmhB8v9Djvf1tc80fjUTyBiAlL/FVwp0Gczgon1TrAlEs
         xMdp8OuxEWqjg9eZUOwSGOEEgjFWbzLOHNQ57KQLsgSBltfWeNLVJQCjJgjxvq2HX8gs
         9nCLZIbUNxCCMlB5vPx/TEy6f1wy2in9ryiIjc4cGBhHR6eH16k9AzM/+yXN8XNDyoIg
         CwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689275718; x=1691867718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDKgV+2VhCkNmfJRAQ0+Mm20zEE5dd4L4ZMOisqNIVo=;
        b=ct2E91KTWK4VPykVSp4soZQCNICD15464V6rSADa1jknfvaBbk8CEIFCEcotGIcuU+
         d7YbLNuyW+vSYdiGKwDd+gZ0nHln226p07tHFTXUBL1GozAmdwtgxR1wPjLNldH1pNEh
         A1nw+fuaWT2Id/q8n0ipRLCk60NOb4UEBDgxXusU5OLMXxYb+FMFSEo39Ep2XihkAQHy
         zmwia89AZiZTXF3hhJTNhqMH6aLqNkiCdOzwMigT16m7y+zwTgeaaYQLlf/bz9ZxUtop
         FFbNtE7ZDBSIQDWa5Kkb6MTNrRdsSj9xoZ2keRJKFfaGbRgVdxDpdS4JBDMxLuAWz3dp
         f3Hw==
X-Gm-Message-State: ABy/qLYGgmfWAN6vNM039LgqmC3Gcwito6Fiq4OYtXFkWL76Xf0qr/1T
	go4pb3L39xy+GHsf8829sUK9/w==
X-Google-Smtp-Source: APBJJlELAg1Nxf6eooM0+CRKrRvlpskYFXShTfzhauAHu83MeS1SUSBIApaMcYEISpitErhzmjowhw==
X-Received: by 2002:a05:600c:224c:b0:3fc:627:ea31 with SMTP id a12-20020a05600c224c00b003fc0627ea31mr2115219wmm.38.1689275718304;
        Thu, 13 Jul 2023 12:15:18 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d855:a28a:e0c1:ddc1? ([2a02:578:8593:1200:d855:a28a:e0c1:ddc1])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c220e00b003fbacc853ccsm8491095wml.18.2023.07.13.12.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 12:15:17 -0700 (PDT)
Message-ID: <43a31da8-8289-0b9e-54b1-4212d812260b@tessares.net>
Date: Thu, 13 Jul 2023 21:15:16 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 01/14] mptcp: more accurate NL event
 generation.
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1688993569.git.pabeni@redhat.com>
 <2dff178d492953373f5d7215aea15676b0e6079c.1688993569.git.pabeni@redhat.com>
 <6b0f2dde-2881-f72c-3012-bd6a267f1676@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <6b0f2dde-2881-f72c-3012-bd6a267f1676@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 13/07/2023 18:45, Mat Martineau wrote:
> On Mon, 10 Jul 2023, Paolo Abeni wrote:
> 
>> Currently the mptcp code generate a "new listener" event even
>> if the actual listen() syscall fails. Address the issue moving
>> the event generation call under the successful branch.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
>> ---
>> this could possibly go via -net, but is used by later patches and
>> is not really critical IMHO.
>> Eventually the additional tag would be:
>> Fixes: f8c9dfbd875b ("mptcp: add pm listener events")
> 
> I replied deeper in the thread about applying this patch to -net, but I
> need to tag it too:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the patch and the review!

Now in our tree (fixes for -net), only patch 1/14, with the Fixes tag:

New patches for t/upstream-net and t/upstream:
- 3e47bbe23f1c: mptcp: more accurate NL event generation
- Results: a99957c74d24..2f898c1f1eda (export-net)
- Results: 3ee02a7d38ae..14584832110b (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230713T191154
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230713T191154

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
