Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF8233924
	for <mptcp@lists.linux.dev>; Sun, 16 Aug 2026 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786846401; cv=none; b=VmulafEBrrj4RcIgyBZq9SZ3AQK3IlbvVXW1LoIurvo3q1gkdri9sjQL6ggsA3Gc3MhPSn15vBmmxGfgIEd3xoV4f/h2XoAsP1lfHxNVR8FaWsA4xIkBFY7j9YNioM/voz/3BvzuUUA6us0DW+gcKmm8+x5/vlZI+A2pPilrtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786846401; c=relaxed/simple;
	bh=7gSJ1uF/q6wOybWgZnqwGpJyNjGJsuhrZjhfN+hQj6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=YCRf6ijJMxAO9QFOKW2LLYEPiu7H5APgXF8/2D70rOVvwlzTwXEL6mfe7GDoxAsSPHbRkvaunDgvZNQ3WdA1FjkDl+rxowH3YpQd/Xs9n44XW/DwP/z7vuNrP1v2ls24txE0Rtx4gzVfIzJCMoef6gBRmNy5E4F3twOG1KmDa50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oF41wNRH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oF41wNRH"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8485ef63b68so1560806b3a.1
        for <mptcp@lists.linux.dev>; Sat, 15 Aug 2026 19:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786846400; x=1787451200; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QeAhjf1at4eLBj9kUxVcAONFJJGuE8ggS7XMPdahnhA=;
        b=oF41wNRHyptb90moPQBTupRvaqehuy3FCKPH3F1T4MjpRSxuHrav0ebCHfGg0pDWAH
         B7C8Us1bf8XWzEgtL3SyXhX8VcfYgwnXCBRyR35jF8Ud0x1TQBLQz/ALzlCf1Bliaots
         vjmc8m4OkvPEEntnMcCZnqrZnkUyg0i3FYK7kifVLWSHoCck13nWv4hePYqhz992naSP
         WL+tFU5WKCnbRugOwv0z2k0fZEvijgC1c4Hp/4LhmCKmMDV4DePQCTKEeJ4IDmnAdXqv
         wtBs9+TQyKGM4h17bUVereTA7xVSvJ0WHcALifhnW1qmyzLb9aTEKOacXe0rd+DSxlVh
         xp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786846400; x=1787451200;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QeAhjf1at4eLBj9kUxVcAONFJJGuE8ggS7XMPdahnhA=;
        b=W55E5eZ2R8j6rkgwtISxXrCmYnagwT5PBjcKWAohQ34keJV/WNsGCwPArWuG2T62kM
         cgQakm0KoTd2ZR1a36mDLhZC4JiSbfb9YuBl/mR8UVQi/QVj4FwlNSJqSW+1Hj1ar+Qy
         r4NAGNOD0BHSogrqBG4BxeIZV+/SNDDC4ausJPQ6ZUfEKfy+Llcf9lQq4YdyOUgRmDCX
         NPWZHevdKpUoZIOwr/KuT3teeA1CAL/oftEIhzYgQpktAvoJ5GWKHIg3sQQXL6++LvBF
         WCQjPFUAJsrM3HIa1Ue6QCnEMEXTydPscYphTYaUDH4BWNSZ8J6+AzpJtL0fkrnrrFu/
         AGag==
X-Gm-Message-State: AOJu0YyImGCWRl2zHnS6Vk6UJngOPQE+5dEXGACp50TORH7ikGQOAn8C
	tUMTh5byN0nU742Zk+yjf1kLYKoKNaolXbQ4H+aMPkXF5b2Oli7gUc70JngQ
X-Gm-Gg: AR+sD12YKl3+yTgVeq0nK97C+tcXlc0R6YVwnUDQ25po+Nfrj9M41Le+6551AJVZNVK
	v1s59Zgv51XDssNqGevTIG1VaW6s6T4oVunHpLDtk9bmKSj6Ysjeb7spueHRAjaLLxqM8DZe5go
	JQnx86fgT6h6aOFqRtS3/JIxdNGzRE6uBQAnkGIeoJd87EdT/9inLTUxAl7Y+AOfS2IVjDlbbPM
	rAvd+yDeHu+4+0bx+fHF2fiPNwzHRVgmvpAoF+k0xMC6hVBKBojteKq5SL2Ti7l9aMepF+qOLvw
	+wb8hKxVQJl/8h3SX4lEnz0H2eHrXbzNWSw6md6LIQ8OUpNE2c/GX677g6M4qVwWCXpBMgKo8xI
	FEO65OsyXdiYgeK5f1TaMfKt1aMFDGxK5g8tD0ltPw9gpr3XEqO8f+g9WdnwOFdxH7sU/1e9fRY
	vw24C9i037sZ1803UKLNO2w35y3LvIZ1feLasU2+uycvdcGUj3fhUTHQLOqe3t/H4TZ5bWRkP4S
	L0IUinEEQks
X-Received: by 2002:a05:6a20:939f:b0:3c3:a1ed:3c36 with SMTP id adf61e73a8af0-3cc71cef032mr19840313637.24.1786846399408;
        Sat, 15 Aug 2026 19:13:19 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c56aesm23932331c88.4.2026.08.15.19.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 19:13:18 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1786841319.git.tanggeliang@kylinos.cn>
References: <cover.1786841319.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH v3 0/4] nvme-tcp: add IPv6 traffic class support
Message-ID: <102efbee-9e6f-1811-2d27-71940e884bf4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 02:13:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/319193=
77372

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/58af0bc691a8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1146638


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
