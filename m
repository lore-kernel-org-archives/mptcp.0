Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF675312832
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778365445; cv=none; b=nFW77psvdm1NkvuAP0qoGVEtKm9Yr3p8XxgfG67v9ptdDO8slGJ0YgpZUkgc9cFdVkRHFLlLEndOOwgiamQucrhz2etYHBRFvfmRaxQ4s4P0PAmWKVAAbdU3d7gIADMU3dFFZwdGTWUS/0oFEdqlqR09jlCml+DxHI0b/FBdxKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778365445; c=relaxed/simple;
	bh=ArizAGQjjSTgCs9zAZQP6WqyrYu+TI3yPSYMeoxmgM4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=REFSbInY9ipwlsvA8KAuxjR6MVCXl4yvvTlGI5aM2sAO85r85bE8T5DnCVKIZFUbCmea4X9Q9zmRNLxZMTzsMVXiI9uVX8PPkRcU4HzDQyxy92UcasVaunCqZbfRIwbXKFPTbnz+FL1xoq88vBzxWzm3k3ecbu591iIkX3XiOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICfV7uKx; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICfV7uKx"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso3521878eec.0
        for <mptcp@lists.linux.dev>; Sat, 09 May 2026 15:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778365443; x=1778970243; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtMEznmKol/5IHHwIjKcYYR73QpRkdrW9Eh74EuEwbc=;
        b=ICfV7uKxIN+ZZhOVqcyRM4LVP6y/FmshfWtKcATfDAb4Wx5S57kdwDE9pF99n1tosp
         ybK22xqcBHxHQ7FVLpfI36zx8FgDBQ9UK6Ure1cjw1qALnELPRhoXaivWf99wT3ZokXu
         y5LL3q6E7bgFPYFk8JREXEaDa2gBtf+GxEVhKT5hmJF2f0Tr6Wk/QxC1cpiADZWATwuu
         uETNLYc3MuTdvfLUE+wKbLgBp0pfUOvQKlbFzYTeBxcJ1aiQgHsUcD2PfNRF6KZl0ihZ
         MtEpiD5b5Rw2bijfRxt/ijv2fUOT2zFhrnjshKbcPRz6NxDswi39c3jjkxVB/dYDR/W5
         Q2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778365443; x=1778970243;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtMEznmKol/5IHHwIjKcYYR73QpRkdrW9Eh74EuEwbc=;
        b=U97gySoWflIWp4q4HpTQhc6bp2t7coU+CNTUQ3VBtH8Sbx5epOFh3YHn9ylU2OneNL
         xwWOy63p6gpJyXysfBikWSz5aju7PkrJqwjQuqrcDhOB4zzgsgPUixcvdF0+/uLETFGi
         oWYR9sfaPBGeMcyjSDefaYcKiGmNnGP2UMFXM4M9F8Kre1UUNiaEo1y7iEo0pdycmBi9
         iECbhjaZekAnKRBnv6+da1GsHs5TeZYIYG7diLT0OEmJDF5d9oyUnfI4//0ETT75y/zZ
         EhkD53VyHsQNOPawNQ4RxjGWz5zkib5wOJtz87dhD4tH4//bNpqpqVvk1ljhHRGJ3OdW
         TIIQ==
X-Gm-Message-State: AOJu0YwcNovMziB6jT7y5q7ttJYbhmY25LnZHu6gzbKKodb4uCrrRPMb
	xEgxhS721qVqFpJGJc87qMbpYyT13mJKQB7rOTJrJahbedlJsh+vV2j7U39f
X-Gm-Gg: Acq92OEJTuhxX0wlo0zMa8I73aAwDDW07/PStO7PWe7Q8IZ0tkM8JkDOquc8a0heBKI
	CSP1VnQVXGWmaZEqXEjBXoqcqjboJRCAjsjxAtQ2dOK/NsA1V6ZuSxLT636I57lEJLFSlWPLwJ4
	XSrxto4KXPc4ONSNMQR8heVHlE2lfvq0QNRWe0BD2Y4FLKfBrvJUqef2vq0pSYzIFthC3GoiZlc
	qzIQR5ihrWs+NTAWz8udYRuczehDg7CxVjS55a4khpZ8V3JACpAYwjh/SsB5m6jzfXOYwtLsChI
	u/4vDp21h3SroeNPPXqtEgFOCJK7wrfZeY+Ti3bE8kQM6cTsJkmFtEZMaF0zORrnRgrnUQvodSH
	ndxUnFcYrwcZJKwU820mKXyNZx1KZ5okSRKkAVCsHzTOpi0mQq53OGBOkqpmrXVZSD8L/sCBruI
	Y6VtHKmrfbCCS+K6u0Ks8hegjx6mdSjknmjuymK2jqaMLtJzM=
X-Received: by 2002:a05:7300:6d07:b0:2ed:6f94:9d94 with SMTP id 5a478bee46e88-2fb4b733457mr1597170eec.19.1778365442715;
        Sat, 09 May 2026 15:24:02 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.12.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d429asm7726801eec.12.2026.05.09.15.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 15:24:02 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260509211651.104934-1-devnexen@gmail.com>
References: <20260509211651.104934-1-devnexen@gmail.com>
Subject: Re: [PATCH mptcp-next v7 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
Message-ID: <37c9a699-4cfa-63ca-7d24-9f71916a1cc5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 22:24:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi David,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/256124=
42092

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0f646cd55809
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1092123


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
