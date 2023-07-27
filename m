Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90A427124
	for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 16:52:53 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso13466305e9.0
        for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 09:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690476771; x=1691081571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NSyGq2gNXfxvWLVPtENMG0GCh7etlraiyoAvz8xW9U=;
        b=MeZc7+Ec6cRhGGOT6UXg9ZuH2/11HIaAYvxzxLJL6FdgShlAN1kHPTElRGxclfgzm2
         NILzG3gq7G5GtLyHSQ7U8poV+/HI0o/E67GAROMiIlRW4r/atFVDObovxfpPB1D2fEkD
         vxUt7XbOmoc0WMhyZaq9jARhg2IL8PEMnshGTVu2ZBFrKSrYn3YjrcrcLsUJwvx9wXkh
         M7n4D9RRxJ6Hiqec76cJgVcfbyueo4ZTgg+0380LAfY0t4AcUzvXGoHq+DOqHdl9rmbc
         gDRmoVNonGQLhJqVXSdlljEVfBbbOZO0RTjMbY0qKsO2GXXyxXq5Fb0zW/JBMfHNsZvt
         5L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690476771; x=1691081571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NSyGq2gNXfxvWLVPtENMG0GCh7etlraiyoAvz8xW9U=;
        b=CfrKr9OPHR0Nueei9i4tAMeaQpEzkjQ0VDqXVOaTNryjDkRacfwAdL+zBf7ZO+K2gg
         OpZYNLpIFPsT3MgAS002Y2UzcJssjpyF8hAgiTmsdjv+OMmPr8JpSyaHn24JaAZ2RLAn
         1okNmh5IjYcXsUWUZWJ/n2+tdO8KpTTM6iOLI94dmVpiSQCAStS12SATx+QhTpDHEw3E
         ecISD20K6QmYN0HMfd1VHaeUgPSONLv9cwrmiv+Xfa8F+E0QOP65SBcmrizvKxNo355v
         TicvVWXGT9nX6mIe63Dx/hG2LOtzUvLQ6WIhQtxg+0t/gxtADct+OXwwGF4A7ut0vWM+
         gx2w==
X-Gm-Message-State: ABy/qLbZnlYLVXnyasFRBOOuo6lNlphegEe4A4Ujdo77P3wbeolbTJkD
	EShkmqmRimUYLlYy6eCvgus2IQ==
X-Google-Smtp-Source: APBJJlGJHZQLjepNZO/uQ2ZmD6obIfGsZflBxWVIjs/MQR+84G2jSFULYUsAdSPEMtb8T4c6Wo4gAQ==
X-Received: by 2002:a7b:c450:0:b0:3f8:f663:921d with SMTP id l16-20020a7bc450000000b003f8f663921dmr2135416wmi.41.1690476771470;
        Thu, 27 Jul 2023 09:52:51 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e411:185b:7f55:ef18? ([2a02:578:8593:1200:e411:185b:7f55:ef18])
        by smtp.gmail.com with ESMTPSA id j4-20020adfe504000000b003063a92bbf5sm2549125wrm.70.2023.07.27.09.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 09:52:51 -0700 (PDT)
Message-ID: <2f4e7845-1817-e34f-80cb-fef9c57a7b72@tessares.net>
Date: Thu, 27 Jul 2023 18:52:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mptcp-next v2 2/2] selftests: mptcp: join: fix 'implicit
 EP' test
Content-Language: en-GB
To: Andrea Claudi <aclaudi@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
References: <cover.1690454072.git.aclaudi@redhat.com>
 <5c70132fb9512ecc42fea01c3118dc9a292791ab.1690454072.git.aclaudi@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <5c70132fb9512ecc42fea01c3118dc9a292791ab.1690454072.git.aclaudi@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrea,

On 27/07/2023 13:08, Andrea Claudi wrote:
> mptcp_join 'implicit EP' test currently fails when using ip mptcp:
> 
> $ ./mptcp_join.sh -iI
> <snip>
> 001 implicit EP    creation[fail] expected '10.0.2.2 10.0.2.2 id 1 implicit' found '10.0.2.2 id 1 rawflags 10 '
> Error: too many addresses or duplicate one: -22.
>                    ID change is prevented[fail] expected '10.0.2.2 10.0.2.2 id 1 implicit' found '10.0.2.2 id 1 rawflags 10 '
>                    modif is allowed[fail] expected '10.0.2.2 10.0.2.2 id 1 signal' found '10.0.2.2 id 1 signal '
> 
> This happens because of two reasons:
> - iproute v6.3.0 does not support the implicit flag, fixed with
>   iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
>   flag")
> - pm_nl_check_endpoint wrongly expects the ip address to be repeated two
>   times in iproute output, and does not account for a final whitespace
>   in it.
> 
> This fixes the issue trimming the whitespace in the output string and
> removing the double address in the expected string.
> 
> Fixes: 34aa6e3bccd8 ("selftests: mptcp: add ip mptcp wrappers")

I guess it is not the right one to use, you might want to keep the one
you had in v1:

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")

No?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
