Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE2412D74E
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001439; cv=none; b=lhq2g6Emr5Axt7g9KEiO14JriMl957NltGM8hbq5XzzMUp1XKLWR1u2vwZeqgPwtN8zhgLRwmzmsRlS1c/2hKCQBRpAs8a5zUf/hqE1cVk5HDwccJd180SbP7bOAKzbjqTjMhtPjZjnpuaWrw+AvvSwcot9+4IgHc+2Y8iXjE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001439; c=relaxed/simple;
	bh=9uUg3HQIYiz4X4RYGXJKPeLOwhpJ/UNxUt0nmwpNS30=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=RFQ0rEQ7lK89uKaWD3LTt+Sb1fB5zXSmw0PrgH5It7dCGlTqUOkSbn89l0ZAtBIR6rmQCuOM3xmNQtWH3y/NA+eoHh7/Sf1u7VYvxYF0q360dvUfIVc/8VAKLbY0U0aZ42mEMyUnFXqRqZD3qAoY0bLEBYJUyOIueJdKEith1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYhrNAiq; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYhrNAiq"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso789102276.2
        for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 04:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708001437; x=1708606237; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7m1Wlcd3mHFjUogFJDHdHK68pgDMDlcjavSQqbY+2I=;
        b=SYhrNAiq11rpmNtrJAS/JLsW4h9+OXy/ZQoviiv64d3gixNwbCOuGTCLniVFeVLWgN
         fQzUyU55F6FGPNJZGUNOtaX9MUaITCKRwW/FsndNwVVwvMlvVhx/RyaZTHiE7SKk3jOH
         yH/ujD4E1jp/NCr8RHPjheeRTJjGr4gSFAg7870t855INFDs7OeF4BFptVfHklk2xbDO
         ksWwhX9J6sr/nTQm2x9lcBcBRfHg3/Us7LL1bamzs0efWkmHygnkIAInuGF5M3LfsqM2
         +qern73aorZVVX9VxrvFCH7cYiMtTKEM1jS4f4m+AX3rrGiIDKjg4Vk697GBkOCPJxb9
         jZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708001437; x=1708606237;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W7m1Wlcd3mHFjUogFJDHdHK68pgDMDlcjavSQqbY+2I=;
        b=ntQHBFtuxfAlR+eEebadwq7Kpu3SFBye2hmXv87Xhic5m9LIcmXaJS8QITuz7iHFra
         tiajLGy34LW3AtFWqcx+W/6YyhOo9YNxHuAvTDqX7Pt0UepsHy1o8jEjd7C0BSoLHHHD
         UjvaovdCXHXJIl21pAS7zpO5S25U6n4MXRF/WgfLpS1dWW+v6RtA/RZ+N4RqX84o5aNB
         QlGnSD0EPsdmXoPhm7vkTCmhu85kJtfNtTTsXVX74hEqWfwsPnR8zAE95TVX63eQYGQG
         x8sj6lTWbsx6WsWGpLS/1a5d+qbAi56VuOznKqU/w49EfcYOfVtMBAPJ3arKzwmxLY6w
         Xw7g==
X-Gm-Message-State: AOJu0Yx443857rnvQYz2c4ksK8nUHa41Y3chu4Z2kf1C2sPpGQ3+mVeY
	q0d4QVed5Krw3gZrkxl/kUW4rNxsCkSAL1fmiPr2N8gyP+a0pB7yF52AGKA=
X-Google-Smtp-Source: AGHT+IFEPMKWax73fbr1bhtQTPRUw/EbeLlMRWxwuI70d1guh+Vx1VP/I9GGho8wOQI+privR4yWtg==
X-Received: by 2002:a25:fc0c:0:b0:dcd:5bfa:8184 with SMTP id v12-20020a25fc0c000000b00dcd5bfa8184mr1347682ybd.39.1708001437069;
        Thu, 15 Feb 2024 04:50:37 -0800 (PST)
Received: from [127.0.0.1] ([172.183.130.204])
        by smtp.gmail.com with ESMTPSA id bi1-20020a05620a318100b007873c8f1b7bsm78550qkb.62.2024.02.15.04.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:50:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240215-mptcp-check-protocol-v4-3-16e932665e21@kernel.org>
References: <20240215-mptcp-check-protocol-v4-3-16e932665e21@kernel.org>
Subject: Re: mptcp: check the protocol in mptcp_sk() with DEBUG_NET: Tests
 Results
Message-ID: <f63116f0-b7f2-7430-ff88-f68a40e0714e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Feb 2024 12:50:36 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5212375712792576
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5212375712792576/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6338275619635200
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6338275619635200/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/96cb1155ed44


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
