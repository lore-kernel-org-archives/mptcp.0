Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2EF4C9F
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707879330; cv=none; b=TtZy6RjX1nS53Mk+lJrtKKBfUG1I/8PmGXtx0wXdqA+kvmgx64AE1StB/wnoQ/E01R60vVSaknq7QpxUI+wM/GH3q6olYl+93ewFFWUW77b+sFeiB7Bx0v9ocU3HNwTGBdSXsUAB1lTJ2fjb9OkBDZJh5fj0e/xc1Qz8BOi0FQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707879330; c=relaxed/simple;
	bh=HAhv7W7JXYqPLt1sRkwIV/6lLbh45Yk9ADMvnf6M1gc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=MJ2SRVKiDHIj/Lg1CfedYV1OsrwocMxfP57ML9tkoDSUoA998YduKLya58eUe2BW42uKR2cRgCwhegm10maUmDebUqpS8wozMGT/FlUCBCmx8SQwZ1weC97+oZtIaznEUvVxQNo9/NaoBbFLdP6sMj4wgJCPu+7tOhp/2VpBLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeVfw2wR; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeVfw2wR"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78725b62cf2so36587385a.1
        for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 18:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707879328; x=1708484128; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRksKU7ypb4y1v69GAvm+2DDwIuqlHB6VlMRaZpIM1w=;
        b=IeVfw2wRQANs74vUy7Mwr5k3urDDnfNpsT0rDk+hzTu83aU8X5y8EnSnNlJ8RzzXaX
         RuDL/SVH26R3N9yHaDXuAANW5yD7oRC19++yLC+UJk2cD3lZEPd5jgNMeHYT/swx4Ohp
         8Gh5zbQ5kauUXtpt2Sz31vUMA/jgSsiXBCU1Nh9SYaM9sZ3gcd2+D9hi2ys110SHTnDE
         lsLFPL/dZclJP1Y7p1g8Dz09BuIkO7+wZUvmoHWtKT7Icv/cs3jZjL9nboZJxbUYgfcj
         ndPqyvoJw5yBJETpA85EiYynD1mZaVoBIuv9T0ECPd0L977TDZx3RBugZO0Ue39N51fj
         cOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707879328; x=1708484128;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MRksKU7ypb4y1v69GAvm+2DDwIuqlHB6VlMRaZpIM1w=;
        b=K0Fpxa8qtEXD40hpYgvHp1NxzbGJ3BISZj7h6CfztKkJ1E12R7fEdqmf+Lx4lwImfg
         /UOs1eHYRSkBt5Y8iFbRTqdxzqCzuf4/bfjTcr0MjiKxaDRBmIkkt+7+gknr+dsQ5nSc
         w51fRbssxasLA19PlihUA5QEaxMhaUny/fbCa1G9KQ07ZDZvyni2ZQmr7NJwqHrG/wu5
         enI/KdekRnrrueF/V+al5Vb+yJiyCzgZk2Ho3wr9IYi4i/iaXYcRXLDvWb2qPA1A0Wf2
         Lb15SKbG7LaeeMXtocRBE2pmFPA6Z5FfyFydvvLJ7FRiXQyRggHcheWSiYBxUgJK6UMY
         PWZg==
X-Gm-Message-State: AOJu0YxZ4uJQ9+WHcwOC5QyA/0cxs32XpH0I5nZvLFnT0J9rzM9kUKCs
	t3emYE5ngvfpPcZxIWEJJIdd8Nxzz7YFGHmLbB8Dagmc5YKnCy4cb0dXKis4pA==
X-Google-Smtp-Source: AGHT+IGRX1P2+Nv7OG336xjB1LpjWfPp5qDYW+QLGA7r33ypmiRVd/izxtEeCMvG/2usVtwbAaDc6g==
X-Received: by 2002:a05:620a:1a90:b0:787:1fac:ef05 with SMTP id bl16-20020a05620a1a9000b007871facef05mr1694134qkb.23.1707879327980;
        Tue, 13 Feb 2024 18:55:27 -0800 (PST)
Received: from [127.0.0.1] ([20.81.158.162])
        by smtp.gmail.com with ESMTPSA id sq4-20020a05620a4ac400b00787188dd406sm1253179qkn.30.2024.02.13.18.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 18:55:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0c91c59ef950d3e64237e8a667a244ef850d0981.1707270765.git.tanggeliang@kylinos.cn>
References:
 <0c91c59ef950d3e64237e8a667a244ef850d0981.1707270765.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: rm subflow with v4/v4mapped addr: Tests
 Results
Message-ID: <34aabc5a-1942-11bf-a3e1-2387fd2c895c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2024 02:55:27 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5714999662870528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5714999662870528/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5152049709449216
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5152049709449216/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9b8ecb217a79


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
