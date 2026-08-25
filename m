Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A0C4457CD
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662099; cv=none; b=AjmOdlp7ynmfq55Gkl+RYa482QarHqksNToK5s6iAfb/wrCG4/6wRqDTEYz5kHpY3K2PAF3ZJXVa/1ir9gTnv3ybPRETFAKrCheTkOniq1wdzPRtJn7rymn4pntvq1g76Re1p3xQMQODdgCFm9tMPLHReXLnJ19vBQqoI++joDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662099; c=relaxed/simple;
	bh=EzL9lWKQ+rZ7v79Ba61fGWKyOTG9GXIHA62Rk00pPTU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=FYYgBKQaZl8x4YWspPmMn0B+LlSjSBh0g8GmmAhn/hIWwrBHwuugZ3HVlndTMvlTUewrE9CzmhbbiJdRg3w46VrnyO7o0YeE0H+/x7NIHtTZumz+ziW4hPsY8AvrBmYC2VksJRN6yKuNHqdSkgVFK5lsLB+b0SqEOJlKcRRm12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N67t1vxw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N67t1vxw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d5655cc850so51376995ad.3
        for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787662091; x=1788266891; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ks0IXLNGuqwlCul7sFUqtboYMNGcLv4TqNlHuGTkEpI=;
        b=N67t1vxwhSxZ086d1L/i3SIuD1J8QCmT/oTfavvtt8o/KHsKLD35wu+2zVIWoxWUsp
         Yc4VNfYhzK1cZuyvr82PycgONEx7qfFNFfVaea4Ho8Tp681n8gpBTzk/Y568BZBUEt72
         FSG0KTEsyUXfJM4BONMAUvaTQ9gmla7i6P5autKNYbOxsPggWt83abjduvgXGJ81uf/W
         QBaGFKAOgXJ1qZ/MQYK9fDVb6BNvpOPeNbaYi9WdlkhFQPxZjKpUQrux95PzAIc3zZfr
         GNOAl3WKAdKQNrIpy7yrkPnj/6ZjhE9AB3yVQ3srSVufJo860tyj/HPsruzQQ8H7vpLi
         8nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787662091; x=1788266891;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ks0IXLNGuqwlCul7sFUqtboYMNGcLv4TqNlHuGTkEpI=;
        b=Hx9p/zeI8jswMHuSm3zfZQRKjFKRjDXM0Ox2gJF+Y+3bFR1ML4UO5O4uFXWAxLgu7d
         owp4d2u1bK48MPv9bzf4BGDlMUtHdDxNuwkpDC4MmTVTLS0fJzSDQxkH8/L5VpHKMgHB
         kN6Qa+b/OmxMTqcWPwwAJt1wHtq0+pi1f/ao1EZrfk63hWXnREmnrPANid1HQD278sW6
         VMv6XeU3RmZmLu/HrVnGq0d4/HIZiGFaDqPki3Z8fWgX7VyHqRr57LcBhIs9FmNai30n
         X9OabG+A2McoFtmtvqMtBznqmWegtrlTXhd1xS6rjs5fIjT7GNju3dXzYDT0vTJN2H6s
         S6Rg==
X-Gm-Message-State: AFuF++ndjcFniIxGEpZFES4X7snEdAlpMg+u9y8SNFARi8W5LWN9Pk69
	GITXu3eDSIHTTOfWzb6npBTBIbDGiTNlzdiBrRZ21M6oZI9EEAL8vOy8vyB/
X-Gm-Gg: AR+sD11XLlg4RbKhK6OW5qoxtxRWi/5iftjKy3pQmweOdIKLXpeJ5fCGqpsnLvzwOf1
	B12l0muZj93aHbJTNS+G6HIgvZHvopwP37VrVWNhPigPNnVYoZSvalds9QGCBwmAIHIgTdgNJfh
	CoVA5/eZflfqun9oyvwyzCVIA4LFwafsRZWHmQ9bJ+Myha+29Sc6552Obxxeh5TJlOS83wHVhq7
	czlyeKTWMA4r3UwcwXgq495yJZvKUFmAjRG7b+QwRrw9LWoRrkOj4QGkPN2sjy1wjcNl2Tpsv5w
	XwJyyWcJ3csgX21gKMURz9X86icAplS+ZJhNMnP4ZmKn0gho1o89FZdE2qSlpJRbo6KYbJcUxaD
	g+kA7cCCy0uDu71pcsMo22mkxzsafNZ5wYSKvTNW6hC8DxGEWU6gwq5nyWhY9vsLpHB7i2TNcUI
	qwDbI+O5gSnQ0nQnteK3xr0ZVxECjHArFZVA41FJLcQPa59Qdk296T4R4ANjZbciZfEzqQxEMT3
	XQ=
X-Received: by 2002:a17:903:2309:b0:2d6:fea6:fe28 with SMTP id d9443c01a7336-2d6fea71bd8mr13185135ad.4.1787662091211;
        Tue, 25 Aug 2026 05:48:11 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6e4fba8b7sm6223435ad.76.2026.08.25.05.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 05:48:10 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260825113355.3573376-1-kalpan.jani@mpiricsoftware.com>
References: <20260825113355.3573376-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net-next] mptcp: normalize seq numbers reported in
 mptcp_info
Message-ID: <c53777b9-d738-d6a2-db55-f8cbde237ee2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 12:48:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/328451=
86022

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/663fdcb90bfa
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1151476


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
