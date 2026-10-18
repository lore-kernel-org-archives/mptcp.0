Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541AA418361
	for <mptcp@lists.linux.dev>; Sun, 18 Oct 2026 04:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297079; cv=none; b=UsXCt7V7ZFP4D+1NIh8sBzj5O1741AdBu4vF9ce+chafMWK7pTjlNqJ2ZwFfbj02Fh1g2g51B2EFAL3C8fnHwfIZ9DE0q4JBIokCJ23Q4prPPNJFVfcgXl1XVJHjtnttSSprG3wNcPaxf0HMVgFTKTxxw7/Dl2euKrJaF4z1K8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297079; c=relaxed/simple;
	bh=0C5EA1v+iu5yN81N2LVGxHNonKI2O69N1o6EdfBlUC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rGT5YNPhzPoUQQIBNw6SkkS+8rpEEglLO0N/3L5EMCkpaDofZMVsQ6swDYG3kDkHDGCnmKNsFwPMOglfKr12ZuPV7jMik3g4in3WEvyxb5iSVAKaizhr0kj8gnliDfIsGQwpf7cSzVdceT/FnUEK1jSnNlBMd6Xe6e9dqQLDIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrZCgQoC; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrZCgQoC"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14fc585291cso139584c88.1
        for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 21:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792297073; x=1792901873; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z8lZJJ5E/XNVZXXbzzWR1JmNZg7uV2MMbrPu12V0uS8=;
        b=nrZCgQoCJ4BEpddRQ4CQ11ke9NkJgDzOCB4NjJBpdYomwu9sk78U6tIyrJivj821d+
         2xqKjE0ow72NFPU1BZyZJlfYO/bTKvhH074vfEoGTh9zUnpypB5ONnFTM07KBWKR8tGH
         QagxtRlDkBMWk9Pm03xjSHLDZJRPc1eBPcnQ6fLXUEjozeIdy/a1gQDQDlsgtAJWHygF
         ZY3EDOfWimN0bi3Ph033Lo7mc/jIHKh2D5R9dG05PzPtP18tMxAzB6SOlDp15wIQlGNb
         L4x1RchVTsWdLnZj4aOf16j7WigFtsVu8SpMJETSUj8+D2dNWqw6GluqnW6CopJglbti
         kp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792297073; x=1792901873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z8lZJJ5E/XNVZXXbzzWR1JmNZg7uV2MMbrPu12V0uS8=;
        b=y8N25o1/Zpd4FJyT6pSD8+4NL6AmR4UzDQQapmLsreW5GiuJnAJtEtURrljhUmt2iD
         XYfsGx8ussijdlsYkwFQQyJ6xd1JL9oUGRNww/Ox5gOa8rFEm8DNc2mV/wxLsBtPL7DE
         b8vbwEaE5TeGgtPv2MiXP+gMqYGXaM4wRj1t+PkusQznpwmPJ3IZcKV5Nov6qNtEMPmG
         /hbWiado1BqGtPxcEab7gUfFy/WXr7RV7Nuz6Av5Ebbv7dAtBpRnSAkJSYMd+cpmjNvJ
         rjgq19neGgFoissnjFemoHpz0pOQCMei0UJ39AdOBO6Y8IWR7XNT/Its+TiGrYMYwGnB
         C8dQ==
X-Gm-Message-State: AFq9FYIYxvxSC90z0B6pbuh4BFFOqkvImE28nEkOKbV8ApxDVYPSb4co
	8QqgrCydA8FOUyl4yHinZ3CwoxCbkz6JH7+MOeyNdJmiLUPCprUifRg22R6FdQ==
X-Gm-Gg: AYBFou1rT0Xg8Biu3ba3+RsNy2SgkVRiodunWu9sw8XLQrGoWu5hx8KQ+SjS9nVuyid
	Hh2ig4mAEfEzINrF78MLgq7PYwMsqNt4bmIYsduuhqXbd8JDII4KR7e19X8uxF0LGDmWy8WDHvn
	uOuw3Px+vH/RRciCa2RhHtfAV0tlRDBV3QCP4BXSX02d9LA+dHZl1NNex8qWOUmIHuuhjlwfVO7
	+kYO48kBT9/pj8XvznfKUi1FV6FZGaySb6Gr10ALyRc1d3S7XnzQV0Y9/FvPiJvyNUj/7wfsJsV
	hJ6lbWjlfrOqECn2BmFL8px5ryY7xdG4JUTbmiG9ttzXO7QMEThWhLV4umJ2BLOjF0CUlxaZFf/
	eou3tovaJzNk2GTvQxVB7Xw2ZhJRGqq2+EGA691uX8ZL3AXkBUWvxRf/c75KXZeSkqfvI2Nolxb
	V3MncU6f5rLBhPbEyFk+X4xUlFQQ2KFI8wgMheipXlGVA8uE7sOGNFgkQM0b9qw35Ys6sknQ7oA
	4EqGlrWEX13t+1ifmZvQTBeAhQv6uW5kZnSTp+eZisaPppgIsTz5/XhtjsUtkJMGXCki1sHkrTm
	5c2AG8H1DThjJ3uSubOha6pdULeFTZHNqX92tXxw10g=
X-Received: by 2002:a05:7022:e808:b0:143:50a0:56d6 with SMTP id a92af1059eb24-185118edb25mr6892543c88.7.1792297072685;
        Sat, 17 Oct 2026 21:17:52 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fdfesm17867932c88.7.2026.10.17.21.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:17:52 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v6 0/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Sun, 18 Oct 2026 04:17:42 +0000
Message-Id: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A subflow closed after an error is never re-created, even once the path
is back (#440).

When TCP closes an established subflow we created because of an error,
the in-kernel PM now creates a new one to the same addresses. Its SYN
retries space out the attempts. Their number is set by a new limit,
subflow-retries, like TCP_SYNCNT: 15 by default, about 20 minutes, 0
disables it.

Patch 1 fixes a selftest tool issue seen with the new test. Patches 2
and 3 add the new limit, patch 4 the retry, patches 5 and 6 the
selftests.

Changes in v6, after the Sashiko reviews (netdev Sashiko on v4, which
also applied to v5, and sashiko.dev on v5): only subflows that were
established are re-created, so the PM still moves on to the next
endpoints as before; removed remote addresses and the local ID 0 are
handled too; the policy checks the maximum value, so the parse_limit()
patch is gone; and the test uses the net/lib.sh helpers. Details in
each patch.

v5: https://lore.kernel.org/mptcp/20261016160926.1155262-1-anilkaushikwireless@gmail.com/
v4: https://lore.kernel.org/mptcp/20261016055010.980819-1-anilkaushikwireless@gmail.com/
v3: https://lore.kernel.org/mptcp/20261014143349.768138-1-anilkaushikwireless@gmail.com/
v2: https://lore.kernel.org/mptcp/20261013025653.523755-1-anilkaushikwireless@gmail.com/
v1: https://lore.kernel.org/mptcp/20261012171740.464517-1-anilkaushikwireless@gmail.com/

Anil Kaushik (6):
  selftests: mptcp: connect: retry write() on EAGAIN
  netlink: specs: mptcp: add the subflow-retries attribute
  mptcp: pm: in-kernel: add the subflow-retries limit
  mptcp: pm: in-kernel: retry subflows closed after an error
  selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
  selftests: mptcp: join: validate subflow retry after link failure

 Documentation/netlink/specs/mptcp_pm.yaml     |  12 ++
 include/uapi/linux/mptcp.h                    |   2 +-
 include/uapi/linux/mptcp_pm.h                 |   1 +
 net/mptcp/mptcp_pm_gen.c                      |  10 +-
 net/mptcp/mptcp_pm_gen.h                      |   4 +-
 net/mptcp/pm.c                                |  39 +++++
 net/mptcp/pm_kernel.c                         | 123 ++++++++++++-
 net/mptcp/protocol.c                          |  23 +++
 net/mptcp/protocol.h                          |  20 +++
 net/mptcp/sockopt.c                           |   2 +
 .../selftests/net/mptcp/mptcp_connect.c       |  18 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 164 ++++++++++++++++++
 .../testing/selftests/net/mptcp/pm_netlink.sh |  42 ++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  34 +++-
 14 files changed, 477 insertions(+), 17 deletions(-)

-- 
2.25.1

