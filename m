Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96292AE97
	for <mptcp@lists.linux.dev>; Thu, 10 Apr 2025 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744263217; cv=none; b=PGJ+eRLBkYTXbjE9Fh7Rkh3wfK8NkeKclPWHrgc68r6C+Cb3sf8CeB4aQJPLX1wzZL8DFM3oYprYkkPrmitAaE/zf8KQWd5wNZ/kpN53HrGpZTRjFuoYLhcq65BaJ6B77YTTixrgh52wWgoCDFOhpOzNQoZfJx0tbymbhu/LWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744263217; c=relaxed/simple;
	bh=P4UTzrTs9x4HV1SW6LIN1pij4RK7xrw5WI2jsGiUYiM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=DSwVRM8J/3Ea3sa7gdBPDdAR0qEhdGef540+GhGRE0X1Pc/KejLfS4dWAbUb2OTHtpjhw3RCMgIvLz/u/10+osrwUSQ1Lzy6vm7utKruCoXZWLI+suTS9OTJw8ZHiaUqYqElbTrw6p6ci/PNZ5kEUy9eyDJYXRL6/sBXrc5MSTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSNL3wKQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSNL3wKQ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af59c920d32so348414a12.0
        for <mptcp@lists.linux.dev>; Wed, 09 Apr 2025 22:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744263215; x=1744868015; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbJ57IK1pgRppnfQomR/HzpKVpwhokzMc13jkpcrkwU=;
        b=XSNL3wKQ1e9nxpg3LlDFVUjum1DRQWoa4xofS48phrelCHzT+uqnzuyCjPxGNADbn/
         F7AzNsW+bgj4w6Jm6aDd3hxLvFEfoN/j+39dMuZoAz6rRJuL/r1iTla8Y3wuMHa5PJ8F
         Se13ItvD/7hGq5dA9Emd5Yw/GZDFKI8S3RpQ7Qj+D69c7Th5A6UiG2TQnNF/2TPLnZXb
         JracVfrazvuav14LTatoZiIEhCDZLxNAgnmEQKmFlX8H1zB7lCvBtWinGeJ857vN8GV4
         ZSG5gtPRMUu2aZzaozdfsex1/lRuAnpLXiLR1+gpeDfuz8szlzbtL4xAK3lNKQGAn3Nv
         leKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744263215; x=1744868015;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TbJ57IK1pgRppnfQomR/HzpKVpwhokzMc13jkpcrkwU=;
        b=wrGXwf+EUe0hmA065DxqR/Wkr0UAwmTf7EodKkKgMs9BYhIW0MHjSSwjaazTByQHmz
         P0dLUqNe9IXlmpBLCRBnl5MrNRhbykpOnvVUtFdgxqXCflQfE0A8uT3DsXrSk7HaUmai
         jOaSNP2Bp/etXzOfAYSWbCXiQDM3SO738kdA2o+FDgufiORHTSwIrAsaY38mRuuqXSRj
         gvpWrocEgF580C492ea8yWt9Tgk4Irs75+q3vJljHN3b/4PfNz8ZmewyGH8iBpLiXEXH
         BWO+y3O54Uf3SaSFshved77FRDYDYBHpnn6PpRSv+3pnqlQqISob8xdt0BbGC6sMPERc
         AOiw==
X-Gm-Message-State: AOJu0Yx8nxTjplybzkV1Zt4iGragASO+8z+91MKmXJCRblp5vsxNxHYc
	+S68pLHrQhkbQC4kbRamAdN4UeFB1SA7qBoe/G+rZaKJz5QvI84Zm9Ak
X-Gm-Gg: ASbGnctwu9eLSDdrRIp3nFpLaJSLnXUMHHkzk0w6CkV/tNx0+3xUxSaEOoiKYOFnLbe
	kdVBC8ahUEWPEtlCMA10a2k5Oi4x/vw2gP0P8W0a5mve09RAzVaLLTmK5aOPWJA1XAFi0YesvTD
	DIqsl3rlsXDM1DvcNBHho3wJ/CCx7wUfFdJj+6X2okrS6yzl1m+yDzIlnZQ/ikv3T6bU07mORcc
	6bKPzWvrU/etMW46qFd8nRr0YASAPc9y5f7TENkmk7psd6tpyv2ZwiGCwF0L3eIznCCn8sUGguc
	p2mNh93mWgHqyux2nEGBXM7+7047xzAbmsS6NHrxUCPrnaO7fD/uPw==
X-Google-Smtp-Source: AGHT+IFZrfkgUJN5jm8WAM2iEtmNiaADUrBNprx8IqAhMpM8TW7EE5O3wTkSiStYMKRPFvbCmXEUag==
X-Received: by 2002:a05:6a21:4006:b0:1f5:8655:3282 with SMTP id adf61e73a8af0-2016ce2fec5mr1402256637.42.1744263214804;
        Wed, 09 Apr 2025 22:33:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.43.247.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1e69b10sm2348105b3a.169.2025.04.09.22.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 22:33:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1744257362.git.tanggeliang@kylinos.cn>
References: <cover.1744257362.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/2] only remove entry from
 local_addr_list when sending a REMOVE_ADDR
Message-ID: <8d24e1c4-8fd2-bac3-8a22-9ef6647c039e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Apr 2025 05:33:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/14372398128

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9ed63bffbd1c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D951834


If there are some issues, you can reproduce them using the same =
environment as
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
