Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A925B662
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762415; cv=none; b=psqh9xsyg0e5tvB1n6QbXDGMn3ZzVn8ItgcmX6BFxVDFq4Ug5B3baZJnqoZQcfAWOZ6ZNU5mqqCFzlAXAwSWRcNM6CRzP5Mtmr+GzJiK8nAsg5aGCDotBhGVAWgFsa4RbQoGydkqau7zMnqokggfCLZgCgUc+rgixIOe83Yx77M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762415; c=relaxed/simple;
	bh=kv0bT76Qc5LfLO5J7LD/eTbVSPJg8/3PpIIBwWWi5vU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=M1L1QgJyotg46ohrOtuMAWzPESuTiNAIYKv+lwyHZ//nUmM55JbB7KVK/4cKZfasEoX+o+7q78Ql1GHp1sOt4iRO9TTnpT61LQzG4a+TPpdCyuhzjzWXSdF7TrC5GlMnbOMmBvLOvJjQ9+fG+sC4LaduX1rtXoH1MrpiEmji1CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjT+IL2k; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjT+IL2k"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c6af798a83so218500185a.0
        for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 00:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769762413; x=1770367213; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaRC2D6IhqyU2dM5adyAW9dAVhYXE3nCTyGna2iQwnQ=;
        b=TjT+IL2kir8s3eonXuPTl/lTcbZ7BKy2NsgGIB9TKLGf4NsIzi62rdpd88xubbokMc
         qaih86qYoHw2S2Q4H8dejheBWSl5RQANxliRM1Tj3MQ7hTwpX8Mwd/UgzexyJyBX1q0d
         WGwkVAeIcmwaYnMcnAc9MClhFZ3TtB4ACFh/LZVjVpV2FjzZJCA7cKZ4X9Zt2gk96X1r
         Yn3eRIbcY1FBSAX7nE1nLjUK2kk1+maUvdz4dpOlQPGQv1ynrtqCkiD0Pa6TNH0UacgH
         tQLp28uBjZdvFqhoLI5TzttbMdf39eEirhyP8K8iVmEply68j4JOGOtSaRxaX1vkiSSa
         dKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769762413; x=1770367213;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zaRC2D6IhqyU2dM5adyAW9dAVhYXE3nCTyGna2iQwnQ=;
        b=nhHmjPwbHtamsxlEH4ZV8GYZ/m9KmEFYxGeEmNOtK3BcTTxmias/ZP3P2m7t/Tx0BK
         HvkWcMcqj9vlVHKMJsoUGIf/1JhvkEQWKYQ+neH8RJMvvZsweeqdctSTzROvI+lZ+wp5
         C6LRhu/k31zAOWi3QPGkViI/iY4JCgRA31lE+rAyKdmrW+dLX8V3K2ZelmMXbtpNsQ98
         vf0568/6vHxf0l3VHq9h8t+snKjilRFI1p4byssGYqyuy62veHgx2NEc8Zysr7Mc8DFw
         PD12lqpFrOVCqH4QGuqEvm1F6ztZoajyKlQB3SuHvfXJBYO0vcyvCk71m+LQDkOQkY3B
         PFLQ==
X-Gm-Message-State: AOJu0YxqLx9O+WZfvym1xJIvGRLgB7O7zJNjqcfvvSmsO2beNSGR0m57
	Fhd/7eF33bZOr75sTlDBJV/4fmEHMQhR2p+14mqPNukYTm84xRhHZ1/9WW/dEnI=
X-Gm-Gg: AZuq6aLMNQmERD+xDZqNb4wsgnJLxwRgkkRi/BjEjTTUaMOy2lpSwg660o7RDiO9v/c
	i/JQCwb445fSEyIvGCAwEJmT8MhhTMawXtB+Mmv1GZaV4E1fRrA3shoKAd+bYoWsGt7HNnkoSkm
	pKsIHHOjZW5Xfu7IvVj6NSGGLTUWDFVf1ueGRGdeZ9Rb4Ejeu1SrPT+DUJXwU9AmIyKJK6rIU7q
	I4bLpBPPDgtNNmzZLPOVOG7U8DKEsOFNbzjJ+MbAmGnACATgpf5yRv8Zk7cTKy70LqoxBfCif5w
	wFZM1s3eSHCDRLYSWFa0Ue67ETJK4+evVS6SXnWkBxB7Roa9Qkn8waBIbG/CHT6P/iTvYt1cIae
	GniipIOXvRKtRfa4xju+5V4GNtAoiJsknsfuqxEChk7Fkp+pEZLeteu97/n7jRqWmv6Q7x1yVn6
	zBQuOKSanF2UcpXoDPQtILc0mq0ufSm+9c6dw=
X-Received: by 2002:a05:620a:3910:b0:8c9:ea70:aa4 with SMTP id af79cd13be357-8c9eb23dabbmr301386485a.22.1769762413275;
        Fri, 30 Jan 2026 00:40:13 -0800 (PST)
Received: from [127.0.0.1] ([135.232.224.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d47e13sm580198085a.45.2026.01.30.00.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 00:40:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260130-mptcp-splice-return-kdoc-v1-1-3363209d2e57@kernel.org>
References:
 <20260130-mptcp-splice-return-kdoc-v1-1-3363209d2e57@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22mptcp=3A_implement_=2Esplice=5Fread?= =?UTF-8?Q?=22?=
Message-ID: <b84ee734-27bd-9885-dd26-43f09fb21420@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Jan 2026 08:40:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Unstable: 1 failed test(s): bpftest_test_progs_mptcp =
=F0=9F=94=B4
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/21508373182

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/30d7bf78ee28
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1048859


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
