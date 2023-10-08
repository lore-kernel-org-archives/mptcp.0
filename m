Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE215CB9
	for <mptcp@lists.linux.dev>; Sun,  8 Oct 2023 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmEwV9Mb"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-77574dec71bso246565385a.2
        for <mptcp@lists.linux.dev>; Sun, 08 Oct 2023 05:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696767624; x=1697372424; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50zqIBzkaNCFW0DVwfFaHP/PpFncxn61tKQSJSd3ql8=;
        b=MmEwV9MbcQgMt0b2AFhASkHUrK2AU9mImWS3kHaRllmNsISqy9m1GySQQfQRLwLxVx
         RP5RfwRZjJ7XyhOcZO0qQIGpR1n+TOcfG4LzPGaAilVFx4ooJRd6jGCJK5Ug49j910eG
         69EX4nzHBpE+Cae+Ws6GqT3P7eO4eno5dYxBND3BEWnncAMd44GJ86vqFU6rVr6+5cfX
         UvJyJ0Z6vjOyUeKYgdc+mZdBcG/gk2wK1nI8c67OHXxdWieIzENSXoL9JWpbeJw/0SMJ
         cPXC+5S4fV32ertd54mBUBwtovvj5EwFOh4yiFudIPPf/HxKDJQwEit4P+aAQs2oQ3YF
         pgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696767624; x=1697372424;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=50zqIBzkaNCFW0DVwfFaHP/PpFncxn61tKQSJSd3ql8=;
        b=Uk80ZHkVU0HH+NJIunenELgtUZnkMT1apx+a00xj7xFGUCuBXl3szYtQxBW55KORAp
         NX3a0I7BvlYE/qzxbxhgEHi4IM9meIIngDMpZ+fi+Qgju/Pofl5gkxqD8X1YRSAdOcgD
         7JR9LDaut/orDyZSs2C3mXWObixNDzgUFTUc02TDetUUYiuRHgjLBFzCT3c/7H1Ev605
         MLGjDlCgMYfmGhv2eiP4H2WIZgHV1lGi1M5oRhPVL/l6oLdMoobgXQOgUCNE0dbiufOs
         aq7mxjkAcIRr/JQ0b8r+mMXUfaIEkgbCW3euopiejW0QPKMSK8mk2PPH8oM8i6Hef7qH
         hVZg==
X-Gm-Message-State: AOJu0YzlPRTG5o4xOW5e/g1f/9zKoeIrsS0vpdnFDQmZXyUCHXJLNqv5
	VEgEjL1F79z/kolDivIriw==
X-Google-Smtp-Source: AGHT+IHIVT5R6ks8MtPolynp1h9PRVcnZQY3JaHQ8FJbD/WzGE1YHgeTGj6wcQpouTJD1j4yA36fJw==
X-Received: by 2002:a0c:e0cb:0:b0:66b:b8e:9251 with SMTP id x11-20020a0ce0cb000000b0066b0b8e9251mr2747155qvk.54.1696767624410;
        Sun, 08 Oct 2023 05:20:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.96.46])
        by smtp.gmail.com with ESMTPSA id h14-20020a0cf40e000000b0065afa998364sm3005145qvl.95.2023.10.08.05.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 05:20:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3738a4c89c049ae3b2832206390a39471331865d.1696760702.git.geliang.tang@suse.com>
References:
 <3738a4c89c049ae3b2832206390a39471331865d.1696760702.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: userspace pm remove id 0 address: Tests
 Results
Message-ID: <51adda09-e06f-4b46-079d-de96afb05199@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Oct 2023 12:20:23 +0000
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
com/task/4593464562679808
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4593464562679808/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5719364469522432
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5719364469522432/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6282314422943744
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6282314422943744/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5156414516101120
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5156414516101120/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/082a5a6f42ef


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
