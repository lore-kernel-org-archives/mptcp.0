Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7F37C
	for <mptcp@lists.linux.dev>; Thu, 16 May 2024 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715818652; cv=none; b=M+yabBob2mhQDuS9QmYzQPbGkXz8n0EC/8M+RUiHa7XkjHtKJBdwbNGXSo+cm5Q2m65Z9JOgMgztS8tZqlGOhkArEE8ANvsM2aZPVyOBfZTfIYcorSs4ymr0hMWtktix1ZS6fLNe++taOAy99C4Ej/50KPTrlkjmiSZIDgsiO/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715818652; c=relaxed/simple;
	bh=eRgukdsUbN0KNkVuu5wUfeFdjmj5S5aB2dkjIs4O8ik=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=GxBgsCYxKiKlwib/p1w584buDoVp4X7LboQbzCedVfy1bJnvooHfYithaWySIrtCk4RJX1NiY3IBoZoAAhXT5qnlLMjdDKUrQ8qJgXQuElmJ0QDnoV2JfuvhVxC3oFChT5Yj3rrnhJiqPSRBpyIFULy652RQxyBs2ecmTwuJbtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNHdzG80; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNHdzG80"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f44d2b3130so6276803b3a.2
        for <mptcp@lists.linux.dev>; Wed, 15 May 2024 17:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715818651; x=1716423451; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkQcM6C9Tw+opnzb5ufbYjlbKC38Z5FBJWH519323Xw=;
        b=bNHdzG80HuDSDiS+hCfzwHccn9CBiA1pa+lam/T5PZfKntAfpayy7IeWuWnFy/OIDy
         GIlZlaa7r/CwbfTpnTlkdvQ+yiFPlEjoc56ZY5VMWRS1Xd92rMoHaODeL2859zRlWe3W
         UdlmVRnxklYV4M/Y+vB25SCYYFJjWE/zK6HRv8wk2YRd1MSLx0myATeQ8N5x7/aTrpTn
         tOVVdpw0IU7jz6TeboP8CZjbl6Z1ZtkOzkm4ef0YdSwMPeKelgYsab+vz60eV2Ed2Mm3
         gCi7S1E7wGkfRNGloBn/LQ7ktYYfM7i/Gv9BvlJs3AVfErBcu48ELfiKx3m9qR4HL696
         f7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715818651; x=1716423451;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EkQcM6C9Tw+opnzb5ufbYjlbKC38Z5FBJWH519323Xw=;
        b=nTzFSKtidXLMIQwOIZpCDSg87HuKfuGQxuWGLYuxhZDVh9CK6V5qKLemYS/eMH7lLk
         IAn2VjrN+fvCxclU5Du/iFM9HfIsaqOMPQtMOaBxIh1TZQaVNnM4LMGEUviD/7K5KFUv
         LafUbF3teiG7fvXsz0ZD4F9SoYhkflz3JXtSRO6oTIIOjlbeQkd4TiGigosj0+UhA66n
         ZJKNPxYf7qiaU/0OPqL7V2ClM+qCPYn//xAjLj3zbnnZxQ5yYoQAhcC4m3OMHEbyYYnZ
         WJL672vxCdgT/EV8YA7ywL2dwWuWTpCnCIHJqiKL/e+C8GMHwpGjfs5+ud5uLE8CTKHx
         tzmQ==
X-Gm-Message-State: AOJu0YwTqfWrGJVX3yP0ndtHRvrpg5LXq2IMOBI6fSkDiyDdVrCuKb0Y
	vcvo0nqwoXH8QMAxKpNw4YWx1QYgdd15QRKk7vNZ5AtWkxqj7DpGASf/
X-Google-Smtp-Source: AGHT+IHgk/yhgA7gFNHnVi6Uunzo1lbgMGP6TMg+f8OTfnMVuvR5KD4NUrILVMjn5E6eypmZ72eR9w==
X-Received: by 2002:a05:6a21:819e:b0:1ae:3f36:28cf with SMTP id adf61e73a8af0-1afde1df2a8mr15535957637.56.1715818650496;
        Wed, 15 May 2024 17:17:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2b48sm11752877b3a.156.2024.05.15.17.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 17:17:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <8e5cdb8e4eb6d964ec3ffe961ab8e65b8788584f.1715815795.git.tanggeliang@kylinos.cn>
References:
 <8e5cdb8e4eb6d964ec3ffe961ab8e65b8788584f.1715815795.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH v2] checkpatch: skip warnings for symbol links
Message-ID: <6e6001f7-3185-dd6f-9f6e-dd4e7157a09a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 May 2024 00:17:29 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9104105207

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e7d456b6f3b0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D853526


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
