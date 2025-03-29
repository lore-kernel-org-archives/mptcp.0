Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28A32746D
	for <mptcp@lists.linux.dev>; Sat, 29 Mar 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743269608; cv=none; b=hFJzNEGTcCByEQZkpPdX4jmH4cpAsG2Vlep+6hSayVXQGbTCPPmc9O5kxNfBALYdXKZelyJG9Hkkn3SsWw4OmbAY2p2QqRH0WARjYiVinlPMGsl+JpETlihyQno5VHeu+N9FPs6rVHIwR8dk7CA6panZz+G7x1rahl6b5qeTxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743269608; c=relaxed/simple;
	bh=sBLhhgxf66LdpF81/GC1br2i02PknLiPvom5zOm/vj8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=G6BVoEf+d5wd0COMzITLjvfBMbwFJl80u5gU1VGwUsgeCAYE8MqYULX0k/4L5Jm2LEOgYvUdk/LBH1F/j/4DJedkJgmbB3DVuqdeCs4wLmTZBVnaFPvA6aj7yi95U/aqZS1ZfgTDTfDjR1HLwTEQRbMUAOldIi3F0Mjsh4eHw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joCV7SkE; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joCV7SkE"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c56a3def84so335212185a.0
        for <mptcp@lists.linux.dev>; Sat, 29 Mar 2025 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743269605; x=1743874405; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du3g03Cr9uCnnIx40hAchqbmM76NedgWVZKIuZNL7yk=;
        b=joCV7SkEyesoqozUCUM7rq59+Vy58QTlIRK4EiAC8kWDZxCYENesW+gYHzU33C3Qbz
         poW8PNDA5B3rgbxjPOahAEFA0d/KhMjISXoHcmqNtPAucjR05TqOurRd0CEwGRJhdO3x
         d69LKIgsr32qYYoVW7z34JFitVdKayv4cJjvhxhUKpYotHxjwQ8v4borAwSYQc2XyFyu
         1MyehKeAduwcvSTf7LIr/+AG7IKBUGjsbhp5kFD+u/F7/y2MBZBjxreHtUiS5me8OUow
         mKU93UXPDJ+NTngzH2aTr3tXEXQV949D0GGHYUJQthXvIYuEJoilOrw/dPxzeEzMr/Q0
         auKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743269605; x=1743874405;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=du3g03Cr9uCnnIx40hAchqbmM76NedgWVZKIuZNL7yk=;
        b=dWc1ZpGbapMqn4tlWPoIXmO6HGLqTMgIYNsu2jjQ8eyUewIpRdgrcKQa5O5exXI6S6
         /ystGKTpp9//ijHenxD9lzGd5efexSWvQrem4kdAt7/0cGVkdaNRUxOoCJgNRNja9aGn
         6CE1i3Oir05oZX3ayogbTh6CbU4vZB9Hz7bexJVRdi9uBqi3fWGBLIbrSJfvpWbkP9kE
         LSt7jakj9UsuFAF3h63lDN/CYw12S60S2hEA+NXz/IriVL2vN31NMXnIa+Qoy8UHaxPw
         2Xmj/djVM2sD0r9KvbuvmqlBcWR8ZO1WVCJTyOd4ZxnQpVLMhrbZFXvzgOybx2fKnhXg
         NhxQ==
X-Gm-Message-State: AOJu0YyOCHPeja51kuksg2wtVTVJJMcgqkjGM9k2Gca3rEs73HY+mxgo
	Bs7pWm5QFOTXKEwixOljwy747jqXtCZiqLdQNWRczKH/lUC79Y0=
X-Gm-Gg: ASbGncvaHnl6Ac9cg783cajQu3NoE4UkeiCovSYt8ej7G6Lg0qcWjvJlNXgxs53Vlsz
	0M6mk/rvTKVEOZbS0BaQKSSZAoVpR4KMFzVlmYiqeh4EzqCBGx7eXgP6IMqEdcMLyba6aCvneXw
	Ji9dYJpmRieH5yzb+uzmSZuNlILKtoI/LffuGkQ9n4gsp70VTvMxMGS1HwWsTzdq38fdhRhu7XL
	EseSOm7gwfmo8iMKGeTnoXSN6V0davozTj3AeWYJwqviqmomr1H56o3H6WBeuI7gbqCx4Qc6dwV
	GLHt4PY6F2F1FgwSbQBk6BK7/8F2fr8AGNEF0S9Y4sDMYk7y0r9uwE0IxA==
X-Google-Smtp-Source: AGHT+IFv8mgU+nskB1e3A1gZ/kgsXhsNCT6Rs6hQ4tHQt3ZVR+58mAj3XovGjHpt6e1PPdKBWCeaPQ==
X-Received: by 2002:a05:620a:4252:b0:7c5:48d4:e8a2 with SMTP id af79cd13be357-7c6862ec55bmr398612185a.2.1743269605499;
        Sat, 29 Mar 2025 10:33:25 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.22.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f76600bdsm266775285a.17.2025.03.29.10.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 10:33:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
References: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
Subject: Re: [PATCH mptcp-next 0/5] mptcp: fix MPJoinAckHMacFailure, add
 MPJoinRejected
Message-ID: <9ca6898d-6206-4d0b-53dc-555e59809d3f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Mar 2025 17:33:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

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
uns/14147512989

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/be5c1c846ff1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D948274


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
