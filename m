Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4763B6C0C
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933151; cv=none; b=U7AKJlVMv2t62gwng5toenm+bOmAWDYcUYTX74egFS6Km9T3Ii6j09Y7UAwfsen3czg6ujI3KyvW3DqWvSf/r0UrixbIk8noYbzBEu07Qjq9qxqd3oVkZ3cL0xEDvwAKvobpnPllCpyxCiqRA2x+GB+/dTZdT9fykYH6yel8icA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933151; c=relaxed/simple;
	bh=2zjV+UmD2+wRL7xbmaslHGN/dtJn/Ej9IO6TIu11gYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=N/RRu1n6fCVTGQDxu73oGoOgeaH2iRPQFlwK1+2lPkEFI744lu+ICBJS0yXjMtbo7Gzw20A23Pvo2UkntP7ybN8aNjzR3L6kpgqwYhoWXGLcMFhHEaLhsRnpoe3KZu9QLYj632dcbw42JwhoU928qfCSQrKQ5asdhv+XrHFmXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Me5q8YXT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Me5q8YXT"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cedda2ce6fso1669395ad.1
        for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 01:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783933149; x=1784537949; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MX8VBhk9UjNRIdZ0S35K4D5EoragTrFGAnXAu6CQpAE=;
        b=Me5q8YXTZvaIpMfWZd8u7bq2jomZwPDqudttQZ7jDvgo2QNaMlKv1wfsjSm4dkkhfu
         UZms6H42PZ9K+/6Z6kjkdJddS/O0YtFZk/BYPIyFkGl9GzXS8GIPh0IKOo4e+3nLo55i
         QFJ4UjtPzIoiVDRUlzfDeDoyYos7ThBiFnoGBrHMdT9jcft+rk98+N/3egJWIpy3Z6iR
         MDUhXyuFzpgYZVRrmFeTdJoSV0qYreXi0Vs2ZM21+9WLrazeP5qflrGNcp7KWQ09sUwO
         43J3VU7UmJnCm1lY0MzHtrDyb6AYjZYAbUe/7mUCbtEgdjxHgj6uwgFbvSR+see9sAmn
         H7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783933149; x=1784537949;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MX8VBhk9UjNRIdZ0S35K4D5EoragTrFGAnXAu6CQpAE=;
        b=VeYh3hpn2dlpL1K7dlbLzu8DX0FeKpTcwhLLzyvuJtPeoRExRnbU+ZrZStb8hT0vTP
         tXNc8ZHyxACZJ/1qGF59kAGpN7fLXee/dYuzT/53yW9nTUUOSD9ikpgdNaKnlJ0narKN
         rLsjB3t2U4oueAWlV+4O/OiDTGbLM1BjdlC9xvGGZ22hKPcoPh8FLvdQR53LfeHGZDm5
         K9oBDRxoIL5wYZosOesAKXQfzPFAQ5b2SGPUsENtJPc6tTWwY/ImtqSj9B29GaEuy+zm
         E1yhLL/gAVULbfvjLLHIt3XlBhen3G5POL7LZiEJJkDUu5QEJQ3GfzN+AmMYEnPAKHiK
         nYVA==
X-Gm-Message-State: AOJu0YyVVSchaL7OtZ6PNbNNEwngatBDzDCex9PY3BfYfFXlvYaW7Zbp
	1nwiecsEmlXcm5WnLZOi0e2Y4PdKsUoSajAYpD9Q2t5XL9EIXI6zBsfl7yVno4s=
X-Gm-Gg: AfdE7cll58hz79l4ID2Huq/xucb/mS4nFTBo5x61QEbLJ49Vhy3Ayl3FhE+26SWsYiC
	spu/Kxwzh3Af1WOFSDas2/DlxN6rVq4n+gFkeji+gTbO+PGOlODjmLUgsy4hgKZsXnvDl1WpD3s
	vHTXJdMKaQRCeO5TszPzvut49zatFlrJiVZEO4bnEuuuR2V/oHk2UUaqGksQX2sz3xcsvXfXiiH
	EcW1VTzu5CVZy3O0BxS36wFsjx235aiMFxJZllPC48JA1PZLC9HN4uebOiSo4lSrHL9f3A+AD94
	FGedoWtE1iUmwu2nERVvrAL1KHcVjz4aa63NsEbnKyDN5m9h15bB+Oly3buit1lqk370h1Y/LcL
	mNn3pHGLE5u2Zg097uNi653mYiuKvC91PYjJk5PcAQbRfoR30vfVAkraistzwKN3PKbehZZXlic
	FDtwZx9jnMz08/3zYel28GeQToo70=
X-Received: by 2002:a17:903:2f90:b0:2c6:8d95:fd6d with SMTP id d9443c01a7336-2ce9eae3af3mr73918885ad.21.1783933148827;
        Mon, 13 Jul 2026 01:59:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.47.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ce95e001b1sm39656955ad.66.2026.07.13.01.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:59:08 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260713074722.47921-1-xuanqiang.luo@linux.dev>
References: <20260713074722.47921-1-xuanqiang.luo@linux.dev>
Subject: Re: [PATCH net v1] mptcp: pm: fix use-after-free in
 userspace_pm_get_local_id()
Message-ID: <d0fe7a5d-905d-8ffd-3a8c-0c1619187b8c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 08:59:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Xuanqiang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/292341=
24591

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b45c87910b87
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1126398


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
