Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537B242501
	for <mptcp@lists.linux.dev>; Thu,  1 Jun 2023 17:41:11 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f6094cb2ebso11414055e9.3
        for <mptcp@lists.linux.dev>; Thu, 01 Jun 2023 10:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685641270; x=1688233270;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjZYUVwEyAvcH1lZCIu7DyBjCApE5b4kvQFczQTAhZw=;
        b=lM/SBVy9/wL6Y5AghoHoNyPQmgag4/6TMWdQ2HsZPwOnduimNEJaPfcmJ1j6pXY5sj
         Vo85Fg7jBmzsYzY2tKA2Cf8eqzndpsRB7NUlTC2i0Orh/eVb5SQFyTS+esY1gFuEucor
         mTM1/5xtIDg7GB0qFQUk+7Pa1Fw7pwZBE8Q3eWV/Mv32/OWE2VIahDCoc9yWzhBsG4ok
         tZP/QYz0IDmBzHh1mXYrndLXOenuStFrqWoLJIznNTvZCKdzHVAC/6m2ZvuErDwosgj8
         2eJou6T/hV3f6VDomt3H6B5GEh9MajHxfzB8MkFO6e7uJXeVfifZjTFN966EnFLhiw1A
         C/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685641270; x=1688233270;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CjZYUVwEyAvcH1lZCIu7DyBjCApE5b4kvQFczQTAhZw=;
        b=E33hDZEQ7c64QFFdCS/NzQGQ0P3EdlkVrR2MnU2oas+MCrvJSjDzCrs7QUjTD/jyNE
         /cXL51CothgIp/UaWDGp3VbTOK+EFcSZ7+hm1JNDegIai5al/ZurdApfj13NX9wdYyiH
         TJfg3wBrSv0AGyqw/iQUFNO0AFVLIP4+3/IVElBaaRl3rORvvwYVKjFO6Lj2sHcogNTy
         LINP/ZYHgwoa+NouAahlyAvm/SMzxvHc8mAI0W8yBpRXgJTR4JavEuMxHZN1KDRQj8cV
         0C1hSG/YiY040XUmjDgVTiSpbNJPEjJyICjFiRFMvWaQnLlxDd3ucx/XlxMdDuOvHqlt
         Sr9Q==
X-Gm-Message-State: AC+VfDyppmWJq+ss9nmY93U7F+k3CvGVSQp/ctHwNXyQePg27qIFx/T8
	rXgK49fJ4OYUXkXkaSYlYgB9+A==
X-Google-Smtp-Source: ACHHUZ7ZLykKAFpe8ctVnbaupHLyw861m43w9Vpmwa0TWjD4Xg9hVpLTWYy+5aWE9mYb6HHALFkDbQ==
X-Received: by 2002:a05:600c:2318:b0:3f5:fb97:eafe with SMTP id 24-20020a05600c231800b003f5fb97eafemr95649wmo.30.1685641270218;
        Thu, 01 Jun 2023 10:41:10 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d0b8:9910:433a:655f? ([2a02:578:8593:1200:d0b8:9910:433a:655f])
        by smtp.gmail.com with ESMTPSA id s4-20020a1cf204000000b003f17848673fsm3044789wmc.27.2023.06.01.10.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 10:41:10 -0700 (PDT)
Message-ID: <a1e6596b-cffd-9860-9146-f8a41defd22e@tessares.net>
Date: Thu, 1 Jun 2023 19:41:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-GB
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Linaro tests: parsing of the kselftests results
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Naresh and other people behind the lkft project,

TL;DR: how can we provide results for sub-tests like it is done with TC
selftests?

Again, thank you for running MPTCP selftests!

Each MPTCP selftests script we have executes multiple sub-tests. For
example, mptcp_join.sh has more than 100 sub-tests. On the other hand,
the kselftests infrastructure uses TAP13 to print the results and it
doesn't support sub-tests (TAP14 does). It means that only the end
result is recorded: so if one sub-test fails, the whole selftest is
marked as failed. It makes it hard to track regressions, especially if
one sub-test always fails for some reasons, all the other sub-tests are
then useless. We would then like to report the results of all individual
sub-tests.

I recently noticed that TC selftests consists of one script (tdc.sh)
executing many sub-tests. Still, it looks like it can report the
different sub-tests somehow[1]. How can we achieve the same with MPTCP
selftests? A special output format? Writing something in a file?

[1]
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.29-293-ge00a3d96f756/testrun/17160994/suite/kselftest-tc-testing/tests/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
