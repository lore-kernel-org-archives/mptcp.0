Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391D2288C0
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583584; cv=none; b=sGpVlIlZBOxoNEF92zQy4TwQkEfOGO9ZsjjA9IEGCLY5a1vDsQoZJT9Ky+j7PcDCTZunPfuqOikTJ8UQuAk0mARhTwTfaYTYvKN+oFyiFJ0za2ZhtpVCWHoVH4ctWudeAvVUcoe3e79FGPOAmJRppEWAdbE29sf+eYB1UqtEMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583584; c=relaxed/simple;
	bh=jFNEy7txSIoz3FP2DFeK3achWCtJ7Dzj+1P8JtMwP6Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=J1Xhy/SsUdh0pWi2fo+JwQy1pa34F7mcCQPORS2Sviv1/5AYuFxtXnCvGeP+5Y+dNBhGBu3MtLONK1hfeTTeT4l0t+MjvVQ6CHw9ZtsLwPjBE1VZE2p18rkY00jZh3XwbdLe6hRyWXyW5u7wtYnsQM6Wiwle/Wju0FjZvFBnrNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of94oS1U; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of94oS1U"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e6846bcde2so54181056d6.1
        for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 07:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740583581; x=1741188381; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeUU34jT9wAljLCJpP3qq5AO/E8vw7rmzxhcsH1MFT8=;
        b=Of94oS1Uyv7MjRR1/Iv7bUH2M4LrXFi/MLcWye7baBMh0FHAGGcgKKs6DpUzYXGpv9
         O5aOn17o57/npQ5LiJy+QHp+M3yR/qsYlu/D92StF0Dxswus8lcX42gMVs4h/EHcHthg
         kOKOOIlb8M7avpIT/z6Kc9Pumprl/D5oYt3h6McQ9BR/ypihKoMkFEuu0650CeZXJ72E
         bSEFUQjdXlD90KbBSEYQDHejmBrFnibd7oM5BOoj6NiwvhXu9uKm5Loi6TZZOMxmn7/e
         meEBlfaW4UOKrNadoe7pWfIs1OGtJVKp0ww55hNbpIXDaYqi2n6JaoIChUO7NwngrfA/
         378A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740583581; x=1741188381;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PeUU34jT9wAljLCJpP3qq5AO/E8vw7rmzxhcsH1MFT8=;
        b=JIoYQo6owPALoQKcD4aHLRkJ42kufPtB9XxS9Bv1V+KQ6smnBLEyeNlxhFGUaB0DCY
         9JNwZgDUS0yOKd8XkgSLS9pLreNQ/lYGA//bjU9aDECXNaaSxm2fWqJY5G/XUVmE2u66
         XHVJCPdWD8xae7Mb4lkWgK7eTlSlkhqTVfYCyp7xb4Zr8PqA9HTGaTcHaf14Aw8SirS2
         QjU9iVjpeTC8QHgr9gnfp+jQcU5+vuPafEJJfD0X6+6M+L4o1kZQ4EGlHUqBB/0m8/Cm
         nPhCAOLdRPparlr82T0GdB/8KSH0n4zNKSBe89AmyoFHij3FqHTcgu6tWkK+NEZLayHr
         3EiQ==
X-Gm-Message-State: AOJu0YyXsMjJFewBiMOQAPALsD551+w/kZKK9xPhRGd+UVCkAhUH8kZk
	bWe+weTO7ZH6WVgFDnTmRebmKreXSMVH73tcUnVjzopyxO28SqVl+wbX
X-Gm-Gg: ASbGncvUDmfhnDxhuCEBMZLJJR7EvTHcTXytuNCAeVx0/E8PorSuERGQ/6OdmgnlQGT
	cinFGIna3FKIo8WADxb4Y4oxDk84BlLiiyydhvELYtuyiO7zb/O+ms9fu+FPqcS7/k/JzJHeeUt
	+L1pje/Tf4zNZ+gNndYMIIwfldp9LnnMf2XwvNKtefd4rVp9yEAK13lKUdlGWwpQYrxQTuYX2IY
	lZ/p0xbR+4QKdvly+DYD9Vv38XbKuaO6l8NpkNdpFfxUh1WHcwgwcyt4yXu4F/Y7v2pGspAlsXQ
	rVNksE967wAQG99Dw5OsKrS+WHk0CZOcLXkcpdQ=
X-Google-Smtp-Source: AGHT+IGz3B6zvVVGyQ7ASVtjkgv5XRieCUYolH34NgPkDH8QMU9E1gTBCCZuiUqSqcFvFcvjEfaReA==
X-Received: by 2002:a05:6214:4005:b0:6e4:2f63:ba54 with SMTP id 6a1803df08f44-6e87ab6f991mr97085116d6.20.1740583581445;
        Wed, 26 Feb 2025 07:26:21 -0800 (PST)
Received: from [127.0.0.1] ([104.45.201.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b19a91fsm23148246d6.124.2025.02.26.07.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:26:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20250226-mptcp-userspace-avoid-worker-v2-1-4b144f314353@kernel.org>
References:
 <20250226-mptcp-userspace-avoid-worker-v2-1-4b144f314353@kernel.org>
Subject: Re: [PATCH mptcp-next v2] mptcp: pm: exit early with ADD_ADDR echo
 if possible
Message-ID: <30094107-8512-7cae-4716-0b88bb7d5c24@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Feb 2025 15:26:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13546321767

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b505c426b765
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D938079


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
