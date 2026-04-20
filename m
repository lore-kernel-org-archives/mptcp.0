Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F9A2D7DDD
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685154; cv=none; b=ErbO23FHSmJGTglFQlo4tILaK282nzv+jZSgrMrVtaApsySW7QcBt2+wggk0EojaorrwcHji+6uGK9Ao7czqzwc+R4lcnP2D17RsZZktqaZKRky9pE4Hz+jay8+34w+zNBNm/X3PAvH3Du0eFFHUWyf84uZ50wcDSVkWRKtOVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685154; c=relaxed/simple;
	bh=Cispbw/h/AKkWDS9Vl/Q5KfrtATTisibxgfRW1n9ONk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=mN0V8P+cqri5luxKzLWhWL8V7ZWDQ9JTTG11dhk7o57l0GN50HwOOUTciFoVqcvA8yHgvpPhTTDXGwyGqJvbbkExw3KKEV5/vlQY7L1f3D3kTwAG636gXtIR4j5N+NrXjLWiBhXIcxZRte/njQXjRKskCBiQbcAxXQ38BfWZxIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/7LT2kg; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/7LT2kg"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c8ccc7755so949960c88.0
        for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776685152; x=1777289952; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGx2bHGiLE8jmHno71bthhTSlHOqWLrP09Tl/YBhyeg=;
        b=f/7LT2kgnpTocYuE8juHwYw3fnfCN9sBsGStOjVFgTanaozyewdmRvOqWsyihK4FgR
         Ghzc4UMLD6btRH2DojBW3gifx0y+IMH+WJfCw2R+SSlmFEYrKk7oBCofSKsgQhNPsZnm
         DZZCNHPBRvj67gjcMn/IZ6UwSXeENokf9R34xI83eUEyT6thnlUzRkVA2IbWkcfRanUC
         UR1EE8ydH6c4jkI55IYBYpQkoBQ0uJ4Ug5lktSy7w7pRtLdfS5Wrkxvb8N4zuNp93hPS
         QjZc6TQslGTZPl27MZNPXOmngKM0HQFY6kAm450AtPhyOfs0YD7aWanK2+VZf15jHZYo
         2jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776685152; x=1777289952;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGx2bHGiLE8jmHno71bthhTSlHOqWLrP09Tl/YBhyeg=;
        b=Mvex993BvX74HoZzNduVOzsHLt+Wr2rY4qJU1hxIe+7RDZlIhnUvgPJeFwZhTYzCLm
         +nMDizTVrwWpMGVEDrN80u0yvLR+SHNbuXFJF51re3pq0WEsNFrSEAJ2SDFlp5cRvY5l
         cEYjDDGYcNw8oT9F5wmUGN+QQ7RU25orklGVIpCv3JTLfkClc2Rk1WSFiI/HKJ6AOkLS
         GZtPWRfML7w2wqjGwuktGejIhz5oef7aZZeGm7MAJIK/ZkeqBxjjGPKgFY/FhLR+KVUp
         L1PBZXDrGB+Q0XQOo/e9X1FU+OcfcsI9uDErWknC0Yg76Za6DqnLOFEpNqH7z5lC90l0
         0VoQ==
X-Gm-Message-State: AOJu0YzwEyz0/2Gcwkj8qkWx/WcqjikUFXkEqlsK4Rt3WjI/0Yd/owJ/
	x90om65KuQrTsv/G2Tty9+9T+2tf+0ajofAikVluLMpKSRyuPrk0Keg=
X-Gm-Gg: AeBDieujZ9e0iHf0QcbGJSjXeXDHFOzmdsVi1R+uxBW5DnQ1NbkCXwqtlDD7N6ZpDAH
	iF/B0wV9/z9X7PisSn/rkyVmhupRfv8y5cwE2E4TdrOd1DhnoxMkqoPHkANlSMwsXCnPWeckfzj
	BoldcaD4a2yu24jqL3oCgXvQz3fmC9XAwBc7Kp7/DrC7jk/cCK9r4FpG+A1QtZooFRP7C8wgLoU
	VbPqxw/UFxnW7Robp0WBzyMIAq48sq+aPKbMrEKy5S+PXJy5otqFk7yGiSRsUN1a5kYWaEO1mXH
	XVxEJLY3CPmDrpXlp3l9rE3IH3ne9Xj/jzGSvbld8SGa4NSs/GmC4qesbLpAYd7SFWH2qC6yaWN
	33jcZ4BlhahqaXBuSDvYNA5ajSqIbiaOmzdoiSwDgTW/UAHtOE78p1xquwblfxzbNp0YkzNMllb
	vqwZlIMZ4ODJSpJZPHB9dzKvh2b7wVIx9+K2rp0xu9CLnqMF4=
X-Received: by 2002:a05:7022:ef0d:b0:119:e56c:18b3 with SMTP id a92af1059eb24-12c73f9707amr6025404c88.27.1776685151400;
        Mon, 20 Apr 2026 04:39:11 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.61.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b944bsm14094581eec.28.2026.04.20.04.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:39:11 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1776680489.git.pabeni@redhat.com>
References: <cover.1776680489.git.pabeni@redhat.com>
Subject: Re: [RFC PATCH 0/6] mptcp: address stall under memory pressure
Message-ID: <aa4a160c-4794-531b-5662-df61ab792762@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 11:39:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_checksum =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(except selftest_mptcp_join): Unstable: 2 failed test(s): packetdrill_dss =
selftest_mptcp_connect_checksum =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: =
btf-normal (only bpftest_all): Unstable: 2 failed test(s): =
bpftest_test_progs-no_alu32_mptcp bpftest_test_progs_mptcp =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-debug (only bpftest_all): =
Unstable: 2 failed test(s): bpftest_test_progs-cpuv4_mptcp =
bpftest_test_progs_mptcp =E2=9A=A0=EF=B8=8F=20
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/24661753570

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d6ebb747f78c
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1083242


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
