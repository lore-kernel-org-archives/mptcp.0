Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B372571A8
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427727; cv=none; b=h3HSnVQPI0K9OtJxlJXCk5UXf2PlYuuPQ+NZd4WZDnOvGA3z+fg5Fqw5xW7/xRtg+SZIcCBT8BZylJgkpRYMSJ0YpLB393DcnxOlAAcRdlAyT0UbAe5XfQfOjlD90h/1cpeUPHFx5EKPAkyPvOTJHuE0OU9bcX8AEPJgHJFvcf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427727; c=relaxed/simple;
	bh=j+AUmqKM3lKUK+xyoObTp0LkjTWxNEVCRer/9Jzn9og=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=RUv9TI3M0N/7TJ9eHonIdGziRcPzv47ZTDuquXrcHoNMd2f8N2CbnameIaz6GFaVOs9wnNHrkAnwZMv70FL8i+WoaqC3kQfZURY8/Z00uD0sq7tnauE8vUDWWorys1U/BwLHOGZnTlBz3vK0KO97kZJBGdKYeMP/Jo5ZHh/ouXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaX3u0C2; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaX3u0C2"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0848d475cso683209485a.2
        for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 12:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740427725; x=1741032525; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4QjcrIq9rq+FVwkQTIdJQitE18UcEhLBBzxYk+XMFA=;
        b=GaX3u0C2J3TGlMOzKTXpy8IHKx7J6CY7o8tx/Wl+vGHDLXCnwHWgH94JxYSDmz1H6O
         T3bSrx6azryHBHRg8dYgUQmcRqIbpAaLyODLbsOSfJ6yS/qWQK1Vlb3r9LUQmjyp5whK
         M/9R0MkJ19SXZjqIn3myDaQSQQzoucwgxSRzLNwLdYoM+bXRBfq9r8XNypo3ijn/b4nH
         iPgIcEJHVsQQjQv14TJI0DjpYHltqARTEOi3QSYc75Jk5Fy0GlxeFiZBw/p2pWga+wm0
         3Vry4fbW2WaTcX3WCm5hGlyQwEQSfGDRFb3uBstSExm3StEzQuxWEHQNHNzEG3Qq7n5k
         nG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740427725; x=1741032525;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T4QjcrIq9rq+FVwkQTIdJQitE18UcEhLBBzxYk+XMFA=;
        b=ci0yLajhJhNmcwFJI6m/PMWa9kFrbdYxZaPI0OqmVS542SH7AyRk+na3aw/qp0RZUi
         wAT7Z3EFKa6Kdx+I/RUiINf33jTGXFsk3txPW1/L8DKOAZNsiUVsPL5VTcODB7WQ5D6t
         vEGvX4PrFudveudPX9P104ZSO/Qd39IOiaWR4iaJpflPuT7voMh5dzI1Ohegx48h+49D
         WVNMhCc/ilXDtHbFw6IwobBk2PvqHtRi+er0hXavkWQfaCeUpM67qszu61YNhrcsns3r
         /3w5gEWCpiddGhtkOpkk/fk5G4EEAaBTkjI3qRFvf+w1Y+zae9fyd0ldqB9KLQVMttJ9
         Yh+Q==
X-Gm-Message-State: AOJu0YwmtDcpA7Ks13qMIZBjjcSROr5QL8QialevEk5saywoWWaxJdsV
	iho0tbmQaM3JtjJt0zMuUoBR09IvfLBL1hVWtnvHg/9f6UlVzxtK5QDJ838=
X-Gm-Gg: ASbGncsQO3pCFnYeUeN0gyltL9ti/5T1fWRw+bIjUSvD9S6FGhZWJxKID4CalTgsPXc
	a/oOC5QPzuNdBEzbEk8Mnk0H9ZhdnU9Mq3EgOclG4lECzbR8JXqjcSDzYHWXRFyxk8IlQl19yFj
	8+dDdsPzk1kj4Ys3wdDbMovngj2EJAOddff/EkJVpkSCqJZnsZw6v7L4FAx7wLPEkDPX1HThOgr
	ptW/UotiZwOp02gdzXiMYYXXSs7rF7u2AM6wrfjm4LVypJ0U2w06NxsXH92ErakrJy6YAOKfvFe
	aVuOFak0hisGQqa93VxcVkyJfFMkexoSHfsmsw==
X-Google-Smtp-Source: AGHT+IGx404Eit/jNz+gzqBLLTJHqw7lQ1CDD6BqsqumxQ2p1LaK2HTtXVdYJ9A2SJhMFCH61Iiv2Q==
X-Received: by 2002:a05:620a:4723:b0:7c0:97d7:27dd with SMTP id af79cd13be357-7c23c045c4amr82941485a.48.1740427725018;
        Mon, 24 Feb 2025 12:08:45 -0800 (PST)
Received: from [127.0.0.1] ([20.57.47.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b153fcesm814736d6.88.2025.02.24.12.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 12:08:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250224-mptcp-sft-diag-squash-v1-1-81eb3843fa53@kernel.org>
References: <20250224-mptcp-sft-diag-squash-v1-1-81eb3843fa53@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests=3A_mptcp=3A_add_a_test_for_?=
 =?UTF-8?Q?mptcp=5Fdiag=5Fdump=5Fone=22?=
Message-ID: <6545c4eb-036c-5272-7062-b2f60e5d0a11@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Feb 2025 20:08:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

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
uns/13505946352

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/11387f67c0cd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D937226


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
