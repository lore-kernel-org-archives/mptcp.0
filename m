Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A8B15219E
	for <mptcp@lists.linux.dev>; Mon,  6 May 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006209; cv=none; b=uAkKC6XqIKv7yl1rKQDdl2RGtMFW2PZ5Irdf9b4YlExKEv+G4Eaf23Bb66LnfJyVzvW+anGgFcIiXopQvl37Eb+SGN0zOIyCz8kQVXmnBY1oDkLU57xqG15IHbW0l+3ySyxYZ6uVbuALKMYFYiAvjgWWAaj8EejepZhlLHKp4k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006209; c=relaxed/simple;
	bh=4Dn5oibhCZ3zjaGoKrR+TJuezb/GXAX/mh3FDXIIng8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XiNajDn5pjKWHjOHXO/Lm3e14ec0LWc0zK6mjW+RZvyIbz7nwtL2V8VI/7Xj3jlfireEpV7Nka1vKsfLMjX9c8NBNz+WOqEGMT5KyF6wMzfwzJ1Wowlep6YGuYhc5VcHdnw7nVlNu4iJW7+1pa7/kWL8OcZCILvZff+/ZxlFnjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs2P0IcE; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs2P0IcE"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f0442816e7so740713a34.2
        for <mptcp@lists.linux.dev>; Mon, 06 May 2024 07:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715006207; x=1715611007; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sztCw6D9vEwilcotzlpm8/BeTgjRql8ceVnUsC+tnXI=;
        b=Zs2P0IcEyEHKUr/wGty98mfUKWfz7ARsHuru5pXLPl9lWt7YR7gwpXo0fllgmVnMTR
         OMUaD8G7oGK8O53dBoDutsOGtBSPcS/HtM4WY/XfCgHt71q+l0nb3Mz0nkpSiwK+IbW8
         6EvTXRUnIY6PDhYO17MRJQBIoLAj5rBnTOBL8VnBCWDfxONFYTiFBt9pSx8zGw4ie0Dd
         a1+RXEf3uJ6C/LN8eG0ekUsRRK+MUt9HWzc9fDNl3o34/wEKRTvOgKPa5SrMunf4z2OF
         0MMT2disGv81hKpYFq6902W1r6SX+2VQY9nylsY81Hz7rSaLX8XIQV5XhFV1DCcWv2aR
         MMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715006207; x=1715611007;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sztCw6D9vEwilcotzlpm8/BeTgjRql8ceVnUsC+tnXI=;
        b=ZFKtEm2pUgmNHmx39J5cM1ijQ3Ly2NuEfe3RsB8fzU2FOUaMPpZRgpVz2qxRIlKLO9
         g1nXMRJGIdvED3+WRFfiyC7QYoY0bvEF2rzqRLtuhB+xIy/Cf3gRcnUBfAr+nmcMOffu
         VfzxOHN6/t4GCtkZGgx11zBm7VmBy8ranOBzQ5WbkPweiThq496Jx+t0+MOZ68bcYoyC
         hbq14LaQKHsAi0rLjNJLTf7UIINOert+Ma6TF0KNfnTWjw65ccM4VdzWTm457Ti6lIgV
         SsVjjDfSpNS9DoDgvZjoeYdbrA09WUWDeKZlIFQJz0mPvp7mRtD4nn+InIQjN836qt7o
         olyg==
X-Gm-Message-State: AOJu0Ywnxz1uIKQ2hCj/J6oM2LtL3aoJS0NPu5RiLmeOfYEXcGp1Pkl5
	xHnCB8mr4wHO0k0FYlWXEJvCl3j1wtkNL8Tz4mH4chigy8i1KNw=
X-Google-Smtp-Source: AGHT+IEBiOq2seFK1RCqjwN5QcEOlZ3a8+Sf2Jl48HGPYyZmNB1lJrOMFqYKE2X8Bqeu7mXRmBO2Tg==
X-Received: by 2002:a9d:73d6:0:b0:6f0:40f3:12f4 with SMTP id m22-20020a9d73d6000000b006f040f312f4mr4763411otk.16.1715006206664;
        Mon, 06 May 2024 07:36:46 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.14.22])
        by smtp.gmail.com with ESMTPSA id c23-20020a05620a135700b007929b21dd57sm844451qkl.113.2024.05.06.07.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:36:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240506135129.3528973-2-matttbe@kernel.org>
References: <20240506135129.3528973-2-matttbe@kernel.org>
Subject: Re: [PATCH] mptcp: fix possible NULL dereferences
Message-ID: <34940939-339d-c6a6-73bc-a8665d4a352f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 May 2024 14:36:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Eric,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_simult_flows=
 =F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/897038=
1678

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0b805722de2c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D850808


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
