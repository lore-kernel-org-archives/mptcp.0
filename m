Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECED1FDE31
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743943; cv=none; b=L3TF70lKl9ws0ruZe3z7a4JtwZag9si2sf7Kgf1OI+1oSgLfDO8xtQbyD9/MCd0d3OuOLS0Y/NX9KGBCdtrPFk62rtB3Ps5566drUMuXomWlGaXLmB6Dv//ndF7l+JJIH31gsuPC5Z1dOzB34Km/Bl4ds66XlRuY/3guPkPlAFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743943; c=relaxed/simple;
	bh=P0HYpN2Bq2y3+GqoiQ8eF9XcEeW89TbrAiU8xBZt+1c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=aaNkUAXzjHkjfCzIgq8F5g/Rmqk6IPe5Zf0tp3H2XowYOjBB04K8K0i6rhNR/PLPP7t81hj1A+pTxMk/I4q2Gu9EqvSE/kley1OZqazjld7zwqbxFuh6T5u51pw2DC8mDzM7MNKgsrH73KkznzPEh3mllRef7Sr9JSLNVkcMmtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ap2MUB6l; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ap2MUB6l"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-516cc597842so22047791cf.0
        for <mptcp@lists.linux.dev>; Mon, 25 May 2026 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779743941; x=1780348741; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOjfz8FvfhD9uwKjkHSTEGLqGrIPzhsOccKZ7bToMUo=;
        b=Ap2MUB6lIN6knhoylqUWKdamZsEj61eQ5dlQ7VFkVKluPMJU/sc0459f3yESti6ext
         wFlUdnkuWdpy2qpJ6WReio2Nl4qEjEvvn1GrqRGHLwhWSAJNShKtYaXeZeynTXksimSB
         Cb3/jqAnP44K7oFXFbrYj6GbvHNTwbdmen8Fu4B4oPDItYcy5quhegscrune+eLt5Sqn
         315cg14yYZMg/VVL2v3mWsFogJ438xY9yBXHhePNOhK8BQkq30TSpwwYENspnpFGNj3o
         /gFhDa/8470Gb9wnodBhjUZnbvVGerqOb+J0bhVvV9Wo1JJ5K/fYM7gUtWJHsTSGSVKe
         1w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779743941; x=1780348741;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOjfz8FvfhD9uwKjkHSTEGLqGrIPzhsOccKZ7bToMUo=;
        b=k8jQOgSydRVd/isGsG/bVRpFG2NjJ1bM/dF6AZcRZN/d2wXSGEGQSa/IOpQhXaPjfz
         HrSTIOpjF7r7L12kD958FrI6HoFwQoYQEvEKm35jeE1+IqAZ0zbdFM9aqsk5kcH+YNTh
         Kx7J8pZpLrLB4Bw9w3EO5zB9UOFWuHrrzBg47rh1P6uIj9d0S1p2hmDpCl0D7oern0QL
         vZzX1CTXL4X4N1ThKBkW+G3fkSFmwYmobMW+818Nxi8AvFfJfvn8RouuzVtH6AUI5Tzl
         kvEuC0dxZSzCgYJNGUCczhvh9ZXUBqYeSiPGF97W5v79xpOB4Ump/M9dK7WaA9hME7f3
         QFuQ==
X-Gm-Message-State: AOJu0YyMSM3MCSX/vHIExM5ISnWN8rlcfkfB05Zx3HcaDprpI4AaUGbw
	q8eyN+VQnopJfcsmckAvxMfnYZaJO+wk9mHlOW16A6rlSSDz7KZk1h4=
X-Gm-Gg: Acq92OEY8vZit0EiXNO/D0XoGIu95SRIMHy6l0V96oF/WMsfnH8ni82EyFlOwr535Hw
	OtDA7sFUlgMC/ZlqnXHrdWJh0yUfp8EF5zQbFs9ZPYEYOcSB7hd+rlCRzsj+YuaJ1YbXG4qKnMP
	cVDOZlVcDMP0YycR/WmQ0sCXAct8MZr0chNU34hMfpP9hUmphmDSul+/AzHVqIO8P9Whb5tkCKD
	gIEqiVdGlR4URflbqN9IR7aSz7A/FqRWbxpld5V6QCMyx7x4Wo0pOcoThPmZi5BpUoui9QJpjrX
	xI5cc+uHjLAJ/rsoLkNJKLKnCY96rOoYQDoX+K9yBOhgFry9oIM8KPU2Vd5PPvlPK0Amfha2jyh
	AsQ3e/PGgJPjg53D+onmr3Rou85M65KYLTGQApYaniJlYVT6xkNm4OnQsXfBizUVtduRzewxDlg
	oPZ/RXD7p0PC27gtjcosUreUrN2ApoWWYQ8jFxTQ==
X-Received: by 2002:a05:622a:94:b0:516:dd65:21b2 with SMTP id d75a77b69052e-516dd6524d0mr179133141cf.50.1779743941200;
        Mon, 25 May 2026 14:19:01 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.176.196])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8d07bdbsm99458581cf.27.2026.05.25.14.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 14:19:00 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260525194828.1137119-1-shardul.b@mpiricsoftware.com>
References: <20260525194828.1137119-1-shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-net v3] mptcp: fix divide-by-zero in
 __mptcp_push_pending close path
Message-ID: <cd1fd42a-5a45-6d8c-051a-fc1be8e613c7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 21:19:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/26417985120

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a19f79759720
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1100586


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
