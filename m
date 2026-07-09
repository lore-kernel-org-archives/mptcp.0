Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A26D366051
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585207; cv=none; b=QECxj2S84sSz0Dt8LLc4sWnf86ui/82Rmhiur0vGTRQMsEN6q45Law/OxPbeWLPlOZfXLAvkd/e1THNkPZifHJO2BQfuPaeSs5AEpc0ORAY8KABomCeOlogHh2L2WSl5pgFgL+IZQz5nn2uE7tkaOz953+v9cHreYa9ErEZVw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585207; c=relaxed/simple;
	bh=LbYArh1XVrJ2Y3JN1OQZpJi1Lf7Al+vcQsaE9IIUZhE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=psP/ysKKnDeYDIi/fyCwFxjEksCMbhbo/j53dKzQbokThqbrLUxRXrBh3qeK+w00b7GDDUumfOBmpp15lZ50moyJKor7LTS40LGNYI3KFjynjM0tnIWofQXGiPDDOb6snIg0X2WzQpPECUcyNNs2by87HvTxecfMh4xALVasp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg6x32bI; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg6x32bI"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e67555e24so72550185a.3
        for <mptcp@lists.linux.dev>; Thu, 09 Jul 2026 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783585205; x=1784190005; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TzaDpTmjhgY7bQxHMBm17vR4to6kTfr/nVq5z24mcFA=;
        b=Qg6x32bIaLgRbIyMr4o7fErL6bFEFOGdgGW/djdzpm7kATMjthJghB7lg1ExqpOq5C
         zQPElAFF9MadWsli0X3n/LH+NwqxGqyDkKU+2lSzRsQzobds1SYytAKPITm64IHYDOCr
         XOfs+xTMSLz/+xD0CY+MVxVGkQj64XIGF0OS1qSMkKeheAUT+MGidoSoRLSbputDiB9f
         Ror5ydAHUQMW4C5mIuBlc2BhwSe+5DpfNvOn5tqpj8gFknIbg/59z9J2yTHMbrOtY3oR
         OM+0BjZZaS86zs+I9/+mZMx0EDIEkcUDPXjXgnijay44LcB/r/ExdtoATMNeJcn7KMuN
         MkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783585205; x=1784190005;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TzaDpTmjhgY7bQxHMBm17vR4to6kTfr/nVq5z24mcFA=;
        b=I7LEaqkAsSl5J6MWXXSWsC9LoCTPEcOiqr8lYSLCX9HUuM9hEoqzZ+yOlpMH5Q3N9C
         eRpseiA98V4A24QfEppNyFexcy1XQW4oDqjz1LndEeORdQg+Hh8ka71+SzjRXDgv9ZcP
         4m5OWYtOakj+itL1pSgSUp4Fw1+ruu9Fl/4Nc1mjmMqhcKq1WXNWDv62HxbcIqL+W8Pg
         rB1FK4dlK5dVoyhFD7nWHq8pi6eXhmOKvZmAgrmxZo7wIjoVclGqJ82IMznYopDUdPYq
         c9s7TWZxOxdXrPwLqj5kif99Ys1z32b7FMeGLusqGGJ4idE+c8TVMRlrfYcs5CoSJAbl
         QQKw==
X-Gm-Message-State: AOJu0YwNihVWoB9TRh/BL3JzB1BGKZv7nSwySXHzlXQV9G9hsmswrdyj
	SP0KryK5ZmT9Wx+z2pTWVFhTySfnA3KGQIepgLo+GeiwkJONBtnmyTaWV8l0
X-Gm-Gg: AfdE7cnb66Qq6UWFObdHzi+SDheMUJXTm2pV4rl5sr9FbIrOWdEr5zF/6hoe2NHNSI9
	WCRqhE3z0moIAts7VuRPM3yHSMvH969TkaX6VfcFlnZw1Qo9mBoh3gUcvA/QnlFvZBvRcXFFBaU
	FaoyanXoy9j3C5etNmGMfaWGTszXsGLrhB6zB/fn/mWuRjiEzEiC5W75fHPHAibrRv8MjCdrwK9
	vHB+pwLcPhzaeuuEmBX5gSbAvyh1z4nSJscpL2dqARX6EaBA8RJWHf61Le8Cao+TD8dx3LRwakk
	ANC8IFki0IDvSXb1ve7FqGrTVSuo8+hSoBb5N6Rih7EUQxY8KdKMhToD5NZUzUVLkKtgeJJrN6V
	XWVdiNtILOoTjXmVinvc9CgLL1AbwoXFsl+cyoqcmpP2GmMqqmuoxjPmhVLlQamd/EI1MSkInPY
	kQksJRw7lmt9RjNpnmfZF+kG8tYXg=
X-Received: by 2002:a05:620a:4622:b0:915:6c63:b9eb with SMTP id af79cd13be357-92ecf68c93fmr591998685a.47.1783585205002;
        Thu, 09 Jul 2026 01:20:05 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.108.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cc18f1sm1588948485a.40.2026.07.09.01.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:20:04 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1783579976.git.tanggeliang@kylinos.cn>
References: <cover.1783579976.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 00/12] selftests: consolidate TCP_INQ
 testing into sockopt
Message-ID: <37ba1100-af2f-6bd6-c549-2001d1fca309@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:20:03 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/290018=
32658

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c950e4c1806b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1124363


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
