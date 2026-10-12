Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24DC4848B2
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825468; cv=none; b=ilFjKiaC/TmbCYnTPTsbyj48VOQC6zRLJbkyNrCqiYh2YifR4kx4TCxKzAuG7to6rsAX8D2B1afHRBs1X8BeQVGMpwzaoVn2U5D5vxtV4tbMGMDOCZTKh3Jb07nuQ1/Auc4jskJ9pPV1/bTY/cVznndsdV49p09aB0cNpvKSGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825468; c=relaxed/simple;
	bh=bcQmAO3M5cB8tgu09/vfZRFy1hmhn4gYlxwlmFXaBwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kSUSrDZczCZZBB80itNYrB8btNwkLpixyxWOX9qS8g11uY78pMXxLS0kmTpIoh3zUAQO0QChsfk+l9o5C114Oq1Ullq7cteNuHp322QEAqWY5bNcOfiCZedjjh83rQ/3P2s5rWCI9CVkfAvUvv4YEKfVIP2J6F8g5eqj11fSiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ommf86s8; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ommf86s8"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso329720eec.0
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791825466; x=1792430266; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0SytoKI+rNrKwMVIKpxY0H2U/lbYWRowCC7cVdvQVMM=;
        b=Ommf86s8aNN60OvgZTEEUwLdq3E/a1IKxUntfAdg56t/3pt46JDI1m/ogK1xHvNgh6
         7UMUlcpvwi/yCS5IyhuKVCY4eCxuOiy+Cur29uxvaaJP6XbmN7Wdd8EuyYurlQYcMBBa
         rS1fXNvz6NLJaNXyswwH61OO2JLeqoR8hfDBvbvSHo3seIUfXObebie69w1op0ZQn0oX
         T0hVxUklJq2DzhzCYXGjgsrjtWXArdzPXtmEKPVypkhIqlVJl7vXD34I+AuaCgIYSGHg
         Me+5S7Fyn3YqEhKYRKyxO6M7flFKpKlS3G8P/eNyVb3GArYvxABKqlyuIYh1Jds0/ajq
         knGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791825466; x=1792430266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0SytoKI+rNrKwMVIKpxY0H2U/lbYWRowCC7cVdvQVMM=;
        b=SWXHnIQndpZ3cR3TS0hE7+CXdZm/dErmUi6nM9hn+v9XUk05fIujGqzRuJPsDl1I7i
         F2YtshnSA0utWdXHnRRtS13Un19cMPc+wh5ojeTcikm/Jx+OyvfXHPjJMPkAoLLA2Biy
         18jFfVdfSzFgC+fJAgo/PApBfI354fFEDAUPFzkyfR2M9BzVrgNZG9mMrf+kvQpDiwJJ
         FSeQOKLsOskWWCwv1Xql0fWParpSMLZCRXgRIVfipMrPzjns4cBWjpdWkcRpJdoXDnpj
         GCl9z0Q8vaBtXwwSTVu8LuGPyj63duEawwJYwApui3yM/Luk9jdjYcs/xxqHRC09dkBK
         Du+A==
X-Gm-Message-State: AFq9FYKH4HoSQLtwpoTYocZLjPlPSDzIMEBCYwZqzVhlcryrZ8+whl6B
	FwHtBUbcv7FeMSFABuLdVTTXI6cIIYVcbSYWOVTQ+y4YG6j6agxQ2I87HOXcmA==
X-Gm-Gg: AYBFou2YLSMIUYmmG5mDD1/X6AZvg2x7ej7Ksq7r6Njtyd7vjUGGmuPPr/PCYDE+woZ
	8Hm6H6mW2gm9QW2a/aqmWN6IELujzuQvrEqkQb7kiIAG/4uas2q/L5AVWYmilTFqBFoVIsjCKyZ
	4IWVNd6OAw7xssJ4c6pPh1LNLlNJVboveeR+sc/xu2+vq3qHIPNxpzRDUoQiWlg6ozYosIxgNM5
	1U7SCAzguOlVIaUiUlMny2KfWDkucKt7gDoZJiJtblhnRQXe15p/J26xCzaa4LI8mQhkPRo6tpJ
	12DhVcAwZu9pkTrctRYAv4hj5SN2wu5fg8mpeC+cLCjFcU+eaFeYcd0DySHfEk2m+UGgcU3x1Td
	k4AB+r1gf+I/aOpfgQtZt9dGHVp0VIfzwRujLbCnSrGA4bb7DGr0y70IDiKT1IDBWzN4rfmWgFO
	faGezcIPN7frzcqUnLmE0Ym0f/94teoHCvzSVPIFLYBR5ypT+jscXghAroMPeyK98Mb23z5aC32
	Wmc9XpCJiQ8/twlNq2LmrUk5HNCsqbyTXjwByqwT1pOA67CwAcm0Aigw9SfK7DmrzQK5ejCeCci
	i2eWr0hNguS/D1RsgecoG1k88AlK48mPIigBtvDWxkc=
X-Received: by 2002:a05:7301:6191:10b0:359:9e84:dc89 with SMTP id 5a478bee46e88-3599e84e944mr7109038eec.36.1791825465394;
        Mon, 12 Oct 2026 10:17:45 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb6a279sm34978099eec.30.2026.10.12.10.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:17:44 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [RFC PATCH mptcp-next 0/3] mptcp: pm: kernel: retry subflows closed after an error
Date: Mon, 12 Oct 2026 17:17:37 +0000
Message-Id: <20261012171740.464517-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the in-kernel PM, a subflow closed after an error is never
re-created, even once the path is back (#440). For example, with fiber
as main link and Starlink as backup, connections never return to the
fiber after an outage.

Patch 1 fixes a selftest flake: write() can return EAGAIN after POLLOUT
when a subflow closes.
Patch 2 adds an opt-in sysctl, net.mptcp.subflow_retry_timeout, to
re-create such subflows with an exponential backoff.
Patch 3 adds the selftests.

Questions:
 - sysctl, or an endpoint flag?
 - the re-created initial subflow counts in the subflows limit, OK?
 - should retries stop after some attempts?

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/440

Anil Kaushik (3):
  selftests: mptcp: connect: retry write() on EAGAIN
  mptcp: pm: kernel: retry subflows closed after an error
  selftests: mptcp: join: validate subflow retry after link failure

 Documentation/networking/mptcp-sysctl.rst     |  15 +
 net/mptcp/ctrl.c                              |  13 +
 net/mptcp/mib.c                               |   1 +
 net/mptcp/mib.h                               |   1 +
 net/mptcp/pm.c                                | 272 ++++++++++++++++++
 net/mptcp/pm_kernel.c                         |   3 +
 net/mptcp/protocol.h                          |   5 +
 .../selftests/net/mptcp/mptcp_connect.c       |   8 +
 .../testing/selftests/net/mptcp/mptcp_join.sh |  84 ++++++
 9 files changed, 402 insertions(+)

-- 
2.25.1

