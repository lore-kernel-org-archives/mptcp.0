Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1361E47A9
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039672; cv=none; b=s/7iOj0WcLz7rxyaTFf3l4LzFWh0CcaqNt9snIphibZfLKJNisAXdCeWNr+ViTdVIOCIBJ8csrVi9tr/GsftH0NpTcYCWUZxnYOsjPopUREl+Wx9bNBDHjhvXQJMrJJJpXvByPS4C9S5kaYlqqVWxwO8Jz+6qR4HNd1SlIyR+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039672; c=relaxed/simple;
	bh=4ddmC8ZkWZagwXfjW5PGfzFSaKpEygJCSUVl4f6SFx0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=rqCATjaeYH3OFnfOZHeAnelX17JIrkd6W3Ht69dPML7Ng8HKNC/IjCmIg5dX5M1EcpmeqcjjWxOsIGOtBVj1s78Y6JQdqZdtGEsX7k+oa3j7OVD2dQlw75m1J+4HQeSsz3QpJHETT/9ImgM+PdIYuMP5IVqHDwZYScsp0MVohCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haGu7hPn; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haGu7hPn"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0818add57so62037185a.3
        for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 00:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740039669; x=1740644469; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S70CxemqNHx+f2QsUOvCVvFLPQWXtUU5bgbvpxQDvuQ=;
        b=haGu7hPnxBAFVDaxR68q0FcUsSXaUeX7+cyZKF7iM+O+8IGu50Jj2H26dP3FvNcWYL
         apSO7+IiahR42BMnlOxTGeuj9CMFaEDsAsha37LECjD7689+rTwGOKTg0Vl+SS861xOZ
         RNXuLKCl9dqL3SKvJaoukoZTB4D4DtKK3tzCrBzyfXdAOC9+Uj6EPDD4hVTcFRjssPqY
         dtGrINXAkD4lmWJjSqIPN9AnWb+/0WG9lQDMrW7NZmjhhPZE+KTliod6dlJ4k97pVG29
         85mOVbypaAsQbHj6kRveDFdJ9pbrn98Tyr9Cs6ETfQOMvFAtkZPj3n9EyKAyiGloiXYT
         WeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740039669; x=1740644469;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S70CxemqNHx+f2QsUOvCVvFLPQWXtUU5bgbvpxQDvuQ=;
        b=LCS4WH+E7U+IqRuTlgvr0ehe7qDmIsEyZqLhoBg3jbjBPn/nkR7BOXf4ctpkIgxIZY
         fG3rzqFVwZi03GuruSnoSpkVQ28ij85kly7N0ToA/6rbDcKUk7Ydm0JDSQunJmpaYSZ0
         Op2roTuq4db7Vd7RkBoUBhpW6fYpsjbXoggk3PtJbv4E7IXnPpweh7H9i3DyrzkvZA05
         IwqxGXE6bnoUHPXaZgVdzRa5bQZQgPCMjPzopv+rOjoqablnDVaPvjMwyzCx8IMAMBDV
         W0eu1ngfF0oAmu+bmaUysOrqtJ85MhtaBqC2OGrSSEPB2CaIKbILnOlYsZhj61deL98f
         xbQA==
X-Gm-Message-State: AOJu0Yxg8t4ZEZoyI+lVJxE0uW4NcW77NuV1RxpWiVPjSEptgJgS/N/u
	BaR5c87GBaRwxgytQdj2SVQrsb8Zl9h6XPEGlDeA4MkhoIqMPLZxqNIv
X-Gm-Gg: ASbGncuqmo6AVWfV0jBATkwm/TgNgLo0LiyypFGJClMoY7Fdxdzzrdc6dlk739HfIrs
	K6SHmbMQ5JVjHfZmcVE5El0c5FzHSZP6hCg2UHOVwUvOPFQgnIUDAot90OQLFPP4NKDz6oGJhyc
	ExbNMbcbuhSNDbrNce4b/jniz7tUx2cIUuApNhdfQRBZaDfMesIZfhL2P94tRV76d/M4w6HFD6V
	Yi6BeHcuHsZ64EnbAqhNJEvnG2KB0ciHlnR7F/l5/aLp+VqfSR6Gey3UwWvlKvlLfgklcExaeod
	GRj1P2493+0Dpb4Gva2hXA7cwUg=
X-Google-Smtp-Source: AGHT+IGVjHx87/bZLXEnFpLX3ivHUCTsyLe3GykuU/wHpGS21tardGhvlyEHHu3cBe0d+nCa8ml6zQ==
X-Received: by 2002:a05:620a:4482:b0:7c0:a532:c398 with SMTP id af79cd13be357-7c0a532c5dfmr2056247185a.54.1740039669166;
        Thu, 20 Feb 2025 00:21:09 -0800 (PST)
Received: from [127.0.0.1] ([20.246.78.61])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a46dbcdcsm384451785a.106.2025.02.20.00.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:21:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740035000.git.yangang@kylinos.cn>
References: <cover.1740035000.git.yangang@kylinos.cn>
Subject: Re: [mptcp-next v2 0/2] selftests: mptcp: add tests for increasing
Message-ID: <b825fa40-94ad-23e0-0be7-55f074b67ec4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Feb 2025 08:21:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

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
uns/13430040097

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3073cb86b512
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D935869


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
