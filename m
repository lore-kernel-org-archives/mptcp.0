Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9917B
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 17:35:47 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id r18so19664145edb.9
        for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 10:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Un+NiPMCHGHJ/Wr+YcFM3yNOTuExnWsPBH5Vu6z+ZRY=;
        b=T/Ysq/NJlT2LaB2mr6WEQfD3fdHKNi4xrhGnsBceL8uzaSDu1qKUn8CHiCKs1Nl0gf
         K11CGwtcCrxKfzYuTD5LvcB8g0KUMK2FVd04t6QDVH1JAqGWUEVYJPnIZxFO5tHNSjR4
         fcs0yvUmWJAQYCDI4A/6CsVEuNgWZUoXAMvOErqMqVLUVBL+89iEI67IXiT1gHKCzAnI
         vERM2VI2WsF/OywN8fjpeAJZBJGeXfABXEpXvgQIHeio7gr4gipFPZnZ3jtIJ8MIXMHd
         YwK5pYjp/EGC5hAbSoxAsXvSIRh7IjuFoE2ti/2YVcTZ/UXWMpo1Jup7urLe4MmeZ2Nz
         Bbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Un+NiPMCHGHJ/Wr+YcFM3yNOTuExnWsPBH5Vu6z+ZRY=;
        b=djefzpJtGq5GmgeVp9Gn0MhEUL2AhaWfsXKkrdlNF0TSVPb3cJSEcZRnKa7y6E0YTm
         KifDhfZB14btjzSpFvhS+VQURoLa3FMupBrYdG8Abg3WnUbopL5vpY4fzO94u+XwVJFS
         qIDJj/6DU5694myJ+eUloabT84NhJRJ8itLWJMjs5yod7CAW/MBvL4OLikfxRdb1ewcU
         OwD3JjjNCCHqWU0bix94BdM+Rr+NH8nSxFsvxYVQJh8yde+FI0KQ+5auQnD0v79pw+ik
         MmxkZCyVPA5hngaWDhFTL3XYmcY2LgtKxJKYw/YL13KNqOms13EReXGtdjQpDXWQAwdz
         vJWQ==
X-Gm-Message-State: AJIora9NrdF4yo2vhHGbgIuu9hWAY39rniJIh7ZgDx938S50LyHGJaeY
	2+0TLDtEcQfDKfATyE0zXlYzylh1ujY04A==
X-Google-Smtp-Source: AGRyM1va8PrkCKj1xrYFu88//to+47EngstZldClr1Y/2KeYpq1mYduFUGKx/U5XTVSc22ctr1aeVg==
X-Received: by 2002:a05:6402:4316:b0:437:8d2e:cf2d with SMTP id m22-20020a056402431600b004378d2ecf2dmr13032720edc.229.1656610545558;
        Thu, 30 Jun 2022 10:35:45 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6947:dee2:2822:3dc2? ([2a02:578:8593:1200:6947:dee2:2822:3dc2])
        by smtp.gmail.com with ESMTPSA id d2-20020aa7d682000000b0042dddaa8af3sm13462819edr.37.2022.06.30.10.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 10:35:44 -0700 (PDT)
Message-ID: <d0547d88-332f-3c5b-403a-f1547b1114ef@tessares.net>
Date: Thu, 30 Jun 2022 19:35:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH mptcp-next] Squash to "bpf: Add bpf_mptcp_sched_ops"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <9ab93a02e7bf2ea1b2cfd40ce9e2001970d2e890.1656586148.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9ab93a02e7bf2ea1b2cfd40ce9e2001970d2e890.1656586148.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 30/06/2022 12:49, Geliang Tang wrote:
> Rename optional_ops to optional_sched_ops, rename is_optional() to
> is_optional_sched(). We may add optional_pm_ops and is_optional_pm()
> in bpf.c in the future for BPF path managers.

Thank you for the patch and the review!

Now in our tree:

- 546b86f8921c: "squashed" in "bpf: Add bpf_mptcp_sched_ops"
- Results: 083eb67a4d91..223590507ff9 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220630T173458
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
