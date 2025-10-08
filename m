Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65429D27E
	for <mptcp@lists.linux.dev>; Wed,  8 Oct 2025 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938165; cv=none; b=Kn7vpfUefQsOBd+VRL4Zh1IlcZz8CsGNtmhoGV8LqWvzo5moz4F3VecugJQuuH0yMaRVZ+cOaj5b1Srq4+JB7pLVoLgngDWaoRQB7bFEuyxb2o3rUuKhSzII6Ro/jJgWGagOGGzQQtnC3vipkCfVD//0S1n6cV3VTFLFWC5oUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938165; c=relaxed/simple;
	bh=AECfk0lwLnGYNR/SxH5QYhinTW8ihVGCUkXq6O5lIsM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FSJ7Ctxi/Yr1Fkdd/fMRlbvF/AmgaduP8rvr/YcGLMeigQbEGkzpL/iwbQpFWfMG2eNsdvFy2iELVwNkKlQr0tm4WMCGt65CbIvgAemhm81stBKAwpG7YFIza+vOySFElKmIg6ZdjKtnI+TJ2b0kHAR2VbWaHh2E2IplJnI+g7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPScmjwl; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPScmjwl"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-91fbba9a8f5so626230139f.0
        for <mptcp@lists.linux.dev>; Wed, 08 Oct 2025 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759938162; x=1760542962; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRJMSiEgUMkMJH0qBBoLQzPGVXd0Boqyg3c/YU6p2/E=;
        b=YPScmjwl45V3YtRZ/XtBbsfbQ26zCSbrcFL1YQoSDJSVfR/8t/RUzPrJV7yQxFGqqx
         8WwxsJDu+gv5K3DsrOQytQ9jceaTVG0r4SbY0ycGE/06jZ58oPGm6OHaSkEJ913ZtCmE
         +NaresWwhDVP/SwSIRjUPU9fq8rhaCpu9O4zOrJApP+rEP64nt5/M1Fb/x79jdmAARxV
         KxycVMqxJPDxqiILNxB+0+N+Th/Rtju3F2SRze5iGsED2gCHEuKFDqPCr851/mF6CEwn
         lHAMsKE/L52Rmmy8unEqt1BN1qXIq0GDuLltu2z+3R6IypT4lyO5UiJGoMiVPP3O5hw5
         cGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938162; x=1760542962;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TRJMSiEgUMkMJH0qBBoLQzPGVXd0Boqyg3c/YU6p2/E=;
        b=vNQmKUTCigQUmnTwVWHf3Geh2le4AC0XsQA1we51YLKLh1KINBa0mBW3+kFH+j9dQB
         W0AbeDAfiuWHoldNMGFpN1xJMf7nzHm7AV2WRW5FHGqi/Crw0+Mwc1dKJxHBUG4pQ4lY
         Dn247sYwTPgOr3vxvGpzBx6DTbYYjWcDasW/ESfgciSmwIiKZxSVwcvnsR/9UfVUbKnK
         2w3mPBh0pv5MpzQ7IwIEpDi5OB+hLFAxcIm8/TOuIR2QM9zK31JmgqAXGvecY7hUzwut
         THoFicPz/X/ggnlxw0UGBs6ka9upgdHjn5/uE4GbzcU+kH9c3nNHaP4jIHNiRZHJAXEc
         ONzw==
X-Gm-Message-State: AOJu0YyrPHt/3+0HjM6iCWnlMYienKzOS1I+u5OefjzDW/uZ9M69Eo/V
	bJIpC5vbDIrSAxF/A947lZoMCfVTzmJqL8buBbNAZBjdWwGfxHeF0XfGoSHN
X-Gm-Gg: ASbGncsq+6mWKImvJAdJ5Yv77EBcyzyn8Ykdqkcw4IrPbkHPIe5f6+ETKWR7CXN82p6
	hgGrm9nfdYQyanF/cN+vendT0g+EJfG0rqZDMaykEB07h1tZ7RWJcYZTQrWiXm6VtkckuF6UGq6
	fu4o2q85B+9OjyOXGlF6sDJQpp7RI1W0JynW1Mb0aXsr8ZRRfqIUHFqowkaMhmCVwH5HqfUEVFd
	x3OWLGbqfKatQpv64MGPoIHdhrTS7YAzyUXfNt5kcrD5OcbuljRgYrl5jaE0y6vfiit9RmTNWvg
	Ms29CY/WlzDkbKy4tKnDKwec2q51T9hwzPdJ7KPRRW8zLsj503fXZYc2+rpZZ8JzMRrlT3/DaDZ
	a1h65bFjZOFAE6DUsr69wyi5zW7aDgL0s7FvjHaKvC5DnjmcS91YJk8fSmKjc
X-Google-Smtp-Source: AGHT+IHGJYCbj6vEVyDOm6aiiVG/vB3MjLwTIrhQlzcMfvQ397umqMBH/+xnHtKKNekawxE9nW7yNg==
X-Received: by 2002:a05:6e02:2143:b0:42d:8c07:70d2 with SMTP id e9e14a558f8ab-42f8736905dmr41267315ab.11.1759938162471;
        Wed, 08 Oct 2025 08:42:42 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.167.81])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ebc8433sm7223346173.41.2025.10.08.08.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:42:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
Subject: Re: [PATCH mptcp-net 0/7] mptcp: pm: in-kernel: C-flag: handle
 late ADD_ADDR + misc.
Message-ID: <01eae48e-4696-9fe7-30f1-fad41140c527@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Oct 2025 15:42:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/18347885638

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/51b6ddb50104
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1009412


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
