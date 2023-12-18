Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029A18EB6
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmIDl660"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d32c5ce32eso28735445ad.0
        for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 02:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702897091; x=1703501891; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjO46KG6s+afTEMZTvCI5sQf1SP9Y5IhKvhwPDjKArg=;
        b=QmIDl660Xzhef6idebAA/FXY8KIoInEy++KutZgocOdAYPDkuG39Pf7T1G24pBPUFN
         d4uQnfLCoWvfPY9lojN2JJY3ILE8CaSQbRCIITkM/wJOEZlsjML3wnLtQ5XosoVxAV9I
         ibSZft7Y00RgqCRc5LL32+GAPt/ahJBrGXliWqW8/gejzXLXD8noJrAV/4gbcu9/2EZc
         L/ZFR3Tu8C8tzNZcewaKAieI+Hcq1+YwbYR8J+QN95LfVbemTpKfBPECeTzrNPXb12Gq
         gglyv+1cBrglSxB3VzaR+zgFg7moqhAYdN8dAN8UYL5kJqCHV52H8hRfjuv0Q/I2BPv3
         1vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702897091; x=1703501891;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QjO46KG6s+afTEMZTvCI5sQf1SP9Y5IhKvhwPDjKArg=;
        b=huKFoy6UzZa84/mwCi4PlW/NN8AnIT+qS1nQJm2fm0FXTiHCzPufw+X1ykiiB4gJEg
         N9zus2UrepntyVDmMzcuVMV1Kioq7zxLuknlSNCOpbO+TkBTd1PEiD6gL5QuNi8sON/j
         JvRrSctJbvZsbwnUcHK9mGJtBbi0RVvQM9gObSda09JANS5PkYhZP6OyHlIyrHArEeyU
         6PzLFQ428AXQMcuqBoVs6MFZKOoYcrF1qCwDQ9u7ol1MUXuDFIO/rLGZc6b8eJoPHidq
         PKHyepUAPrHSB6HVgQQcaxJGU+yzqkANa0SlgFLe3tTbYQig2PjbwWMfXxIw81Lwpx0l
         rbTw==
X-Gm-Message-State: AOJu0YxVWK9zeqhIw8JoGXeaUvmo5I+ZgBMuL6cO/ZWb+q5O0BLAeKVO
	9ubYl3ISBvAFo9htERlBdQ==
X-Google-Smtp-Source: AGHT+IFa06RM20Ee5E51knGRqfaMF4pJzQzwZjbPPi0WJw6tnL+Lq5aBb9qJhrKEG5buFS/gGg+CCg==
X-Received: by 2002:a17:903:24e:b0:1d0:af63:2403 with SMTP id j14-20020a170903024e00b001d0af632403mr19674724plh.50.1702897091280;
        Mon, 18 Dec 2023 02:58:11 -0800 (PST)
Received: from [127.0.0.1] ([20.172.0.32])
        by smtp.gmail.com with ESMTPSA id p6-20020a1709026b8600b001cfc50e5afesm18222262plk.23.2023.12.18.02.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 02:58:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7eaf5f34e18dd3349683d4b65d9957ff776df28d.1702891194.git.geliang.tang@linux.dev>
References:
 <7eaf5f34e18dd3349683d4b65d9957ff776df28d.1702891194.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Tests Results
Message-ID: <cc5e70d6-4188-4534-cea7-51609890de31@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Dec 2023 10:58:10 +0000
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
com/task/4505113289555968
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4505113289555968/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Critical: 3 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5804062763909120
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5804062763909120/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5631013196398592
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5631013196398592/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join - Critical: 3 Call =
Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/6193963149819904
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6193963149819904/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/14e9a9fcd464


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
