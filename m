Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A41E1843
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 20:58:31 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id v1so36760767ejg.13
        for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=tQn7RZ3kKpZxRbJVzN4OBalFqotLwXYWEvpAznJfrnA=;
        b=z77vkEfeETMRJCdPD3kc80d2M8WsgPnIxHatfOSUkXzkK1OQ86UsOjVdprHgo526kE
         2JcmZFLauYbVz7nw81s8Z6PkBPbofmTA3r8DFCxBlyfHzx0fdlNzXJShagWW+PXKC78N
         s5tlfW2j2tVEDZeYefO4nrEZJTwbSGhXR+lvWJOrfI9XC/Ga1YlUG90Wo/w8ePALCXke
         Ybzl6M/V3HnhNQPrHk08raqYMdO0ec7n3DMR90AI8M1mnVRzKYQAQ1Ch+0x+GmNvG0BI
         lChudnvG4YeXbEdsbgzrwvq/rzb0iAkWPnMz6mquJIN09EtDlBgLpD0SYLrv+4HUlglH
         E5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tQn7RZ3kKpZxRbJVzN4OBalFqotLwXYWEvpAznJfrnA=;
        b=YIGaYrq0WtrH8aPdoQlnXBp77DEBwRvAdidRNK8UABvszhjMKoypuAtoo/3fzlizSC
         xrjVgxGMx7/+SvL05JnJBBx2v55fxY31FwgdQBGwacN/quIfWAJEXZlrIjsnyTQKqMoF
         cg5xS9H0LckqaXN5pV8Q/XvhN6B0AoVPv9JOE1w6wGu/uqfW3DLXCGS+GTi+E1IBFsjC
         7pChMTK2L1GYENBsGoiPnSVnnsyShuMRQtq5XPDu0word7XopAZdVzZCEk1shC0O2h8c
         z1oRPQnjtFn92XhlPHuhNSm6Ri+k/U+Ow4hnmcUcH5DLN823U5U2M4ybzkunBlf/b5zR
         t8rg==
X-Gm-Message-State: AJIora/KpNS+nT11a0Rmq5ZiUMvwwNUEZ4PNHUsUajv2RGq8nj3jvWPM
	H7lKZ6mKpMmsRB1W15q4H0ouhA==
X-Google-Smtp-Source: AGRyM1vYZe4ktnfCWZkvx/tVoqHMG97jcDozLqHxRVrjUavaq0favsjq4nfDtGZ/lEPiMUJ4l/4Pfw==
X-Received: by 2002:a17:907:1694:b0:716:14a4:fba with SMTP id hc20-20020a170907169400b0071614a40fbamr5115949ejc.290.1655931509445;
        Wed, 22 Jun 2022 13:58:29 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e063:12b5:8fdc:749e? ([2a02:578:8593:1200:e063:12b5:8fdc:749e])
        by smtp.gmail.com with ESMTPSA id hf27-20020a1709072c5b00b006fee961b9e0sm9823387ejc.195.2022.06.22.13.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 13:58:29 -0700 (PDT)
Message-ID: <861cf3cf-93e7-1a3f-525a-2a9727ec1845@tessares.net>
Date: Wed, 22 Jun 2022 22:58:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: userspace pm
 address tests"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <6f64d72dac256f2dd6449f8e75c14c98c46ca631.1655776730.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <6f64d72dac256f2dd6449f8e75c14c98c46ca631.1655776730.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 21/06/2022 03:59, Geliang Tang wrote:
> Use kill_wait() helper as Mat suggested.

Thank you for the patches and reviews!

- 35df311b36fd: "squashed" in "selftests: mptcp: userspace pm address tests"
- d8492465ee5e: "squashed" in "selftests: mptcp: userspace pm subflow tests"
- Results: 972138d95a98..d99676bfce76 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220622T205731
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
