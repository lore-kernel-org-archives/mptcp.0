Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99C21D3D6
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892561; cv=none; b=Qn/0RHuTVH7t6NXVa9abSsC8UCPcIJOOrWsltka04eyHV4ccoXaYmNTksEjftYz83dJPO0Jh3mQVyj0OcNv6ygNSUJWX8Wz2pXgWdt80MH3yiUszrC0PTnJflFkIvQKw/ax4oo7IzXm7cLDqHUrmYKG/Oo43x76BpWUnrIuUlKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892561; c=relaxed/simple;
	bh=cTo9DMzzlHY9No2xuDKJXK/YQ0jHwIKwAgN6xEIH5lw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=MxbICUgBH4CPlShoWe3gNiOyZEmH7Mpf3vQTdqFrxEcUs5a11zCyal1w4G+AgliMOGvWw/nrwOzonyunWVGvVAhZH6D3b7CR4K4VQ0qFyzSMZ1NAIFolD4K9CfkMAsv/RK2o5scNqQbMXJnGT47v33hwn+qvluyQC9z+pzAESfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhJvwvFF; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhJvwvFF"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6966e1a0b91so2263937eaf.3
        for <mptcp@lists.linux.dev>; Mon, 04 May 2026 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777892558; x=1778497358; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyhGqxiBncnY5chAb8e77/4J1Tgbs+aHu+lfbDfKCsQ=;
        b=YhJvwvFFVWoJ42ghgLgZNnc8TEz/e+Lt3qQ9rNlxXr9bw+Z2aht3RMumAW3wAFFPYM
         wNAMqcu8r8MiRCBTmCe2qWnGJJx+nYgifISiiFVvRHjm9iLxS7aGqLJjfBdh1BkYnJSY
         G/z8LFbQCnmhqFx0+VEiUYj5Iw74Bv8L9B4jp4mtsCdxe1ipJFN3ZJeB8aKec/FiGvV+
         HvmPzxZEN2uOodHcz292yuOZk8ubHEYoj6/fG1AjKYclQlooVcgzCQfTcLsk82Y8a9CO
         L25qS9dV8bVuDpbhq6E08ekeGkJ1jrcZMYcN+JiPEOkZGnbt5Ur2D2vdDwJCTd7vhmWd
         a2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777892558; x=1778497358;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyhGqxiBncnY5chAb8e77/4J1Tgbs+aHu+lfbDfKCsQ=;
        b=QwQ/taUMZhDVZk5Pw9ymfoour3GO3dhF3A8Ix/NWPpuJ3rWBdfL9vUhSTB31SxtM0U
         s+4Y4gKPXCYNSL1kzxDZlBSgk3nZnRwkmhOKk5OXxTKIAgOwhACF+epiLYzrY+W8vb2s
         /ci/tn6/axrUCmqS8bY07HPAWQcjJeJcRQXUA3HCj+jvxRBMAvZX0LYYuVtv8cFWLDPS
         vB5L/dRu1FgEAGY9G7MU94zSs+Al8gNpdWov3pLOB8Hcr+IPlKV51n0xMT3H9r9glmcl
         /qDW1F1GAN/f+JrRDVXdQbuv4GFKBeKiaOuNWSOvCNtWJTckm+Lt0/l3CxCORLThCnLF
         Wz3w==
X-Gm-Message-State: AOJu0YybCJSk/SOJMXYBxDVCEOKXVu9uk61DdesRq7xuzXF8PgJKUheb
	F2ktL6DNhII4oM8ske4+qCZJ2yvMVentd3CC0W41Iy5KsVud8VAI4xg=
X-Gm-Gg: AeBDiesFgO38hyLeTCnefN4/ftdi6Qlwlq0ch4dWbXUELc6+agPAZkt0MX3L7p3BoHL
	p4fqur98La/ye+TnSlPqVTzE8C6XGaTtCvh/oTQT0mGXNoR+30TVOo6TWkdEC9K3CMEpaDCGQ55
	qIEIddFADeNrq32xPrn2XnzSn7zAiX6o04FCq3syJrfl9soCr4PDjeHSd4HkY4rRdEwSiXt7Wur
	UeISAPbIaRWDnItPJuSLwIQpyga0X/uw93djK7AHGdIftLYtlf9Qls7Jx2DhPtYvqF1woRE58Dw
	O4LFYMhI4Pzlo0eTANswEs1QAJc6S273efiAK427TO/DBMHtSn1nYexmR6NRls1HxEVhej7gSE0
	u1rIfXp3pGNz2T7B63HILpxcsbypsIYLqyICuEnM/B9lAH6fbLzGwOpQsD0qjgf2USZbj2pOSoD
	eXN1FPB2w9+JnhMe8SWRoY64e7GdUC5m6xLQIalz6u2NXsCiI=
X-Received: by 2002:a05:6820:612:b0:696:85b1:7fc1 with SMTP id 006d021491bc7-69697c661a4mr3924588eaf.45.1777892558067;
        Mon, 04 May 2026 04:02:38 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.161.41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253259sm987234285a.24.2026.05.04.04.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 04:02:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260504095101.852039-2-matttbe@kernel.org>
References: <20260504095101.852039-2-matttbe@kernel.org>
Subject: Re: [PATCH] mptcp: fix KMSAN: uninit-value in
 mptcp_established_options
Message-ID: <dd41d2d6-b119-b7c0-0f66-e98dfc55cc6c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 11:02:37 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/25313209741

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f5d0fa2e42ba
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1089187


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
