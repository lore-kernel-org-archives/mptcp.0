Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E618C2C
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776769719; cv=none; b=cptefCsZylAULKFjpWG5gST8x0zHYV/UWDXR86hgBVIwZrSvHxHXd9zBawoyr721vKbqqdksPwo8B03ak05PCOolB/pyuyNaG5OJ4e3Cc3F0zlRXA0DoR/DR4W69JU/V/nfeieTeTgO7nQ+/EX4QBIHRcRvNY430OySQ4BY2x3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776769719; c=relaxed/simple;
	bh=AQgw97q98BzHEyp4YvbanXclwpn9aNFfib8XbKaQ5Ck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=s56+nlTs6Y83moN0zvUuaUv5q/zNA8gmgtMZd7TuwPBjSBVegvzcvA/KThfdAPBMEsHseQSEAwtklleVUBwF9vxNtsHpHoc8CRG+gq3k4SpuoXaslkQQA5ACuN156tlCE8Q9fgTrIO/os4/5QRgffVwjvvA/3aJkCgJcCMz0BFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLlsxjSy; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLlsxjSy"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89f87257904so34245276d6.1
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 04:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776769717; x=1777374517; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3q5CGgHfKcTUm39i8JuJKJrFWpbAWrLMcfucOqL0EA=;
        b=kLlsxjSyu/x/yv0m6M53ZjhaDfU5Obfd2ywXRhtyHzSA5CHXoLX2Xq/yhyulX/LCk2
         I3bnkOXaNrbzpx2U86HxBZZgKKO/lH2HAUFrrQZq4LjqUWc2yjXUTd0A4w0UVDJ3M86J
         f1E1WeKZbyIwExFWJO8HsBj6ya+8iZg45//ooJP2GGXgib20gwuCjnsKoJvV8W/hywVB
         HSsf/d7n2n9kd5c3VKTISmOSIqtFc3gnvy9NxbVa9w+0w00YEhlt17f5QZmewF0tr7E2
         s2eKO2zeD8lbJKp8xu5FJSiHllgSAswSmShxmu5vTDmpT4dB518nl5r06wlKRfZujrov
         A69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776769717; x=1777374517;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3q5CGgHfKcTUm39i8JuJKJrFWpbAWrLMcfucOqL0EA=;
        b=p6dT8B6iTpblnqXutaQu4xFhFhIsG9jlxpibwdUDCPi/SkSIA9qYt4B1JrrMQNw+mj
         gMrvvqT/ybn4diJXqf4d5y6GlLoGGqmSqT/n1CZRB2Y3Mz+zJ/LRFGYGu9I1s/nii5qN
         kSISgsKY2wKhTW3RaUNVjFx3Yk496+xfdcTXJUrYgWCW4OZNNFlzR4/yGkTizQpbzz+4
         AtK0jpcdca7yiJfZ8/I1k1MetELEDPcg0u+PwrE4gnvth5i29laKfvBQIW3e0oiHsZgJ
         TEvOBZ8Ykd5840a3r92RPxoKUIbXB3iQQxYdX/u5brso2cLlnoJtYRExT/EGHk54vw2j
         Ku9w==
X-Gm-Message-State: AOJu0YwOZUOLGXyrdz1X28NSYCnSLOqG+ogTiYDG1+jZvD1aUVSzq02L
	titesEIXJYzvabB7wOKiGBI+i1MX0T1/tC21h54rVEP7GNQUhIEXJxU=
X-Gm-Gg: AeBDievvmZbujIFUbWJYNYX98KWEQxalTBPJWU02EEnrO9W5wgS8do6Av7OJ0I/88H2
	b4sejWJvp18fGYCTYmXBI9IG67c9+/nJuqqbUBBW75zshO6mK5kkpvacvvsErwwk+sXHhEdLId7
	t6xgBwWO9epqF+HkeiRpvDqO3/LPZYSDGcK+1SQRp9+mf0N79Djjn3h+RY7XljdnV28zsGkoDci
	2hXW0Peh+O2MrdXtV4UFpDZxSqsxyU/yjC9Zr5qu6YJkrUR0vlny2OteqeIzHtDK+SyK55InkPQ
	aDY++HrlCvgHcA66AbFiPWnS6v20OkH8uxKiiTKyy/fjD0LK0SedGl0YQHmd852B6X+O538nQU0
	4i7gx2SwpR7q484haI5MOlxmL6hrNycgm3tkSn4//WSlkdQ7ot7ERrDnGlQnS6O4QXP3iq7Ur6H
	5VPxj/Q+B3nRlRoq5XLs1mK2b/5ZcH9Zourde9jl6Fme+5yD5dQQ==
X-Received: by 2002:ad4:4eaf:0:b0:8b0:2ae4:da26 with SMTP id 6a1803df08f44-8b02ae4ddc1mr276524376d6.10.1776769717547;
        Tue, 21 Apr 2026 04:08:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.157.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5ec2dsm103699496d6.29.2026.04.21.04.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:08:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardulsb08@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260421095646.3741956-1-shardul.b@mpiricsoftware.com>
References: <20260421095646.3741956-1-shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH] mptcp: add per-reason MIB counters for
 MPTCP_RST_EMPTCP resets
Message-ID: <d1434c9c-d6ca-a796-3d87-7e961a34a7bd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 11:08:36 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/247170=
43493

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e67c367c37f3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1083751


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
