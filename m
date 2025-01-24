Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B291D3595A
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709630; cv=none; b=ahsTnBlMsJ19ElIC9piljrQXN8sgUTDeCyEOE9w5RS7Ro8KzvApdFbamHBKtCi09zfsK3c0CIM7FRmVfcPtLEKMVX0WLNO6XbEn2iARXMtd6CSQLruQQ2VZ/230D9s3PpeHnKBP/T5x4WmRdZKK7FC0A14dGdT5iJV9xF3QmYAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709630; c=relaxed/simple;
	bh=fxVgOrwkLjBPo2cFNIQMKfm4V4s33x1/pT4MqbfjKXU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=cO+WLciIuswgQ7YvRj/OuHyh2p+ZT4lYcjWHMkGsfvi0d3s+v0rRHZrB3rd4rPanPiBjHZ2IdQI0E26ezPijxRP+88MrZupTXvGHQ9XUNuENL55yqugWXJk72LwEv5i4oG2hXcUmlj2e1SvXS7kh27eeDhdsPzF7Cw/IuVyk9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAI85I5R; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAI85I5R"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4678cd314b6so17791721cf.3
        for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 01:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737709627; x=1738314427; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvKi2Sg9w9USPW1b5eaCsbdX0caCY2sLyYB/UZF/djM=;
        b=cAI85I5RrIos+5RFjiw4zAKfc6OYfNoDCzWQhvly1CdYG45erGwFUkIM7Tbd5wwHX3
         pn1rg0X4I+Ug5m78tShfXn2/PkZ49iXcrXRkdFVhs4tA9pFuMJJVXSShDRAJlKboK2iB
         MVkSUjZNSvq8ARnqdIxjW+K5e/7sOwqri3zLSQaRuNXlR96AwwE02dYspxNqYx8l6Bhk
         ahSNtQV6z7XTWTo/CyjlzqkA0EJl40kVJs8sJu457OhqcFR4L5dJ/QTEwpI1vuzJHaao
         DUePoLzI6ZfaZ5fIhCORJqySCNyDRDFA4UsPi/A8WSFnHbn6FrVy5FZqNmLvbvUXop5q
         Aa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709627; x=1738314427;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BvKi2Sg9w9USPW1b5eaCsbdX0caCY2sLyYB/UZF/djM=;
        b=Gxk71w5bmrDmGvejwjFQe43qIS8rA8LFBAbZpLOweypQU7BDYwRKxKTjFWq3JNDS/8
         fps19IULE7v49l5v12UNZdtfMtCiJDedupCbypEhPA4l0XnTyU3wBYiv8VOfW1FBM3D9
         YrUtfK0O1OvNYqlz4CNLC8Gmnb/+v3P+v20XOdJSOLIKMfCuXcAdKlDS0IDwPXg8pAur
         C9zqVBXa08vz4xLH5N+9VKmeyNPpIwkWvQWkV45T7GdDAcfc2hDT9dfbECgkFEnNxtF+
         brBs8sblRxinE3PaaltkkUWBkQ9L5Sz8qaRZnNQF5FBdxzLmqywYTZZX6dKveD4Hqt9G
         bAdQ==
X-Gm-Message-State: AOJu0Yx4R9lC1dgSebY8FANdPlmW2db5jvi5XguU6KGmNbFDV4q4y+J6
	MavlMrIKBIXo2d3CcYTLjYNXyY2MpVgNX840z1KVzy6H0EKvJ7Mtu+SL
X-Gm-Gg: ASbGnct+3cvQr6KutlKKWmR8RZXMW19dwpQSNzfa92oB451plWvGL3MU9RSqIrdjUC4
	oIl3bA+Y6PVev1S+WAB4H6ONUJbM8Hot84Yb8cwBYQkF3rKyKAzUPg02GssB1cHTaFmtZTCg56v
	gB+V3JpCFlU3AE5HvVXXRnAB5qbg/OdteIkgWe0UaHOtAgfPq83wXFUQWAwaUJGdcQErylpjT6z
	P1UYZw3l5381acofAv4ldPB8i6DShiEOucc7mlkg+XeTWRQ22sVDnbEpNnKHasXiQFKVZZeo/xJ
	SV90P8iTjAgv9+lT
X-Google-Smtp-Source: AGHT+IH/sD+J/lIamCK9LyExHsoecdq/8pEw2H4NvO8YJqaJLo5D71HCK/HSGlv2cOH2FKJpCXdqkA==
X-Received: by 2002:ac8:7115:0:b0:46e:23bc:8589 with SMTP id d75a77b69052e-46e23bc861bmr322594721cf.13.1737709627496;
        Fri, 24 Jan 2025 01:07:07 -0800 (PST)
Received: from [127.0.0.1] ([20.42.51.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e66b84c9esm7720751cf.66.2025.01.24.01.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:07:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1737702298.git.tanggeliang@kylinos.cn>
References: <cover.1737702298.git.tanggeliang@kylinos.cn>
Subject: Re: BPF path manager, part 3
Message-ID: <8485be69-123e-a010-f0de-828a640c2750@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jan 2025 09:07:05 +0000
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
Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Unstable: 1 failed test(s): bpftest_test_progs-cpuv4_mptcp =
=F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/action=
s/runs/12945359042

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6e73d43e9da0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D928039


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
