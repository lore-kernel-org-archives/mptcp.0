Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883A238DF2
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726027231; cv=none; b=oqf+tIiZOGGXQ+4M+3aQPN9nROY8dgmL/IM+VUxMy8m2YzdxnFdYsLpW4UVTqXKlaKUklXUIYMJu+SdSH+6JilYzYJj5pWfJFn0Bdir7ykEmUjvzbH3TyIdAMx3TlTHUDOTl1CNtFCENN7vg1tC9Fii3CuasHqRtgaC6fSoZHDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726027231; c=relaxed/simple;
	bh=O7z0+wZCPi8XEb1yKxZxevLNZvyYzUNsCVco3OpSGSw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=CgBGB30VREYi2b+I7pgDXh1z4/4yrK784nW0aOYLyCIRHjynpYetL+hdWqEvNXglEKv1OY0N+dxbMUv2HxjwmMb/VvLI5+hASVUtN7u4KOoyOTRK/Qg/vHCeEUXgsEcjVdqIKmlCLIWpCR3oMIUKFL4UcY/tXGtzrxjVweOvqok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS7vlBe6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS7vlBe6"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9ad15d11bso343868685a.0
        for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 21:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726027228; x=1726632028; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nx7BsEwo+wy5oauSNr7b1iemuQI2TfjIycL1prgLFtI=;
        b=fS7vlBe6N3lE+HEcgHsJCDj9Ba7ZcjqWQQ7rXVIY/oQceHzIW4KvABKf3w3i7Cjvuu
         jnsKeCERvHG+8CvF9lTSLhovWRv6Hydefi4DGoBc7p2BKhVaeP69w3VQeXd9+69d1Yhu
         1PM3wW7Q7rzqYXkO1diLZlr6Uc+KknqBEkojOhYMN/kkzph/MNPRijgvt4M/fDJ/ymm3
         ePBe6qziK+T+FgQb0bje27VRBOoT8TG632VvTTqVQffEaGJN1Foz8+sX5l5wQxLFs31P
         dEjZGmIfGmDmb9lRltj6Sufz4ciu8M3RkxVE881aSq6FAZfI0KDIPR/wBo9DYKtkOWWP
         8AkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726027228; x=1726632028;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nx7BsEwo+wy5oauSNr7b1iemuQI2TfjIycL1prgLFtI=;
        b=JKva6Z19OVw4bhd3Jqbf8aSnmZjQYN5D1ijKZccovrZSDawZsR9q0Sx7zw0nKUgJ7Q
         2hMbGX+v/QBbt+EYweyLgZ6Fgc6UaX9FEMEb3mp8jsz8wHRBoN9GHSX+Oez9bBAu6ayd
         BE4ta7GD17sG36NG7Bw4lhYJejr/qjvRFl5UhaLnYTaI+S/qznX2M3k14r+VVVRZrKYi
         YHhl+R9j0mM9xKS+xBw+afET0O7LUrx8cXZQuGZgZvTDSt/KlmyuFhcEU830EkKduHc+
         ym/tajaE/TIpxAIKwlPRmUetVK60C2BsvRGVAWj4TvhhvEogo+nonoLxAscLJ5Wm82WS
         mLkg==
X-Gm-Message-State: AOJu0YwwWJaaYSmsbBvNcjeAh4HFiE3RXlmBML0K0IY5GbaTg1pyhvEq
	khDF6iEFjrP2Fo6YStMhP3nw9qc/hdLrYc7iGnvfNF5sTwfN1CFudqbi
X-Google-Smtp-Source: AGHT+IHHeztAvgyjU4MnEQ9LP9nH63frKO8QHayP9FfqXQVGMfjTvEEaIYW8rRLDPIR33pD9r7vaMQ==
X-Received: by 2002:a05:620a:170f:b0:7a9:bba4:161 with SMTP id af79cd13be357-7a9bba40476mr1377408385a.46.1726027228394;
        Tue, 10 Sep 2024 21:00:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.77.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7967ccfsm373115485a.34.2024.09.10.21.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 21:00:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1726023577.git.tanggeliang@kylinos.cn>
References: <cover.1726023577.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/5] add mptcp_subflow bpf_iter
Message-ID: <6ae736e3-16a3-c1e1-3d40-3bacd93e3534@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Sep 2024 04:00:27 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10804410958

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e82320bba409
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D889124


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
