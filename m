Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B2E2FFFA5
	for <mptcp@lists.linux.dev>; Tue, 28 Apr 2026 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368159; cv=none; b=i36PB0xkjtd/Gk/+mLMizUN0pq5kTC03Nl6KTZ2yUXkFz+mW7uK1goBuh3dabe819TXfPd+6VH0ojDfnpZYfzaKmBON1UqZ52sdjYZF+QSU6WkA2TM47eMLhhl2d0LlKsQjqDJvwEnlPJNlxNDI+rtDpwwxvwoZ24SMeMRsDR2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368159; c=relaxed/simple;
	bh=XGTmsE1k+sFDG5ySs3ugOqg7TULbwtbhIKsOdKJXV0k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=WipFwIRbiDpLKyp1YZCJQr/mDW4zeABGZ0iT78okWc2aSXpYL71nXcbUIiWRtAoc3Fp0Xaor0009s5l7DPAz47jw84oDoeilSkL/AenETlRktJXUCvyjisTthzSq+MybtyZgW1IWpN491WrUorAs7OEaVXgM3uhQ7OlSXQByBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3pAVzcu; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3pAVzcu"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb20bcff5aso1044971485a.3
        for <mptcp@lists.linux.dev>; Tue, 28 Apr 2026 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777368157; x=1777972957; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ult8SPJp3ZiNU3w4F+uA3o3zZpPBur8Nfm8yl0rA7zQ=;
        b=b3pAVzcu+9T0iwOcoHlQKflWvw7wKJHCnxFtu8rn4fMO3fnn1PdhJsXerz/Z8hq9X0
         8CaNIbefDgrSgPtTWApXi8J2P89GEp/A6bb180wsH6ejZcZ8rp/iFMqE3wgNGHtoAtvY
         u6cm+k2WEu57bsOThkszkoCtzX9Ejy5liw6r93XrRQ3VD6ZqCLJ5wPebbZkd3fplYogM
         wrvqbyKOI7M4MEufPiHoUXktfPGdE0p71vCIyEo6PuNMhb0bePCIPSaA2AqIEeGU+mhc
         9dfbVYoEr0MeZ5F2gkjlld1gJcMNaw0sxGPrHrnNGo+lh0TuCiCTsEv+PI2R9idiezt1
         VeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368157; x=1777972957;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ult8SPJp3ZiNU3w4F+uA3o3zZpPBur8Nfm8yl0rA7zQ=;
        b=tPD+AiKhV6Ej1tY/+zEaddeI5LKLg4sc2SykjMOb1i1AkPWKeDkg+LtWm4RbX/fKkk
         s0OqLzcN1uDmGl8tgZ1V/wwl9EnMbbGdTrBo/LzSwrq5OXujtgPlEx//Cv3zyccY7hAb
         Fmx4qUrT0YDPXfoZc7QGshAPbxlsjn5xsNDhZfbwG52tJijlrPhJi6ydClxm3xsHMo+1
         vi8A+p4/SlPtM+1DlNNR3QsgjH8gTlLg76Z/tEfMEQ+cQGbZ1/UalPx6HOt5mXowrv+v
         CnDCNwW3y6E1+z6U19bR/HYckIQVXdRR19H/74kyx9fxUHCSJFW0LI4sRlcprhO7b9rX
         OzHw==
X-Gm-Message-State: AOJu0YycfNoWzy6fWCpZG1ndSPDcI6H8jM4/+ODMspc/gs5Bmaq4ssAV
	P9zloNFUJtasoUGxdZtHemtdKOxqkU/tDvi0pxZYEFegexXpkQYMaEBIS1MB
X-Gm-Gg: AeBDieu8C0QwbKmYs/EptfQUcAnsCm0pf6dpw2ojUoDyScD1QISbZcC9hjpDwC1AFrJ
	QOoWQIGe2ggkft7qo+t5fNoOM+O5pgaB8CFDSbT1bsc+VL+TNbKsLa1GZxVF56dMCMWY29rgc/w
	oUJpEHwYrepF13AzAnuGg7RC5lDr0oZuv7FRC07WmbE3gWlGWKszEmvNW54Ima5MkxYugbAnQop
	OeO9xI+Qw43DjIbbar/btS2hRuwa1h9Mqb7nNPhNbUi+CEA2jb7yWC7NNQNvKDE7CwUD/FI5zFV
	8MtNjC9htd4guI46Dmc18mSr2qa4sXaIXsCJOiBUGiku3MI2SVd1Wvn61JTzMGj5Pzy8epCsnRF
	XewKnJHSOU3exHf88wYiFESXAX3XNaqvfBaBn8SnjwZ9pEqU2WDGGxHcFTSALG3AkFYOAEHDhl+
	gW/z5yHM6SZ0cFo+iG/9sdZ9h5SQQG9J6lo62VvPlvvxWnQQ==
X-Received: by 2002:a05:620a:461e:b0:8f6:2efb:b10d with SMTP id af79cd13be357-8f7d9009326mr272043985a.35.1777368157180;
        Tue, 28 Apr 2026 02:22:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.174.55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c48c79b5sm150274585a.8.2026.04.28.02.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:22:36 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260428074844.1746594-1-shardul.b@mpiricsoftware.com>
References: <20260428074844.1746594-1-shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-net] mptcp: use MPJoinSynAckHMacFailure for
 SynAck HMAC failure
Message-ID: <16faa9f8-de44-0e2e-b90b-e8527cd149a2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 09:22:35 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/250415=
71236

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f83294fe083e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1086634


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
