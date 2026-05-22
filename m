Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71393BC68E
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445587; cv=none; b=DhAyATjTSHCmrpqDrys/VncT1rQ5b0R3d2nk8X5bklgAqoSeHzYS2nnnRPrvUtTktc3XIAknWcOrGRIGfQ1Ochvj1OYmQ9wGidpdxhqViUFqu6Svhf0hZPRQkEP0f7MXm64S/Uve/W3wgGneCefs6lxDkRCb/jCKugi4nkkGics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445587; c=relaxed/simple;
	bh=wMgp2Phu8I6W0pPPphG0ylArddgioHSK8w6BQwits1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=SDNM1vbVdINnF/UFTh0LeQEg3eC6o4fluU1/JGgBG8K+qIuVmuUnfSlaWnwNE6D5E8+uelGMTj4MzgVKIIiqTxyyBCUWe4os+YJLJN+gsxInvzMdRiNBTW9LOZ8qcjMrdGiFBq7B8gC1mL81drjLnuoHgA+J+u/GjDK5TgDOHVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFWyp9vi; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFWyp9vi"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e63771d91so70391781cf.0
        for <mptcp@lists.linux.dev>; Fri, 22 May 2026 03:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779445585; x=1780050385; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKnxrUXTIRzIYxhstCuWd/SbiizkBnZ+OXQMWyvg2r8=;
        b=mFWyp9viSRrdklQzFVZIZZs/oT1eqDhlnuYIbS6zejwJh42Qxxg5OUSNoYm77w4JVh
         FId0rL6AroZ8jnPiPQPj1EvT/fopdWVu9S6h2ADzf236erybYdz4kuPxI56XucUzlLuW
         wDLBUDY9I/xDMLHJaCU2NDNg4EK/+S8FVcRSmUMH2bDD7NUiLkGP+qEr/kiG8niHv6sL
         ddzJlafljaHQEKv2/I/mQ9IhZ3yhWx5Z2Jj782UEFgbMITGOVMpVGmcLwH/drHKeD2VM
         61cgF6I0xT9Ior892lbTGcAdQsHoubII/bsLPuQbROvyG1Dz07lVtNtsFlKyBP9XlDaA
         BXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779445585; x=1780050385;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKnxrUXTIRzIYxhstCuWd/SbiizkBnZ+OXQMWyvg2r8=;
        b=K+FsDtV1bn0aGmrU7RmJzKwwkAqQB3jfPutlsgQvP8mKxab8rstQ/Gj4YICxOCkKka
         fiX9o8NoSDdRyWk613nC9u8LBoAt4XZVsvtLmoKZyz+6HVhCeygwLVpaHbDYy7XnyDyt
         pYw5XYFKRAafxWAJOPU+bmacfPoVdFk9Dm9V7Gkm3O0zA+P0G3sEhMJUBvUPkDDOiSFX
         nKFhDVGZPcqHmXUuqJ2BkRoyQCpFn7cUgwJobQloDefk5LEg3VGyVa3LIh4YRXuWgyax
         IsJEL4psQRtL0gM4zW9WCNuCsrmApd1dSNCGXTEepvxX/5v1GIKLJC7L/HxyXls0uq3E
         uprw==
X-Gm-Message-State: AOJu0YxCm8yV/veySpjo4spZbY22FCshOf1p+3r2BgjgADN9azElAJcq
	gZaf/nFv3YYf87yc213GbKb2xxOYpW/B41Ae1Raz4zMLjv++N9efSqd2e22b
X-Gm-Gg: Acq92OFtp5NzJPq0wiW2b1p3tpJHAMk7JfJl/nIz6PwPsIj60vtyawOckAHH+/uHQfE
	sGz8SiSluEkDhqnbcv6dYKdNaLzcxm3VLjGMgGC25l8FItOE96UY532yQXmDrp2Q1kx9eDUdkea
	OKM1tNtA1YN3K1k4msnhDcQXXtoLRifgehH2TFv+XOZySeRJo8r+7CUb5G3JreXG2q7hnxcpgTh
	kS3yTpmRpR0siuvqpQDJf6Ya8VW0aK+XVWRCuG/LYLoFundPeDMAhdAhTAPdjz2Enue/2L3KR+8
	3uWiYf4UuY2U5zvX/ygcjzZKaLXaZfFrsJtqvcNfW3RqxcqOGfook2CBSpFAZGmIBR3MfGv6K49
	tORNWcYXm5kJALuc8+DCiIr9e0O2nMQE0MruGg4+LQz6Vf+G8r3e7N+6S5rTiwACHhzluAeU5X6
	8ntDuZfmA+O3tIHHwDPA0XowufLapBe8MyC78+vl9a8qeHYA==
X-Received: by 2002:a05:622a:189d:b0:50e:5cea:a519 with SMTP id d75a77b69052e-516d443c718mr41932041cf.12.1779445584825;
        Fri, 22 May 2026 03:26:24 -0700 (PDT)
Received: from [127.0.0.1] ([51.8.152.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b25a01sm10482041cf.8.2026.05.22.03.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:26:23 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Tao Cui <cuitao@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260522084658.1896374-1-cuitao@kylinos.cn>
References: <20260522084658.1896374-1-cuitao@kylinos.cn>
Subject: Re: [PATCH mptcp-net v4 0/2] mptcp: pm: fix extra_subflows
 underflow for userspace PM
Message-ID: <7d780aa9-4ca0-ee4c-8bdc-d74e76ee25e1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 10:26:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Tao,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_mp_capable =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/262786=
24724

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fc567e889a52
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1099222


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
