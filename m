Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F93362139
	for <mptcp@lists.linux.dev>; Thu, 15 Jan 2026 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472561; cv=none; b=qvozL5FzSeYm6Dg1zHy0THBp1rDvq1NyKC8kW6S9iU5LY8UzAMyj4Z7i565f9P8aS+VJFZZrpnyNCh0uMf4cBejPGaAt6X2mauTIRw2Pr7QEx5ahhA3H84ECoViJXw8lL8iAOcNmRo8Yg32z4hfAXqXKG/yBD64A/+MnyZnc1Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472561; c=relaxed/simple;
	bh=O/h8J3FYgTvaflhDRBLc8V/a2hCZEAwTZtrQBJU9ROo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=BTdkT0VfbhJT9CCOZ40cT0sotPYFea+RUnlKygvHkCvJBPf91n5KdHUIRBLAhNGVe/4xmDcUuUBN25jOOCxejW9YNcJLGOaltE5dSeSys3o+73z7oiUu2tGiDcAl5d2KPbji7w47gybZ9d5tRfjCHciXbnwjvaTe7mMhe8oXGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nprltuRj; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nprltuRj"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-501488a12cbso8183881cf.3
        for <mptcp@lists.linux.dev>; Thu, 15 Jan 2026 02:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768472556; x=1769077356; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ydd2SsH9EPD6uM9ukgCfSF9ZZhA2BcGals9ZXdE7VuY=;
        b=nprltuRjqu2Ag2OBxjHtNIYHnggrgPWp7r0sYP+PMwQ7uPIPurj407so6CkNjPLbrF
         WkvZrIa+MP53bbgS5JI7C6Vl9vQheqHnJJKf1jU9Sqm8V6y/N6ffbgnP5VK8GTVR1BTs
         TSr9R81Hse1a40dXiyhoKNWYk4pPxpPXIQAJuW4IZdDQq96J2EWQiT1lDRnJwdydGXcX
         WfV0Taf4TaBJvzW/C7og9i3DAUYZJDR3fB6Xs3zBizkHcUywsqLgVpSVheC6ZUGkruQX
         G/y4dSBW4Hc1nQtkIngtL0SdigAjsWcXrgXBR4x7jXE8STzIPozCynqgsiwA6rxvgIRR
         WO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472556; x=1769077356;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ydd2SsH9EPD6uM9ukgCfSF9ZZhA2BcGals9ZXdE7VuY=;
        b=lZ4EBR+hsWcKwphVm3UGzXH0bIN8nymqf+dxtJCwsfSMvgxyLVdsdrEWB7UQaYOT2w
         QMDt/HkM0gWDFzFEvO7YzDq/b7UyK1JV4Yt3Q4WMYox8lTcrtp4kKPTYwgBRxagRGLiT
         dZNbGwGtu/Qjhza7jV3ROrAyhrUr4LAGyYUuVzRjYxNeXOPnsRlXAg8kvvlz6nGGvYdV
         sxY0NlUPjYOf9BIF5m2Z97DSq1fn/eVUmAQ7OXOBYSFJpWCqqKNXKOcXqfxevODNp2Rr
         kKL7v2gKVbdoTxoe2CHl0aazMjD86+u3US5Ola3JaWOYOhiItx3teo6G5ZD6QRgqtguG
         Ll4A==
X-Gm-Message-State: AOJu0YyzxwG+tBUmXHuLskBTcRVy7IVzPqAA2fxwb5cVaWbKLUqqSMiS
	Bfkp9TWVgjujUn0vLjITREMQmcb/mPPtbQfL315l3ItIsZ9VTLXI/uo2tBD80q8=
X-Gm-Gg: AY/fxX5eKtz42Jy8DMboC3ouYBrp2Ex4Ls/KQCF4mlWwDktSXkIA1tbyhxcfmpocfrT
	p78bTTCuC0nZPHvCeBOOs9dmdNc+lCzol73iTqfQBzYCMxIPWNatP76zwWcrZSxgFAIw7dF8SmE
	+xhvIR3ARjQa+VOz5+ENLxO0ruT6Os1bk8ZAVSNFVyRY0GvdNYVRkt+HOAKg6Na/dVdjxcC59UG
	8nKgtzeHVvd0J4Zb+WynGjw1+yRywWnV1vrO2Psc14YumCok7Q4ctTGL+JVQ6XQd9nfTYUbKaDi
	eArixpeKnhYYshEgR/PdMTZU1LXZwzLLL1LU5cR6JoF4/1n0T7eLowIpN2VPMnDtJ2iYvbQmlE6
	W2hLQv3VbJ5etV4mxo/2t+7HcKxD2ygcWf1QIzp+aDZYkMwHFQWHXQsPBN1qZt1hQJa8RuFWrYE
	nBv8VO4mADTrKE6+SXg5g5DXk=
X-Received: by 2002:a05:622a:451:b0:502:9e4c:2670 with SMTP id d75a77b69052e-5029e4c2d43mr2855281cf.27.1768472556501;
        Thu, 15 Jan 2026 02:22:36 -0800 (PST)
Received: from [127.0.0.1] ([64.236.161.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077267e14sm196688796d6.49.2026.01.15.02.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:22:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2fa14a04f5287c956a1112cef8cdfb2c86931d2d.1768467496.git.tanggeliang@kylinos.cn>
References:
 <2fa14a04f5287c956a1112cef8cdfb2c86931d2d.1768467496.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH net-next v2] selftests: tls: use mkstemp instead of
 open(O_TMPFILE)
Message-ID: <2049bef0-6cdb-8b8c-9ab2-f073324d0806@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Jan 2026 10:22:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_add_addr =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Critical: 5 Call=
 Trace(s) - Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-debug =
(only bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/21026154890

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4a8b2ed1da3d
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1042708


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
