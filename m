Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6698C41D647
	for <mptcp@lists.linux.dev>; Tue,  4 Aug 2026 03:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814482; cv=none; b=dyJJRbeyRhGdMhav1hKOa/QIZV6e9A5b+Q+LFCtl6neoK194ySQd37ikwoj4Uwwe7MHlzDbHgmZ1sz49IYeyXovoNBxKDfC2dTChITbovk2zXWzaGx3fXiXXGn/YnsuBsfnxxNOKDP0wsTxFTeWR6POavuMiZjkec4Gjagc9Hnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814482; c=relaxed/simple;
	bh=fxz0G+pJOqFnQuxm2vTZzE6+vvX76agIfci5COzjaMI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=VIOeGLmNuggzq2A0oeTkcEoEB0k1VHYoGQ7TvhQ+LZcqRTbCF/ZvCCqiU4kDebGxPxgNgcKpOCw1CSR/evtOKScap4HTHnH0OUAvp02/8kRescACGSCoIIQtDftj5I0tHgE5u+DReFFIRYpzLYbnzwuFyYUkAB6h55JnuhdT+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwDEmnIX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwDEmnIX"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-848479c9bd5so3462324b3a.3
        for <mptcp@lists.linux.dev>; Mon, 03 Aug 2026 20:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785814481; x=1786419281; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gWwnaLTFDaiv9pbHUaeOlTDYqTzq/kmxl4XuZGdwZzc=;
        b=nwDEmnIXy6Xx7PN3UjBB/B0kD9pSrSYLDvDYbSMtejF10n+R3e2+gfWeMsrsNXF9yx
         6zBcLJqruVP3BFjYt6cJDzATJQ7jt1gSZ6kqwYsDPuPZT1Xejn3FsVkBiT0gysoz30uL
         or/g3GOzzuORRRLj/HYhK5JyAhvlzf3Br8RUQsNk4kfGMbSyIzf36lhFpP3FEnPKgXL9
         a/NcKE5HwXawXm9KA7cZZ+71mLZvwrQAQvKNAHyl9yGvPkjYiMqQeCC0fjKZcc1MWxKw
         4rgyvOScER+SEIpEarl1aiF2s4E8+ZR9fzxPyB/ZgSZlImX6BJzRs4h9cijHoXlcvdD7
         Dj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785814481; x=1786419281;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gWwnaLTFDaiv9pbHUaeOlTDYqTzq/kmxl4XuZGdwZzc=;
        b=TOfc4wQEaYhtgtGaHlKj2FIfvEmwbwNfhQ0ghv+O9NA1+uZabiRzAoVQMdFID3Bby9
         sdafjtt1qCHhgpvs8Q+3awXFRF79XqwR3jy805sADTc0hiFcUsMXyIExw5RkulJ/s7dD
         XX8dk07O6SzawGYo6FRTmzbJ3XfrsoDo5XuMwNtGaSXypggRb6mNUODnNuVDkTMNB236
         p0+gvKutYSoP+ACIy0CKnvLkWOxOGSfVk+k3PIOqpeNblnplqRWMCCzswQ0ckw4bXxpk
         j8V9fSD0+sh750clVkJybP8yNJ0DngQF1gZJamor2QpwCT+xqLQSh/iJQaZ8+wWJQOSG
         z5eQ==
X-Gm-Message-State: AOJu0Yyqplsmvb0sgUrmYLWlvATVNcHv0IqJwRIV5H20fq+0HpTkt6GH
	DT6lHVtGaxmi94DOfe5ck1l8wlJ0C6W4OVZdPhl4sYIuZKbiwv8wjQ/rS31G
X-Gm-Gg: AR+sD130j4wOF7a+uwIOhpfceVxhzslqIYFzt1ZAAZVTFDUpJOa5yFJdw1JRh1lyz0T
	CAWZL59p/DboOHJtac7WdvaYqrtGM9OnMAAonDGU2QzpNCCz4mZcbGvgsZjpoOcL8ZgtRfqvP/8
	aPlCnSdl+l4ji8Ot1eeIWAuZp2xVkX362VTzOxAWcz67Wf/pTm1juMgVCYXZrtjq1gd32bBkftu
	L+9H5x2469VrcjEMLG0Yz29ElgBZyRxXEVtaOmkdNeMPRnqK+sZP6XlMegpLI74Ko8YX20HEzCb
	auoPIrBajY7uJ1NjZ7aZ4z32er0sBB/CC8CTB+ZNfE2o8E/zzSkk9QvTlckBrngFIe0BabMjwuo
	IpPWw++UCUVHYjZXGWFKo0Xk+nn9VrqmJCunMzgfZi3tWQJ3uYJeZYjdDvFknfoX4Y3mie4ZgiE
	A/nUs8nGEifvPSVkUuK6snS/tzly0Qqvswv5cLluJa3tH6oiefig3EWCBMBOZZgfVf3bYq08HYq
	50=
X-Received: by 2002:a05:6a00:4484:b0:845:3d82:10fc with SMTP id d2e1a72fcca58-84ee45b8bbdmr11346657b3a.0.1785814480505;
        Mon, 03 Aug 2026 20:34:40 -0700 (PDT)
Received: from [127.0.0.1] ([52.153.130.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe572d1sm4604497b3a.18.2026.08.03.20.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:34:40 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Qing Luo <luoqing@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260804022350.181323-1-l1138897701@163.com>
References: <20260804022350.181323-1-l1138897701@163.com>
Subject: Re: [PATCH v2 MPTCP-net] pm: userspace: fix address ID overflow
 when all IDs exhausted
Message-ID: <785f01cf-5bd8-3623-8636-8dd042e3b0d3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 03:34:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Qing,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(only selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_join=
 =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): =
Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success!=
 =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/30872730143

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e6cb13c9a93b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1139752


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
