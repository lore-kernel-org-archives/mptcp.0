Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817EE3C2765
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773750475; cv=none; b=CaO+UF3qKaPMIoKfgwz0cHND5GCZBhhBAWw/iWAxjozrvjreXIOxue6imGwfa/IwIB4OpAJ4yhRL8UzFMX5EyZJZYO/UMndJZSW8ZVIll9gvu6K46tGwEyuiEd2oIk2kGoTy2IMAY9rAsRPNSJUSDbVdvDW1QS50cy3ERGfVFrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773750475; c=relaxed/simple;
	bh=9gnK79BDMza13ZlXKeyrW6QkczJF8tKfOIZmTclbwo8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=TW9ULo7HYCbWMpkkgvwgw2pDmhxjEBtK0WelhdmhXY2I1CBh16xyOlfOADlxYw/Lxf1SKT02y1kt7LcbnV8QKWGT+G8b4o0B6W3ODX074MY+JZVhoq0Qvfx3QawMRFWgDTsNFlr+cS49B9WBRDZfvtVK8Sobx57oJNxp77vCV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+zu1MQS; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+zu1MQS"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-126ea4e9694so80120c88.1
        for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 05:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773750473; x=1774355273; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqOfEQkAYCuA+Pzbumh6QbEYM5tiDxFfgsRHJuqcpCo=;
        b=R+zu1MQScW9zgcY4FVNe70Q2B7hmflR/ISgQibtiQSA2ccFj1a3KPNP1uxSh/gqMg0
         LQpNChFIB1n1JexCM8DyfP9cX0u1yCE8KASXVhJiGj+xtD1T5LHdeA5X88dx81zZt0y1
         gh1Csx0QuKK9LoXJIBTswbkffP92GtVJv3PRO/hOIf+scY6iIRShcZfm/MD+/fjeiz88
         JnQvx67OuER+FhNZbb7XdLm8XgmsAxh1UrHw+F19waC0IXMwZTpxE/6Xdub2PrxeYXf+
         jj5mUmarFD74vBr8KucJxYe9F0wZZH4kUgKGsCwNlkqMBOpOX3olE0G1rJ0zdYJZSX/0
         EK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773750473; x=1774355273;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqOfEQkAYCuA+Pzbumh6QbEYM5tiDxFfgsRHJuqcpCo=;
        b=Xt7Es26LDIZAdZ+u0m7pFP/IQ+Z8XYwxom/9jJgICKC8ItJjUbsk/2hMuNofyvqlCq
         opXozXECZK4luR4LP9wBnJ6aUSZujRfthu5x2pvzkmahvTG1FjutGQsTdkA3lzdRqmPz
         FasZt3NDWY6n4UvKNee99VP33Oo40OglCCBIT1xKLO6J0wSV+M4Er9oeOaYktXfrZIXm
         PGHODzzvikqfogQVPSOKdmgTh/HtvASVJrxwy0eXAU0O2GyH87P7jjmMIBwAW9wOOmm+
         hd88+NNod0hH8TBCxxDsKR6f34yKa/8xMJKylk3CO8KFkEDSVMb99QUCSNYGErwlzYcp
         FIZQ==
X-Gm-Message-State: AOJu0YxtP1x8DaFBzYCvHU4KW2vvPMXAXaya19lygYFDk/Rl93FoVg4W
	vkveG0oedX7f/tOwon0/e/MdR8zbEquei41Ni9yg2Pg2xWlmgWCMLfA=
X-Gm-Gg: ATEYQzy5Spa/ijUrR+nBWMjtB35QGed0j3X1knJtHYeOp3o82LzA19RU1xtAYLiXyPs
	kjOw43df9PuZjkCdMvvTiUC6KldbjLKjhZSxh/cP3UmXFrP0tIZdGBB2LiryRpPm+SmbaXdO+WD
	5zOHBThpb1s1YwflTLJ6Kooz2HwIMQUuAT31sB7MHvMQffsin2vKW0YxIYTcLvH/B0LATOCjGUa
	daZaRgAj+2WcArgB4LbbpMqI4GnYNU4K6KfDvKVNSRES8pEGX+aQKfDoLB5tWRo6GCaqSBRfIJG
	atgCNiF0+iYcAeVq8geNORjdFcN/bp/RW+bruMNDk38YVXCK4K6zMBEQh9OZNXqUNdW2laQpmut
	839GRiPKv8V5/lqi7bBpOd0mNr7ab6l1B3TfDrdmRBo/5SyCCDHRLSikZxGAPYOCSS0Y/btqcaH
	yYtlOvMbcucWmyyr5TDcHJPLH+/GjK7KTrCMox
X-Received: by 2002:a05:7022:eacf:b0:128:d20a:2f3d with SMTP id a92af1059eb24-128f3d1d58amr8599308c88.4.1773750473188;
        Tue, 17 Mar 2026 05:27:53 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.137.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f63baa3dsm18753091c88.15.2026.03.17.05.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 05:27:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260317-mptcp-data-race-snd_una-v2-1-2caac60de92a@kernel.org>
References: <20260317-mptcp-data-race-snd_una-v2-1-2caac60de92a@kernel.org>
Subject: Re: [PATCH mptcp-net v2] mptcp: fix data-race in __mptcp_retrans /
 mptcp_incoming_options
Message-ID: <cfae962f-9d97-49cb-332a-ef292cb2ec94@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Mar 2026 12:27:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_mp_capable =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/231914=
63243

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6d0a7619439b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1067924


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
