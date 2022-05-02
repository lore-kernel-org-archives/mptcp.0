Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9514B3204
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 20:22:11 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id m20so29767397ejj.10
        for <mptcp@lists.linux.dev>; Mon, 02 May 2022 13:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ESD9sI/LXaDLgrW47z1kaByylTCDzQrlrS4/AZle/Cw=;
        b=ooaGa+PVtaElNA1b5i+JFCMfq6t0f2e55rGUP+bKdUBagsZpDy8dHFXGnqcC7gS49q
         GQzPBSZ+8LxqhzRwxQDhyTfdNkDFAdmiaEMUrgEi0OzGs2ktpXI7pEfrJ0LDPUEAmfiW
         a3fg/TccOxJguTTousmgklbQRI4cxWF2W20tISVNeOieaBaGfh5DN+CjsJJ+oEJkBgyJ
         DvWDCjuuW+bol9MWaeJ3lEVX5htcTNIQaOixzJ8GR3sKsZ2dMWCkISrYt0KgBf3GqVQe
         rMr4vGtbCoIwhlByVWHu6903vlePPz2MsLKn6BEBkPJYR7oWnYWZNwNya5ID8dePstcp
         U5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ESD9sI/LXaDLgrW47z1kaByylTCDzQrlrS4/AZle/Cw=;
        b=ONXv7oE02j4OITRu1ZZefiYmRQHgVxu8IWUjFACRqfopefn66nBw8k5DTe6cHQDiDG
         av7qtiiuBLLSfT0Rt6xdD3wFGdC9aYDbu3UhHrOd0kV5zgONGRsL76qI+a/v3AoCNJGn
         IQYS+dmZy+XPhoxaEZl3Yranj2r8F5NEUU/aPyRxQDxqGtAC1mu+u6eIyf6iTckcQBz9
         FtR4WymdjvDSr91TgyCqw9mTpWojQxFEXcKbqs/Hx45v4Xtz1NwbQXVKMqmMymLAaZYx
         Z5pF2vePb/Sir4l2Eq4p100Flrb0iXLDcay60oRBezaHlJtM/bZKxeCj7i+CFXQ4t6Jw
         bTLA==
X-Gm-Message-State: AOAM533x6Faoi4+OSxLEsZsDJciQy5SegUrATwBOZwR6KxWFCYb+qeb/
	3jW/JmdZgE2ROuax7g2X/o+NJ7QyuvuCSCD2
X-Google-Smtp-Source: ABdhPJyEhU9TKgP/CrcWRRUljYJIp3FqYwV0XSh0hqL8dKfcCvFGmLPZQDczJeQo3anWZoq4s5Q/nw==
X-Received: by 2002:a17:906:58d2:b0:6da:b635:fbf3 with SMTP id e18-20020a17090658d200b006dab635fbf3mr12062518ejs.40.1651522929419;
        Mon, 02 May 2022 13:22:09 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8b1c:91db:8679:8c21? ([2a02:578:8593:1200:8b1c:91db:8679:8c21])
        by smtp.gmail.com with ESMTPSA id ia17-20020a170907a07100b006f3ef214de6sm3906432ejc.76.2022.05.02.13.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 13:22:09 -0700 (PDT)
Message-ID: <c70f3083-6c3f-71bd-34c0-3bdd0b5a450e@tessares.net>
Date: Mon, 2 May 2022 22:22:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v2] selftests/bpf: Enable CONFIG_IKCONFIG_PROC
 in config
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <f14787485262a8dd8c439e01cd5651f10d5eb63d.1651114997.git.geliang.tang@suse.com>
 <46af5926-5671-53b7-8358-7697336ed67@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <46af5926-5671-53b7-8358-7697336ed67@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang, Mat,

On 29/04/2022 01:29, Mat Martineau wrote:
> On Thu, 28 Apr 2022, Geliang Tang wrote:
> 
>> CONFIG_IKCONFIG_PROC is required by BPF selftests, otherwise we get
>> errors like this:
>>
>> libbpf: failed to open system Kconfig
>> libbpf: failed to load object 'kprobe_multi'
>> libbpf: failed to load BPF skeleton 'kprobe_multi': -22
>>
>> It's because /proc/config.gz is opened in bpf_object__read_kconfig_file()
>> in tools/lib/bpf/libbpf.c:
>>
>>        file = gzopen("/proc/config.gz", "r");
>>
>> So this patch enables CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC in
>> tools/testing/selftests/bpf/config.

Thank you for the patch and the review:

New patches for t/upstream:
- 94d844c712d5: selftests: bpf: Enable CONFIG_IKCONFIG_PROC in config
- be5f5a7b44f8: conflict in t/selftests-bpf-add-MPTCP-test-base
- Results: f1fcfe627540..2767792d035c (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220502T201958
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
