Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503C5476B
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629335; cv=none; b=g9wUa8cRtW7iGZ/fn/Hiqk6KjnZ4mwnqIhiOFui6QVJsTcicyRP+lELgNiSzD4RwzHtplYucZo6f57ZZw0aptV3yUdfzz0YhpshCP5LDpawiYC7hXp4cYrqSc542NDcBqAwkRa4jYYGLjb4JdpTO1fboj/tUnIA/u7iYxN+dp7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629335; c=relaxed/simple;
	bh=0G+QAuteWM1XwzeV5KhJlauuJaSDz48f7MAzRDekfNM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=kNumt+1lCrY6KZkSRNqOBZXCVUkEdlqng6wgXlfa+O5FszslHlqLNPdiRqN+3baY8wpj6Lfj9XJtEuYlbq0nCvpaAk9OZlws2AkkMN9GLQ6AtlskFz2Kh0K6oMrNT+Q6+kgm/B0fyUOflF8d/vaVmIYWxjUYkY5U1T2nR2o03II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB6PEfm8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB6PEfm8"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e5d7f1f25fso2153538b3a.0
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 01:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709629333; x=1710234133; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8vqqZDwXkIJl9cLXWHsH8QFBP/jxfDTjn0O5cWN5dw=;
        b=TB6PEfm8SbWyjn0k9SFyyNvMPOuOhUzePlVgF3CZOtJKCkJQwJ4DllJxUDjf6zNJ71
         Mo7yAuJaRsxLrvNLU7pHZRwsCXd/XbD95GQceXl5yBWiaQSzhVRn+EJfai0j8SCr5DdJ
         IdR9JxXd+6kSIa/XndD9TUi+CGFcAbVgbT02AMBztAWeJYe7PqDRvoJFjUuiX7WcqPTA
         aFdVj0IPCpK7TbhpiUYtEJ9tp/wF4Hrd9moQcPFYDjzccT7/GyI5WXiQVOisAzicI+10
         AGs8sFfbD08+zTscm9+gJ9rLpWtipIQamRk4CAkVOHgp1S/e/4mLe7wTmTrtgF+P0PX/
         lOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629333; x=1710234133;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y8vqqZDwXkIJl9cLXWHsH8QFBP/jxfDTjn0O5cWN5dw=;
        b=nOq8HrAY/WDEubH1Nn981ew0mKyc1BUjIGG5+Sw4rr4TsCfsGO3WrVzMkjgtLq4kzH
         ZEgBUxSD9W/YHwcvArahxDUT7iDLkmb0MsJBFvcjrPrDL9l1gPqa/PgXwuv/0ZJn97wz
         OLFgNSrkuR7OUnwjykrJbFmVT2p8JlhNcvlI2AtbG4CZV5HG3VaMvwnEnmrbyIcdt6L7
         FE1M0z42BuiUDewC8QvhsVQlIGsVWjP6isy7eF2/WWIDsB3kkg7ex6boC03uhC4kjkyo
         u8QiAO5tfof3HxU38hMtEkCb6IpqoL/8fOh10MB3v9ZAQkGQtL3FGOWhDA5r/xmbKqkG
         BQ1w==
X-Gm-Message-State: AOJu0Yz22/ayFw966Mo8ywUjW3fG/P7MgqW2zUD8p7Au/iuCYaxsn9uK
	pULnjLFyjgNjPhPZMAQGSgdkR3zPpi1QaZ/KqGKc3oTYfXkjtK2i423hYGo=
X-Google-Smtp-Source: AGHT+IHCYZmHmgsbQp73eth4EdhlrotTJ82QR7Wn/OfHeUwngayh4w70NTVaVunPrTrwepf4U+I/fg==
X-Received: by 2002:a05:6a20:8e25:b0:1a1:4eb9:e264 with SMTP id y37-20020a056a208e2500b001a14eb9e264mr1259916pzj.1.1709629332843;
        Tue, 05 Mar 2024 01:02:12 -0800 (PST)
Received: from [127.0.0.1] ([20.171.75.99])
        by smtp.gmail.com with ESMTPSA id z12-20020aa785cc000000b006e56e5c09absm8768585pfn.14.2024.03.05.01.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:02:12 -0800 (PST)
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
Message-ID: <14808803-405a-58b6-73a7-13e0e1105649@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Mar 2024 09:02:11 +0000
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
  - Unstable: 2 failed test(s): =
packetdrill_regressions selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/8153=
140542

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
        auto-normal

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
