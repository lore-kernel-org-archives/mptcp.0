Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE226B2DA
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810825; cv=none; b=LTRO/hdLmbScdTP79w704Myje2onyxQF/ytZ3jgrZbZdlsvG3qoVTZT6v0+bd5fAHwjNRIlLu0REP2QCS5fd9686HWwBjfwmtUaTLnPwSnxMn29sK8MLhAqVChqR6Tyt0ykf7KLwRgqLYCWmAs1Tb27HjnJlSaFksrMf79hmqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810825; c=relaxed/simple;
	bh=qnhqjCaKlsJVyAteA3UeC2/JiIbjkDzpQerMtfyl57g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6ZtXcieeZKKrHPHME+iE/BUaHF/prY8s/WtuNQ8sGT/4ITpkmKszIGlCoA1hrHm+mTqyxjKSgvPfF6uJ4RPxGQHEWHZLQQYW8sppjSJ4dEYXOS95a4Ifc8nPBhsqvbomXoQHreQCxyAy9RFMQZ84iV4kCKY7m/8hd2SOxvaDAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUQK2Uz4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUQK2Uz4"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891cd41959so28548545e9.3
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776810822; x=1777415622; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPjjwOD1sB6ZwtL4pVMKsl+ZYylqgqDnS7FA15K5m9M=;
        b=gUQK2Uz4zQBaFtCNZeWo7aOXN1hb5Qg8MITAu2AwkLcXRapA3WvUXa6Y7RtLy98zpj
         ZzBWmmKGdl2weMEO3BAyxy1r+o3rbM7/UEl7X92wXIK2rnF20DzeErw2OjyUL8PUJcaV
         ZsUzfEu+AB/w9rRSqRONLLt/tR67LkFmtCisM6oCOHmWsZ6W0jbIRqtO1D3pz00HuJo7
         1iwaRODzjK3+yQjcqUS2r0T+iqhdb6l8eAJPjfPpQa/GFlYwvZ2BZG0nVWHj/mtQBGpL
         0bSSb+0d/g2GHs/KK/jmg7Bd6PXTV7U9HQkKoe5u9S21Sj9wD5vH6UE3vxpGBmAYl4Rd
         pJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810822; x=1777415622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPjjwOD1sB6ZwtL4pVMKsl+ZYylqgqDnS7FA15K5m9M=;
        b=oTxkIy7EEulmElTTkDGSbyV/t+RjjWoIqUYNYvZbLufpjFiY0by0XpR7OKhHndAeOH
         cXnMkpI+l9aIgELeHb1DJ3Ia8yS+aH4WrKV/KoBOAJq9LVc1Z/hzoxgkPv+fNN0riWTH
         PZvQXzmGcccqLqeH+7xArXNOBJPd5TPeDaDLv6oLpr8Y3AXZWt0qNVjT85UllzNci63G
         mNBbnHoQyqUrJWUQmxCa2zdx0vbwOMmK7E//j+FXiHlXzXnYZtGYaBY6EP5Wb4oMZUlz
         RnPnkSCerYpbbRr8kHht9ve/Stgd4twiaN5WVPucu1uYTVFl31CnSS+WiUJhbBywSB5U
         LIgw==
X-Gm-Message-State: AOJu0YwAe0TeWdYY3F0g1kEAVPmC9he67h3Wk0NnZKXqpnZ0G5ljA2u6
	RlXbMD4pVloHUtz6aNTNi9hcGDwf1StYgTUf73L3CbsCfRBZ86dma41zW4Aom7m1
X-Gm-Gg: AeBDietq98jbA4K4OYYb2l1rEqEFP0mqgVTojPpo4W0uAwvFmfCHQPyUqUYQRAfKNVh
	xt9mUSPjM4oIWSQqXw7DdoD2orwf/59C5duvYzFbj3r2/eVD8/Nsp5GI9UdWtvnAR+XsY0pEwMz
	bRMPnrrkMyafpA8C+ul5/VeQxFKBenPUSo5nKPQM/xTDmQGjFuYoBMh4tAHVdbwo4SufTeQ8XLq
	iZftZw4TQWTuI73XgpZo1DQgMwIME2iPXw847alcKU1l4Fp2BkZRYnGU3JIylEhj+8wcOyrEWv/
	Su3fw6jKXIlkHV8uvYg6WULYH440TdJWH4GJ2MxrLPucesCQinJ6zjUOomMmgJeGunO6mhrvQyc
	uSiQDEthajxFfMvz7adoCV3s6aO5+ucLCPdnY/pnhLY3/zTUeXvabGAynVw4bdXdZVJa7d1bgQG
	TBWs2t/MgNxCdl85ZOgtwt090kFPatzmYeRKlZKTfuZfHP097SWoWVef+ky1Z5eVhQW0IzAkbgU
	NFeqxuPCCibZEvr0QWuCw==
X-Received: by 2002:a05:600c:1e09:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48a592ce7c2mr23249195e9.17.1776810822211;
        Tue, 21 Apr 2026 15:33:42 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c01cfsm413350505e9.10.2026.04.21.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:33:41 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v3 0/3] mptcp: MSG_ERRQUEUE support on the parent socket
Date: Tue, 21 Apr 2026 23:33:35 +0100
Message-ID: <20260421223338.52743-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPTCP already advertises IP_RECVERR/IPV6_RECVERR as supported, but the
parent socket does not currently provide usable MSG_ERRQUEUE handling.

This series wires the MPTCP socket up to the IPv4/IPv6 error queue
paths. It propagates RECVERR-related sockopts to existing and future
subflows, makes poll() report pending errqueue activity through the
parent socket, and allows recvmsg(MSG_ERRQUEUE) on the MPTCP socket to
consume queued errors with the parent socket ABI.

The series also handles mixed-family subflows by applying the matching
sockopt according to each subflow family, and avoids silently losing an
error skb if requeueing to the parent socket fails under rmem pressure.

v2 -> v3:
  - Only consume ssk->sk_err in the fallback / MPC-connect branch of
    __mptcp_subflow_error_report(). Steady-state MPTCP now leaves
    TCP's one-shot sk_err to TCP's own consumer instead of silently
    draining it via sock_error().
  - In mptcp_recv_error(), also route to inet_recv_error() when
    sk->sk_err is set, so a fallback-propagated error reaches userspace
    even when the parent errqueue is empty.
  - Scope the new selftest to IP_RECVERR sockopt propagation only.
    End-to-end errqueue delivery (TX timestamps, ICMP, zerocopy)
    depends on subflow-side producers that are out of scope for this
    series and will be covered by follow-up work. Fixes the
    mptcp_sockopt selftest timeout reported by the MPTCP CI on v2.

v1 -> v2:
  - Retargeted to mptcp-next per Matthieu Baerts' feedback (net-next
    closed during the merge window; iterate on the MPTCP tree).
  - Guard mptcp_setsockopt_v6_recverr() and its dispatch cases in
    mptcp_setsockopt_v6() with #if IS_ENABLED(CONFIG_IPV6) to fix
    the MPTCP CI link break on without_ipv6/with_mptcp configs
    (undefined reference to ipv6_setsockopt).

v1: https://lore.kernel.org/mptcp/20260421152216.38127-1-devnexen@gmail.com/
v2: https://lore.kernel.org/mptcp/20260421191337.58341-1-devnexen@gmail.com/

David Carlier (3):
  mptcp: propagate RECVERR sockopts to subflows
  mptcp: support MSG_ERRQUEUE on the parent socket
  selftests: mptcp: cover IP_RECVERR sockopt propagation

 net/mptcp/protocol.c                          | 123 ++++++++++++++---
 net/mptcp/sockopt.c                           | 129 ++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.c       |  55 ++++++++
 3 files changed, 287 insertions(+), 20 deletions(-)


base-commit: 4464afe97dc56e817a23b730979cbc6fc48f1912
-- 
2.53.0

