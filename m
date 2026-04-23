Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE7532D0DC
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962720; cv=none; b=LpIqCaggKBX2FRlHEO1ps8ZJ/Hb8pKjwRT7WlDyGFSiziO1KUHrpYMKJOPSrU25YxQ5lpQO4vNNhF++mWGZYF1Ew3GZ/tfJj9h5Yg4NUEborH6vUeEefATJ0vRRgDOZPOo/pM+d7NJzV4cLQuqQQYHk1lvRNS6qoGdKeZdUketA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962720; c=relaxed/simple;
	bh=PmYGVzoIz3V+2gBc6zblQni+4ZQs37rJCvCbFJJrKHQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=oOjJLDOosd6xpewoDcTH5oLOXzPwdAVX77t1Ad/lHm4VTZ7WBjPqFlJoqvTxpPOBkaadCTVPMomwRYv2iPL9NZTpN0UIyIi3YViEQZOeGvVL8k2GxseI3g5IGKq0fpyZaucILOA2iXqfIWwjV1q8FRWk/JkB6Zz7gBGIJUQBH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Twh9X/mg; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Twh9X/mg"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c70b5594f4so755492285a.1
        for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776962718; x=1777567518; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwHUzkjvyPu+AbkwVY5FbHhcmUxW/Q7KOupi6/1x7a8=;
        b=Twh9X/mgyjayGLHZMVMBZ7+mX8CnnE4bmJTRItAjih5pK3UZ1qeny831XtSj9RN7Tl
         jfl9BJBVJ7hh+rYfYJgr+piK1U2IGsCMLWz2wrNEmqCe00kMd5lDWjfSFej+cgepcFv7
         qWvl1SuT0k8TQhZUToyfq/w9uZbBkISF1MJJAtRPMSGlsLkrQRaE2cTiwXrhiuWF9AxJ
         p335D0aSDFUph+6wlFDI5Bxnt/lU/OAJBZ54oPpyZi/j+fvpaPSoHydf8K0jN6I5bMcv
         KC2uvwFf67WzeOsIHLytRuRRR2i0KYpR6SUJrcqx7roqqdUXponlattp4k3TBKbX9DiO
         5J0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962718; x=1777567518;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bwHUzkjvyPu+AbkwVY5FbHhcmUxW/Q7KOupi6/1x7a8=;
        b=m69ytg4tspl/Y5+4AG2O2pcIPf2xPAdGAvuwolF1UpVxw7sP1G/xUb50vmFLVs/gAx
         IH7vKtHzkbdwWeSB9lJ9A0tFOZm89iq15LzjTkmNsi25Eqw3LQY47ROf4bzEE1uuzLjp
         g/iQfIqdK25Mr8EJYsmqI45SLUXfsmN+f5zalrelPsdItIx6KA/IOJZPxgDy7s4RIf4v
         UH41IMWVYBw00IgmdVTDaoDgB49wVMtOhmREMQ53q139hZYg2W6a+2fuOadjbQma0xg0
         XpBQZlFuuyNlUhS1Vg7ihW7MeVYI7pTNJ0dgIvK4TYd+VVcgrkCeuxRBaA1ea+lDurGB
         gjsQ==
X-Gm-Message-State: AOJu0Yz/uJk0pJvmD/NvEmjkcub/uPu0p7RicDgL6rpeARjnwseB5cS0
	VenC8thNpuodK4HZ1tuSwoCBMTqAWjAkeLfsP9kHQqSGp1JMfoyRFwcMQrJI
X-Gm-Gg: AeBDieuajKbUrrmKIMk30IEfUGhY79gLzdmKLLDU5MQBMIG4Lic8i56Q1VMgoPvfGqQ
	SDB8mj4T3V86WppMFSd4A0O9xMiOPxf/gJldBTPHrh6eKrK8UzFa2vbyO57rTGyNAB6ULzG7kvH
	wsTFZ9ygTl3GdiKPSnzlWZGJS3mKie6a2e+8oRk8ZY6HecaQZ/hMjY7mEA1UADuYLYddXBUi9GO
	jZaHM/687AkWRDy/H6UkDMJAR8KuEG/XiqYs+vpQcIiDW5aMD9mXBOX4+LDqfI8VLGL1IDY79jK
	CGse/MmrxWPaccSARU6RkSHi2PPQ4HPD+qQve8nf1XzFakMm3L7Oom74yhNnpaGHIzMMpG8LuQ3
	ALC4KM0r4PmxWHHriKpmdkT7Xp26D1CqjW8lwQ88ztaNH0w9e3oFQLjNj4U53qkwqSWy4BAqD2z
	cY11v9xxPlHjkX4T8NtjuWkOJhHnKyBoGcPMSFc0vA3v7rBMM=
X-Received: by 2002:a05:620a:4481:b0:8f1:9e59:21fa with SMTP id af79cd13be357-8f19e6869b6mr298542585a.5.1776962717680;
        Thu, 23 Apr 2026 09:45:17 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.54.104])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d92ce037sm1591110285a.32.2026.04.23.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:45:17 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260422091927.77770-1-gang.yan@linux.dev>
References: <20260422091927.77770-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: replace lock_sock_fast with
 sleepable lock
Message-ID: <9899664f-365e-ae3d-f09b-6142d05a289e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 16:45:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/248444=
19761

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e433f0995d36
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1084186


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
