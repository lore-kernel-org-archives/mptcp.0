Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24AB14B092
	for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758420; cv=none; b=EM5UcGd06f7TR8osNllD499CVoV5lUxCwom1s/cdZgAj/rX64ymU9DDUDwDj+IowdLnGZF3ZKyq68KN6l900ktMC0Eh0fLxI3B5GVoozboPO8IAwMSCq4V9n1PGqCCcBCuWuwVzSAT0ILrcGPKOomd9Zv8jsudjWN+pdV3riQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758420; c=relaxed/simple;
	bh=q36AXX7q4jP3ADfk7KSfXaXrvJx2I9dQgCF4HLESOds=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=skbfqlkGv6Wwm/9BelcRif80C1nm3fsDHmQtFs1HaazWYKxNkfm5oGLn8bSrQi138HAxeLBn4HzfiYGpAEr3eeWhaujXCViz4HpyLSHvKh+NSJq1P+KTvjQBRlKdxk5/vS8SpJcWRY9opslmAXDjnRWXnUdKjjSaEbw3m0XCpz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDKxycjP; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDKxycjP"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6bce380eb96so943726a12.0
        for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 14:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723758418; x=1724363218; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21DAXzek6uyxDQIw3daFrmiROdQULF1bG1We7LF8J4M=;
        b=PDKxycjPun9U17Fgb0+7Zp9FrXynNCRZHNV5e7EDl9Niutcap1WKwvg97s1QR1GleD
         fvBIyLiYgoRx9oezLTWF4nzONbrQ1pPzfuISXYcDvbolPUPrboQJftehyg8ORfi8lewU
         saLVta2ESFbY5W2QlZMLjGFshXLODSbPB7PVkR6qQA2BC4DOd/aATVYhNmXFocZNS+fu
         ws0uBHpa/sfC3MC1l5Har2iaDxZbuCbvraPDxDel5wgWiQntpCv8AYI1RsY0z8WWAo7P
         n4KSkfBGza4vquZh/K/t5/y0prAVN35mzd/41HgBt3ghj24C5hxLvhv29XiamPxjaog2
         fBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758418; x=1724363218;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=21DAXzek6uyxDQIw3daFrmiROdQULF1bG1We7LF8J4M=;
        b=A7GNOacgo7LXetu6+AGdxTJNmxfWpYXBSlXET/o5Y2D7StlmC7jnh3aUvwkOpiP8dr
         TXreN1UEQ6diCbO1nrOltG0BCcGJCiDppTKFvQD/DV70EHgO5xFOQQfFcudqk+zXw6I5
         DevWxAbHOdz5Lg8wcKCvjZos1s1c8ed/X5lSAUvdtP8IbJwOWbjMzYyu8F1I6LNDImBe
         pbHie0CSb/V16VjR7TiMYHLvWhIEj8jSs49aWZ4PnSVU3a0Y4UbR98qd/kAY37RDr0Bo
         N1pl/oYq3XzCqN04DSUFk1X2x3rMS1+Vokmh73KN2km4dxuupY8rce9rEv1bqg6ELAni
         dWKQ==
X-Gm-Message-State: AOJu0Ywn4yvXH2Ed8x5uJjhfhH2fSO+IST6oBLbB9B+53q/yRI9Gx4lE
	/ofLZyEHoG80vnWsX+40xJDBsxY35eSG03XvD4/Xu2d23Bs3ERs=
X-Google-Smtp-Source: AGHT+IE1SR1xO4B0SdxS/vZNNmSo3hnKgJJ8cCQoE12YUGxUl7w2Y9KeGhCTK27t8bon5NO9epIyIg==
X-Received: by 2002:a17:90a:2d8c:b0:2c9:e24d:bbaa with SMTP id 98e67ed59e1d1-2d3dfff5d3dmr1167334a91.27.1723758417823;
        Thu, 15 Aug 2024 14:46:57 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.40.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3d94fa2sm291082a91.47.2024.08.15.14.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:46:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
References: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
Subject: Re: [PATCH mptcp-net 00/10] mptcp: pm: fix re-re-create the ID 0
 endpoint
Message-ID: <59fe54ed-4788-b21f-4c0f-03f6463ce50d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Aug 2024 21:46:56 +0000
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
Unstable: 1 failed test(s): mptcp_connect_mmap =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/104105=
32494

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6a0e89f29675
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D880118


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
