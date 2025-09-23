Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FAE28E0F
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758586828; cv=none; b=CmZ0+wlAhhkyh2FRIIHHR4PC+wam/ImDqprg4IlufJTko8OB9s8WgbuPzPS7BcE1asKZZpL9tiLcti4OwRdic2eaO6G1+J4iFRU3SQBok/HHksF+7fpSwFEvUfK+MzFu6I4wi4mKv0oP+eZpU273pmz6tN0mapP2SFffida/y/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758586828; c=relaxed/simple;
	bh=Vfddb/t68vdJHNHrNXK74atgbetVd/lEdcz47BRZC1c=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tWjoPBAb/OVU5JIQDs9e58deha7wmHmzcwHnBCVPN5eJJXvFF3EM4LUCJFx+3W4pkNYFX55XpI0o7W8Js6Gxgcl9QRV4IcZuG1dbEBBNalN+z/onc75CILZc+aPzqJuibA6JpkHcvvLpc2qR1GdKiINyHcVK2Bx1NvayEdFetf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALRlLphW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALRlLphW"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27d3540a43fso330425ad.3
        for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 17:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758586826; x=1759191626; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+rKHLWSTxQUI5xIvXDGAdcCuReTbal1gqJ7RRDcEA8=;
        b=ALRlLphWCy9tyi29aBaPbGQzS7JNzbl3AGlEfXI+P1ImHuFI8MMlx3aUh4lB2xA9rM
         Rvo1/kt+D0J5LTI/6Bj6JMROYh7G3PbzzjbrOFVki+u28J+FmVBadQ2lT4EYJt1Jn4vO
         ultd0ZWWE2z3I2wu+s8Yenp9J8kDQ4gYAiFFfOAeuWy1Cm1AlVErQUdvsZSQJgM3MhSY
         nzd17lJb05sV4LEIszAm14l4dFz/NnQ+Wjy95vFUTtRodFGgpnlRGwiCHnzVvdONrtmj
         kdSoYf8d5e2HaZEdnOYHnx7IuaHXQ1rPEe1MAkNbT8xxBjtVUoGCZYdzjeKqYxoOp8tr
         jC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758586826; x=1759191626;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J+rKHLWSTxQUI5xIvXDGAdcCuReTbal1gqJ7RRDcEA8=;
        b=CuYTeRFiROpvpz0G57GXWOnfEA3/hwhwDXEtP1p1TZNySj+2VnZkPNvEgyiOtESbYX
         v5j17dSAA6cMCJzFkkwnQ7yWbNB7MjQLVu/CKtfPAwa0x+G1yDTZCh+VyeZ2/q3guUkr
         QNVLl706Kh8vrxj/IDd/z1DTDh6Wf8Zi7RdXTqreA9j9HI3arDbYeloUVnksH1mDaErJ
         ITuo9drJAwEGn0DU+ceomzR5pf+V7aTPyi7SzoEzrf4BZtmX7SvlGpeUVoX/2/Z60DHO
         bh/RhZdezihXf9KMEtSNhJGPHDPq43KQghKi8sQqnLLLM3kZhrkxjQG6YC3xIvHOK7u+
         CDJg==
X-Gm-Message-State: AOJu0Ywe0AowK187RGA4KnusebUkmzOK7ww/4l9EsoVSdb+g9FZF+2iW
	Tbb7aXZcH7sFi87f2HBLToKLhc3d6MXTtH2CQUBSoT+PndeR/U5FwM58lDZV
X-Gm-Gg: ASbGncsl+Txjzmxv5RFqa4eV/iVMTdjmdlQNs4Qg+hF6QkoDUWPhLj4fT1vXDKRZWMT
	yDDoXpr8fw2HiJ/tMBtipJ3BCWo80R7JKW5cB5YtIwk/WkNBff1w7TUYDqMmRyBUg3cMlduHe7E
	wfIFNVNDmwypvMoQDOC5GdvN4KBSPGgRmY5s2rPTvL0tePJo6qEYCvZSk1JOIhiG9cDy7WSbDzW
	Ms418g3bMNJ3WwQeiMl0zpDhZgRwTp7ZzIfyTH5I3xCMG25Jnd2dgmppxsvG2EgQN0L9aqwcF1/
	aeW9ta8+yr+dFgmH9BfnXl4mb9aIe+3rKHfvv4XMNFFCZEwtEG9E2g0SUchNz3P6ps6CK/Yf6Lq
	OxFZcCXR3FxgMEieogGlPh9VIM9C0RqdqVyZyO0Rz1HW1ouk=
X-Google-Smtp-Source: AGHT+IEF4XPndftl8Ru2ao56quxffaD27RGTj/A+DDRifRyg97S0G2Ri+nGsqUCjj/xfIAjVkMyMtw==
X-Received: by 2002:a17:902:f68d:b0:274:3e52:4d2d with SMTP id d9443c01a7336-27cc4998965mr8772145ad.37.1758586826103;
        Mon, 22 Sep 2025 17:20:26 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df446sm144751875ad.68.2025.09.22.17.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:20:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
References:
 <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
Subject: Re: [PATCH mptcp-next 0/6] mptcp: pm: in-kernel: add 'address'
 endpoints
Message-ID: <93293138-3960-633b-aa8c-451e76125027@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Sep 2025 00:20:24 +0000
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
uns/17930472338

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0a3de317c9c0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1005050


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
