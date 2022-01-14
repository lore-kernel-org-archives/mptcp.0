Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13B9168
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 14:53:44 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id s6-20020a7bc386000000b0034a89445406so3832949wmj.2
        for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 06:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Ts0TwhkzbY1uP/dafXfYTcuSdjqBoYyJTsD7NQU4ONw=;
        b=uJdrdldrCNTRt1gOqxRjQ/5W+DfVBkWNvbuGOmQR2OaDE0V/4HqaJWmZt0PsFpD0Jc
         qxA3jMgzHwT+kVWxV9gL0vvxAOUnH46eRsoCQdaIOJMJ1XiGDS8IAif8mSBCHdzxuveM
         yv0of7lRWMxjDj7pTCuDTi8oHDZ/f4etIv63J/vX2k6M5LwrdRrGOBJA0UrTKjF1c1gR
         V1hvyf+RPkeACwJEA4hqkqjDGR486+Mxz3/fBRHi6t7TzsVfxmghrelleb2SuFZmxH2k
         Ofu2GR21qdKV6IUwc6sM+yYi3GugZ6fooj1rv+Uwo8rM+/mATFh2+whEnnqRw7Yl30Ft
         ZWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ts0TwhkzbY1uP/dafXfYTcuSdjqBoYyJTsD7NQU4ONw=;
        b=sajDQW4fFpYj23ykjK731ZK7LYO0sdd4lwCBj8BmJbM3/6jGuYGYRgvUTv5mLWCYCj
         qf2PHlvr8YYrD6465Fg6vggthELJCE7ln+IPtFAfUdmHVe56NYXU/LA8ATaVRZ0f/N9C
         AIE5qLpZAsDZvqlnXLvPTOpcNidaH97IglcXqoTr69C/RBa4x+QjsDMq0N/QOgf0vlEQ
         uE/scr4FjHfPa+lTbnI7rAL05sUJr0CgtlczLY9K2Fw2bDZAgzAtXtO75fgrksjHJex1
         JhkgvxeRg14FAJim78r+5G5AFJ+NSZp5pGp/mHSFMMf3LAOVwCVAlFbeFFF9qC3XDldH
         BRfw==
X-Gm-Message-State: AOAM530yjSV+gxB6dGyLGkNoFCL7dkXf+6968XjgrxjLGoj8WJrixQW7
	CAsZRA9tBQvV+hoykCUVHxGMGg==
X-Google-Smtp-Source: ABdhPJxNhyjB6tW9D2CKDOoNvirjWSnifn8vYEq/dHyHwwzmeUFffv1ErnMpIX4vG9xtfT44S3ovVg==
X-Received: by 2002:a17:907:2da1:: with SMTP id gt33mr7684504ejc.590.1642172022711;
        Fri, 14 Jan 2022 06:53:42 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:e62e:56dc:2d31:6b1a? ([2a02:578:8593:1200:e62e:56dc:2d31:6b1a])
        by smtp.gmail.com with ESMTPSA id 14sm1891814ejk.215.2022.01.14.06.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 06:53:42 -0800 (PST)
Message-ID: <c57f38e4-d30e-ff0d-bce6-c1536ad41b6b@tessares.net>
Date: Fri, 14 Jan 2022 15:53:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix ipv6 routing setup
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <059912660c7f5973da40413a9384bad542047013.1642098123.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <059912660c7f5973da40413a9384bad542047013.1642098123.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat, Geliang,

On 13/01/2022 19:34, Paolo Abeni wrote:
> MPJ ipv6 selftests currently lack per link route to the server
> net. Additionally, ipv6 subflows endpoints are created without any
> interface specified. The end-result is that in ipv6 self-tests
> subflows are created all on the same link, leading to expected delays
> and sporadic self-tests failures.
> 
> Fix the issue by adding the missing setup bits.

Thank you for the patch, review and test!

Now in our tree (fixes for -net) with Mat's RvB and Geliang's R&T tags:

- 9b1eb82a3253: selftests: mptcp: fix ipv6 routing setup
- Results: 26c341404c60..a99ed2058930

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220114T145330
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
