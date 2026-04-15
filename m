Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930B23183F
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776278143; cv=none; b=arZPZAdolv+4uq0P5R46rB+nyqKCqd4aMii9YUU+GpDmWfXfpkBOdMER22heHutyB5ZeXsTRt9nMvDhwg9TNHJc48mdKmdV98P2IOrB8lhKajBq+PaPm6nk+TtxUHkJ8eI2wGMjR2Wghi4/I9/XvGL7JSoTzNyC6gMODuJvAxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776278143; c=relaxed/simple;
	bh=5On/91/25D3hQOQnftGKYad90uusPjP6OkKqcKGBnOo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=e6EIXZcRjVn2pdiilHbzYCSXN/BVLYACRo6JwCcwtBfpYkziydms3CjL/T6ZbEzFTieGWnSBysAdpkujejpwJ8yeyI2oVMmz0YnTeOHV6rSNlzMGwL+o+iMJCPGnJj7Z67OuOrImsom5KaJXm0TaxVglfFw9OolpM00U6m5aNc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhkaK8uL; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhkaK8uL"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d736211595so510060885a.0
        for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278141; x=1776882941; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/qWcaZowEijsTKYmoM65aH/t4SC+/JyS1RWPb0Eb/E=;
        b=BhkaK8uLtj/S08QyRtYTXi7S+EbLTbN+BlAeEOwyHEe32UDts+IUTI6DDhtbdML+bZ
         ZAmZkyDQ0OIUAKx8HcO3cTQS0B4d9IPTxw7cNoyQUv2Jouj6hqUfrg04Ch+olkSCMJ0b
         36iCb76DXuiJvYuzQlH0ihc+HaBXMdALhxtWspz4YWaLSdLcqICOsnQEoURpPDhtCWik
         UAATMYw+wTcGPvCoGkoVevWSBnZUdJhEFp+EnubSP2su71zyBTM9blZ8Hfncxbo2jkvg
         UVeD74htQsF+5yo0XgIteXhPCX3nU/B1Oidu6YfPkk/mpod36PdTW5yXipPl2yzIRmzj
         CF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278141; x=1776882941;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/qWcaZowEijsTKYmoM65aH/t4SC+/JyS1RWPb0Eb/E=;
        b=cZ69cAYLllMCHxSc/NNg1bH/+rRfJ9MgXlwiI79c6T0vI7ZisUDS7BLqiMt9b4zvzT
         jMGxXvEOeTxryQvfn01f+C03zVRuJmqWeATEZft3kKjuXmCyd/ehF7v24DGVBK0vNJrs
         cg0uA4f9I7hGnnP7wGfxeQRzXG2yIfQjS3KSKjvnvZUjo59LL+eoQi9l46biNNLEBWH9
         lrtsvx1rhPhJFjCr/6D+4RbvUzd0U2vg2IvNw7QT5n8BbhqRINniHwBpweG1LOVfOtHv
         EjlGKTwuSTfeD+dFyBPgSx0qU2vt+IqXi8D+updXPVJaeJ7b6ZmPzDFHXONlI3fVlLpC
         miHg==
X-Gm-Message-State: AOJu0Yxb+KhE0szNUm+WGL/sSB/R6HnfWrk6gs3GgSuevsPgOmM9E0EU
	526YVueyGIQ30bYPQ7ShOfOasfAD9BcvNEJ5tzWFfnFIppyUa1ZvGfU=
X-Gm-Gg: AeBDieuAq+C68ylJTGuBloB3S43hJ9tBxC7TOO/8pGrn4x5NTRmNnzj1ylU6FKs9d2F
	EawEtbMvpm0TdzA3WHeRuA8+A+9LUcEp1RAqX9BCiIIfpvBFnBHFClJwu/jraEWtuy2HGH2WKg3
	Ejo2p3KLM/O0k4wTINvYtzjJNBq0kEcYGUzx+QbtOiMOkdRRB7AoEatQOA82gPDAQSKzObqj+wp
	C/LIxf17asH+cu1SaIapOo/Q3Vw/kQ4TvxT+cFumQK6tQKl+GLfHBnbonITZjtjW9PKiWygRuwK
	gdNN9sa750RfZNii8O9chSiNhknDc8bBJzHH0IR4l3ixqdqEcHmwlM204EDoJMRVQL9PGrkNKRa
	uiEv1H2b1nqBWoMQCdIDx58jqZ0Egf0CIn4kLMNfX6d22UZrykhim08eHq79+rzJyeOZsCPKnCr
	cUDZI5zQtVDPIKxkZhMotAUq5MDio8MCMzri1EzA==
X-Received: by 2002:a05:620a:3707:b0:8d6:dd76:a52c with SMTP id af79cd13be357-8ddce5c0df6mr3310035185a.29.1776278141364;
        Wed, 15 Apr 2026 11:35:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4fae74060sm206546885a.4.2026.04.15.11.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:35:40 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Ruide Cao <caoruide123@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com>
References:
 <86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com>
Subject: Re: [PATCH net 1/1] mptcp: hold subflow request owners when
 cloning reqsk
Message-ID: <e6194fdd-c5dd-80d1-7f80-40317a02f290@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 18:35:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Ruide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Unstable: 1 failed =
test(s): bpftest_test_progs_mptcp =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/244692=
79829

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b360c31cd841
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1081484


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
