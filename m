Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196039934
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O48Dq3OU"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-578b407045bso54368a12.0
        for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697045614; x=1697650414; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5puuv8QNRcINPzYXm4dFeMdpZP08BUpreFHilxtNn8=;
        b=O48Dq3OUhkB5PRzvS8/T+cGnyYiMk8drtOwC/KUxnt67xr/7Kq25JhZa9CbkQjN6PO
         KYrUzPHd+XCrH8epx1ZNFhLpeF2T7v8wGEz9DCWuYvd/EV5dLYCOf2wMLMopzLAi+n39
         Ie1uhgh5F4gSKknNcWokqErBnyZNP+hSiS8duRHyaDvZTVEwJ21BsdztdpsPDoqtMbyc
         GaH8MWO9eatAozeJ9mt9ejl3110GAaTWC01L+pL4C0bWqwKmetJuzDGgbW0G95CWrxhZ
         ZmNS5tlgGYWz6n6OKTPQWORMznXFDsqEPOaKnEfb34Ymi7N5PWitMEVbljvr/75KA6oS
         ZvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697045614; x=1697650414;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p5puuv8QNRcINPzYXm4dFeMdpZP08BUpreFHilxtNn8=;
        b=AHzORD7B9rg2KRldxGHBQZl6FbjSvV1De4ZpacJKxppmoXJzS1hOR5QniozmnY7j8I
         oLyHfJw0Jn6QeCvJiK+zWenVMzlHUoZvbUAQS8NF8aPE1vHfGdC9IRgibfuKAYWlznoq
         Dr3W5nMsaylDoFs8KmBBrLdDg3rAs010HadPcVp97NLY7+wEpfFM5d51iF+HzoSrm9VN
         9cgESWEBuEuFfZODYgkFFUWLU3dK4oIVoaM4bjQYRwjf6bFIDnHpSLG8+WUWR+qBF9hE
         NyULJ7wkm7+mxKkuBh90t9VNJJmVkwTPfF9eroJllvz8vODVKvkAy6fuJbjDoMnWBH0P
         y9Ow==
X-Gm-Message-State: AOJu0YzxIJ0DuCUxFe3cDs9XbMUNHTcEjReI6HqfiIbiXI79egqtxpUT
	KelsWmrjflbdFd3D6EtTkQ==
X-Google-Smtp-Source: AGHT+IHXnZAAHf9q4TdQzuq3YhBgP1q/CCbkRpJG8cyJBSm7Ap+3lfXPMJhchCw5GLm/wLpvuW0MGw==
X-Received: by 2002:a17:90b:110a:b0:27c:eb84:39af with SMTP id gi10-20020a17090b110a00b0027ceb8439afmr5392173pjb.43.1697045613793;
        Wed, 11 Oct 2023 10:33:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.132.243])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090ab88e00b0027360359b70sm165293pjr.48.2023.10.11.10.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:33:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <036c68f42c3d071ce7e52ef69ffec650c3301268.1697040427.git.pabeni@redhat.com>
References:
 <036c68f42c3d071ce7e52ef69ffec650c3301268.1697040427.git.pabeni@redhat.com>
Subject: Re: mptcp: more conservative check for zero probes.: Tests Results
Message-ID: <341bd070-fc49-de0a-fa75-1af2596bea12@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2023 17:33:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5897917144236032
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5897917144236032/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6460867097657344
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6460867097657344/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5053492214104064
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5053492214104064/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5334967190814720
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5334967190814720/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5734cf1cf528


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
Bot operated by Matthieu Baerts (Tessares)
