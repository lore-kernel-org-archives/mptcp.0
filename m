Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F13168E4
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764230898; cv=none; b=RMU8igqlEDxd59mHFDMO0JV4tMT2Toco530hYLJcaw+fBi/a/wMLPHsCAv66m+0qRhy9QGeyjdDakbJlcqIKNC6PbZsrS8PO8FB6Cl9orAZnf2VC0Jy6xsoM4JZ8PEINYNKGxfSIMnRR9e1N2tJVS8GhG1N/U2736Lp3Urz4i2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764230898; c=relaxed/simple;
	bh=/ET0kDgNhEPPKdPK44G0xe9XIbwMWNvUd01sOF4Yhok=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=icMSwKvbYgnr2tTjkBPqqn1tslqyFaFIazWrfi6GjixE8AjIjCxFzaQPSR/A3K+HkyH2d5VSF1L6N1OZTPciFRhxD2xn4Yt1qJWfOGbKzxWFjImCVfY3Ga6yqLOY+529SWRcCAmMR8p/BOwVmDmDieX6x15CwZoq97Ba5qwOydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsERO26H; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsERO26H"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b22624bcdaso67511985a.3
        for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 00:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764230895; x=1764835695; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+zRVwtjWHI4Ye43XrLueIVCRHm7IgbeRghxYkFpSzc=;
        b=IsERO26HgNXs+AXRxoc+AuPZBIbTNFjJ10wp2PlBzlszuphJCYKhFq37sFIsoLUfRa
         qIwDfYHfBm3ILQQIPyKcro5GalNfm1XiR/3cx3SejU7ohopCI9wO8fgppOVcbnSQMejo
         ZV/4qCNw2ocozzTMHUUAXZn+b/EIcIjPlAmcKym+ntuGbPH2kPuu7IGWDKx6LEqEnAPT
         fRAfQMLDfQvZuwt4UTA13tRb72sT9ub3Fumz88v7whJArcr8mKqC5JATbreWptUT24Ts
         IERf2/aKX7r8gKORGJfnug7jWR6jrR6E5SosCh27H9MUsrIOW6QpbUTk81TWT1kF0vNO
         qOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764230895; x=1764835695;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+zRVwtjWHI4Ye43XrLueIVCRHm7IgbeRghxYkFpSzc=;
        b=XbnjpFJDrJ+EsBME7Pmr6gOTaDTts7JWJBOxwL3RU1h6URrGla+ao0nxnnaLCoOEGn
         QJ5r9JzIqQ7f5M6NfWwvFTAPOZpL6zHpAtmolRlv0tM29AbW2XmVHcvinqzogvnR15c6
         R2coO7LdjNJ8YrLT3MfpQsadAt1SjCb7M2IO843Pf9gKLM/DM2PnbOvhEr2Iw8vooQqy
         TyDrWPresr3Ngc/CUbujnoaYd4cD9rV8FRrBUGpkWxl8W7ZZVoweS7YxF+KFkTqJRREO
         Ua8CoCqvm1P74iW4lmJCkZfvvDJs7vmcahM2DzKIWr5579RWgyvRldBQ7We1RnRdkylx
         tZQw==
X-Gm-Message-State: AOJu0Yxmaz8Yim45oDeLSG31xi1tCGpptbHp4df3ca62H2r+07N5DbWr
	+/6WFrDPwpV092GkKlPb7voTIaSHNeyd3MgemxlCeWF2jnjtphLWQPOfTKcf
X-Gm-Gg: ASbGncv1FgmwaAhQr2jfj3g1O4nLXljFiUegflVVsii5b/xQLkdbFYQwUy/2LwzBbbG
	2YhgHHhCpQE3HWGxi0tE6zoigja42NoUUISd6oAlRmNGXzOAhg+BzWkDIgJCyjz4Y+bDemPcicb
	NuvKN+bXMQ18aOFs0fzzE+tDT5CIPIxS7mgPbIOBxIzY0FWeTvhj/hwpXaSSzU+NJ15GAjtbxQn
	3krLVzyKMzkFyqYm/qD/H8ZreJdNENCjwAFbV1VHyAMdmwbe9uXoFWD5Q02TBiClRPckCB3f+Tn
	tGHjTRn7UFws8PT0dTq1soFvJ6zkXU/H5mCI+qRivNe2kS1d1oESOIEdGkaCoNmuWlZnZn2qEBA
	KVggyy4aHBgoTa0ESCMplio/IibQ/gG2dXbzc3Kd9bQyL3T7FKmlnTssrL8BB73Oxca2Flx2o2A
	qC4ymZju7PUniSp87jsM6PLgFemMcrFHTu
X-Google-Smtp-Source: AGHT+IF4VyF/insi07vhgnKbRhap5WwIc4l/y6u31pQhznGQY0HBPRnom+rcvMdHQYrncY9/d8nxTA==
X-Received: by 2002:a05:620a:4722:b0:8b2:7331:28e6 with SMTP id af79cd13be357-8b33d4c711cmr2735760385a.86.1764230895191;
        Thu, 27 Nov 2025 00:08:15 -0800 (PST)
Received: from [127.0.0.1] ([74.235.123.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1cb5a5sm60155385a.46.2025.11.27.00.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 00:08:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251127070417.53513-1-gang.yan@linux.dev>
References: <20251127070417.53513-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-net] mptcp: sync the msk->sndbuf at accept() time
Message-ID: <7b09ae45-31cf-ea52-33aa-4813dcef7cc5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Nov 2025 08:08:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/197283=
35198

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e6e537dee960
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1028131


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
