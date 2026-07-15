Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B6F334692
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115337; cv=none; b=ZqqXuII/lm1RootjrlbOb5gBQvpjy3dHzyFy9Ll31YrYgaPcCUEBBcOkRu1H2/edxA2IVsa8PRVAIHbQ9ad8lGSUVBs5PsDu8Ev08Myl0ydLpR4aaT0OS0fZNQUq00Mz+gLNcYEYyj+XTonZLc3r8YvNV/I5qLgSzxMkBfcdJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115337; c=relaxed/simple;
	bh=k5cZ85hv8wADyLQoc8FmQn7WG9qsvhKip/aKixe1VSA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=F1lDgvNq4JOGBCRg2Udyhc7PDLokhzw472jc56mvYTU22P82wf9gBgwQl0DImiI+P+2Vwl5E4kSiryMQ3n5UisvXAxLnaqGhsszWCz9hCJnwdJ/zEeaIKXOFcCUYjSM+V46068ttfDUtWDohy7x6xR7GzRswiC/uA0z4guS3zn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feezR0m0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feezR0m0"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9aea40d799so928456a12.0
        for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 04:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784115333; x=1784720133; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mnzX5owLgTVPtZt7vlvCh1w1XFCjjdiYuwHbJC3ImBU=;
        b=feezR0m0ITgZpDwhSXGd1mpyHAvL30W6hCuZPQim2aGOD0Q1BIp5YXWS6SUrAKMuU1
         fNhFOxN5JBWNUy1xf1ZZf1hA11vsMMsDPWxypl/JwxzmRKS1TyqnAuz5PgZ+JLBuIIZI
         PZ388s3nJPCbVjPJ+ovAcMM7PWe8ZOuw+y5UKhaPjcZBNa6IciB1VsntNaSMX+eUKBVS
         /h3B107EpT2EnSzsWirOq8DXI0JKCfK1DsaGnMJOWR66OMr/aP2r+6cfN6KC8YHhES2y
         Bkv8/DA1jiavrhxy9puafCaFFDEhe9rLYw8IV4rQNr0e6Cb+liKlsVMklorLCzf9AtJZ
         1V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784115333; x=1784720133;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mnzX5owLgTVPtZt7vlvCh1w1XFCjjdiYuwHbJC3ImBU=;
        b=GLOFMTZc17dp+tqFqoIaZnic5jYHYH/J06sRmPo7dI65TCyrn2fCrJ8p4NVhv1NqGI
         h/RobVTgyrSpumiJIjsbFtcAP53F6jawNpOg/H8eK/YV2sqBEKPByeQipTPXWS9JnmoH
         XC4tbVnZ54nUH/Koij/mKddxL0N7iiNZKwcLSCdVFeMR4fmphyiFKrU1yfJxkp3Wza6U
         P3Hsujbu8nRRmgHggMN7qCd1apIfvZ0le42UjBtG4z/vITvwxVkKEGmNkaykdpdLux26
         Qh/nZVzfEiDU0RTeSqZ61wQ+R3raHPVHBIoSEgoZZj0wAA8R8IwGUXiYVfo0jwcUi0MU
         2Mpg==
X-Gm-Message-State: AOJu0YwMu83Um60sURCEaWHFjHZkKJKpiBSNVoxl0ydpbxts+aL+Kp5Y
	IfwyNz6wI0UFrPqcuU8mHt6+6MdPbVRmKnDwOWLf3Xd41kWV+CJFTHiv1g8/
X-Gm-Gg: AfdE7cmFcE80/N0VisjHwhmUdiBRoANgUv+azqmcDQxuDzuGBPxwVKkYJWwRKp9CLuZ
	f2k5g0RHjS217vpIIQhAeyleR8XRMEIA3O4ThAHU+0PdfxWbXxNowCNQXUMxdciemMdh5SbASSU
	okGFSQcpvaxaiGfyNtN+xhAm0sWoj/jNv3pntP3OmOYHncVZaC1sK4LWGgJo4NoVSfrn7DmQbRy
	CByxaaGWny+e87ok1Ty1r6EH7xTz7U6DU3QfAaOKhMdo/OFT0zrRJ3vlMcGLpQ2rPvEsk7FsVBx
	zZvnLsOD6tIFC72o0R7lWdqP60OczgOMvv/Y/yBYRq5UeeVdtmsNqFe0hwQi3cd4fMZNg0rj77A
	LcmloXKiwgJsEMqBmqeJMaLzE8raPiFbCEHzuyXWfmDdApjT7jdUs3Os9Ul9DRWktW0cW2MvAnU
	vDDfQaUVdsL9IIMx5mRBgIqUr06xHP7+wrvMRYWuw=
X-Received: by 2002:a05:6a21:4d8f:b0:3c0:9c1a:894f with SMTP id adf61e73a8af0-3c110b33403mr19342727637.71.1784115333411;
        Wed, 15 Jul 2026 04:35:33 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.229])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd428b2d3sm648589c88.5.2026.07.15.04.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 04:35:32 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260715101148.2601045-1-kalpan.jani@mpiricsoftware.com>
References: <20260715101148.2601045-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next 0/2] mptcp: sched: let schedulers mark a
 subflow to avoid
Message-ID: <50cfda78-fed5-c866-2690-97167cab686e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 11:35:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/294094=
72750

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/11781b9663bb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1128052


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
