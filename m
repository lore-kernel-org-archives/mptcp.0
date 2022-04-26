Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFD1625
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 10:28:23 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id i19so3421318eja.11
        for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nV29tvx4ktXLAg/oMyFT2AD2hwHd30bPOclTkH6CR9A=;
        b=F5+677Nn7qCNmXJbRfMDEDkh5NDTF/nClvJaxv0ak6FwIsZ9RCQMlOZu34IxDiMQRe
         1VMj4IRTOgCeXpabUNKdC8qdmVrwL0M/N98cxGioUUTnf4iyDyLDHv6Xm6KvQF/3RxWk
         zeHf2NbInJtLtV/IUXgVVp0JRrWjJO4b3kyLJH3PVODg7f0L3JN0pXrQhoJjV4omFoFD
         LJlLQ75Vj7FtKEuU29WdV4ecRkTG6owiZRD+AIvS4vnQ7VDlBJrhxx89ycAL0GQHLgoJ
         MfDSjRls0r17jqsIIxfu9CE5OCbEa/S4iTeq0c+gb0p6DvCSdKDxtkoYnEN2Wz8bpPo7
         ArbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nV29tvx4ktXLAg/oMyFT2AD2hwHd30bPOclTkH6CR9A=;
        b=3toNl0MsRm5fT4EchlwOWXFGmRM1h1IScGiODNXeB/211TwTGPVOa6cq9wH+lT4FjC
         pnGdvhFFuV4DMR/djnXJH5MztGdg0YdhiiePNhlIQ3MMieHTpDo00A1At/vpHia/iu4L
         55vfKM9bBV+vv1sucyu9nN7fcnY5PGDLB1xQV15uUwJUWp42Lt4We7veB0oLYLFd7RDq
         U19yZyhPTwv7dn5X+BlSjYJOVdWUd8gXCBTQgF7QCCL4mfzlhnqvkdy4rvjPe1kc6Kay
         hCtBa2hP00O5wiMqeD675SKhoOzAAjpVylvC4ehlH678wfbTby9dCVqdUxgP8h354m4k
         NN+g==
X-Gm-Message-State: AOAM532ruAsoY4hcFqUm4voTwDWNKP2cAUg7ed0byy75N2Km9zODqoow
	Nz4nywK4j7O1FoEPAZyz1h9TbUt0tZZKzA==
X-Google-Smtp-Source: ABdhPJzkOwsvZ1+7U44mF0RUbjR5pRIQw4v9AGLJtAtdLX6rS5xsGCAdUqdJwJ1PJx3h8rfu8+B1Dg==
X-Received: by 2002:a17:906:99c1:b0:6db:f0cf:e38c with SMTP id s1-20020a17090699c100b006dbf0cfe38cmr20691566ejn.692.1650968901334;
        Tue, 26 Apr 2022 03:28:21 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:20e3:b4e6:37ad:5b92? ([2a02:578:8593:1200:20e3:b4e6:37ad:5b92])
        by smtp.gmail.com with ESMTPSA id z2-20020a05640235c200b00425fff78dbbsm428175edc.49.2022.04.26.03.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 03:28:20 -0700 (PDT)
Message-ID: <9b28d9fd-56fb-9be9-261d-f989411d39fd@tessares.net>
Date: Tue, 26 Apr 2022 12:28:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] selftests/bpf: Drop duplicate max/min
 definitions
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <93623928052528277b9a67f19a1a102518c538bb.1650967584.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <93623928052528277b9a67f19a1a102518c538bb.1650967584.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

(without Daniel and Song)

On 26/04/2022 12:09, Geliang Tang wrote:
> Drop duplicate macros min() and MAX() definitions in prog_tests and use
> MIN() or MAX() in sys/param.h instead.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Song Liu <songliubraving@fb.com>
> Link: https://lore.kernel.org/bpf/1ae276da9925c2de59b5bdc93b693b4c243e692e.1649462033.git.geliang.tang@suse.com
> ---
> This patch was applied on bpf-next. It needs to merge to mptcp_net-next
> too. Since the commit "selftests: bpf: add bpf_first test" will depend
> on this patch.

Thank you, just added in our tree (fixes for net-next):

New patches for t/upstream:
- 48ff9164f46e: selftests/bpf: Drop duplicate max/min definitions
- Results: 29d9117bba61..08fa6dc386aa (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220426T102605
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
