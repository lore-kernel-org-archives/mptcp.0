Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA43384CDF
	for <mptcp@lists.linux.dev>; Tue, 21 Jul 2026 23:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678363; cv=none; b=gVkuIiD8JsJGZHLiMgEf3Kl6Kt8lm3YtPkPkOBv75WWUG4dqEF4wHvOMsuyz2tE7FMF95x4NZVWsyexx3s4CGQkO0hRfd2GKqufKWnTUip+wOBtPc94+QpcH6bZzPJ2JKoEW1YqMLmaBB3pvsl8AwGVblhKiDbfexjmpyj75y4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678363; c=relaxed/simple;
	bh=sEwKbYQ97PnuZhb7NMC6xC1R2f4PiD8U/CX/pzcCt7o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=myi5F2h8SXSZ1Tblnq2pY88Y58e7qxG0ZtuBfwdyjglxG2XDNzaz/cWnOSt7j+fVb8QzZxkgFVddwOinU4pirT2SvO06r0zRfyezktgb125hHlwroHD+JKt52OSHIWjQPWtwPvlAe4Jw6X5H7zxB3h4nT4r6jm/m3zMAjY6oxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9ptnSZC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9ptnSZC"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso9820904a91.2
        for <mptcp@lists.linux.dev>; Tue, 21 Jul 2026 16:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784678359; x=1785283159; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5fBicaa0Lz1u38B/UbkVXYjvJQjLhNFxMLNDIR0ctyg=;
        b=d9ptnSZC6GMjxVm6beAufU1jIG+16pgOMpK0mVpSNxFKQF3yAWwqJTMx5l43xVHF+S
         7qVCg10mA7qkPiSQ+q86c3V7AXJWSnak0UJvfRHfXizpTue87QDfUb2lgqSaHBR3n4cp
         vyeyRyNs/N7ooi+mD5lQJRN62vDi2mUQcEhQuFzi6oscK541SxWOtcC/FnJuyL8sDLMt
         WVAkUHnzuIfO7LGkucqwDeYOkllAN9RPjXvguUW1A99jZvikJrusQ/I7gY+yBM2hpR6C
         Hh7NJKaPjgWPg7mol6XM1C3lln3hEPHOTkl2WPini+RGxxC6Ocu2nYg33+MoUlKGG5x7
         Yc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784678359; x=1785283159;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5fBicaa0Lz1u38B/UbkVXYjvJQjLhNFxMLNDIR0ctyg=;
        b=gu0ErdjQOT600Num+PxP9pcxWI8nvLdUrzf7eV5CA49rXtW/UE3yt+tgv1uUneQhXQ
         FKt7ZYxVHlFSv9t4D2ub5v2QupwjqdMyifNgvQUoV16DbiZQRQFohS33H9p16sTM4s0j
         rqoOp5P9TdXXmJCzsU8LpHoyAmUb/gCMw0j5CagldXg7JsCSl+vos7KGZ9LdebQryZ+r
         x8RybaJFeHnCuKLvEpeaH+RGR8ggtJYdf4Vz8dbJiIsPFL93grCHKlBBgjvxbgbSTsnX
         FUR5DuJfdfXsLiq8GQGtMwq/Er8e45M7HURS3Z/vIoxF3hjM5uSpHGy7c6Y+hjSKLsQk
         7ZJw==
X-Gm-Message-State: AOJu0YzaWcy0chMqr0BPReTFEbPwOEWVoVfs82OgbKnF0C5KVYRQ9LoI
	5mkvM1MpQx9ltaF/pzWGknsGqsxHNW5rGVqFE7HdW7WwqrywzdqyQ4f+VULg
X-Gm-Gg: AR+sD12TzhT2U48tpSAz2tbcsLcvbrV0gIyLEwWSxW/kb9o6JgN9+kI7z8zzqhyCPzl
	LA4WLYaQF5sk4W2Sk1Et+Ry0dZMyCr3VO9qh4Kr6IJqpTF9C5aeQhQhjkGh0mzzvA1EAmTpu3bz
	pamDRjBwmMcWJAVYMNFncmCYvOUdo8OOE4tUzq2GEXGn2pvzMZ/13ahWO2Ms70IOfv7KcqUIltC
	3bbd3hEp7xk5XdiEaraT3O2Qx3ZLIlPL2pgAhSnMZASWCxJxQx/XVrze5PVQJzWEceDPeiRIpUC
	VXtOvGb8cIcpAUjPR9o6rNCnI5vMzI8CzTmRY3tr1w4eqGFp1qwBxIsmGf9Lw+WDdizm0OrcBEh
	yEdr8Oa8JBnBQvPtyuvrl9Fjs0PJkU+n/iXAf54rPEiHIufYWVPLtT9Et30iNcN833etlr7cSfW
	rlGRLKTIAwScqUtlc=
X-Received: by 2002:a17:90b:380c:b0:38e:485c:ebc5 with SMTP id 98e67ed59e1d1-38e4b4312e7mr20210389a91.9.1784678358827;
        Tue, 21 Jul 2026 16:59:18 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.45.176])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f55c6sm683768c88.15.2026.07.21.16.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:59:18 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260722-mptcp-harden-combine-opt-v2-1-2021e67703f3@kernel.org>
References:
 <20260722-mptcp-harden-combine-opt-v2-1-2021e67703f3@kernel.org>
Subject: Re: [PATCH mptcp-net v2] mptcp: avoid combining some incoming
 suboptions
Message-ID: <4d38dbdf-ffa8-5a32-b77a-1abdcd8cdb25@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 23:59:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/298765=
15722

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b327335614d4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1131982


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
