Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916E82C6B4
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343604; cv=none; b=kUofi4Wj6ZKsbZS4K/fb1TMxMU1sbVJu3XYq+lh98sp09Q6TibtuaMu6iVhZJECvk6cW252zr+WanzCd06du2wneiNNPOpT8u/sykGyvIGj6yYJ8neZu2GgT6CgBR2E28GKtQQuAgXOzvW953nOt6qjA2HG3UxhFX36pIMIOagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343604; c=relaxed/simple;
	bh=RBXxLnp3lWnTehwJPBwcGyXHEkCitaakDLOXXDG+V6o=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=NR2Js6eA1wxWZ53MDPPSYX37ZxnvWmDX8JpNaEZVieIPdQxLOO5a7NUXZCJZxGqrQbanJZp9WWzHzNMR2iEPHO6F8cwpxHbfK9SXzf59sEBatzKLbpWqw+i2ws3tA9KTFzE/pRBvmr71Dj5yNKVLLY1epOfrGHMyyu4A4XrY87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGiOl0FP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGiOl0FP"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e3bdea186cso261908b3a.3
        for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 03:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708343603; x=1708948403; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zg8nowo2Qa0MKshiclmTEozklGlNtlq5iux6TM6kV8M=;
        b=QGiOl0FP3wF29z+dRHX08TtsRLGaEybYeQK+N43wvUyVMUHo5LAiSpYrYResAd7cdb
         gBU+D/E2ul3ajnLobniYDk6xgycYJMuPLdm5JZE+0hhUZUCP1wpLveAiGeRN5ujm51rN
         kNdfHDTW4ukAuizxe1FpIZGLPfehdF/5va7LhaWCYTODXZNJcbnHECv800JqPfS9bpeQ
         X8+6hvcVenVK2OTRhNZp9xfFDVaS83PAh3uTSqwxTJzwK1EPuVLKV1Xt8jAKeBAb2mBU
         4JhTG+rbaHzp0C/V/eJuH2rz1wryFS4NX5vvie/8H99WJAfAPjtPrfBqWRrJxsiAxJbo
         DPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343603; x=1708948403;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zg8nowo2Qa0MKshiclmTEozklGlNtlq5iux6TM6kV8M=;
        b=Q5bjacYQV3qFofOlmsmKg5bk262lVXpAFEkH91pTtVItkILB2H8IUtSOaiufmkN+mO
         C8PPHhMSiPPqzSByZBvSQT2owbMC9sunoz1jOAFdGAIYzkdSfo0OMFu94QwHve3x67co
         v0W5oGIx2tSsHaPUOQgSRcjpEhrmoyD2eCY71ITfjXUMhjii5MK4gFtnoEUyBjSbY5R0
         gdmpi0r20UShIWP5ad++W96zizpejcvBkVvv7ht/GgrSGLGdApnspPQjdQwzsGO2QGJY
         QEtnVYanNR0gcXDYzRIyfQL5yOW4YFb12ifRtuChy4u9vhBuZsOIh5Ei7nCzEAOx9RqQ
         qN1g==
X-Gm-Message-State: AOJu0YwAmtIs2rHl2DNKE59ppo7K7a3AaSUVXoZiAa8vQUo17j5vbL+Z
	O2gG0blIewnhMwMQvwvw1ajOKsG7I8buCByGOjXoDolRWuKg/o3BYQw/GhI=
X-Google-Smtp-Source: AGHT+IFSblTvfr35xx3shcQH9UAmDkvMKO2MYnCh2VjLsHFgzkwXvJ7L2JVA+G3hIztiimTfTkW6Ig==
X-Received: by 2002:a05:6a21:1518:b0:19e:cf31:6a04 with SMTP id nq24-20020a056a21151800b0019ecf316a04mr12475475pzb.59.1708343602561;
        Mon, 19 Feb 2024 03:53:22 -0800 (PST)
Received: from [127.0.0.1] ([20.171.122.177])
        by smtp.gmail.com with ESMTPSA id ka26-20020a056a00939a00b006e134c4d69csm4591259pfb.200.2024.02.19.03.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 03:53:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <82ff7dbbf5ba256c707e3863ebbcbdc71179de3a.1708334189.git.tanggeliang@kylinos.cn>
References:
 <82ff7dbbf5ba256c707e3863ebbcbdc71179de3a.1708334189.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: add mptcp_lib_check_tools helper: Tests
 Results
Message-ID: <ce333d1f-7d9e-6665-95a2-8dbd1c3597c0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Feb 2024 11:53:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7958652450

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/cd66cc07a3ce


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
