Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51FF1BF323
	for <mptcp@lists.linux.dev>; Tue,  6 Aug 2024 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946112; cv=none; b=BE2Qm77v1QA5SbZLdq5f4LxdzPYVi9v4YyJBtRYExVI6jKx6/XENLeMM26+Yx8onQ0XlTdInea/Di9mLwjSt+vCP4Ug19RSzHOozHvgTcxU45UtHaL380k8+zkU5W1ccgy7hUZkrSHbLSDRWgIbqeSM6epTRv+eqZLB2gI9NpkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946112; c=relaxed/simple;
	bh=OZoZSBIITiOTMr0p0Dk9Tvw2qw9ZMPSmBZDG3phOWmk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=eIxcvc5sdcpTTqVTfhIt78KZilKEVQHEfodWQglD41PaD4EQBiAoxbUl6eafRvdIDCDJzLKLoCJE/W0Cosz7rbIn6K96kcb1bHemM+o19QciVCEp+oRpxCRZ2GVDDnYri9uGeuDFdx3WIKp+dLm//z7zhsfgm9EMYOp1HIN3/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+QVckAE; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+QVckAE"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7091558067eso291820a34.3
        for <mptcp@lists.linux.dev>; Tue, 06 Aug 2024 05:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722946110; x=1723550910; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz4okfVedYYdyjaykL+OAtEJfepPjCaQaykt5AvwDcA=;
        b=E+QVckAEIivsLGkIR/OxdyCZSPInX3eeleiyX+V2hUF6x9wzTZ7wNezspFAiz+pqjg
         fJH9Lr2UlzDD7iVN/6nuH7my3qrSkTFazCIWnqFC9CqjWSPyYaUrBxagHgSW5X1Me7nk
         QqEos9m8vGujFskOZUokVuom6BMMzoCWyMVqjqoyABCFggQE+pgWS3OiAyVYzE0OnFIz
         xB9Cd0Tr3XUimKFX+10/LOu7GsgFhgMlq90MpOli2EzUdxXNy6F4nFOGUsN4s4WovOvU
         o4JCHErwlNymRKBhhZSnwFBMtXOITNlaQekXA6f8Fpr9jzWi9AEtxdnrIEQz1ExddbSw
         OwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722946110; x=1723550910;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tz4okfVedYYdyjaykL+OAtEJfepPjCaQaykt5AvwDcA=;
        b=G6qzue/1FYxGxR0rYnWvMS9oDmVVzKWNEo4tEifFBSLRSXxs5wH18pik5eq9vM34br
         r7zmpVKrJtehhdKFaMgCGfYEVd8D2l8a8d+IkkYQF1DIiZY8cce69P3KkOy10kTzx0LF
         rARsWSwWm9MrJdtXxogKe6SOuzFwtloj0EY4LQiwhnl6iJ0Bp7mP7hwpWvuYfbDEMJMy
         SyqKs7iVB3b3XeHDSAO28kHyXXsvz/JAR4tnL3iRFISYKTMKlhBGvGaJM1gnsp+jc0o9
         EfPNh8pTDLVJ633AsquysgD4BLqAm4n4d5SA9bpY1IG5cEoakK9HJySXhxV57s5XGFWF
         HCkQ==
X-Gm-Message-State: AOJu0YyyDvpGbUfgVHIeoTOrON4V0HqlGZCGhq6KYhWMxTmV5CTkkwhM
	eBge11pxHLZH1H920UDhf8Y9K3DbyPB7lUo7ikq4BiSd3/dwCAg=
X-Google-Smtp-Source: AGHT+IFJ6X7d/XTxA4ue0wWXERarMtd72kQjFKSckGUWcv2e5gb9woFRGeBE9Vxs/v3KP317jkcqeg==
X-Received: by 2002:a05:6830:4905:b0:703:68c2:8356 with SMTP id 46e09a7af769-709b323d1b0mr18240656a34.17.1722946109773;
        Tue, 06 Aug 2024 05:08:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.78.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bba1527214sm41097276d6.116.2024.08.06.05.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:08:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
Subject: Re: [PATCH mptcp-next v3 0/8] mptcp: MIB counters for sent MP_JOIN
Message-ID: <04ba9261-03bc-cff1-b8ca-3d8c232a4996@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Aug 2024 12:08:28 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10265659749

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a07e36f8ecfa
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D877027


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
