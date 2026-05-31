Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D9D38F227
	for <mptcp@lists.linux.dev>; Sun, 31 May 2026 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780239603; cv=none; b=bcZlX5x1JvHG6i0QVHHjKfLnaqTe+28eniSjITUCoCGdfT9n3nLz/6ibEgf03pxefYnCz+viSTRlfgfRy2gWJcTge/JOwWUZEFmOnWV0o6SOuPTU4/XfKXsb3LRrjOivd8sP/PBcv1c/J40kuE/RjkmSXb2GoCrG+CFtyF+eTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780239603; c=relaxed/simple;
	bh=/ZKkFSF089cFO4oAxpQ0rE+jSnBF8L5elTv7E2ExT4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJlLvV+6QXDuL0r7guN4VasFelobvRGH2K73ZvbXzpgcCdJsuB5y5mfzXMQPPrNVQsAtx/zShSYUsHtH8Ut3nOnQjsOr+hpjj+N++5U2rGw9ZeMlRRBARLGox0rmSNGPRjRwmf0Thcu7tDUJjROvaroQkxC+bWKMC+J1ndyP+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFtrOLmx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFtrOLmx"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490a762db7aso3376865e9.0
        for <mptcp@lists.linux.dev>; Sun, 31 May 2026 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780239599; x=1780844399; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/j3XZr4R//aN4oTHtVRnxWvBTtkJYT2w70QKJOgWgOc=;
        b=NFtrOLmxF3vmnm581NgkmAwZVrizuvDcNn8Wr9i/H0UEF5DaKSCjz/9LP83+zRuaaX
         8hMtooON8yAqIUyEbtgWedpVvMU1D5GGCtXl1pQ6uAOLOunSUp4i2vUPJNWwmq+5J0aR
         H6FE3IIJGomtJBW93hXDNk1O7A/OSvaBiP6Cumn9N9WMitXeqNW52QB/jciERVochgik
         c5nFBLyPZSLcoKwc1PfgOlLGH4xnk+XAjt8zcDLXPV978FwuE5XGwdSJc6NI98Syntsr
         Gvo6qc3Gz5f5ANbDqnO6Gd7HEF0+Qrpqq1pPaYFbLlQa+w53E73unCfjPrtmCjVJ2wiV
         cxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780239599; x=1780844399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/j3XZr4R//aN4oTHtVRnxWvBTtkJYT2w70QKJOgWgOc=;
        b=A73xLWBmUrFB37+uYx99RS2H8RYLFb0wg5Erg72/4GytKwnKDUlfizz51TZ9aJXk44
         uoClAXwQ44DcKTesODV68jahHfINyo+lsWvu8zBdnJW59Y7FP5PcRauEC5EDHFNRuV9K
         1iL0NeZvQACPGfjqzasC1k4FSe9NeKbh2K45ZFDpMU4nS9F830/Z6NNcBcdWUExeu4Lq
         6Zqrs4EQ5L6gU2/6fpA+8Etez6OH/tNv/fz/KC2yVGg15fJ4Jqjb7gRVhEV7tF9/Ndis
         Ev06B++mVGgqH5VVY36ca3V7Tp9GflBHyzcV0TMoVmh5q7ZwA+1Eryw/zqtloG+HCOOE
         Zmjw==
X-Gm-Message-State: AOJu0Yzbua3Gqri2wwbotSvE4tn8uoUW2ns/CJHftpvvZ6ccyi5AYCpE
	teRrh/Qd/vnOtesWG8240+K7xUNc6qg8TLjkxF+u2s6Z8VH6RvHGZrsDGpgu6w==
X-Gm-Gg: Acq92OH9/n/y/2cavRsrQrmzx1Ur63jUPrUPGh8FAqyIFZqvUDZoztBEDxAv6TaYlyw
	XiAiEcVQvc/vdWucU4wujzdTOyWTiapJc0VSQgMAW3h0dNhH7v0CVJ/KXRpKlA5oU8NEu3wdlxL
	RaFTkWsjm5BjQ/06dH3Sn/Mm8yC24BjmBh6LL1f9E2iPeUKw/gwcWX+TAI9ZuHCwQvzRaOLiocV
	IRc7ESTfuAqkPupj7EuZBaFM4ueW9swiaore+vMKSYUEnwEHP5G84DLnY6U9VKQ0mlPFUwtjL0I
	h7rETj6THqpPKyGsb3J8xSq9SYBxcKWTQAxAGGDJFxVKGlHWUM3mGGa1FLEV6keYgI4PS7X0VdX
	WQDhbb/UOlWyaB+FkUZAsByajtrtC+7IsppFQ/bHY8atqUkYlNK+JVcyPTRqM1htsiCT3Kvh3gh
	S23K34WRJG52eSpBC14lmS1TxlIv/RDH2CqV5p4nq8IaP8T/vZ+0NRW1gYh8hWnKv6b3yAycQ1p
	W7b6FeLVavghaNEoDUJ+g==
X-Received: by 2002:a05:600c:3b14:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490a2904d7fmr135745115e9.7.1780239598551;
        Sun, 31 May 2026 07:59:58 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3587072sm19133545f8f.34.2026.05.31.07.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 07:59:57 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v11 0/4] mptcp: MSG_ERRQUEUE support on the parent socket
Date: Sun, 31 May 2026 15:59:49 +0100
Message-ID: <20260531145955.322337-1-devnexen@gmail.com>
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
through the standard inet ABI, the same way they would on a plain TCP
socket. ICMP-derived errors stay on the subflow queue: the legacy
RECVERR ABI cannot convey their per-subflow peer identity, and they
are intended for a future MPTCP_RECERR channel.

Patch 1 factors the existing inet_flags subflow-propagation hard-coded
list into a mask, so subsequent patches can extend it without churn.

Patch 2 makes IP_RECVERR / IPV6_RECVERR (and the RFC4884 variants)
propagate to the subflows. The parent stores the bit so MPTCP-aware
helpers can branch on it.

Patch 3 splices subflow err-skbs onto the parent's sk_error_queue at
error-report time. All forwarded events go through sock_queue_err_skb(),
which re-homes skb->sk onto the parent and charges sk_rmem_alloc, so the
parent's error queue stays bounded by sk_rcvbuf and is dropped under rmem
pressure, matching tcp's tx-timestamp path and ip_icmp_error() /
ipv6_icmp_error(). MPTCP never originates MSG_ZEROCOPY or OPT_ID
tx-timestamp completions -- its data path copies into msk-owned pages and
bypasses tcp_sendmsg_locked() -- so no subflow-relative ee_data sequence
is ever forwarded. mptcp_recvmsg(MSG_ERRQUEUE) forwards directly to
inet_recv_error(), and mptcp_poll() advertises EPOLLERR purely on the
parent's sk_err / sk_error_queue, matching tcp_poll().

Patch 4 is a selftest covering the propagation path.

Changes in v11 (addresses sashiko v10 review,
https://sashiko.dev/#/patchset/20260529174524.260199-1-devnexen@gmail.com):
 - patch 3/4: route MSG_ZEROCOPY completions through sock_queue_err_skb()
   like every other forwarded event, rather than orphaning them and
   queueing to the parent by hand. The hand-rolled path ran the subflow
   destructor (refunding its memory charge) but never charged the parent,
   so completions could pile up unbounded on the parent err queue and
   exhaust memory (OOM). The "never drop or we leak pinned pages" premise
   was also wrong: __msg_zerocopy_callback() calls
   mm_unaccount_pinned_pages() before queueing, so a dropped notification
   loses only the notification, not the pages. (sashiko v10, High)
 - no functional change for the ee_data concern: MPTCP originates neither
   MSG_ZEROCOPY nor OPT_ID tx-timestamp completions, so no subflow-relative
   sequence is ever spliced to the parent. (sashiko v10, High)
 - patch 2/4: initialise val in mptcp_setsockopt_recverr() to silence a
   latent -Wmaybe-uninitialized on the switch without a default case.

v10: https://lore.kernel.org/mptcp/20260529174524.260199-1-devnexen@gmail.com/
v9: https://lore.kernel.org/mptcp/20260528055459.55133-1-devnexen@gmail.com/

David Carlier (4):
  mptcp: sockopt: factor inet_flags propagation into a mask
  mptcp: propagate RECVERR sockopts to subflows
  mptcp: support MSG_ERRQUEUE on the parent socket
  selftests: mptcp: cover IP_RECVERR sockopt propagation

 net/mptcp/protocol.c                          |  63 ++++++--
 net/mptcp/sockopt.c                           | 153 +++++++++++++++---
 .../selftests/net/mptcp/mptcp_sockopt.c       |  55 +++++++
 3 files changed, 237 insertions(+), 34 deletions(-)


base-commit: e05cbdb611ff815528cdf90e29a96663b9af48c6
-- 
2.53.0

