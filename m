Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39860309DB1
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997418; cv=none; b=oPqzMTJb06vMuDT6GJtgcgbdwRPO7pSjRY85541YxUojq1v6J37VjaAU5Dl/zkS0GqsDC1Uhw9O2yNUvSZsrg3omTrrilpfHAh8zmCsBU3gBcqWcJqiGmhjZJeR62u1Z7Yl5co1dO1AZ0lqCc12Pq91HSHyOhGgwq+8jvlnFPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997418; c=relaxed/simple;
	bh=XuMMp81xlIWLufIJFt18pwhp77ZlMnFUMnVR8B5zYko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=sWHC/F+4N4bY0p6faIXE3hAOwjJ5Z8MIlGzQ0OAHP1NE+DduiAeWUwy4qCJsk4oV0Vui85HL2LQra0yLN+XtlhXAHzxs56IggnqVrnp5AJHrTs+2YyhchQ9DzqwO9oyAUVqfwA+a6BxxmKW2hniWIGW2GTfuM1oBw5ZMc2Q5lvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxs/mxKH; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxs/mxKH"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-44cc65b0a7fso372869fac.0
        for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 19:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783997416; x=1784602216; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0sJ+EXGchq6tpdm8/yi/4lEX2Uko/KasExedZuHto+I=;
        b=mxs/mxKHGSBXTrHUU9RZTeCo+aM1ZJaCpbcxt6nYbbJIDeqI+Pj51O1kWpFvYaPExj
         ZeKTTZ8ZQ2mD/2PAVTcnszLJ+xv0PyiSVHnlrVXW8tKGnUBvzqWgWc77C9wsXzqXi6Mu
         hw5gUbLwk/tRl/NtrE4jFHidJF30DWqJAXkDiLCKYrsxQEfd4o+sB8171R2isV2zrE7i
         XagL3eqJOU7f5+FQWOe5iDqq51p2qpT+0fxhBl3iNCPJY0i1wIHfYJ69nEc1IfEZSQdN
         eL17nll4CuyazA5cJVmxMNBk9E7tWm+0gCMXuGjjGjUE2dvDhcNrTgYfdsNZ/29qRNWL
         e7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783997416; x=1784602216;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0sJ+EXGchq6tpdm8/yi/4lEX2Uko/KasExedZuHto+I=;
        b=lbr+juQLOTvp0yJ5vptdC6psjANFm61gnFj3XDWMcWl0goUMrNX/Tnwne7+/ab5D12
         fSYpK6Lxo20P08eLfhBK5b2VJXnY4v57EN5+DNaoG2VaPTVfAaxgH1tXrsSHxuShjUhQ
         NmmPr03omMkMzFWTztEn9hBufvYfoCJ4QS48OpbqHcA5PALkOX1I2aj3dP7tDiXVnUGf
         XrEN4slrPTWz+XU1ecBpU+1WnqvFrgcB0ZxlVhXypLOBaLRT4ZqjnCL/X2PnVk7w6Doq
         Rkhy4LAphar9aNCx2o71/unokQZ1y7jZyjsxZjAD7nlToAO2upN3NlWom3JjScKCC8Q3
         0zJw==
X-Gm-Message-State: AOJu0YxviX2TSVY68vx9siGM/eNqPLeD29O+qTsrwoW+0QaRXXCxa13z
	TAaR3+vvmSvAXJ3V+bDzVf0X1Uk113fdZGg9Y08JtV0hAzHnwwoMxVM2eeKN
X-Gm-Gg: AfdE7ckb4AnOaZvOEmxyb4Qwk2/KWAOKV6Ss6UfrApPGr8/8Lo8KWaBR4ZOMOW8Wo5p
	/duK/oQHTUpJkp/bNGcVRe3KoOLMGeURbWEPag7vSsdjdFx1Tetd5jR3yIFC5FiB0WhlAJpNaoe
	lJ9ytDQoiJotjKlxX8/0K2M+mo03+sCRwv1V3FjlLCYmEaAHC6Vy+XM/8Z5sr2H0UcZ4ZYPSuI/
	bJkcH4SrHzRYpOnKME2oMac1xozwZZHKkhVH0IliVdezfqHmLMM9xlpnSIn1hfePfKi1/7GtiTZ
	gbNcXpQe5drtd25YOte06Ih++LvyFNPbatD2pxq6V2DzcDA0e3C5r0D71N8bTTNDWe5BYTwiDL0
	ETlJSl6XGax+ODmDqj3QVQ/BXKeebyB0IaKknYMFJk7mCpkcIe7LtZ9PuOEdepnXmRp7kT7MXGw
	oPmqz3kJxw9nTDH1F0pfHitI6wsw==
X-Received: by 2002:a05:6820:1627:b0:6a1:50f8:abb5 with SMTP id 006d021491bc7-6a39bee703cmr5564622eaf.32.1783997416090;
        Mon, 13 Jul 2026 19:50:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.46.239.179])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2bae7fsm15655966a34.21.2026.07.13.19.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 19:50:15 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1783992745.git.tanggeliang@kylinos.cn>
References: <cover.1783992745.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/7] mptcp: add MSG_ZEROCOPY support
Message-ID: <98337a98-7042-c045-3fff-a89b28226692@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 02:50:14 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/293000=
93407

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e372d75693cd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1126988


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
