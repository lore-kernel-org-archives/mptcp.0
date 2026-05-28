Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B67A34389C
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947705; cv=none; b=gqh+TtbEynsX+InqWZEJEqQuY8QgvUYUQzHFDtCtYrU5whcTLFWM2hGxVny1qq/vxO8xA8ZnBagvtAWipr51vsTHneOn7FNlKIyiWryS2lvhiuESyI7eRWxtqFWoKHtfFObZpyWEC4Qm8g3VdxehQ1JNzzgwrMdqNNmakQ4yS40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947705; c=relaxed/simple;
	bh=FZdjEnzJTPJM/eo9+KnPD7sEzYeRH8cbp7BiDaKxwDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cMcwO3doCsDltWiBh3JKuaFcSENyINWCQYHKwS2P57hE5DkFYeS86EqT138qetbJIWie5p9YsiwvzJK+9HkZG0PXuvQqM6Ehp4dicr7dU/zxvC9Y0R3VICcEHZ/yTZ+a0MEi312fOPS0Lkj1luKDGmBSjoVCGzHwOC1E/59CNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3lZUnxi; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3lZUnxi"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-444826c16ffso10410111f8f.1
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 22:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779947702; x=1780552502; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G3PAUNArON5q4bRKkhGpX968oy+pTEhH5ohxGYGTjOo=;
        b=i3lZUnxioF0JxBx3+mq1xhxK1GyXcf9+evq61ZEsU7KZewmjSg12xPSYg4adlQSe01
         FWu7m3vncM76CArHWInUtakrvNhVRajs4qzeeIIMrukJOrWUAHNU59AbbEyRoSk2Mwjb
         UV3CV2SImrwGFXYOSIi90V1FgyVJdTG5C4i6saZHM4PQVlO1FrqJ5F0jyZ+r6JOisDvq
         3NEGbViqTHEunW85QVZwSBhnACx6GBgd3jQU+Fsc+0x2zGeO8+OIWBH2aSBk79+DR2La
         zhNYQN3vdqHrk32hhu70ktpEjA4LCQFe4sgaEzFfKOK4WRtFhL5ZoVVLz6WymnnbWzWs
         Bxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779947702; x=1780552502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3PAUNArON5q4bRKkhGpX968oy+pTEhH5ohxGYGTjOo=;
        b=j3A6ltH8AuPKznAVfoQ5kFX5cXsInKzeXdaYrEtxY61Gmq16CN+zP7BTsuYZIitz7E
         ldHDSG4iAj7R13qyqDdwmo0dOPG62PU0fmbXyk/ndxCj1+BFS/xqvOTjFR7sd7PUK9XE
         cpeWy+qSOBgrzCLRzErouKBSH9Gk/AmxQ4dg4cgLa9MB3gYxd1KhoGBDXSXiv+U1gpHS
         V1ub9n0JkIaUvLcTOeELhD/oLcCNizrQEZ5ENIErImgsvqtpuy08WkHfOT8jfH5HtZQQ
         s19eFeM1yPydUjY1GsNiRgLH+AQDLPQJ0xdjyakVzxIgfkGSFggfcPpSCrZ8IaHXUxaj
         6RfA==
X-Gm-Message-State: AOJu0Yxh5Fa5xPQ9wNYjhxTY3Z2WtVJlTlXSnD1h08isHIOBw4+Wgdwe
	QNw08MYnq1DOKbmW/JBiXgCHL5eV9JZ520diNoFk6EY9xvewnVQ3VyIMcsY6LVO/
X-Gm-Gg: Acq92OErT5MRzy7vSHbvVgNd0jvG+/qnzk6ssfLhitWk2D8qp96wLd7C9ZU8y3KR1qg
	6bomrq0GcnlOGnrettZotk4HqHGzRWH5X0SEwYPe+MIybyAY9enaj77X3dQn2nfzYJVUORSiTDH
	UImgUpECO6hMBFb3JpBDEFpwQqnUZXiVMEorr4WSfbcDAK2ZTtraQSNxyfaO0flTwFyaUTKFbPd
	ICtKcAOvDY0WviMgaBA1aa9J6X1a3e4r40DTtCcD/Bacmmqi8rFdydSLs+oohS9TFTN5D/pyevD
	gJvX5zi1kN+zqfr9ME68JjK9dYETx4aSYlmuYGis8BLFUSqD3kJ5TKNqLabe8CRVkgQeq5a3waJ
	KWg/elL7vXs29yGrYTspksdb4q77uPVmwrrFG19WnCvzA+7fd0AHFoXxh/m1OSXohU9qtRoFSdG
	CR9LDp8FjpnsYxY11YudFgP/Lq/VJPU6yz2JHlCBKFPUCOe/60Ss57l7j98KSWmH2ujGLKQwWVU
	slncUBmT8wvLzzIZvTOAg==
X-Received: by 2002:a05:6000:4701:b0:45d:b14b:2412 with SMTP id ffacd0b85a97d-45eb369ca6fmr42647199f8f.6.1779947702180;
        Wed, 27 May 2026 22:55:02 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a2c87sm11002245f8f.17.2026.05.27.22.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:55:01 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v9 0/4] mptcp: MSG_ERRQUEUE support on the parent socket
Date: Thu, 28 May 2026 06:54:54 +0100
Message-ID: <20260528055459.55133-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series lets MPTCP applications use poll(EPOLLERR) and
recvmsg(MSG_ERRQUEUE) on the parent socket to drain TX timestamps,
MSG_ZEROCOPY completion notifications and SO_EE_ORIGIN_LOCAL events
that are produced by the subflows, the same way they would on a plain
TCP socket. ICMP-derived errors stay on the subflow queue: the legacy
RECVERR ABI cannot convey their per-subflow peer identity, and they
are intended for a future MPTCP_RECERR channel.

Patch 1 factors the existing inet_flags subflow-propagation hard-coded
list into a mask, so subsequent patches can extend it without churn.

Patch 2 makes IP_RECVERR / IPV6_RECVERR (and the RFC4884 variants)
propagate to the subflows. The parent stores the bit so MPTCP-aware
helpers can branch on it.

Patch 3 splices subflow err-skbs onto the parent's sk_error_queue at
error-report time. When the parent's err queue is full, the splice
drops the offending skb (matching ip_icmp_error() / ipv6_icmp_error()
behaviour). mptcp_recvmsg(MSG_ERRQUEUE) forwards directly to
inet_recv_error(), and mptcp_poll() advertises EPOLLERR purely on the
parent's sk_err / sk_error_queue, matching tcp_poll().

Patch 4 is a selftest covering the propagation path.

Changes in v9 (addresses sashiko v8 review,
https://sashiko.dev/#/patchset/cover.1779890764.git.devnexen@gmail.com):
 - patch 2/4: don't propagate the v6-only RECVERR6 bits onto v4
   subflows in sync_socket_options(); matches the SOL_IPV6 skip already
   performed in mptcp_setsockopt_all_sf(). The bits were never read on
   an AF_INET subflow, but left existing and newly-joined subflows
   inconsistent. (sashiko v8, Low)
 - patch 3/4: don't break the __mptcp_error_report() subflow scan after
   a bare errqueue splice; only break on a real sk_err. Splicing one
   subflow's error queue no longer short-circuits the loop and leaves
   the remaining subflows' pending notifications undrained. (sashiko
   v8, High)

v8: https://lore.kernel.org/mptcp/cover.1779890764.git.devnexen@gmail.com/

David Carlier (4):
  mptcp: sockopt: factor inet_flags propagation into a mask
  mptcp: propagate RECVERR sockopts to subflows
  mptcp: support MSG_ERRQUEUE on the parent socket
  selftests: mptcp: cover IP_RECVERR sockopt propagation

 net/mptcp/protocol.c                          |  55 +++++--
 net/mptcp/sockopt.c                           | 144 +++++++++++++++---
 .../selftests/net/mptcp/mptcp_sockopt.c       |  55 +++++++
 3 files changed, 221 insertions(+), 33 deletions(-)


base-commit: 6ae41d6df6c12883277b2c9ab490b5c8b1a4fc85
-- 
2.53.0

