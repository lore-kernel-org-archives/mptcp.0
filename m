Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844CB7C
	for <mptcp@lists.linux.dev>; Sat,  2 Apr 2022 10:44:59 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id g22so5703270edz.2
        for <mptcp@lists.linux.dev>; Sat, 02 Apr 2022 03:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:cc:in-reply-to:content-transfer-encoding;
        bh=yc6WQnRRPjWu4TPcyshpab4IMVba3FP2SqrX2guYdgQ=;
        b=wCHv8zNciEyFm0Mzjy7/qVs2bZbcNK0kqICkdR0WxoUve9beZXA1Q0GGIVbltCNcej
         kIrdzdpEIHQ94TvPlJiWPttRd8PDp3q2GU680DpQyIzEu72ulRVxRWzwy4S8lTDAjXze
         5BTQjU+0xhaYIXIH1Kea8WFmaxJ9Nl+YDvH+4y36r6Mymq6T/OON8c39aehyxiqhNlKL
         LlQqJh6XJGPLObDRRgybdC90/NIAFR3G4FLx8uLamUXOYxFNr5RWmZk3RB37oecNrzVp
         F5Ut3vac7A1j3e2xPI6pSf7ZUgIrCq6MVMJOlz7MagnivY59HBvLj1qMVLwm1d3GO+8r
         j2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=yc6WQnRRPjWu4TPcyshpab4IMVba3FP2SqrX2guYdgQ=;
        b=RZIhjseq/BN3fj8HpT6v10sZeY/6jIqJ3U+o/8lZV18kiVG8OG6YC++13pxUTe9nzN
         e/MWjZ+GKDGDydQFGBaFKpJ6tDJkbT42Aw81oEzDXmkYIqdv7+SXLLL2OGj0XDyxOOpC
         QnDsTewWj94KPkIP84FhM5qreSk3Ct2GtTpFHwrDKOylCUlMhrU5sBrDnxmqw9ih+iqM
         iaCInRYE6DgecTl/LWxq4usIp1JcGGtUXXcW0f6y/zVpL4RDhr56MUnvSguqhP6IAa7I
         ZO0gr0bKDVgxScv553069XYdV5gfZ3nwuwkfGzxIgGZm04rL65FJz/HS8Oemm6bgV0ms
         fIcQ==
X-Gm-Message-State: AOAM530vzIzaCc7RczaY8KxgoYGxagoE8kdabUmLYg881xh0r5vtCSaR
	hY3K5Bg+53inzb2Zn2ezyN1O4A==
X-Google-Smtp-Source: ABdhPJxJd0WGz4Q0queP2xW9GvqWKbg062tgIb8uzIHQzGO5Ybnl2CT9g5mPmSGFuFNVhZ9Qn7j3/g==
X-Received: by 2002:a05:6402:4305:b0:419:2aeb:2a9b with SMTP id m5-20020a056402430500b004192aeb2a9bmr24817584edc.346.1648896298133;
        Sat, 02 Apr 2022 03:44:58 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9373:86b5:c614:c3cf? ([2a02:578:8593:1200:9373:86b5:c614:c3cf])
        by smtp.gmail.com with ESMTPSA id d1-20020a50fe81000000b004197f2ecdc2sm2272678edt.89.2022.04.02.03.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 03:44:57 -0700 (PDT)
Message-ID: <efedbec0-3617-0e2c-95ac-f4fd788507fd@tessares.net>
Date: Sat, 2 Apr 2022 12:44:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next 0/2] split MP_FAIL testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <cover.1648826372.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
In-Reply-To: <cover.1648826372.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 01/04/2022 17:31, Geliang Tang wrote:
> Split MP_FAIL testcases into two patches:
> 
>  selftests: mptcp: add infinite map testcase
>  selftests: mptcp: add MP_FAIL reset testcase
> 
> The former can be upstreaming with the infinite map series, the latter
> stays on the export branch, waiting for the dropping bad data patches,
> and the fix for issue #265.

Thank you for the patches and the reviews!

Now in our tree (feat. for net-next-next):

New patches for t/upstream:
- 0da1606b57c1: "squashed" patch 1/2 in "selftests: mptcp: add the
MP_FAIL testcases"
- d703a6233117: tg:msg: update requested by Geliang
- Results: c56ab3a9d998..aba96189ad1a (export)

- 4c7ac3a904ee: selftests: mptcp: add MP_FAIL reset testcase
- Results: aba96189ad1a..463bac3cb3eb (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220402T104349
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
