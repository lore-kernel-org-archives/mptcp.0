Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF43403F7
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810400; cv=none; b=gwxsXuWP0MpSUPkLAY18fNmxle6fecxGonDhUU2rHQ1gJ9T3pUi1oAg7y+MlvgN4yJd7hKiB/nmKLfL/a9G25fokU8BvrrW4/Tcj1L8LJAPt+igIO5aqXkSQes9DI/CELS+TMlRb89uA3reytC8oukj1lXDSIb+7byNM8PlKXIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810400; c=relaxed/simple;
	bh=SfGWeaiIBJ09677AYN+I/LHCCO4oGqjHcvpATjiCh+w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=dz8GUbmxA91mS6rmN1RRS5v+de4j9acsl86SEM0B0BveUyoFeicu8hJk/3fsYCqucbUaYYMC8B/L3zBPuuZ5yqzBeWp/qVuoI5G0KW2pr77WL9Etas3S97zdgCS4bWTYLnN5jb22PRDeSW5T0+B4A8RCqnKhBTDvHY0uTe+i85c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFFJ6V/d; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFFJ6V/d"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9159951f05aso522377785a.0
        for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 02:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782810398; x=1783415198; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+xHRViXcMl0e+2HFNTgBQp0DyPsU+goMhAbwu+H7g4=;
        b=hFFJ6V/do5dsu2KdnikWC6FO7UKv2qVvZwxxdrQ3JOE3nWhfLpH23J3GjaEXQHKvPX
         8a5nxD/OgzWToZzk9Wn8nhGlPOzVBYxXKVn54iry6VOCNPi1p3VXxNlwLzs84tOx4vuD
         Spk1LTYrbWYvEfP+5mERHYjX22UySlZaGY6CRGuubAXQBRHtDe4Ln9JTT5WIx/+i7GZN
         oRV6jNgbSXsJ2V5MOkar1PhLCEC30AW3mc3tW1y6dt0GSFErSXRfPIZUleq6TEElowIf
         p6p3t4eyqN5sIDtcbKji5v61qsuEVvf77wIbWYozi7qyj0HMfMqPQZn8Kmb0SyL2Q2BC
         kEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782810398; x=1783415198;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+xHRViXcMl0e+2HFNTgBQp0DyPsU+goMhAbwu+H7g4=;
        b=fUye+gcwI8r0JlcMkIpW/G0N49nVwZNlWmS1GOtPYTGqfHd0tdPi1TQOI1Z7pZ5GYF
         3HGEIhlEGdqGMCkGrEv/mc9ZUhmJI9aPUJqyQEcGaShCSbtgWlGGcxll1BY/2FsiOp6p
         EjC7BzQAcTXrArfuFxKXExGRbs9Jts1TOySp92MOFr5PiQ3SGdaknrHOnHa78kFMdQ9b
         8TqGcMFyWsc1ynNx22HRRTmrzf+7HameNy3DuNUiZBkNZ7HTq/wrer0HdHa2hepF98UY
         Mk/xXCoO6T57vbbI8wAtRYCrE6HH4I0ftQaRRTihcjcM4gtUlywzp/e2j5mhqeXbrFXS
         IOqw==
X-Gm-Message-State: AOJu0Yx37W+35RdaNy84OWVPQ1IGqMl0jriB4tLpx/WyoCn8YcV6OLZD
	0mJfKM6+mHf6zDa3Glsq3N6jEkgS73fLpY74QMf5wdQGs+m5WqgbDlZVqUSd8kw=
X-Gm-Gg: AfdE7cnCGERpEp+cCHiRkh0rM0NMqyq4cIlEWtLRTstyVNm6K6uTD5kBtTU9/NQ4ZKJ
	ceaCJ3Ksoeoo43UWusM8iffvPjEipfifOpbksQaNLrKGzIH2vYKvB4BneG5/hde7QFWcbCS/QqH
	mVYVMm1x0NuiFoKzfFzSxMAwOIf5weJvZhFvzFTn+G8s89CHZHXDpXsU22WkzqLpk0UOHSMFNKw
	DLf/UjNojr2/3c/k4zN5eN02rIjTZTXPQonFFprdNRgCnjTGIcG3XA2vYCl/uujcxFO2QIRyqdA
	QY8FOKq80i5ykgHu3W3o7TeMgX6AOwVWbwxWx86hH11dvsFaMbqa9GoED9F//HB3f6+KDIuh85t
	+/n5uf7WJvO0S1nOhifScpHfWkg23Ql8qZ4XX6D7EDxRQEyqDVSwONT0zN52PZEaztHlrlVKhqb
	3J17cmGPL1A+4DS3iKYvcLe3mtyg==
X-Received: by 2002:a05:620a:31a7:b0:915:9efe:6dd8 with SMTP id af79cd13be357-92e6279c3acmr426220185a.42.1782810397834;
        Tue, 30 Jun 2026 02:06:37 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.86.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e622e84e5sm202093885a.24.2026.06.30.02.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:06:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260630074237.166076-1-gang.yan@linux.dev>
References: <20260630074237.166076-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-net] mptcp: pm: fix potential NULL deref in
 mptcp_pm_ops_init
Message-ID: <1736ee42-4d3d-9b46-ca1e-c77213476bda@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:06:36 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/284301=
60954

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b0b9e97629b2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1118737


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
