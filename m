Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B0C58AAC
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012496; cv=none; b=h3f5pGtaJIyx7LOJpMCr1FS8sZPoLAoTQQnlZw2HFDpALHHQaXqOH42LZSQzSYge/Twe/modNGoTRIgKf7OW81afqEUk700aGpS0L2ggVcPJwSWAQeY/iDrT9ohK6KalET27ONWjmoCLWlWsWCx7qY1ubuKukBoiG31a6uhL3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012496; c=relaxed/simple;
	bh=nwB0T6f+En7xsWStpaUTEp45hHbbBZZgvFhEXeth1VY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FGPSfqNvD1gQLbXCmghZxhv6za5RhX3T4ZB83uu27nayXy3PGs2UyK5b3JOTwHzsMtutdV10fGLpYUovaAVl9HKwk5wRxI4cK+2E2U0Q30qWSgui4YEjumLdJGVvBJE1s8y2XCGNwR90XQx/iPC8IUqvPVxcLfRuqfU1iXJpin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WA3xwN/S; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA3xwN/S"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7872bc61fccso55603185a.1
        for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 07:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708012494; x=1708617294; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8U/fo7TdhPfcrOW4zNpUGrVGIYRFvS6bobPfv5sx/4Q=;
        b=WA3xwN/SpVCmuKw0/lVnbIloar43QCpqQ2tTjCYNBHgR86FZ+RW2gzSqYWujwNG+Jo
         UkqTyfB5CY465UNf91YfBUHTBlsm38KJhpj6Yn8SDTkYRW5CB5nsZtoxRp7g/6VnYFIw
         7xuWa6WVJphRqhvw5UfI6ePSIFEWrKZYA/pG/V90/Yg6U8WGXA5CQ7rNfPYr9bMD85ig
         tmAts4wSfIaExNXYMv1OOVeOuD3YNlp3K5SiZnGvgKzJkE/Q3rfcUjvH9E/r4jVljBRO
         +YRnVG2tWzw19SWz6996ae0hxbkQYw2xkleo1UC9ZpiGLxdOej3F0AnK6anLqhcQ2l1S
         OgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708012494; x=1708617294;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8U/fo7TdhPfcrOW4zNpUGrVGIYRFvS6bobPfv5sx/4Q=;
        b=MlGhzE/7/iX3RHnwKuIFr76HTi76jeQmWJ3nYiLcdt3YhmutxngdwzDkTKE4h7Z7YF
         hf8A6CiJGM+LWN+RMLADdvOKjzHFStY+62IJ7GsPB858sbpW26Jg1QqZXOjGeOKQZZib
         Sk2PrSlTpDTvc0y/yj4OVEjOwSleUoqu8XgSestwZQst4HTo9zaiHTCb5dMTg0cFHQyt
         5jIAYtoJxjQBtCNv8kUZsP/1gHZrHw2Mdk9TZZi+xg7VF5uOkkVVVpdvKL9hrd88JqBB
         ztjY8Ap938C3ucoDWnVVthzu2dJHJrzYCLLj5qA9JPaxWwIJLXuv9CUQ+drGw1WUH+N/
         b6lQ==
X-Gm-Message-State: AOJu0YxLAtz5mYOcH4GqrfziBHOq5JDkUrmBYi5n44d67sg153Ym2peo
	mFkcERqvxDDLFKUtrQGRZPVxedqxPDJPaaqb7OdTudzHrcOP4bE=
X-Google-Smtp-Source: AGHT+IEjdlV1dB5Qz2ekUSjNRtmJF/2C0V55shzCnCcgslQAHKk82hs7C5QE6z9MDfKFGdsIf8ly3w==
X-Received: by 2002:a05:620a:471f:b0:787:3e32:1c26 with SMTP id bs31-20020a05620a471f00b007873e321c26mr330673qkb.35.1708012494218;
        Thu, 15 Feb 2024 07:54:54 -0800 (PST)
Received: from [127.0.0.1] ([20.98.6.128])
        by smtp.gmail.com with ESMTPSA id ee6-20020a05620a800600b007873d989689sm120118qkb.3.2024.02.15.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 07:54:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
References: <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
Subject: Re: mptcp: avoid printing warning once on client side: Tests
 Results
Message-ID: <4f3ab276-e796-4819-957f-a6eeaad8b914@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Feb 2024 15:54:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Critical: 1 Call Trace(s) - Critical: =
Unexpected stop of the VM =E2=9D=8C:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7918253003

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/39cb90ad6cf5


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
