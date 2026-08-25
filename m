Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C03E6DCF
	for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648732; cv=none; b=ixBYYmXpC2zpOZg9khaR+WcWbUzXewByfcOtSVCErQZa8HZ8Zuw/5sX5RfaxSFPwIorC8UA6YfLBcNxeRp56iIO/pMmohMW9wpgCMfZk4jBQN+sfoeibfptbEsN6GJwOqjQ2cKJfmSD18KlGM0BHSHMEPOy+xJyzNxN+6QX+qIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648732; c=relaxed/simple;
	bh=KHj1RXYHrsH9WwuVLHhbI3Ub3xxnNvFdXZrw7EGUI/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=BHgANBcd3NhMGlgFuYoA4PWn7OxpPbKh4IPyrIL4321tN6b2EAwgeGqZL75jLOzaFKTN3eUqddRTMtUXJr5tFLT7RUaPrKG3bWx2KTTJj317pRsdVHRK8EvhWqL9Qf90sb62WRkYdccygXXaQHVwUgtHAB7TUGUC/5v8XRb4vrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWqlw+RJ; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWqlw+RJ"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-45e6d266921so2912980fac.2
        for <mptcp@lists.linux.dev>; Tue, 25 Aug 2026 02:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787648729; x=1788253529; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IeIxIrOQZYUwFcYcf+RFTXYq0UPXZmPBnWyOFYDJh+U=;
        b=jWqlw+RJ325cxEg+ZP7F6VSA6gLmyy0RKwpy8jzimg+4aFXnLqTVLIbbC1u1fAftqr
         x5N37yt+YPdGxNIc7uaIpmupSJkSR4oaE2YRaaCfD5bXuBYpqwIU3aNYLB/WfIxILaMh
         Q7rR3FMkKDxUFiYLFOAfs75y8B+Fuk6Lcib3Eq7sOr6MSnE1zBhSI7gIrAGo3Hghs/jX
         ymoSCWYxI5tjC7p3tWLhobUwnCImtJUAUXDu8bdyWJuYyVfcAxzdCevJ896fNgBa7mCN
         Tndz6tUjcMR9BdkX6Q+T9T9g2KUGdCoPfK3VZ8vm5pSA3g3vS2vyys4E8qVtrQoqxZRD
         vEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787648729; x=1788253529;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IeIxIrOQZYUwFcYcf+RFTXYq0UPXZmPBnWyOFYDJh+U=;
        b=mi2g8zy5SPp0qJfcmjSVRkPKEgHXcXupFjWgA8CqaG6FLzG/DGuoGko7iMKBOQ8AsF
         umBU/WyJm0rEi0m5bYw0XPQ/zjTz+xFi9WAV2BmgDQ1xmIRLyJbGuKrcSFMM5cFqfZUm
         9Lle3oZn+/I4EBeJfEKhuU1ILG/8FeGTiiJuutUjrs4JlX63eHZ99nl7LM0uMh6+FTg0
         HaVqJT4IOuzYgnK/Hv+59RoKo9LujRTRxP9LMygI0Obv/3VrOp8halngjQuIfc+ShZev
         8Qe9bq+YcoOd8LboU4MM/2+yhoTTpZBgKJLeyumeZUiDd6KRTgPXLdo85fdOi2QxB4NP
         ce/w==
X-Gm-Message-State: AFuF++mKHFiY3hIpLSfN213ZXZmGulQDA1GRmMTR2PRmOdykkO8wcH1h
	7eNd00b0KnbjjqBHNr5u+yzmUAMJ9v4ddP8fH1iIs7YHIaa8b8zJ3PJoSgonYf4=
X-Gm-Gg: AR+sD11RjYvpwk6Kk/0Zg2k6XNgKsaOX0SOWoQzM4XGn5B2WiUswiwnlgw421KSRpYV
	WKkQyjVK5cmumi9og6eLBF9OWXaKeeYDDa5lPsbC/5PY4U99behUb3Xm7n780iG7u1toZ3gLpQN
	PyPNoLtzh971e/lQ10LvIjsl21P+/ctLq4PcssiVe5dvrgiLZHc+35EF4rSCpTcGdobJM4NszDe
	XyjiTB9jzVyOm0s019RuBKiUgTMa2Ha0KXWubrnWck1mGgV5BWTPBTFVQ1/10KR9xja+wg/kn7H
	zXw+33c0UuOQs173eKTD0dRN0uNsYIJ7ZuzLDWUDHowg/cBjk8IKEzMZ1FnqlbJV4fer4vUkOtx
	NQMz4FOxKNdL2tnHNawrlcgUztG01YDfp4tckLiIp+PYn0b8i4IxBcwJrCDtyNoxfKvKD0tlM5y
	1Q2TS2LuBacLFaPd4ANatPUKIXy0QZrxFQe2T9gpBZ+zW7jYtmmACaVQNfDq8HyT9Mv3A7DOjDQ
	K1rWXeVClicYOk=
X-Received: by 2002:a05:6870:a799:b0:456:6097:168e with SMTP id 586e51a60fabf-463518c0e5emr29098079fac.19.1787648729348;
        Tue, 25 Aug 2026 02:05:29 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.223.224])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4638354650dsm6957626fac.16.2026.08.25.02.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:05:28 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1787644449.git.tanggeliang@kylinos.cn>
References: <cover.1787644449.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v8 0/8] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <2348d23b-6361-4421-84a6-bdaf3a917b01@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 09:05:27 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/328256=
88610

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/415f8a01f452
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1151323


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
