Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E73CAE8A
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094132; cv=none; b=r6Ow2iAZ9hx/PsVSzPXlBAZ7y+gCXJWzJy1sozyLJXGRlmPuHU/wpN4y+m6T7LVZNfz03If23AaMBInjjSWInxJn4R7bjt+URYhY5/ltuAlBLq33lL4h3pUrRko1xIdGHwZCH7OyE6iyI/wihiWzLGDMI0TMwftjZtCRwXebblo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094132; c=relaxed/simple;
	bh=Lc2eMeuA3Vxr4zzq03RXKeeCeKbpchbBmdPB8YLqMkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Ocw5NTBPjfOVTmjYyDxn/MClyyZCNlvpQlE7oxc+rBzZ+zStp5jz7NH7srfqOPp2mFQC8TNtJPNT1WETeCEvAJTUVPYvFl9p1/R/3w29hVA6O34Sp5qCdRejf0zkI3j5uQbzfxJluOceSO5iVOupAnQ9k8qcD/6JLII/tPAtNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLrHaP4t; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLrHaP4t"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8d7e7f48499so449581485a.1
        for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776094130; x=1776698930; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N8S428zHzfog3knJ3B7Zl7VZygHrKLaSE9ndYhf4sw=;
        b=XLrHaP4t+rRsGhyjWX5x2xw1M+G0jBjLaR9MBEcpO1Sx/eIIP63aGfNYJPR904C79h
         kA2ftdL9IOoSDc0sV5CePgyzqMLigmN9NrtMMDEjzHiUN+dxVrO+YXSgy5RyenkIppCi
         JXWllztlm0zK4DNzF6wlOSFydC4ipI9Mz98HUg7Q4Iz0LzudHyvY5DlxWJyhN+gLLWSM
         TrCN952prLU6k2U77gv7HuSEXueeaju2yROL0c0lpmFOyINTT0oMbac4bwOfGzX2uV5O
         d4P0WYJK7NKNUjfggMbJujrUcr/agIkcKXzeUXt+1Wbd5oTkINDElZHu86b3aI2BBzYg
         ymFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776094130; x=1776698930;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0N8S428zHzfog3knJ3B7Zl7VZygHrKLaSE9ndYhf4sw=;
        b=WnlK+mhBEufZjQ09E7yeuvcYTVOQqwROSOIQ/dkdDq5GAvbMq8fAXeOhcSknfEHtSR
         7WDVfAHqWH4zQoPR1vjLs43J6mKyve3rBQlUYF1CMbxrx7yXKjcMpaTeZCuY0+P/6OBi
         c9ftqbg0QFDebL/dhIQC6koo00WVEySta8iHhdDQruVcuPhAVumB8i5e3hTc7Jqc6INe
         ik4vxgRNbjBXM9qdDXZMKsHGsTXcENWjixen0osVtVu3HZdzsGCMeU5S9vqpbx1A13Sz
         CVxx7WhPzhEY0AWrHSQYImlrmShxYpH363TMG4IfVTRX2Zp5Kj1Ltg6pNRPp6ou+7dJV
         /5Xw==
X-Gm-Message-State: AOJu0Yw7HovkEy4kne/ll1tUnx8KPaOUGjSk6iIE7BjP6uDvCFcSVeg8
	LWFes9ebc7nqGNJAIrImeQuTxb6BnJjeFkcgt+BW8aWagWBO8sV9Cnk=
X-Gm-Gg: AeBDieuQmQgVxwP9r0idPRcxwO4ams52KOkUxF7CX8CdQkN7vxJUv8YlGV/hCVEOdDF
	wAv/nhvTN6oude0het33k46E8cTSDij/EHEBeywLY5Lp1IyYMHv39NLJ8coG13D76DY7nOqnZnz
	PSfchfdE6LjD9TbhD7WLvXFEsHfpqtKL4INkdsz5oRz+YQO8sjnmP46BpFaSb8tSvieysFO7NBM
	mXPuis37+Mnpnrg1XmpkUBd4qasidInSun8Tkzo7+Os70+DiQqu/VLvEJBLf+TK/k21hammb2fE
	HRzzOW7hbRKmxjCUnAaqEYsJDF6ub0YQgvE24FPa4SlmfM3cAigNmbOJKVoI6b05C3TzpK797lx
	KaD80HHztqdydEzR/7Lczmt0361JMkbgC88hUXSkdLTfI2ma6DiCNmih4X1TuAL6cVWFfL07xGG
	PmZ/E26vMsw0K2ca/PEWITnw+/NiLptdIes+y7
X-Received: by 2002:a05:620a:bc8:b0:8cf:ff82:6dc3 with SMTP id af79cd13be357-8ddcfea0c55mr2039177185a.51.1776094130214;
        Mon, 13 Apr 2026 08:28:50 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.135.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb934dcd3sm916502385a.34.2026.04.13.08.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:28:49 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
Subject: Re: [PATCH mptcp-net v3 00/19] mptcp: pm: increase limits, and
 related fixes and cleanup
Message-ID: <ccc63dc1-975d-e283-2c0b-f800e89590d2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 15:28:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/243493=
97795

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/dd49feeb5952
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1080761


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
