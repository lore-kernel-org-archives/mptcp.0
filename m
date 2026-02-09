Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0295367F4B
	for <mptcp@lists.linux.dev>; Mon,  9 Feb 2026 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770634108; cv=none; b=ZxW1kkf0bRQoZzYnfQtBAkmI+a2NLGVTNodKazo7mQh5XxsTRnUT/aw6uj5xd/lNsCzcnfQszWEnwhT80aWi1zvzH4RomO+0xUcL3Y3NNCsa227j69+OJhryqfxHItSLX/lPrsXZ3La3egFMsNH2U5Db8IcBom2VrpmKkGl6VQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770634108; c=relaxed/simple;
	bh=60HszaKwPmDvWRZNwbyamd3RjbokSV03j25ld8wfJhE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VkMh1edcttCVOuEIecLx98EppilV2gUYKj3xqYnIIV6t0tgqNY/H3Dcf+YZocvOs9x217U0/kDxgRy5Mffup+ADqBDGX8O69wi3K/NuoNvF18v9t7twcind7lZiyyxT0ObHHhdvPh7zSmIoZ7k6QKopTMBly/I6oBsa/Pa+ddi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ik2P2moJ; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik2P2moJ"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-896fb37d1f0so17261246d6.2
        for <mptcp@lists.linux.dev>; Mon, 09 Feb 2026 02:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770634107; x=1771238907; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fywbk7BwKxmYKLKj9iOrh5x7bXVCKg/FX5YDbuhPbG0=;
        b=Ik2P2moJsfMbPQn8FnyA4kmHD+iD5MErugc72WXAvx9LTw8JkJ6VmYiv7qOgWGDB/S
         R5sVpiT0pjnsRyj1Sne2Zd/6/vy34uSA6lMc54jAnytDcGwFDPzt5ye6dIWyubrlM0tt
         WGiJO9Z/KSFdGWgeeqnLaPTVSlluP7E87BpHwAodTy8WUfezdV7UOMFxEIwoJzu4EqmB
         b8yXDoj7f0xczgCBHwR1Bs45HSLY3UZ3w4AE+dJmzn9svjaWcrNiFi6gnblLg3LOkH0b
         4PQ6Qza9o7TdE4amdBWD5eJfNE1r6uZWbdOFtFV1QY7U09oMsLVsnssWotO/a4BzdbTb
         jk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770634107; x=1771238907;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fywbk7BwKxmYKLKj9iOrh5x7bXVCKg/FX5YDbuhPbG0=;
        b=XQUpsCzE/MCAM3dADPTYMGIyUzZA0aPDfrgRUH6IcIbBdi8ZAwWFeghyTjM4qQBIJC
         6yPGDHhH/55A+O5bHwWHaJ3r2oE/BBYdcB4JXHZCIAfwvnhE+DXCkeJPyAJNBxcVJGNi
         Zb5LtZR7Q/4sCAehhsvL4euuaLqoboYSO05YIa3jYk4vb1fSjLdrjynKJEgT7poT6+5d
         KnnnCbHtzWOJOAeNX++ZbSiV9GY79xWaxzVDW28prZbP1vLo6yNClRQuVlaP5Pv2Ui5r
         ZhV9yXchmBPb4Dxp2Xfaagzs9iBbgmIoqQULU1pEvBgmMgzPIspIevPMW/ePDZ6Xbfvv
         Nn5Q==
X-Gm-Message-State: AOJu0YwoqOcCE2gYSNnTBczXCRR8YAFABEFHuv4xv3TZVZlRuZYIausH
	JMO4fTXcZvVyjh2oP/DdG7lLVMUdM4MKus/0qEYCFoG3DwTgU4PnKy6zRpPCh7c=
X-Gm-Gg: AZuq6aIrycOvbme/DBRRetSKHU9PYGPNltWC1MH2uowRp9aHEU8BWaZ0cQrxipQbYex
	6rQ3/Ss9M3aDJ9mxlxXZJCdDV64TzBw4ByaVgkaRv1IIJnIfS5shJHEvoyghWoCcYcW9VWzzTXz
	2I/5tc4XUx1g5Tu7pK3qxmmVKjBi0UElGyOvw8bfkpKAVruIkvJgu7827PM1YIQG1txwhBSY95a
	WSvZTQypQRHptRDFuYzyoOQT9aR5c4BEqgcXKC4eX5Jlznsw2+0t4zYRYnmMjBF15FdYJTBv+EP
	iDR7D/WQqyLB8/YvKLoD15ozQyp/tqsll7CHqk7SzxS0fCbav9EzIoryRn7VpuFXqXv+5dFjRla
	G3kuInP87KSMYD9mP2vqf/glYKksxT2wfqWnOTz9OnEt+uAkPhPzjl892bZ8OdAYrKzAQcOCf3G
	gzuyJQtP8FNM98Pkf0NcpojFY=
X-Received: by 2002:ad4:4ead:0:b0:890:247e:dce2 with SMTP id 6a1803df08f44-8953c7d74famr158456486d6.1.1770634106603;
        Mon, 09 Feb 2026 02:48:26 -0800 (PST)
Received: from [127.0.0.1] ([4.246.135.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5064543c20bsm60590131cf.29.2026.02.09.02.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:48:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1770627071.git.tanggeliang@kylinos.cn>
References: <cover.1770627071.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v3 0/7] NVME over MPTCP
Message-ID: <513516ed-9638-d934-e67c-2bc0a61788e9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Feb 2026 10:48:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/21819574281

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ea245e8c4ab9
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1052185


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
