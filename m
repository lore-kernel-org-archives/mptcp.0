Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4BF14AB6
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOHAMM0I"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d7609cb6d2so1114538b3a.1
        for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 02:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702983312; x=1703588112; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uG77+QhT1dHeUYARjeamP4i/CGQWP8Z+DyUtj3xWS1k=;
        b=KOHAMM0IJOjHXHhYSK19x62ABPK8PLlnloz0y72oe7pXOZ/4HcHxMWKhr65PHyJMcR
         b74r6LkDlgCnUAeTOkuiHSeEXWMyhUazurQjYnpJHxCozaIetIZLlIvAOvgt7Q2YwCUP
         ADrWkbYhC9Dwbaeonlt+hpQUiePTrpCOUgrCRyZlTdayyKMfwMAsVW6RvtBhLTSpSfJC
         F1gpOWV+a2c3s33y/B5JGxTsyLOXTMfsKg24FV9VhJ8ovXw02Cu41DU9euhcVOdsSqN7
         1jpx6i8G8opswqgFDzl92qhISE/m7yu88vtjCv+zKQpuNEFRR6CNMOBGf/PY96XopZW1
         rL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702983312; x=1703588112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uG77+QhT1dHeUYARjeamP4i/CGQWP8Z+DyUtj3xWS1k=;
        b=gGDu0DLNuPVYkcSjJmHLZ5IAz/86niCRvoZk6nB1j4KZ7viYyVRkVC5OuqqcHuquS0
         N6NVXJg+MuRFQ+jAhvSumU4FxCBvdjyJdV1cavFZRAyZ8gebxD4BUL57vb/LKXAGWntu
         hv8PMea2/CbWgEYD5UTkmpcJnSh/DLrBnBHZ6mghcQ0aFSDsZPCbNWRuHXGpueHLuGEU
         9BZCxYiYqLYK9Gm7aFtwEhl4uHj4mxghGMs+QORZPVuhGJx8J1CiuL/PAWtkG0gDsOsc
         enoIg6V0/Q+lDMB3nVfamwHpFIw40/d/DVm+lHFR62e9B92lo98yTHb28jR6u1/TwycK
         LdEg==
X-Gm-Message-State: AOJu0YxCtjebf71oUGlz3vlQ0EBtC+FjifiXLkzsMMDc/K6muybqVZOT
	JKJpPOucDyIVmxvhokD4cw==
X-Google-Smtp-Source: AGHT+IEN94Gn8PH9x1WTQiEw1J6+87TbVc9hqhl8dHoh3cQuW2zJ+iRZXtLqkG5vTBHMIjnAVnwWww==
X-Received: by 2002:aa7:8702:0:b0:6d9:2e2f:9cc9 with SMTP id b2-20020aa78702000000b006d92e2f9cc9mr957612pfo.62.1702983311884;
        Tue, 19 Dec 2023 02:55:11 -0800 (PST)
Received: from [127.0.0.1] ([13.88.99.142])
        by smtp.gmail.com with ESMTPSA id n37-20020a634d65000000b005c21c23180bsm19209243pgl.76.2023.12.19.02.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:55:11 -0800 (PST)
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
Message-ID: <d2437e93-da05-48a4-27cc-1da68120c532@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Dec 2023 10:55:10 +0000
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
  - Task: https://cirrus-ci.com/task/4651956644347904
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4651956644347904/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6340806504611840
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6340806504611840/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5777856551190528
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5777856551190528/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5214906597769216
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5214906597769216/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8745a4886c7f


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
