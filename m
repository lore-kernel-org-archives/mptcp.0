Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154EC3EDAD8
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497127; cv=none; b=eSIgyCLVk5Tx9tsocdQeeHBzhbeoXhL2nMM3oofR+frIBMsBO0nXowdS1KvjlsEgs6q9BMrE42gWKV4+qx5csa+65l7qWFCUwctRj/UdJRImwZHsvetPfdlYuml/VUSD+voLW/Vyfk8dsBjPEa9auXbrBkYHuEQGUKZJ94ILsj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497127; c=relaxed/simple;
	bh=h0+R25o/nqBvkI6KkbhNUujRhaGHgwaR1zFlALXGcaw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=gq5M21VzBAKP5F0AYQzhS0Wk+no7FOMtgieTrJ2eFxFThc+lntdI3eHAQYBFMLujIdJLu/ZTYeHYMixgXeMIkYS7sk8MsFMOddkPDGIOW0hpsrwY+pxy9lFXijCwyFtVSM+UHagVD7K0spTlx2kymSFluvjg7AWGeUDsPw5udLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dt352094; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt352094"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caf228a910so5670135ad.2
        for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 04:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497125; x=1786101925; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rbRtKMYEGnTNIp2m9ZI+jhF/PMSpsL5F9OnTXTWMpC0=;
        b=Dt352094tvBmAJQOlEhr03LxhevDRI3IgXWImvgpiAa9hZUNWThIAX74h8YeUjPW4p
         b1WOCkxFqi+PHnLzyrKp/cLaM3Jat/wp12IIAbQ1LEoqM8ksbntQQlrQC36KgyyEEDH2
         Kbx8RyEWmp/MfBdI6tkpXJeqIZXDQwLDSR+FL9XTQXwMtEvQBYCS007v9jwK2UNpc3Ii
         h4xRvL2NMacHJeaHyjKKWlfchCVmV92YKoK9BSpvfPuimEZmhTWLu5/OBU1kEuBuJqd4
         kBleUSJWv////hvk/Hhu7/fED9wymSK8ROXIjr4RADrumh+NoTag8gu82LcZwRrYFSfP
         v+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497125; x=1786101925;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbRtKMYEGnTNIp2m9ZI+jhF/PMSpsL5F9OnTXTWMpC0=;
        b=KzUCKC8bY6bi4tpWRG969Bm+bQgvzbA/XArQEJZp4d39A2G/h6kZ+Q4RMi3ViCEw6p
         VwnW5y9RSPhhC8diS5dVXUqSVDUJMU1zaq6hHLRTeogI3klvLzIyaXlKykM0CCTyeGNv
         /hMIaEga7oVPGuN8sK39/7OM/G17SOmwGaDydC4zi1zWYIrqjQ80GiT2vEAKFsqGtK4M
         lJ3lwjrZwBfaYUbZq76v79yQPVu9Tz6WVL0xC7bZ0D6zEUc2cYjh+ZK9TDqb+cwGjTpU
         SzrC5ueBgGRDsJ31SJTt9ELR/Vj9vk+bcM+WmCo3U1zDQal1IPMVv0WdsXcHWXlrQTGm
         zCaQ==
X-Gm-Message-State: AOJu0Yx3xhGWTP8p2c+uGO8dnkUR1O3OeP9mJV18his3ctRfEo3+bdFv
	ohWt4idYV4vPWsT9MJDsS0UPQeKMPCA3d8/WpKAsuHMbOo6+axBGTHb8ahmp
X-Gm-Gg: AR+sD11t/tIQwrgrZT/CGR2sDxA/OUL8CeG/ByJIe3srVEtKLzRXJdTTdywHKTU7Roa
	5BA9JaW62J39mv8LGD1D6viablFhEo0a0N3uCDwAZEQtv2KDo47fUubpr6K44vu+3N/zBzSFPKt
	ypKtJXLibYtirvSirsohu+HmxrBsJ+Y9xhJUcYBa2hOg446GW06iFJ7xBdzzhKddYM63CRKpbtR
	xLBDLsHXbM+Uy+pAf/16agJaeB6glKCXAGesVot05zgJ9mKre8bPg3ahjvd8cKA8kNqP75Dfo/W
	VjAyM86Jo4oqq6Xkgum8D8xo3WX4aAhoTzeEzUft0oERnMHj1T9ksX3SO7AbYX+6ymG4xSE2dtp
	Ap8c2AJop0cOJ6HDwR/lXOff3LhSsAjBItZVFbhGt/lPR5ebBJvWYJ99oVxuQ/aZq9WkxEWEVOg
	co/Y7MhH3yD0qHd9dKN8+BoNw6JDhgQnAJqVRVfyyMuZx+5QQHumZO3Tvq6HuU6FzBQeid3+2XR
	0m9
X-Received: by 2002:a05:6a21:998c:b0:3b4:605c:2163 with SMTP id adf61e73a8af0-3c91b0a25d1mr1728857637.4.1785497125262;
        Fri, 31 Jul 2026 04:25:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.224.166])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4f197sm5333926eec.6.2026.07.31.04.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:25:24 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260731-mptcp-squash-ooo-pruning-v2-0-499a523bbce3@kernel.org>
References:
 <20260731-mptcp-squash-ooo-pruning-v2-0-499a523bbce3@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2_0/2=5D_Squa?=
 =?UTF-8?Q?sh_to_=22mptcp=3A_out-of-order_queue_pru?= =?UTF-8?Q?ning=22?=
Message-ID: <2100b134-73b8-fcfb-1eb0-ba0a80afe9fc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 11:25:24 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/306242=
37503

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/94cf0d3c0576
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1138063


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
