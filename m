Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD963AB
	for <mptcp@lists.linux.dev>; Sat,  6 Jan 2024 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtxzr6Nx"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68009cb4669so3687016d6.1
        for <mptcp@lists.linux.dev>; Sat, 06 Jan 2024 01:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704535048; x=1705139848; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J69Vi0/qHlbZ3fmoWYMIAZxqYoNd/YySmKEqg7dL6sY=;
        b=Gtxzr6Nx9IyMOXflC6cYorGLM2871SkZ3zgoxGEvz2adlzymjXniUvOoUXUkDOyYSh
         xueh6lOz6PJLcjCtNsnirgpu9xNzGVR1fkkTUzagRkEFoVIbCPhETIT2NYTp4QQgLDVz
         Jjj3HnpZS5LNr0A58mStBdYwjTDNEBBJnb5K3xUoogO7bGWaxvRWTCFeWrJluVsR0gck
         EPyPUrdRvH2W0mDHOc6O35/fy9A3kFw22eDTLyVGDpSiVg55WIKHVFi+zKhFpssWKkSl
         EU36r0iqB1iRrBbhRF3rho46Qm0un7bQyMKpqWyelowpf/gIu+nBJdAhZLYDMJZ5V/Xi
         d7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704535048; x=1705139848;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J69Vi0/qHlbZ3fmoWYMIAZxqYoNd/YySmKEqg7dL6sY=;
        b=Q1OwrAaglAdrQDf+/s5//7a7QJt+xfviaSY7QokgOfGtPP5+gWS+pczA8VwUB83F0h
         IF/wDTE+PUB3E/DyI9cOeVQrVyKF/ZJiweeGto9zmxaWKx65E8/I+aYH51lIRlaZDS3o
         FGZuQUCx9uWT/Ze3mK2Rtx2+lxyG+Q3BmG6g0vvSJCA+muqAROVrTH5PwVjIIaf9NxWw
         +p4SR7UyyUcMn/X4S7OdZ36oMQIVXltXisuVw+PfHuJ2u/NU3kVdapQB7Fj376UU7L4M
         M580AydvtvZgNRnHIIROkD8fr1KmxhI38TEMBAZObQ3ODiDfC4J7j+JiByxjRFN0o2U6
         OssA==
X-Gm-Message-State: AOJu0YzmVm/mPMUcic1z7WyXJMibeokoCQZVfMa/H9vnyWd70YjwsUkt
	IgLgg9eqJySY0QjkYrTzSw==
X-Google-Smtp-Source: AGHT+IG4gX3/3f8iAn70ONfE9UvvVG6C/Z5btOc/dkccVqmEk7ZuYEnGbhQQRTqrWS2wHX19JcqnVg==
X-Received: by 2002:a0c:d64b:0:b0:680:f98e:c9d6 with SMTP id e11-20020a0cd64b000000b00680f98ec9d6mr210872qvj.131.1704535047853;
        Sat, 06 Jan 2024 01:57:27 -0800 (PST)
Received: from [127.0.0.1] ([74.249.14.211])
        by smtp.gmail.com with ESMTPSA id s16-20020ad45250000000b0067f986ff8c3sm1300508qvq.35.2024.01.06.01.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 01:57:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9e2fbdc6e5a9c59d4b8eded4bfb2ae71a768afad.1704530434.git.geliang.tang@linux.dev>
References:
 <9e2fbdc6e5a9c59d4b8eded4bfb2ae71a768afad.1704530434.git.geliang.tang@linux.dev>
Subject: Re: bpf: Add mptcp_sched_ops CFI: Tests Results
Message-ID: <02853108-2631-18aa-e992-074e7a8b2570@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jan 2024 09:57:26 +0000
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
com/task/5406963979255808
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5406963979255808/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5829176444321792
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5829176444321792/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6532863886098432
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6532863886098432/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4703276537479168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4703276537479168/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ca110d1ee2db


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
