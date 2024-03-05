Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A6F548EA
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633332; cv=none; b=N2EtCYD7Uw3R14dJIrvuH7ee1OuIa74tybREt3/hFKOAU9QlCqFg1aYnsrHNElvzi+MjTp5FAPTwSsyQZPFSx39aBajNTxtj179RClaxFY1jj/59vafZG5zNRrNDRvmmFL/eRq0poSn8XN/RNFKtHb2X/vMc7NRhVWeweXGk7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633332; c=relaxed/simple;
	bh=o5GMgwU+XYJ3aO6TyEsT1CX0Uad7EJRMFz0j/x8MJ5M=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=TGnT2Lzq8+IcgEcpinnNT7LfEAYPbej6cPLdNkP3YIE2goF7QR/1JNqMxNR6FSxDOPY2JQnUBkbAO/ggzNJ6vxhELcauI8QNHIU0fACRg8VTXOs7jgH28VeN6DilR0ZkCGlbA+KjAZ6fj5yr1X9ivT2mL/H9x5D0RRoWFCAKbN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1nQJjXZ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1nQJjXZ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42eff0d5381so2570571cf.1
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 02:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709633330; x=1710238130; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjSMF2pCseeC35UKg7t9Ib6nE3tP9WlaIYj6QhqO2iY=;
        b=W1nQJjXZrXY1bTswO7W18icLEm+bpAaDdB1Ig+OanLT6+fFQTcsO0rjQ8t1RFCVsLl
         rAkYYozKmp+7wDdnFiyan2gdvh2etfLz9uw0YYKJN4JzCfdw8VEepTfRO3rvUAJCXvyH
         zZl//6BdWcAKHokCMzaj5FN7eUSeIduvtIXInNwxL3IBrk0XQOGX4HX7u+6Y0Cbf7c/T
         AAvIJsXyGHF4rGxMtig1SC1Jw5hTtIFMCCDuX5U++2uxofZvuEEhJtCuw2SaIoC7PXT+
         7poWXwQgvMiXfG+UoU66dS2Nxwzn69Aar09KIseFcuQZryhaq2nXJTLpxeChdPDxBUyY
         6mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633330; x=1710238130;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UjSMF2pCseeC35UKg7t9Ib6nE3tP9WlaIYj6QhqO2iY=;
        b=fczwWPGKeezPFamWqgbd03+URjK16VFeJFLVdRjKdud4ZqB0EnL/eDCDiU77xJnJP3
         JyrxP5rtNlKIAKlYWrzAM++Cj0YgCMsG6cLu1L74KeUsqkTvPYpgqYcyMghmhG95uqkL
         rY/YhhRV7txV/Z8Y97gCMLcw/Oe/49pwiNBFtZkwriex69bXhs6tRh5RxZYjeCFSBobb
         FSProJ8s9xmBxrxLZcQAwDvkMmj/8LrewAA4USHjQ8rBGYRlFpOSH36MKULV/pXoD5O5
         hzyG9XurhJrrQm7rz0clCS78wKbPubv9NkG0GV6PGDlVtrHg/v1pWCRHNlr0UMZR0MiJ
         2XCw==
X-Gm-Message-State: AOJu0YyC8kkw+tKGcLVy1vkHRq8O7mDRAlSuLi1amIJqxXAmh9qOnXRE
	xQ3tz9I45xmbGohTeGAxVhugBvYU03d5g5X6khh+KbXvotKP6RmrfL0yVZ0=
X-Google-Smtp-Source: AGHT+IEsTV4GpttqyYh3eNB6701IX4RqUH1iEfn6rohSffH6yrm4+CMK+y2nrBok3bxeZ1NlbSnPjQ==
X-Received: by 2002:ac8:7f54:0:b0:42e:f3a6:7fb3 with SMTP id g20-20020ac87f54000000b0042ef3a67fb3mr1637764qtk.6.1709633330009;
        Tue, 05 Mar 2024 02:08:50 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.32])
        by smtp.gmail.com with ESMTPSA id on7-20020a056214448700b0068f9b20fb0bsm6009453qvb.100.2024.03.05.02.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:08:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <93e203493c3ce7a0c7b4e17146baa37a9db2f568.1709626306.git.geliang@kernel.org>
References:
 <93e203493c3ce7a0c7b4e17146baa37a9db2f568.1709626306.git.geliang@kernel.org>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22bpf=3A_Add_bpf=5Fmptc?=
 =?UTF-8?Q?p=5Fsched=5Fkfunc=5Fset=22=3A_Tests_Resu?= =?UTF-8?Q?lts?=
Message-ID: <a96dec6b-7a13-f161-ee71-8c6529b99a3e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Mar 2024 10:08:49 +0000
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
com/task/6514107336097792
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6514107336097792/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5290875752808448
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5290875752808448/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/29b98e5b5bd5


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
