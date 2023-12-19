Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366FC120
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 03:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMAsqPcs"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-77f320ca2d5so301060685a.1
        for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 19:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702955791; x=1703560591; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lq3ka0SfVC9cVGLGSbPQv0xx38zg43N8LjwY6iqYzzw=;
        b=MMAsqPcsR1rsKI1DNiReZuvHfOitKGDd4B2FVzV6u0DBUS4RxBWz1MdDlCxXx14pT9
         McCMaeswQyHbEjW9R2p+JIj5CqDB5XKuUps2rFoeTZ+Wv5bIgKyOWLWJ54Qa7QAUQe0h
         1waLeVBRBY79i4CC4mIK34XT+Zdi8ArO9iwS7HDUhNSM2s6GmDUm1jnVg71+aGxqolNl
         FfWUQjygZAc1IJ3PBiWXyDMOoQsD4TeGb3CW9ecp9e2iE0nuRLuZtDIvc8m/Ffncul/n
         E9cMJi+RAhFN/3T89C5nFq+DgZoDjXN/OENeB85y3fZllZeu3bmVQLjDZOnbPKq1VhO1
         kBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702955791; x=1703560591;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lq3ka0SfVC9cVGLGSbPQv0xx38zg43N8LjwY6iqYzzw=;
        b=NMVBaRHJuHXsaTHsBMWR+EMVMR2m4xxKwnmoj+pAH0pRSGrjPbVIAuKeU3XVv5pLf5
         etW+DmwRuDhBmHWyd+p4cSnM146kEb/635F8XBugr+Y1n9HcMh/BcFiNQnDEQ4AqOaxu
         x6PBt70LAKb3LPmzzjYwmTwCKNyAHvLvrY+NJNz3nxIrDdt4nmciinXb5Cm9OhT7OTDb
         thkxmegEI8osW6/EYqTlrRKySshzH0vMwdTc4TDrMCW2l+A62WoGohoy0kD4cNt9YRm9
         WBMrRO7m2X+jPgycAeGdEFiQZFPjIpT1VfurDNpL07Bx9KVkMIiGEL6pP0nPO8V00REA
         0PGA==
X-Gm-Message-State: AOJu0YzAkOk/cK06XTobUP3I4GYWeZQYrf+JOQ7Fu6mLSyR062Zbvg0S
	bHSwPQdIi9YnqN6HLndaGw==
X-Google-Smtp-Source: AGHT+IEunOO46aLEu4cN0zpqhIM+xml6FN6SZC4A+uBfoXZ/r6Ww75cxwQYDQ6BXx1SKZEINbAY87g==
X-Received: by 2002:a05:620a:4907:b0:77f:34bf:5593 with SMTP id vy7-20020a05620a490700b0077f34bf5593mr595237qkn.17.1702955791170;
        Mon, 18 Dec 2023 19:16:31 -0800 (PST)
Received: from [127.0.0.1] ([172.183.154.244])
        by smtp.gmail.com with ESMTPSA id tr24-20020a05620a2d9800b0077d797676a4sm8808949qkn.122.2023.12.18.19.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 19:16:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6d9def0df5cb5edf499ca2538d7f5bd28721029a.1702951288.git.geliang.tang@linux.dev>
References:
 <6d9def0df5cb5edf499ca2538d7f5bd28721029a.1702951288.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: diag: check CURRESTAB counters: Tests
 Results
Message-ID: <aa4e82b3-d99f-fc3d-82b0-9b1469f8362f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Dec 2023 03:16:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4894198806085632
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4894198806085632/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6020098712928256
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6020098712928256/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6583048666349568
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6583048666349568/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5457148759506944
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5457148759506944/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/21a1645f1f1b


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
