Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4338412B78
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ilhp/HKq"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67f5c2bcf18so3547926d6.2
        for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 00:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702975010; x=1703579810; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lw5Qi+0hgpwNJlG+lmH2F5rO4MI5pFaN/hvHHmY1Ub0=;
        b=Ilhp/HKqYNbl0+lubQHj5cAIUqyQfQmlHljwfJzCre72o4C+7eR0iAfFKyyLQjU2GK
         Ba5BRwovJbyt8q8f64fAGSjYyLC1m3enPQfjg231flmgNBF5QtH3wpC/zLTFbY/goFKX
         PjBeUjKhD+iPu4LU7X4gsiQaSPR2yr1k51GUGidcUT7WdqTkjQeP6DqFAJSUf9F0e+jO
         ekHk6KtWBx5MKkppGUATUEoHJqadvI5ozRf7aVouN6PvywQDiXP5KV0ctwVSFbVo7JpJ
         QXcmhMedWh6Y4hWB8EArPOnOVkSmfTZTQ/tGlrp08zePBKMFNHkDBgWhFD1zFFVqZuFj
         o2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975010; x=1703579810;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lw5Qi+0hgpwNJlG+lmH2F5rO4MI5pFaN/hvHHmY1Ub0=;
        b=QTYw3N5IFIB7D/o9Nnsjg7hUfuzoZPUsPcdsWi5tMnxJrHyz80sCLexnZtOxMjdO38
         V3w8iyApX8NwSPcac5pY794xFkpY7EgqLuIC+Pu752JJ4OOAigohZWnuK8IIMwXeO2ry
         7MVCBG/ksOc/x4Jz3ikuFTswoAKWweGOooh6RediGU28bYVSOZoVmj5uShe8plJa+Zeo
         A+NG5MaYqNfxCWXoOS52P6iQfyCUCHijU/emSeQXkkqXzNSkkkeAqLenTbK4AMwIbdMj
         dA8t95gLCn8xClgLGNvMZlR8DerlesKeaT7GE+Zk3VZx7NGdGHno5si1tEym+PwjSpM6
         offg==
X-Gm-Message-State: AOJu0Yw4/+p3+OuD5xYs9ZUEFIFfB6FeSStIzqrAf9XF+xC+Yop/F9mU
	1Gc0QMBRumm1DLVTWxHsTQ==
X-Google-Smtp-Source: AGHT+IH9gEH/GoLRXGwzp6/vfN8rSMSvtjyfbJnJ8hv2tDnH6q+HXD5AHFteOYDtwF+ngsPPzchRZg==
X-Received: by 2002:a0c:be89:0:b0:67a:a721:7850 with SMTP id n9-20020a0cbe89000000b0067aa7217850mr17121016qvi.117.1702975010145;
        Tue, 19 Dec 2023 00:36:50 -0800 (PST)
Received: from [127.0.0.1] ([172.183.74.1])
        by smtp.gmail.com with ESMTPSA id l7-20020a0cee27000000b0067ee78e8791sm6643461qvs.47.2023.12.19.00.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:36:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9a8034c76311d8871fb8d9e69aefc459b2e607ec.1702973751.git.geliang.tang@linux.dev>
References:
 <9a8034c76311d8871fb8d9e69aefc459b2e607ec.1702973751.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Tests Results
Message-ID: <28943d98-38c3-7f4c-71ea-4ca38ae17cba@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Dec 2023 08:36:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6002476764102656
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6002476764102656/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6565426717523968
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6565426717523968/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5439526810681344
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5439526810681344/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/4735839368904704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4735839368904704/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f1dcab025390


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
