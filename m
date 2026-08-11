Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632BE32ED39
	for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786489227; cv=none; b=H/GdHgh1XZVwctXSAvB5oFQsiufw4xJDmDVNcbmyimwDUltF0+0F4FF94q5xjq4o84UobtgoC7FS6sYQuplvrKbaNg6VYmuVwcrFvBW1xDCMlKdcqCFT+y14OGz9moRSUuqUCjyLECPy9X4WzzPY/6aBp8z2+bHtqx424Ctb4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786489227; c=relaxed/simple;
	bh=gXUWwX9pqmLrEerMvHuQNT3r4iTQHnx1WqK2O9HxFO8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=st0layh7/A2gJXRbDV8IixpBYY+lmafZK5OquHqRJZGh5QFR5zg7wNnlDeYzf/kZyl/i3cHurFrM89LyG6dhg/0shJ0rhDvIiy5dbU7zzNLtKOT/sp3a8p7V39EdmORPm1t5v1Q3oOhVo2gCVw35vcjmlzOeUSGp4YgUCowNvNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeAWgX+8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeAWgX+8"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e88b60121so420582a91.3
        for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 16:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786489226; x=1787094026; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YQ21QuIDd7gHrIGf42B/v0zI6a8r2nQv2PXtrR/kKRE=;
        b=PeAWgX+8AZcxIP0j0D4rr6RoJJNpO6XVXJ7UlMefgos444arvBcQ7dXU2tl/CaFero
         Ym63Y+ao35LKypQJG6uZuDrWdNlWnQ8Ryo+B3TnMnzGW2JbJWasd9VFFDT+Dc8R4y9Nv
         78BZtggdPPJ5v9pmn9g/D/rr9vHcubplXe/Ymk9fF7XwDWOx3rrW+j5VUrq9/kMr3xFm
         6nee6XvAA4kEefV3em/XsgBcL5xJcXnOftDQat8hTVOWNrz8d9W+x8ytGt6mhTST8T6x
         R6AGJZf8dA7XDqY9QVmPlr1V+kaaopZtVOQYlt6C4qY8uRTsr2UcloOYtxoqat2lhKYw
         BnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786489226; x=1787094026;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YQ21QuIDd7gHrIGf42B/v0zI6a8r2nQv2PXtrR/kKRE=;
        b=d/5K7has1SvEiVwUlzvYJGu7y/oJspQMRJxPwofa4SaxuqvNSxmE3J/abaMfP0ZHb8
         9a+N8nropgm3df0UcHxZ3RoGJ1KDyiUQJxyi/s8vaO06nQc8qahbBi7RcVTq4FN7BqFQ
         vvA1gH2AKAnWbfVpabrFb4Ui8O8OTsde86sy1CwMBkViTXWML5uCqEkWvKkQw2AsNAhv
         bsnX07X2aVS0lqz1hxfsICGVEv0h94APB2rShi/1Ru5I7fptlwkxfiRiLmofekUYjCzi
         aj57pd7HysMJkvGJMkjBFbVB3QpTCeYPhoKjkRauzACXbDIqRK+IpAG5df4MWWQFPNNO
         n11w==
X-Gm-Message-State: AOJu0Yyzw+inwm+J4G4ky8uBVJZjRnD5Ntv9DVhtHjA35nfn4Vbeb3qB
	kpngz9QBGW9pz668oVxKZq618E/rjFGkIQG0szcg2SwBqu2G01StpUE=
X-Gm-Gg: AR+sD10gZLXeomzEgYrqNFjtAcp64RY8FTgvusLXghZgASh//Qx5VN/qbCAMKOLWw4Y
	BoCG6m1sa6xrsndGuAFLX7gbhYTYQh9caZu/j6svuv0HvRnfbPXHeSEztP0+1yZMznSu29/bwdY
	jejmMgc+X6NhVxJ54C5gJ7UErlOBhO3Bky+HQPtAWOg87t26m07FhvEtF0qSUK9vcstcf7OdIpP
	b4B7SvelF6S3ADpt9uNq1uwwldYWsW/cqvKtVrCk4VlUVQ83YOhcxlpJyug8feqoLUXUn+bfj0X
	l+7HWMXx7hgzlUyUxk569I2bZL1kEIRQG0lcXXs7egN0ZEIgNkaZX976e7qstMX8eYS8eB1qf5N
	47CUsH8dxBr22W8qRb0IYXkoUzX7SouJm00tdXdmFKptk1pmYFCLJiVEf4e0WmeSOLwjd9cesqH
	f3ObCZQKyjQik973qszE00YsiRciJY1tvXtXmuZLcqU/rHvbQ9mKBlylZrLqBY1Vdh+nDELzpDV
	aM2yQ==
X-Received: by 2002:a17:90a:ec8c:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-39301285e35mr563953a91.1.1786489225582;
        Tue, 11 Aug 2026 16:00:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.174.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f94add3asm1128134a91.12.2026.08.11.16.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 16:00:24 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Harshit Varu <harshitvaru666@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260811215135.87756-1-harshitvaru666@gmail.com>
References: <20260811215135.87756-1-harshitvaru666@gmail.com>
Subject: Re: [PATCH mptcp] mptcp: fix uninitialized local_id in syncookie
 MP_JOIN reconstruction
Message-ID: <731b407a-3f05-2429-3876-de03a732083f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 23:00:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Harshit,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/315418=
82498

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/015cdc9962ec
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1144343


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
