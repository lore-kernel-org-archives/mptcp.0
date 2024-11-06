Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2831F13541B
	for <mptcp@lists.linux.dev>; Wed,  6 Nov 2024 04:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730868573; cv=none; b=dkSY69Vhztm4CAKFAo16hT9UjAsQC5ydq9lYF5eZ9+MY4ePBBbU9grUPneFPsJ4Nf4hx76lvw0/DKC9iGj9POdW/mZPX6CFoXV2C5dd+66ANN3THhywMIkhj+v+m7nkBdWGKrRcZFFPeX3YH5Lsske0QTyPb2ID9aS6iLJmiFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730868573; c=relaxed/simple;
	bh=DqTYsgC0Zvp1tEFdwMbVl+KWAUmjMSvB/3PkJ7V05FY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Sqi/wrcpBC5H0/P8PaaSbkH+Nj+ioMg7kYdM0rOf2UsA/MscB0hHgdYKKz/3lanIXIpV9h6Jc06bCtsZUQsWmGuIfYKHkh5CSew4S2XS3g/Q54Xgkn8cXFX3UAerQss6QOi/rzpWrQa3Gqv0RoJarbqqWfZIiJBy4IxFKDL8Ydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9iK2w2N; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9iK2w2N"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460dce6fff9so45551121cf.1
        for <mptcp@lists.linux.dev>; Tue, 05 Nov 2024 20:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730868571; x=1731473371; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsEFCJ8LRDOU2NSTm1mmS2RzzQSLq2g3Oh1dvXmyXdw=;
        b=J9iK2w2N5lBIUsmTA9QAvwbOGqrD6m3WdP8qQ5y6JaFrMp1BRAHLjGSenfoxC98MeK
         QH4qFqq4xH0widU5JRTdVfA1eW9WkXw5eOyA5EUnHmJxRFzCmR7S/3KWKlqHqGNT41Uf
         wowUKlgKV4kbnbxMGBw6QbD0gXrhyCsxAEvrK829db618eT+L+tRtSIhxKddX0bolsmb
         l27ZJqFrFb5F9jau2goDLEgycNKKLiV+qNor4/BKLDju8DZREb9s9GOlVL4QxuzXqOr0
         eEv32+ANG+C7q/D51x2wSCA2ioacvt1UHghg7xTuvNbmbUGOYz0gRZEQwVWBDEWGfs77
         49NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730868571; x=1731473371;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wsEFCJ8LRDOU2NSTm1mmS2RzzQSLq2g3Oh1dvXmyXdw=;
        b=ucxWf7+JGHo7rjpAztQNdSQ48iYdEIO6mvV3z/Ryg7fkVi2y1/i8IDIlRlZ7gtr5bz
         zQAIbupKmZSsbHLHDT6WpDvOICWvykVraFcyzT97JrR1ZtcgKQ3+pTZ9O8KFZvxV6ot9
         xVVCjqRjZubYovQmvlgKcA0B8GNaKfEDy8nIFAE4yYm6BvM+yhMUiE1Xfv+U3RiBdgN3
         saOhEBtNUXOy0+vUDfIZbZTT+d+iuAR3082uDXQHrH1LT1rzYhnZSbpZFcTBxtAxNVSR
         itYpl2fLvIsmcYmelPcNyTqjrNIoRQEy1c5lLpIivgipOOMEMGNI4iAltbEc44mR4cyM
         7vWg==
X-Gm-Message-State: AOJu0YzLxGTlsBhn+SbEd/AJQjFqN6wlShG3SD8Uc/elFER+WDLSX6Zy
	IvC70/6Wft3K6FmRyEpLpXMDM5ZyJqGIKaqyT2YXjpGlI27ZhKuqOaJu
X-Google-Smtp-Source: AGHT+IFBIYu/G9Xkr51FCYSmL93lwiqUPEJuUZgjnAh3uQq/CVchuRyU1EMkw0n+hACO3m+CotWfpA==
X-Received: by 2002:ac8:474d:0:b0:462:ea22:33bb with SMTP id d75a77b69052e-462ea22349amr38884291cf.38.1730868570927;
        Tue, 05 Nov 2024 20:49:30 -0800 (PST)
Received: from [127.0.0.1] ([40.76.119.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad19b328sm67172441cf.85.2024.11.05.20.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 20:49:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1730864444.git.tanggeliang@kylinos.cn>
References: <cover.1730864444.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net v2 0/2] fixes for userspace pm
Message-ID: <9738c08b-3c0a-a8f2-944f-79cbdbc7c668@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Nov 2024 04:49:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/116969=
18672

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/63b85be8ec5d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D906742


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
