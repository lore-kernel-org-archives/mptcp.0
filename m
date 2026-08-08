Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1E2F8E82
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 04:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786163277; cv=none; b=DV8Z6KU0CSu2rzwnMLIHOPEp50AC107eUc9HIE2mjXLe041fFLEvbeLUjgGLl0LbmivurO8og4K1ydrYVnwzDiYP7zTyasQaq0OtShZZyPiUKgeGh+TeHw34Y7Mnwdz/hjg4WVTGT/52LcyEC/8ApKuIBTp/KAMfgs5Kv11cjaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786163277; c=relaxed/simple;
	bh=rIbYZnPNL64qlQoDme+fZN2vdQJ7xkSlHkW1am+ENmU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=T2Ijomx1Xz3dIZadxG7Jb8um57HI+Uv0HUzS4JcZxfDWBqzHLeYhbtTxqtKQgwpYEXltJ/7xD8JSApMdBEIR6K3CKCWZftuGofyI2Z7CKW3v7fTe6ccAtPx2meHiHpNUaTE6wltnnTMDtOtwVpyTkb4ur5drE6N34IowzWy30xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYbIUPfL; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYbIUPfL"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81ecf499af9so2764527b3.1
        for <mptcp@lists.linux.dev>; Fri, 07 Aug 2026 21:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786163275; x=1786768075; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=82nCmKYgHsTMxxBLdKNuWzFJY01B7lS5daTZ9Qo/3wI=;
        b=LYbIUPfLugo4YqzMm062AznOy/K4JGJlkc3AlwZcmplx2jiaQ64a6g6USgEJ5Mcu91
         c1fK95iXAqBmFbqypyuI+YsKhaFvzC+fOiBV9W5AOWQAlPOt7JRwsgm7Kx41LNYr65an
         0IiXWkLR9jU+q8M3iv6trZDDsfAzVY+Mmyrkemvd56RYztnalBWHhPXXlHLh9jtGUSG9
         f6Ux65ClxKmdutWsl6WTUgdX2Z6S5uBKsAKvirmuEN10G9buRzovBaHORTKAvdsBwkGp
         gjrD5vEhG5JTcUOkeOmnT04vd7M0LmY7larPVEGAlfqwsHRZpzKwUcdWrJVgzoguDAX4
         82AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786163275; x=1786768075;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=82nCmKYgHsTMxxBLdKNuWzFJY01B7lS5daTZ9Qo/3wI=;
        b=c9wGm01mQevbGfo6SVbTTGHNmBqxZ4x1SEGwFaa7QDVVL15Qk/e7v5ELzgWFBJA7DJ
         yMyXPQEDUu0UB7x67yG2i2HxDIBMF8L7A+VKxriwSaDr0YoqGn29UUjmwRPY7TzvsqS1
         8itukqq5u81TAeCx/UuEd5bEdWyg3w1w7YHkN0Fe7+loN6et2i4YZf0ARnwPX31ONacB
         sxPlDT5qO85xgoJU11RAvVuTQ7MxMtwVLWMgvs6BFhsNppJwBtVif5kt9QyEQXwx7bf7
         IAFnQo11z125TK6GOn8s2o07+9SMJZTH0Y/vWwTib5BlDDLwC62nCohesFcJVLgC+sf3
         Vgow==
X-Gm-Message-State: AOJu0Yxh7fUfz2BDX+hOUnsADUS2JMv7QTIXVpgo37KiR4wFfeIrcoU6
	QCwQP06cIp7EMkrRXxW6JQzqbREvEZ9GRddQ0ST2+r0MtMTQeJLIthxNMvCfFrk=
X-Gm-Gg: AR+sD12maa9OGeTbL5+QNaaDEb6MOzxucawy5mjD026+MkjYRp96g2E8xyO+Dan+rcw
	zC6/iuc8LT4Rmss81J5aMXjPB32ESySzwDUFQv36lvHSdE8rztSiN4PFlvc96jiTC6GQJr95dDN
	Qsn3CGHLnFIlU2QwPe0ivXubYeB0Z0Hab0FTCHHAETQjnOKOwmIhUBof2ceW6zztHF25Fx3wUsd
	ZF32ta10rm2aD0k2AwzpAILDqAYpJhXXJpvE4quarnNxsfMScZcmT0ALqLtX5FfUO2YPNTVVk5D
	QyL3odiKzUU72wjxz1eq13fz+KmO5OkjXonyM+gU8fuiF5mVXepKG+a1Z58SdTADGGoioRm9Rsg
	rNfTzuHZzGcCa78uOS7fC42CyCpNXLHXjg6boVzdUDI2t/Z5ZaXM1Phf1emYLeQWDLKoCw0p0UO
	3vrxNrpG/niVAuY2HbWbRd5THYSMGmpMCaNjS2nG4x5OduX0TzUhJdHE8gdy8Ys+fPCtgTm1Xgz
	dfp
X-Received: by 2002:a05:690c:6b86:b0:820:b24:27a4 with SMTP id 00721157ae682-8202272ecf2mr167972337b3.32.1786163275252;
        Fri, 07 Aug 2026 21:27:55 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.220.240])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f73d24edsm20929337b3.44.2026.08.07.21.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 21:27:54 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1786158416.git.tanggeliang@kylinos.cn>
References: <cover.1786158416.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/7] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <dd1a74ed-b427-ef62-b11c-53081af387e3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 04:27:54 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/312375=
45840

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/efc30429ad05
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1142512


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
