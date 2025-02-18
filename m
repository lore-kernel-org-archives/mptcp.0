Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213D1246323
	for <mptcp@lists.linux.dev>; Tue, 18 Feb 2025 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881947; cv=none; b=uGtMZNASV2xVo4Cze+JE9OCbajBgikyCPJ/FSpI6URg1Rb+f+brPXm2Ay1bRg4caUEGsw4gOo2i9+bVqMChHd1I/Tvvx3l8g6bBfN1Tya1QBggowv0hFtsPNBGVpGLcLhkqqgZx6/ML++o2GvUA+KyldM6kSTy/EMjgi6oFktKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881947; c=relaxed/simple;
	bh=ZaH8i0BGwGecUQaO8wj3O6KczMaNFHD3GUOUReX6EtI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=DXHjTxogFxVoClyeL54NIXQx9+YZtlH5ejwL2aegzIFMFzUl/QirLMfvp/kfDBjQkyt2rnXR0A0tPTvgHIFaoT3Zi/Ipf6dkCYv1j+pCeT/gLRCE+YJN+38gTx/p9MZwJDoJUXrvMY79oVCquSJmO2pgmrmRle5lA9SgiXD6hHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLmdMcEl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLmdMcEl"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc32756139so5513896a91.1
        for <mptcp@lists.linux.dev>; Tue, 18 Feb 2025 04:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739881945; x=1740486745; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFU2H5Cozo+hCDUExSNpa6N0qM17kXBmf+CJ7wyYVxA=;
        b=OLmdMcElxCHdiT8fOsdTvvoEW+/Bv/K7QtNwwKXHiXtN1htzqmCNvu3fnME6I/2LwG
         TXDYqSnOaGGA7v9NsAYrT7zOjrjCF3x8C3lqFoImqXxw/03OuiO5xOCgF5wlsdFa1f5r
         eDkM/racN/pl+oYSv6AwU+wH8a6GBVpMv0Abm/f1NeXbcrBYByCLiP/akw1oO6n0TSPY
         sgu9gW3LkBEvU28+FfFT19tGqokagXj97pWWAiKo6Uv3/2aNRqdJneJri8GSQxxYcmSv
         WsINlkQAKq3uf/4lD3vDOTUoSPjY+TRaQF1hbvIEat5M60TzvSXq3ZLY8mLovE/7R1rg
         p94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739881945; x=1740486745;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NFU2H5Cozo+hCDUExSNpa6N0qM17kXBmf+CJ7wyYVxA=;
        b=qUQhvg8CMogwV39LOL/dap8EBiN85V+3aBLWBKVL0jhbodGu+Lrhqa+LuStN9ar7dq
         hs5xnTfDbnF2wflW1xTDI7INoNp82LLExOOEHVr2AshiH3l56mATeeGQyP90VsNHmRDY
         WVa87KkzbvdjdUnct2uqttmzYOutnAYkdZeWS7Of8zGcZdRHLwEm4OQTF2VikkqdbC2M
         n1eEmG0Mf/swT3D1fr3NfWzq0/GlyfVwTGBCYtxv1cWjOr56J56JLbXEoTyKp7ph9hEO
         jmQutOqGgYrnXuvbfiWl6POUhpqpDYpHlCMU4Emyq5ZKvwipXgkuK0QbAHpo3rDxjL7t
         O7FQ==
X-Gm-Message-State: AOJu0Yz9109qyyw+TjTD0BGhkihgWAUUq8LbBYM8lxF5WBYxtaoY4FJF
	EAWmnWob23g4JYeeJwzPZBRA/MaEQ4zdtVZnZoqJp42iNykt6B9NweWs
X-Gm-Gg: ASbGnct0eqE9JzZi1Hz9fHdGEx40Fm8KhcG1Ej+2nnPeW90TosgR9pMtpOPAoXniF3B
	A8HMpiIwGtR0Cz9VDnIp0np5kNMVvqDYASr+Kv9bnNJxepuG45xCHb5gCz8jrq+4eqqkzZp86F7
	mj1BT6Rhpzuc4BqC5CMdWPWjRFljsWCTpwFVyjZAqw8+I45uLLLeFaLqlH6fPIosIS0JqLDz0CE
	2dfp4sYuppLvGYc2fpslYVxoKzu5c+189fpTCcQ49e23K+y31iVrWMkFw4ikxIZWMgAiVYxJ6k0
	sRxoabkt5+0Se0/JffdG1lro4tI=
X-Google-Smtp-Source: AGHT+IF+LJASKNzLjVc4wWiwGQCHusquv/y2F/5EU6YhbZ2DN5Ad2Y2NttlAKnWItmcH5cNsfdHR+A==
X-Received: by 2002:a17:90b:3ec6:b0:2ee:9d36:6821 with SMTP id 98e67ed59e1d1-2fc4104502dmr19351137a91.27.1739881945203;
        Tue, 18 Feb 2025 04:32:25 -0800 (PST)
Received: from [127.0.0.1] ([52.225.37.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545cf76sm87628885ad.131.2025.02.18.04.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 04:32:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250218-mptcp-dss-drop-mpj-v2-0-0c6caa10ec52@kernel.org>
References: <20250218-mptcp-dss-drop-mpj-v2-0-0c6caa10ec52@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: reset when MPTCP opts are
 dropped after MPJ
Message-ID: <dd4d8a0b-fa6d-1769-d72e-cbb71c8eef6e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Feb 2025 12:32:24 +0000
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
uns/13389741751

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/031a27795787
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D935069


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
