Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12659111B
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 21:16:09 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id v1so36844038ejg.13
        for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=0jI4JYqdrM3TSLR6BenqUoJJCrTFzs90bBXCx/NGLV4=;
        b=6Q3Tq+shvcxMFSTfPQ/jfD04uHMOpqOQjhW5nL2wAy2iAxXck+Hbli+2/CSvjf5jxt
         YpBEUwU0On9/63WZdQbc+xwXd2gOrjLNq2VR1BjGEcCFgqNo+7ZQ9oJRpcZe7kGy7ZDd
         uxNZx8bJhlYja9a0XRnQnlIYxW3ry+c9L61UBQYnEuQbUVPJYvT1BYwA9wYcLxMENWBy
         FwL6JKdjyJfaR4Idi37BMFmu3QkhLexBBQXeT1xXPeNjiYCxkbyYb0UYJONET2yMK831
         klcQz4S8Qd2pXZGvz7bP8Qx/5/yQme8J40l0LIQzjXoo8etYJtZILD97Laf4uloQGffU
         A75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0jI4JYqdrM3TSLR6BenqUoJJCrTFzs90bBXCx/NGLV4=;
        b=L/mUDVFnpHWyTWKuNPOpjoyyK1mVg+3yHAD3eimoSMa23ONTyjVT/iQn7+XN+62mL+
         rzXMbjp9T5N0QsRREriyo0B4EMQL0fmG8BfeUdZRwTSKfCMdE4mUMdOFzaBe23Ht5Nvl
         7ZqHaUwLn2IUePRSsRKkp0X5+PzebMA9/rTTI9mkpi4j5TZ0BpIPocZZ6M4UZNi4Kl1/
         FWPlfkSZYxUQXqW/D6fgt37sHuYrt0NAl6fRdn/aOcXqOWuxJUJKB03RctWMDOp/ujn9
         XNsN7MfKGxN+d4rM0PSjw17zTBgpsWxcBlQ5r8qb2oeZ1CaD80BwcJ0YYJxNoClrwly2
         rGAg==
X-Gm-Message-State: AJIora/1nxZCOZ2W4+SIezWjlzYFC1lKnT7EOEdcN8j89Mw8Pct0hLTn
	+mvb7E/bLgnaO4GkX8mkRmmCZWKj3GEw7g==
X-Google-Smtp-Source: AGRyM1sv1vGnSvTXklYLa4oQCUYB7FLLk1bVN/q6mdqjdEfI0mumnVRUgyO6WKz/uy+C6ln2QYul5g==
X-Received: by 2002:a17:907:72c9:b0:722:d5ef:6dea with SMTP id du9-20020a17090772c900b00722d5ef6deamr4954646ejc.551.1655932568163;
        Wed, 22 Jun 2022 14:16:08 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e063:12b5:8fdc:749e? ([2a02:578:8593:1200:e063:12b5:8fdc:749e])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906349700b00709343c0017sm305530ejb.98.2022.06.22.14.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 14:16:07 -0700 (PDT)
Message-ID: <8f35c94a-c306-9042-5e2c-6a0bdb68628f@tessares.net>
Date: Wed, 22 Jun 2022 23:16:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-net] Squash-to: "selftests: mptcp: more stable diag
 tests"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <f1109179c77a14bed80be75bb297aac1ef867a49.1655891188.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f1109179c77a14bed80be75bb297aac1ef867a49.1655891188.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 22/06/2022 11:47, Paolo Abeni wrote:
> The "....chk remote_key" testcase is failing quite often in debug
> build. I guess the mptcp_connect completes before the script execute
> this latter test, so I'm adding another large wait. It should not
> impact the test run-time, as the mptcp_connect processes are terminated
> just after running the check.

Thank you for the patch and the review!

New patches for t/upstream-net:
- c15701ca49c2: "squashed" in "selftests: mptcp: more stable diag tests"
- Results: 7db03aa2d67f..66322cb76048 (export-net)

New patches for t/upstream:
- c15701ca49c2: "squashed" in "selftests: mptcp: more stable diag tests"
- Results: cbb1cc653035..23a79309dbdb (export)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20220622T211409
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export-net

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220622T211409
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
