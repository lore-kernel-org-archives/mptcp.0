Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F0175A99
	for <mptcp@lists.linux.dev>; Tue,  4 Aug 2026 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814152; cv=none; b=LaVOMXZlW3iMdbTiAmK34HmVr5H5aLYQsbwLuS2T+LKyBIO4c6utR3ueXtegojrapYPSkvRY4c6AyZjOtLL4UcmpDwtkwTrppoFvNONIzmgzeI/V9XoVxx/oz//i85UqIrwczL2Wh2/vCIG5awJspfxXCSE6jP16dd5sIiLIl0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814152; c=relaxed/simple;
	bh=8r2Yta7KuHlYkyMCKimJy0BJk2SkAOHC08mkhImKvwo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ofUCFTwFCYq1ULnsQfZEUKKKZey1bXP03GxiWUwsqAIyovw6Bv0x/3zzuW8znG6kD5QYXv7xIJv6hSR0n2ziJzT6/dMIOxR1IRroIlIEF5N+2K4eGjcMv1rZMe3daJe1Xd/SlrJNsOcohcfsOhHkdAXlTGOzXAg0I898nkeG48s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRZXdM3N; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRZXdM3N"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso4622284a34.3
        for <mptcp@lists.linux.dev>; Mon, 03 Aug 2026 20:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785814149; x=1786418949; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sOETd6+u8M7X1B421bm34dPOXepmPzyM+D6XCNkpb0E=;
        b=JRZXdM3Necru1ek4eHMopkMUMTmO02M4sH7oR+yxrvJZ8fJDO2z6HwON74euRjnadK
         cJYnwcsUe9kXlmZimTaaB5Zr5STjwzUuXcehpZCLep4BXIudoDGHZ2BK+RXTSZD9XA53
         rqT9pVOm6P20atxx1aIKR4Xvt9aQvXS0WYqfA6DVB4X6D8UsDJfXjdjqzeBsxaIP+Hld
         5mDeSvrQBigtEJQ9duAZIuy9LVcZlLr5+oIkKSvn0zZ2Nrgy7IOYDrYaBeLKjb2mQVII
         VKtQYLdYGlNskwt//4RMWBBaNh5U2a2isV5+k5nh0FxoqP2kSH2S41WtFjbGxscbOcLA
         VdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785814149; x=1786418949;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sOETd6+u8M7X1B421bm34dPOXepmPzyM+D6XCNkpb0E=;
        b=CaqJ0sTw+QNVPXacyDGybKDapVPrJuqLhEKAWwFb4bKIrmVTrhykXmO0Z2E3HFqbVA
         ziuSCGMVFytp0tlX3nDZ4v9fbT/XMfhGJq7TxsmiCuDnsOlzSd7PI/tF8zBXh2H1QISV
         9KiNKcig/DcmWlf40HC7AXzJHyJqtOARCZ/KbTiSbqBL3xddywmoDxuYey/oFkZ7XHZ6
         bVUHUAsxZw1+Pbs1D6bHfGnkP6aIB64JYmOG+tq9o1EBTCAUwGcYO1Zi3gBIwMPI/YiR
         YzpGi37dZ2Aidw4leRE9rHKOn+6BSrwHopc0sQSaI6b/hN51RmxREPJoJEuieXpGu1ly
         y54g==
X-Gm-Message-State: AOJu0YyihAnU9J94mGP3qTPcPTWVt5hrV8omzxntMRISETjMb0oFdoem
	Um79IRRtOCEcJ2nxSQCRDoH46/Xk9DA9Z2tQOHH21LapPQOB00WWvHadddXx
X-Gm-Gg: AR+sD10MoHN3z7zaGqpX7rhbcMz0qLvh+Y7XDnwvcaVf8U8VgOR8b8wNSJsiZhQEmuN
	xYpZhhA0bqjIPTc0obwmNqCZXA+YYxYTPdNT9Tx3iwg/g/pkpz5S7E+lqNMWNNHs9gevCwB37Xj
	+S75lp5M4myI86hIYQk0LNwjSXhjZoj4l64H6sLZQ+CJWNcE2ZGO9ghhpwiyIrVRhfvYaZfMaJV
	JJ/WUhXfJ6IpLbtvGePJHekkgj41SYcmeInMaK4MeU0AmO1IRc8wmYNh3uUT/uQVeciBRPSfIN9
	oXiDohSBAZIUEDzgkPBml/9fXfEkW9O8VcU2lHNNFvlRwiuQ+TP3bbP0BNXCdPtzUQdz7NonI0d
	H2pp0Btz3523F0UXhwBiWQzDxlEBUGWMkhoikV5XYvjKtogQMyonetBwiAKB+ExUoeKH/sy3emW
	54PtTpDbYm4V3M+/yxTv20OvcW3bBrw0RiodiIR8H6AVZML7PZzjgnjmJtHzWZf14CAeEpDESxB
	Q==
X-Received: by 2002:a05:6830:6737:b0:7dc:df37:844b with SMTP id 46e09a7af769-7f196baee6fmr22214506a34.4.1785814149482;
        Mon, 03 Aug 2026 20:29:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.38.104])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed3e91bsm8662435a34.4.2026.08.03.20.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:29:08 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Qing Luo <luoqing@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260804022350.181323-2-l1138897701@163.com>
References: <20260804022350.181323-2-l1138897701@163.com>
Subject: Re: [PATCH MPTCH-next] selftests: add test for userspace PM
 address ID overflow
Message-ID: <fe330efb-ea81-8d83-b953-cbacb352de38@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 03:29:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Qing,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_userspace_pm =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_userspace_pm =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/308726=
89423

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/dc56ec09ff01
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1139751


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
