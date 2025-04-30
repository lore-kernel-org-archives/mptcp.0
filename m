Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5492AF0E
	for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745998279; cv=none; b=GYRTwsQy8SdJqVmUVXRl+8ShQG1rmN6BEH1vedA2Kt1gW6MdRUFn6dvYbxCMrecsX28Fwo9f3OQVNfPgQ8Tksxby/JFavt40YlV3buDSXQsWCCsveMI07DgkztWdVRr6G7J6ZMEPlj8sksf1kB3/M2JVOe9T975Neg/+CyEWyZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745998279; c=relaxed/simple;
	bh=axAs+TJH7BAGANn4c9TaNEdxbpjRn/8AIgrbbkBeheA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=emj52khS4ya4WS4T343mQI7iI3ij9zWs1iIrkfsvBATGWgWuEece6L0pdZpleVb9EPdAk7Yntmbbj6ydCyAUfQQkZ73lCZQ3hvNb6GuPwJLLcFFneFFUZ6NW69iGRAN2lD6xsUYGPx8IQs02coLEAjyU97F042SgBxgyWqLYrJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlXjzper; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlXjzper"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7370a2d1981so5602965b3a.2
        for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 00:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745998277; x=1746603077; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAzKpt3oQ+0En2AOxCeCFwwPv/vqXc6nymLr7Vr/xX4=;
        b=IlXjzper5DVcd2pmL7fUg6ErDLfAdbNVmOtv6XnlrwDwJgsS0E3IQ0k4E7FHlV9sx9
         grnckVw6iR+YKpJ+DX04WR4Uf0CL+L4sMAw62PKRZGsVio9LjSKPpYNgWKefINay5BEr
         Yw3HPQVNZ6p2rwgIlHLxErmWipm9nGQxRnMfmYYwDKDixP717+gmXYc+BmE4RxLEuYue
         RtBr4RPhT+JhoVLtH/9QrVdiCCpfXwciH6bFxwH5u4vyiEn/aTXNo+I9k3uEs75fiqNI
         05jGh8k4QQiC8/L3At8tUSpclkhAtoMEjAKa51YW88zlzb6GiE9ub8qufgUZSvZ2t/5Q
         mUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745998277; x=1746603077;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAzKpt3oQ+0En2AOxCeCFwwPv/vqXc6nymLr7Vr/xX4=;
        b=HsjIaYwFvBJjy8gupzQg+v7wSq1YeLBraJVKPlKckjfhUmCZNrWzPQ522IpY1puH2A
         C2+8FSeIIRRPclKkDp+iILvv6bBjG+U9F6dAPnraJROOreXgMJ/Adgy7rkxi1ROUH3EW
         /a1fZr8scK/dRgKWgWrGPgOtUXAlOG3nbuys1vB4cjUYRBvn5VKLaVLD5OBYXZ9C1vA4
         n5o2bj2eRrY7iXQIx44rdTL0c62mxu8XPs7kCaqADD8Go+dtaDcTbcMz2uQHfDrFXsZ8
         id2htZJKWaykFkxRsQP885gWHzfAxVuZgMnpburqZJA4MFP05uFml149/zHAgsf03Yka
         TqhQ==
X-Gm-Message-State: AOJu0YynJNzVX2MBgyIqXBT1yOcCP+7vOSHTYnduytqKQzAnUlG5PqXl
	SSPHTGT9bfzDf9v2oZhuKwLjh/xmBLqMU62yry3VtH0lx62LzXxTbGaJ
X-Gm-Gg: ASbGncvU8q/Y+e7n68DBhE/n8HqH36bgJPD3ugRc6VIfmUktSeioqaR3RcVsNYdHwA7
	gKGhyoeNkMIPybeQZt+cM3snNmM999WYcU0sCGU/tuQHfLQ7ixb43juVG+ApEbxb34MsKsjWHve
	2DtXTuw9T7rZ/VY1yCb9SAvcnBY+pzAP6BL+6+JnrQyi8wTiepwEph/RjxNDF/64fpC/Wal7JwQ
	CnHLxFJOY1fMifISoooEuk7O9nN8SXoKTbLmZwzo6MakOoiNTvZLHhwJJL6z5+6kpstSgJUztuh
	8/ubQut6Sy0Z4ABjVHskh++nq/GPktat08ItxPd7skux3Zpz1gZ+nA==
X-Google-Smtp-Source: AGHT+IEGLKVwbAcMMFkc1o9VFcmSZouC84e5Ya4w3npzNMQFTKJBO63xDPju+ktJ/fmH9GfenY+gZg==
X-Received: by 2002:a05:6a00:1411:b0:736:50d1:fc84 with SMTP id d2e1a72fcca58-7403a831e52mr2417162b3a.21.1745998277570;
        Wed, 30 Apr 2025 00:31:17 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.46.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62bfdsm982760b3a.142.2025.04.30.00.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 00:31:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b10aabf6c4529977b61e7662cf1f09db4752edaa.1745991826.git.geliang@kernel.org>
References:
 <b10aabf6c4529977b61e7662cf1f09db4752edaa.1745991826.git.geliang@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: validate maxseg sockopt
Message-ID: <e7bfb5f8-a341-088c-6db1-d242bb0a4062@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Apr 2025 07:31:16 +0000
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
uns/14747844787

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c9ed2af6416c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D958366


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
