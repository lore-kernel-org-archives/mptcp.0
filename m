Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6D3FD152
	for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734295; cv=none; b=FXksxpkJHhVXQ2/TrwrFMySro7v4w87xpWFuFtLYxW8sO7EHEV/nFyN2WzJ059Bv2x6BG+2yD6IvBwjwmAtHw+g2mwBpTPPXB6UpcdIpv1NWQmrwz8whgPR0GIAiYAUM3Lz2iu1gTKDxCQj/PZEN8NNS6m6VKjgc/loVJovWYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734295; c=relaxed/simple;
	bh=+wWm2Lq+lS2NmvgCy0CO2DwjUuEfIuOmtyrcAEX3BG0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=HwLOALacg003YWCdfZu1YaruiYjozKk9Zqyby69BTPoFNEb/0icZLEPr0FHcLmI76TpgFsPCt8ANAFEMrQYuLKn//CX0BvLtVbvReDsqd0mpr9txCaqv8TrB6BUA20LKvOYZEub9KR67THFUAwhrYQzUBXkZJHLzLuAW3D9SSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4GHBY+R; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4GHBY+R"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37fa06b39b4so1626304a91.2
        for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 04:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782734293; x=1783339093; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+YMJBxiFTjAKkNyMwOE7ldHvaioOw1RWUfvuZKXz4w=;
        b=Z4GHBY+RI2xcMbbYT71upOk5rXKB+NY7l8UXCJ31vjFRUuxHnmo48Gdj6Dd12ZLh0q
         yZvnEFIdiRa0iPmeL9JPs5haiUaeJNx1ndU1YnP6+QAtMc/yYHUGjp6HwzUfEkAuno5O
         90NQRXGGhNbMd9UE6i2GNHEu3OR427RO+eCj5W9+uwr80+6j8s8Px22Z5PiOGcV6Sw0U
         atc/qSmVa5cy5E/V35ktQRHkBVasSdsIz+vNydFcTE0M6LvBRDWkpMMi58T5AqeJ0G0U
         fCRZvUymFdcp+EaF+N6dMiqhuiJPup8bl9jTt2FpbyDX8Zvo7X/g3GgflE+X3cLtGRWT
         rziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782734293; x=1783339093;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+YMJBxiFTjAKkNyMwOE7ldHvaioOw1RWUfvuZKXz4w=;
        b=V6JcRsPoJGPT5MxAKKSqKFZXq7QbWNdr4OmcMa77Wor7sLGaIYfjmwfKNzwf0kUj2n
         S8Py/6EneGpJtEeBLF6sK78Yi4W2wuhCevDqbv3kctTnQZ6e+ZFub0gefKnCmcp1O/QA
         jrfhPmeaiEJlHNQnfbqvFhvDEZ48wsRk7hj9QUS+a+D99IgKslXjIsumSqHEn3m/TI0U
         Gt/APtRtNkdORzNZx5NdUC37YWiQTDUzXhJPd2tnhQOqDR3YDbkRWbJA7tabB+gbiUvc
         cgIG4j/PFemwYQ3RZxkXvKiQpIAUWkGyBlUij8r8xj0wnPl+rOeqJmnmyCpYRunLQe7p
         pz6Q==
X-Gm-Message-State: AOJu0YxPWxbyfHmNQF+nJUKWnUZU2AJxyPDiPVWAjeCPYmII6byaB47B
	q3IiedcFGISuJMBhTNeIWeboXfxVugbsJX5hnhBpdUTy3731uRZQCn0pOP0v
X-Gm-Gg: AfdE7clrrP8Jn9lsNJ4rEW6Iw1v52sRuBq7AQPTRya8O5ZF0Wc66bRbzGvB7AsKpXkf
	KM8mfWv/C5aLt35i4ft7ZJ+/3FfQsDtoIk1aRwH0rUkYE5Zc45IVPhTeHWR9VzAaQ23OSRIFN5+
	uOFshNFWkpD8aWhkAdzgm5jHiRvF4/BcbiE4E2lMsLKaJFVm0Gpdji8LXRIKxd5+M9VLowaRAxD
	UavYMGi0i/K0PBIYkCH3OFMRFNYMwo+5gkL+wqtN5lnAtR3Nk5PK/Gf12y18Qc+g5UbEn4j8RDS
	FxY0wPvGunSZO5HvKtWMDhShsJS8f0X4dbFsHLtgdpKDZ0+YTGb8CFY9IAfry3r/VJLPMOycqyo
	nhzZJYytAR6hytpTvQpjbZKoKq5ouCZZIWd57qzCfZdtQ73uf1/9Baubq6HD4cTy4WdyWecNrRb
	sgtTTuK1BQryIYK4SQJTzH78lEXg==
X-Received: by 2002:a17:90b:37c3:b0:37d:7bbb:afab with SMTP id 98e67ed59e1d1-37dfa1a8ac0mr15044821a91.11.1782734293268;
        Mon, 29 Jun 2026 04:58:13 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.60.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37fde4c5327sm1820266a91.1.2026.06.29.04.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 04:58:12 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260629105020.1670781-1-kalpan.jani@mpiricsoftware.com>
References: <20260629105020.1670781-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-net v3] mptcp: bpf: fix NULL deref and UAF in
 bpf_mptcp_sock_from_subflow()
Message-ID: <ba60cf65-96cb-0c76-9f72-9558accc5d6a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 11:58:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/283679=
19372

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/79cd11093b06
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1118110


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
