Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D733DD851
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791852; cv=none; b=mlfZhhq49gY/R7trTuwJD935hesdFmFRtRJzzrqJud8p1c/2bxpylRVIi5JiyL904PkDPPhSglOwAVJrdcB7MNmyBR5OUBSbe7s3uR6xsZJdxthpcgnDejRdBwfT5CHx4MO5cxWthcANj3eXW/hn/MmAEm4atDOjhlNnEhmhYmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791852; c=relaxed/simple;
	bh=9v2p2K8CaC28gGA8G02vz0tE6LjPPmoW5WFg1x8pOCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQOlvnAosckmzMiqJsqGuh5aOGBoCkDLEe2ZMZtSOerBkSlnnlrAkgD3INHX/SPrErd0vnsmNRH4xv5hE2qow6h+rRSgZLuQvGIDW6fOh6wzoj04yGnm7nts56POqHF93TLlF9C6n1xT1FoIIIqa1a6tkon4vvRHQ0rrdhytW1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRJ1huJW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRJ1huJW"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b45cb89f7eso69784115ad.0
        for <mptcp@lists.linux.dev>; Tue, 26 May 2026 03:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779791851; x=1780396651; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nNS6smt/fwujpdjGdjOpXjr3l/UYMRr0xdwkosYLDqo=;
        b=nRJ1huJWuNrj3EflRo3xDyCDQBpmmBGx32U8EBGo10pk/OOiKR57zbG9oSkHIpEgZa
         C7vW3DBENZ+FAtVtLQ9PsT+xZDD0okXVbAvL4IwCY7BaTGVXY/G4wYgnGcfqPK/T5nd0
         spAl5pWMJmmBSMTqPFqqCwXof0jQjIho9Da9sLicWbwigvgXKdfj5wzxA8ExNpoaZe43
         bHJ9urGAJtaI7fKMrrn/XJbcM0HVCVzd76gJ13Tf0H6oKZllY65kt6Ul17JR2rg+Rdin
         d9fVtQvu1U9cfzlbdpY03TrYRACXvZzaupaCinFc3dxOyXXpR+p+X92fJdKPrfwt/jRB
         FbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779791851; x=1780396651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNS6smt/fwujpdjGdjOpXjr3l/UYMRr0xdwkosYLDqo=;
        b=H2ehAwU3/GO7YUL7SOSuFE1vpwR+NRR1rL6DaNxAVxI/D6yQLNF5e7rmiyLDS6QNlE
         kZ52KvgK/ZH30BY/c4hVYr1xwty8tRvemppQXxcxoI3PVWvN4DDTBhnyY/4aP3qfZOYP
         bkLaUB+Dd0nPIcukaF2XP7/Z/UEsY5CaOlo2yjQfXixOFq/Gf5gZIvSO2p9AWKW3Jj/X
         aTNwEPQ9nLxQh5fMfAhxxMAR/iiBtnmqiIabUNErHBbKIQgpuommsLYJFvhzhUNl5Xjl
         hLj+Bvdc7IqqHjc8rHoQZ65RsTPsa847YCK6LLJwVYQG8/30yHfUI7u/dOLWZO8ut+bM
         JhJA==
X-Gm-Message-State: AOJu0YwXF6YSbyZQKGbTkVE/wZXo7LbYosiyl7UmgNd53y0VisahAQ5a
	70//KT6Dy83zLF/qoRhBbLoAGviHyF5yMwxt3VhqQrsSJNBz0p05g/LGJQQx3amC9Ik=
X-Gm-Gg: Acq92OFi8GXl8SRI9aocSYAIZOf8KXF8JF+2PPc5hxTD3iM8at83HZRqDvmTyKN34eF
	EcRVIRBwbsw2Ob7FxXlLwohMqTaPHs2o7sOFBCevYRxYlGFRtZEE8Dr5/HeyH5nOMEukVhKvWx6
	cBGIG+Z6V+nnEvgly171Hmo8DjeP5DiqZCQSTn1cQyv/OMlO9Ac3vpjhJs8Vr/WbNP41IOcSNG4
	43ncdOBL0BdH4Iy+KXCIoFgVqdJTIrDY67s63e6QbSmfWNh031h0jjuLMFeZl3iK0hAVqcrGb8K
	6Obsk6zYzbSYf2pC5qVmMxtDa073gw0HUAm1EOXG23dOUY7X/JTMrzdDEFNzM/LZ5J7MZ0Zm1l4
	r3c+XxC7keCNjWIrs9F6VdGDlZutSU0hOSCGEzWBVCqZaUdE8ai1PQLUPhfdV4Rdtv2S0CcBDBd
	aiPd1BG0cWl4a+ECPcQj8JkR4=
X-Received: by 2002:a17:903:46cb:b0:2bc:f3c5:ff0a with SMTP id d9443c01a7336-2beb060dda9mr191816545ad.30.1779791850772;
        Tue, 26 May 2026 03:37:30 -0700 (PDT)
Received: from iotshare.. ([183.159.55.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c49b2sm115615235ad.60.2026.05.26.03.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:37:30 -0700 (PDT)
From: Li Xiasong <xiasonglee@gmail.com>
X-Google-Original-From: Li Xiasong <xiasong.lee@gmail.com>
To: mptcp@lists.linux.dev
Cc: lixiasong1@huawei.com
Subject: [PATCH mptcp-net 0/2] mptcp: prevent add_addr timer rearm during teardown
Date: Tue, 26 May 2026 10:36:45 +0000
Message-ID: <20260526103647.732350-1-xiasong.lee@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Xiasong <lixiasong1@huawei.com>

This series fixes a potential use-after-free in MPTCP ADD_ADDR timer
teardown.

The ADD_ADDR retransmission timer callback may re-arm itself on the
sock_owned_by_user() path. During final teardown, this can race with
timer cancellation and leave a timer pending after the entry is removed
and freed.

Using sk_stop_timer_sync() is not sufficient for this case because it
waits for a running callback but does not permanently disable the timer.

This series does two things:

  1. Add sk_shutdown_timer_sync() to socket timer helpers.
     It wraps timer_shutdown_sync() and preserves sk reference accounting
     semantics by dropping a socket reference when a pending timer is
     removed.

  2. Switch MPTCP ADD_ADDR final teardown paths to
     sk_shutdown_timer_sync(), so the timer cannot be re-armed once
     teardown starts.

Reported scenario:
  Link: https://github.com/multipath-tcp/mptcp_net-next/issues/623

Li Xiasong (2):
  net: add sk_shutdown_timer_sync() helper
  mptcp: use sk_shutdown_timer_sync() for add_addr timer teardown

 include/net/sock.h | 5 +++++
 net/core/sock.c    | 7 +++++++
 net/mptcp/pm.c     | 4 ++--
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.43.0

