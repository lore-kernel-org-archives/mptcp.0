Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F6E556
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708855543; cv=none; b=SfY/SFwTgR8NO1kJQ5IYp1ySQDCQenN+t8OfwDEjldWsdpwplxeYhp9Xqu5c/GKqCTHylcnUWXfU2jsruzJ5uUU6ZhdIG4BEYBTFUJgvQj1iLuXk1akgG7bD1SvZ+F/jwPk9ymR21yX6kNKE+/nXNp1uRH8cHrozKfjaqZYFyV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708855543; c=relaxed/simple;
	bh=lfhVA77LXDGT0jjt5zqoTlRj540s5XYWCfaiev5As9w=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=U6RwNnnf+3gwxDsnp2/r1sKxLBH3LZs3SZaXGsQjo4EpA2KiuT0TZjHtU7w72aUtk+RdxUrpaFqd9Jd0GQyAqDIiV6zIURmXqmkpQhNA0fRibbxg96/+3kd+m70jrqDuPVb2AXMCQasbvA/QAKKSi4WllRVjeDNx6X+deH61yI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8A7sJRi; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8A7sJRi"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-787bc61cb69so122956585a.1
        for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 02:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708855541; x=1709460341; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KVB+9xT9Mmg80bXal/OkpspopNuZ3OCfbO8/spWv3s=;
        b=A8A7sJRiE6zZiXZbpEV47yciag4aB1H3XcjsHaxgrusZYPMxAbcj217esxi85q2pNf
         urze6NVmoBqcAyt0F7z7rGfZx4iTKTsxXlFFnPtMunqwWmSUudCzlirka0+WNhAAAssJ
         E2hm8wf9txmLpAu094yiY7DbChCRKCTtoOrXZZMeeDNnql/9Op2WjZ/k5o29r6C3MEJr
         iD76kkM3Rgm3TvtQeMbK/l4DqMrgPr7pTqUXgzDSMzizcLFyMfXIUjEcrF/Oi6d46q79
         V299TuftPZJ1xlGdDyJyHe3zViTDJS4qyduqgRpapcebzo548LQiu3Rqic8ULMVCayxj
         RPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708855541; x=1709460341;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/KVB+9xT9Mmg80bXal/OkpspopNuZ3OCfbO8/spWv3s=;
        b=tT5nbXW7GoXW02tObZIg9JIBlk3Bw1Z5r7Mz8zsBgiz4Jn1HOywCum4xCIoP4661Ib
         kjB//XIi9qPsK3e6/eGAzAkrDah29FBHmVDy36R9sV7W73ZQDgya1mMV0epKH0kqY9/R
         yssvv5ubTpCYS3bLTZHFsD1bkV6b+ldtzMCvtunMqur+ytvRzWXwbjNhaVQhWqBf+mXX
         KqJh8IwpYj7jfd07jjeI97+yhzT7io+E7yp5yba6IA2WDQsE/hglPaO0EgTBTalovr79
         kwqzgwn8o/i7cnd0L9rr55lR9PyNRrFhiLhqsXTKCILT5+FQsy4osLROQv2cTyrYBaJi
         IRzQ==
X-Gm-Message-State: AOJu0Ywt227fU00Trh7JFdiT7Hm3rcYyT3ZYkFe0uBSqGih5BZTCYwqh
	aPpqxpr5J/2eD4TXDtT/S5vkOPt7V8vS+nIzeqn90QgT5yIz7mwWQfyN014=
X-Google-Smtp-Source: AGHT+IH/sKXxcm8weva+/KDINpeRRCPXRuxXCVHpiGQm4vaUAoj1BEE6Cpybm7cblnZr9I6CCVbXWw==
X-Received: by 2002:a0c:8f02:0:b0:68f:4579:6584 with SMTP id z2-20020a0c8f02000000b0068f45796584mr4016739qvd.43.1708855540634;
        Sun, 25 Feb 2024 02:05:40 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.35])
        by smtp.gmail.com with ESMTPSA id d7-20020a0ce447000000b0068f881d0d00sm1622247qvm.53.2024.02.25.02.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 02:05:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <812420af9b237318454ca7bc0a2cd05654734723.1708852208.git.tanggeliang@kylinos.cn>
References:
 <812420af9b237318454ca7bc0a2cd05654734723.1708852208.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL: Tests
 Results
Message-ID: <4a92b259-2c52-f43e-785b-22e5f0c03821@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Feb 2024 10:05:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8036972620

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8e3d9cfe89ec


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
