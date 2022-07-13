Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC7328E1
	for <mptcp@lists.linux.dev>; Wed, 13 Jul 2022 08:47:02 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id mf4so17451048ejc.3
        for <mptcp@lists.linux.dev>; Wed, 13 Jul 2022 01:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xBvQ6MqrICm+Da1HSD7WEo+BDncVG3qSk4tvgfkJRYI=;
        b=BD5LyGE1h+3US79q7EuRBKXhWoEO8PMkBNeQmGjiASPOuEgnRUdLgpShJ47g2eGsov
         2vAiL4AJwHbYLqLxI1iC8of/LitoGQNZ3Zy4xtse42Dwl02Kb4xck7XaoiIVrmNr7LDr
         yTf23Oy7gEzwy1/xr/DO7U09Aq6z4aWtoocyU9zYZHU5SnvcOLxRQikCUhrLF98H9s7V
         f0y3G3uGGWVmrotoQ9kkiTwh2fPp7qC2DBujM4FbK/3wkBpfSxTK1HsqX7ME85eS/ckT
         suB2QiNP6Ok40DI55d4Dm/2eywouGx3779rlkP022Zd09L/33iy4vkauruFEt1SngIEt
         m2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xBvQ6MqrICm+Da1HSD7WEo+BDncVG3qSk4tvgfkJRYI=;
        b=q5kERYRTrVE1itrxauiJxTcjoIBViGQ1JDKc50eqZPJBBCyq3IGVWk69GMvM+a5KnI
         Gw6MR75MW5yp9M37MBH9aSZ9JENfQLQh07Sji8xz24vR5o4u5UCdf+UBKkAXIbmFU180
         xxBSASPOq0M0zWxgGLMa+BN4W3TAbL4sDI6sL8cFJebxw6c99QHQaVJ97YV0BxCP3XmH
         3CDUhFDTBwrb7wtHYK0nSTEUhrj7AeMBKoE+mCds0UkbSXoZMQUCCXMjovoibQEHVCKr
         bnvlugI3nNMIIwM3VLRWKBmJwjrd+CoVjaOTrR0ZQNCjTGQTu1c12P/BR4T/PhUnhnu/
         kKsw==
X-Gm-Message-State: AJIora85qxzZoRQJ4k6PH1b5k5I1M1HOJTqx5nx36GvOXTvE0brPfSSy
	F+agOiTnBk/nqVjUPefJNolDgA==
X-Google-Smtp-Source: AGRyM1tBI6gcM0ZUzaO+iUDByMjJAV6KGNbyjzw8mL5OFBK01burk0FfI+cg33JGVwkynjR1Kw2SHw==
X-Received: by 2002:a17:907:b02:b0:72b:6162:b47f with SMTP id h2-20020a1709070b0200b0072b6162b47fmr2232455ejl.245.1657702020975;
        Wed, 13 Jul 2022 01:47:00 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e753:3e74:5c34:497d? ([2a02:578:8593:1200:e753:3e74:5c34:497d])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906300700b007041e969a8asm4725524ejz.97.2022.07.13.01.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 01:47:00 -0700 (PDT)
Message-ID: <0ee0d127-8cf1-2c9d-0294-9fc13dda8dbd@tessares.net>
Date: Wed, 13 Jul 2022 10:46:59 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH mptcp-next] mptcp: add mptcp_for_each_subflow_safe helper
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20220712160236.3668376-1-matthieu.baerts@tessares.net>
 <2898be1f-e7c0-3c-c732-8f2ea01c28ea@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2898be1f-e7c0-3c-c732-8f2ea01c28ea@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 12/07/2022 19:25, Mat Martineau wrote:
> On Tue, 12 Jul 2022, Matthieu Baerts wrote:
> 
>> Similar to mptcp_for_each_subflow(): this is clearer now that the _safe
>> version is used in multiple places.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Looks good to me, thanks Matthieu
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the review!

Now in our tree (feat. for net-next):

New patches for t/upstream:
- 9b920d84b10d: mptcp: add mptcp_for_each_subflow_safe helper
- Results: bd3c22dfa097..ca68291a7562 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220713T084449

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
