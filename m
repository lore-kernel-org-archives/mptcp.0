Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F611D524
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390861; cv=none; b=SIFocrlhQQzb8OdT97uTpcuepNxPG3DOtMRAlWPi8b2BA7GvSa8j2KkZRulVMLsIVUFD31SeXAoqoX0S6j3JlnSLeusAkOBNTnnritwkyRPS1tu70ufqrjK4zFqD802yPhiV0ihAPeddYBXm3EZ2t3ikoR0t00PlvXwAH645oGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390861; c=relaxed/simple;
	bh=2RB11ICs8wxyVrfdpn5uY6dOk1GskmvTB0GZD0o7oBY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=uwDmVtKZz8C8hxZ2R+emHGR5KFvpH4W8e2P4cTx0BHZpwFksLyLs8ECIT2xYDr2zJFtFQ5aq0dFAPexRdkXd7vCfK1y+QJfgZ3epLfAiCIxjUqqmFpg0EJI3xTT90AXj0HLrviGSypLJ9h1ndp6rYknnhQ7VMErJ8BeRcZ8YmbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj2sdL1/; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj2sdL1/"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-781753f52afso89416985a.2
        for <mptcp@lists.linux.dev>; Thu, 08 Feb 2024 03:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707390858; x=1707995658; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWx1/1ctd07kgFoa2vMi2hLayEgNTHkHqldNcfl0vBo=;
        b=Tj2sdL1/aaWieuYVgotYCOEM/pbF1viOfg7GtOFuXiVo07GZHDSFX2uzoUq0qC2EXH
         48M4avEK1QjjMeCS7WSE2QDn7ekJuxWEgt4KmVqB6ucYHSzMut7rQoFC4nx0XO4LOAHN
         hPCeWu94SCD0jm3uuSOLx2ZoOnhOkW5Nizw/GThdJqe9vTzWbNAUlsqFgQqQFOn8e4nY
         bT/HktYcaShjjSGpq2jehH2e3BNCb/rijMgYQb2/rzdF0aaywrCPqAh0pE6XfqRyCg1L
         DPkHNB7AHVDhdbxbcZid+Przcxqtn24AiCz+S6nmD8kI845IAx7vWI6G6O5VYL0rbTzf
         rptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707390858; x=1707995658;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OWx1/1ctd07kgFoa2vMi2hLayEgNTHkHqldNcfl0vBo=;
        b=QKsBhYzmOd7FpJByVkovc3fGEldjWAQ505jLpH0JBgiInStUdc44IYoEsPAHIrzirR
         cBfm9fFy1IlT3lVp3pkwo4wrBasetkLU2cdD6w6IOpMBZLw9VSF0Bc4KYsxmJgk9XzL0
         RBVvp5nN9PEbusv8VkmOm0YVDbRsa8waTwKskhRwvshOPN6D1AtRB87TnrFOgcMpAElk
         x9VoPGqOpISbHdNCTyW8Ta4RfPzmKTVHxkagrjlWK4Q23qsqE+eSmek6mWtjOya4/z4g
         OORpkgBBpqJrTkoO3VWPsdY/3v2Yg+sgeaCQbIiesqVw0zS4UHlelfrLWubrPSFBXHhv
         xWLw==
X-Gm-Message-State: AOJu0YxWQdLZ7kPUEWRckWtIv6NrwSzBx502Xc06obZGisEHykfKhyR5
	dDvJmN/4LIsN12fnpYx9jzQw6iTnDjycHFkQ/ynEd+tUVLKeNlb6leyekus=
X-Google-Smtp-Source: AGHT+IH6m7scQB6wdPQV/SV2fiWpITACQ8e5tshzJ0EJg/vB9vc8Vc3CudKF4n0tx87klx0kJxo7uA==
X-Received: by 2002:a05:620a:25d6:b0:784:8cb:52f5 with SMTP id y22-20020a05620a25d600b0078408cb52f5mr8588872qko.39.1707390858266;
        Thu, 08 Feb 2024 03:14:18 -0800 (PST)
Received: from [127.0.0.1] ([40.76.119.133])
        by smtp.gmail.com with ESMTPSA id l19-20020a05620a211300b00783dc97436dsm1297315qkl.13.2024.02.08.03.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 03:14:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <69082b9835463fe36f9e354bddf2d0a97df39c2b.1707373307.git.tanggeliang@kylinos.cn>
References:
 <69082b9835463fe36f9e354bddf2d0a97df39c2b.1707373307.git.tanggeliang@kylinos.cn>
Subject: Re: bpf, btf: Check btf for register_bpf_struct_ops: Tests Results
Message-ID: <6076abe1-0e0e-e270-b8eb-5d5ee214a1d0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2024 11:14:17 +0000
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
com/task/6339634976784384
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6339634976784384/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4932260093231104
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4932260093231104/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/95e0e3a258c6


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
