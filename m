Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8182F3C3F
	for <mptcp@lists.linux.dev>; Thu,  4 Sep 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993983; cv=none; b=Smu1HpHq7DsInVUutmLgjyEldTmYCzHjTBu+iBJtOqtoXYrNB4rnWD8yKXp/uiX8WlthCs41w2C6CaXNT20QEeo9XKLGRq+bVZeilaKQjFmqwnE5c8rJC3WfFdDTe9v5cQ2d5sIsa2sG7tPcSlsRjE8Zxwe76LB2fdYW3+RSQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993983; c=relaxed/simple;
	bh=WLqARZddXhJbBSVaz5NmnriYLiB1gf2MmIGEtLJTJFA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OwVQtwqlPxswnWtg1nmOFGEcvcEfkVdh7ZWx++gcmElULwNvB8u/MSHk53wjsAXx0ReYFvrUQ4AzQfOVTJP2g5TrUscsMyI3I/0qECK9S5f3bhEv2i/BPznLXF1U9iQ0QkKQHQRSLoq0ZLiQH6PPC/RH3d0AlIV26IbD96f3Sqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1ie2naz; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1ie2naz"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-80e3612e1a7so112360485a.0
        for <mptcp@lists.linux.dev>; Thu, 04 Sep 2025 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756993979; x=1757598779; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFpvcFGH5WKZLdpyWI2Re5zPhk05mS/1rMN0XEQ5Rpc=;
        b=X1ie2nazjte4zAc6Yy/T3i6xJW8ALO++YgLbpGjBcHmgPTSPanAH5Nqf8gBOqvYAUJ
         B0AJx4mP7jZHbxjelKyoIzl5y4VYBaPgxIs3gQMyNIrGANJcRFlZgf2bXMp6o/tX9JUj
         7CSDJE8BWwhVyS0rfnoKlbdDuLu2lEO9laXFEplsYCB971B2AlH+7sVk0Mrlm9mXfsqK
         Bu0dtBzPs7pUQKXS4tcxYTwt3tF4bgK6V2k9K6p12gEWoJkxwiqBHrfQCrMXuCdD3cQp
         alLGMNDg4Fhtn/RhXrvpDYnnnwkqlLZu6gJz8ENOlXi0L82VyjRL1V/Z2eV43/OsL1yZ
         OwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756993979; x=1757598779;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZFpvcFGH5WKZLdpyWI2Re5zPhk05mS/1rMN0XEQ5Rpc=;
        b=NbTrPTP7sAO6ZVSnO+mHXujtrUMxeH8UjrYOwVqqVDksZU5OkhP2yST5rA5BAP2F8C
         he1mByCddU0ml5sktUTZSIATMVJCvv1edkdfFMjzQJ9qpk9WKQPhFJ9fC0V8ixPSIjcj
         5j+ZQFqKsrWMPDS1wqrdVVL6KO/zKYfs5tZehpExoVVDKtbFgOA+qLZhOFf7Ff981Fmu
         MBgjOLKj1XnpskIKndaAh+9FI9cUEtdF96d/3H+lvbMnejkU3HGREcTTcqMXTchzMxLG
         rXFc6DuplORtrT8cApKIj+OkmBN3fQ9RN2JLbTlMgrrrOXmI4sbSkTIw8Gqah1XjsjXT
         J3sw==
X-Gm-Message-State: AOJu0YzUw/i2jGLu6hfAqcFqC1D0GLPDMG4ZtT152MrLdLLYQyzv1zPy
	Vgus6Ch0uD850ORm5JaRd4fmpvAhCJGqaFjue7EqECYzdytmnOentn8=
X-Gm-Gg: ASbGncsXWZcdhv/O5WRgiMqsA4sRNZZXqkM+oVl5YN0BVRlLNWiEJWBWgaeaTGNefSr
	UxMl7D9u+7DVbrOsim1Nlq9X8jM1fqUJX/KnrfbM/7nq4csydXGOKQa563FCMvUl+Qc9zhz6hU0
	ORupY4wvd4KQ76RUHiowrrDOZEXpE0x27azYJyB+r42vmMlXmaFAJzIRqDrTWOmDREPZao8eA57
	FlFFGwy1nQ13neOHBR9GH9RBybqhemUcudYWpZr91RaNpnjkZ8gHgES0HGITn6UdM1eMirhAKv9
	eXBWzR1nOns0ca4e2ydmQwzMggmM4FFAcQa3rnd6chKYIyZlnzHvo3hEqRmmWRrCiBDZMZjzPaV
	1SK2Kqkg1nP0N8snjTeG78cirArkVs8qL0T0rU0hgaLdsKw==
X-Google-Smtp-Source: AGHT+IGSZy9CGqbTuvTMhvL480/TjmTtqpVDqcFh+9e3FB50REoq5MrFlHeNvmiNdbmzYHkmFB4Qrw==
X-Received: by 2002:a05:620a:2587:b0:7fc:23c3:cf78 with SMTP id af79cd13be357-7ff2bf5203bmr2070793185a.66.1756993979229;
        Thu, 04 Sep 2025 06:52:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aac520d75sm285459785a.69.2025.09.04.06.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:52:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250904-sft-mptcp-join-add_addr-no-retrans-v2-0-a019e6678628@kernel.org>
References:
 <20250904-sft-mptcp-join-add_addr-no-retrans-v2-0-a019e6678628@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/3] mptcp: fixes for adaptive ADD_ADDR
 retransmission timeout
Message-ID: <2b09caab-f7b2-4fdb-dc97-ad223d3069c9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Sep 2025 13:52:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Unstable: 3 =
failed test(s): packetdrill_add_addr selftest_mptcp_connect_checksum =
selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/17463051487

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7003d852301a
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D998827


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

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
