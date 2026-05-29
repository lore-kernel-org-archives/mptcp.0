Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765436212E
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076731; cv=none; b=Pzx8GYpavlabnsTv6ywUgc+WgtNds4ZohS43nB1QX4VjIChqmCMLPx+cymIJe9ip1UTOdGjVIvYGSPWbhCcC0e4/tl+r9NCaGNjdryxN3N92tcG9nTPoWApAdf7lDJXsUhIZYvJGrGiEGEtIKlj7mInwzFiwj1HsvLw5VrmN56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076731; c=relaxed/simple;
	bh=/08PVuvlgH4JgX70kFC1rEwuVdhbGdZR0Ocd1aYxg+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oJ5FQ+PI4oXxsybe7o9OktTWhfslpenFbZNMhe/rzRY7OUF6bBXHwkIEf7RkzqJxcchVm2pE7+Sboy3Sjww4WocneE43k6k3T9fjOIqS9NJOt9iC6fIUIVYC19hbn5ZDLJBU8nBaKHff2RAyJnkh9w8to01l9mutUgoySyT1wx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAh1SqUv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAh1SqUv"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso822661f8f.0
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780076728; x=1780681528; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v443d071FzymCFas0aDHKpcWdAjwlpG/MSjty8fEZy0=;
        b=sAh1SqUv5f9a7JH1ciBiGwlHykCucZruGZbEq3BzKTrNaVzsccvkJXBSL8KprywmCO
         1nJYUrLvTaYz7/LY1hLVI6yVsmSwjVZrcsgeNT6zDdpeUDzwL+pZ0PSQM3SK06H7X77I
         9CMwcY6UpwewWmDV6DBix65usPyUSd2Yhf0lv9ga2kH4gf03KFIqpHy2ys+nDTANxsWp
         zMqlKWBmfL6Mj2vURJ9DcOQy+zNnRK9KliqxXXEJN8n3n33n+RzA7mCeVkTkovxKS4Z+
         gPT87AL0tKlbvhNn6gtq/bUHBqaHhSptT7Xt2qEC13uiBq8Zj+/PLZh7zWk5yhFqU916
         EK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780076728; x=1780681528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v443d071FzymCFas0aDHKpcWdAjwlpG/MSjty8fEZy0=;
        b=QVxlFJFvT+F9wKQTj/0XeU9SCQnLNgtqGb9b4aOzTiNjMAENBHAhXK23b2H+YIiBkS
         9TE3xUcC7jFkznFKHioLy2wS9uOaiBjQ8tLVBHbKvRJDJemtZtgznx7DTX0Qa8sH2DVA
         qIptoC8ix409OqlNg3LcKbpUKMs72HDakiT2SCVtr2YyPEKpsORecufJG7lx5K+Vt/C8
         7Vm717HYps+7R1yOeyd4DB2Cp4gsNT0iAfMki8VBX4CFNIzJWhxEUwP30KMS3D/6FFDO
         09KNRMpkNGT9ssZKlOunaUUBdcio6rnAgYHWy5O0lz6Bbf2wrjRsrio6FYGUhSRXLJG7
         qZZQ==
X-Gm-Message-State: AOJu0YyokGRzJNLF4JUyxo9eEoiqU0fJnlz6rfcYdoY6r3lAlVl/mjFI
	FqpqoQnZyeGX+QK5PTsY1B/95MG5IBvdQQC4Yy/5QU+1cq7gdl6SyOQH1mLnxg==
X-Gm-Gg: Acq92OHgJDCx90LYSXhljBw8eb28DFRk7Ri9t7v6L6BBuqktqdZJnOchwl6gJeWznQ1
	E6FY5XWslUIdS4TWiTfyYWfuvMHhj3WRRjN20a78wxQpAj6HADpMTdbElG6yvV5ntoFZhxR/Bt2
	eeMQ1DxFgLfZoby68kZ+TtU9dgr3LRbsSwPhQDJ94DsVfg8XGNAsv1fV09hVkfUdT70dpwPcYv2
	EwIcYwUq/Jlud+vXUKJl/XCVGoSQ3fxtmaJnLhwDzuztjipp066zbCIujU/siXjt7YO6Zy6qlBd
	UFmp2yMr2mwek1JxFWktbDYvrFYbXYaNpCQ66d/QzLbSh4112Hh3yHVm6Q2EzXS55jHZRRxhyfQ
	7XzkKL/58cGx8xC68A7GzU5BNRa4Rk29Sf+JVFi3LTADcKHh/p0U6BAT0PYRH/i4bUzqe1a+30e
	o2WOHhtuzDplu4BNumihbVNxEp5lkBHx8/oEjN7pHTXLe/E33c8SpBG66esEj9+x3AZuWbnW6aM
	TPZeUmzHYkOgyDRh+CklQ==
X-Received: by 2002:a05:600c:6091:b0:490:6237:521b with SMTP id 5b1f17b1804b1-490a2b6b21cmr4161745e9.27.1780076728271;
        Fri, 29 May 2026 10:45:28 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c09ab75sm18738075e9.6.2026.05.29.10.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:45:26 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v10 0/4] mptcp: MSG_ERRQUEUE support on the parent socket
Date: Fri, 29 May 2026 18:45:18 +0100
Message-ID: <20260529174524.260199-1-devnexen@gmail.com>
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
error-report time. MSG_ZEROCOPY completions are queued unconditionally
so a notification is never lost, mirroring tcp's
__msg_zerocopy_callback() which bypasses sk_rcvbuf for the same reason.
Timestamp and local events go through sock_queue_err_skb() and may be
dropped under rmem pressure, matching tcp's tx-timestamp path and
ip_icmp_error() / ipv6_icmp_error(). mptcp_recvmsg(MSG_ERRQUEUE)
forwards directly to inet_recv_error(), and mptcp_poll() advertises
EPOLLERR purely on the parent's sk_err / sk_error_queue, matching
tcp_poll().

Patch 4 is a selftest covering the propagation path.

Changes in v10 (addresses sashiko v9 review,
https://sashiko.dev/#/patchset/20260528055459.55133-1-devnexen@gmail.com):
 - patch 2/4: reject IPV6_RECVERR / IPV6_RECVERR_RFC4884 set/getsockopt
   on an AF_INET socket with -ENOPROTOOPT instead of routing a v4 socket
   into the v6 handler; matches plain TCP and removes a latent pinet6
   deref hazard. (sashiko v9, Medium)
 - patch 3/4: never drop MSG_ZEROCOPY completions. They are queued to
   the parent regardless of sk_rcvbuf, like tcp's
   __msg_zerocopy_callback(); previously a full parent err queue could
   drop them under receive-buffer pressure and leak the pinned userspace
   pages. (sashiko v9, High)

v9: https://lore.kernel.org/mptcp/20260528055459.55133-1-devnexen@gmail.com/

David Carlier (4):
  mptcp: sockopt: factor inet_flags propagation into a mask
  mptcp: propagate RECVERR sockopts to subflows
  mptcp: support MSG_ERRQUEUE on the parent socket
  selftests: mptcp: cover IP_RECVERR sockopt propagation

 net/mptcp/protocol.c                          |  68 ++++++--
 net/mptcp/sockopt.c                           | 151 +++++++++++++++---
 .../selftests/net/mptcp/mptcp_sockopt.c       |  55 +++++++
 3 files changed, 241 insertions(+), 33 deletions(-)


base-commit: 6ae41d6df6c12883277b2c9ab490b5c8b1a4fc85
--
2.53.0

