Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3055531E85A
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890850; cv=none; b=m8wltiXeFtmi7fIvGl46s6NPDasqjRh5qv/68/GVEu2tcTAYmgkykIMedUwiTAhhNpAw+/pj0+t9MfRCeeGWNYrYspmJueaD6ewcxlVaiA+zczoudmUbR7gvzijOan0Lw3WpcE7bxMTC0Ml29+yYd+5EKQsbn0GjWXI6xs4FWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890850; c=relaxed/simple;
	bh=ASK6YyJ7moqMvYakfybFij2bLLF/w0yKoCE34gXgkm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z+tZ9xIleYWNpRMYU87oyWlMDlfunsFYyWyeEegxy/dD5v8GGLCIx89MvLu10GuB56Z6fiU0n76M3HSVz8T7+y4faYv+YLN8422jKHHajInNxWXFWxGI9QQWsLG/YCBxxCFbU0jgJv6hmGe28F2PCLlcDxAn3kpDbERCVtX5/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHgsA39/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHgsA39/"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso61014545e9.0
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890847; x=1780495647; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ac+LtDDGjKLGYz9djmy+P3BUUxhc5yZd0r8RVqyk4dE=;
        b=sHgsA39/9ARwPW+1UbRiKW/tkkBxl09rERyrUx7fCciauq6VLntws/NHJgpZJ2em8l
         ljVcjQgrOqkxvPn/lVpX9Q9UEPGlv32gU2oZkzNjPSXw6fjxfKkvQAOfRpgG0ySnUgTd
         sw/r7/ZiWgCugKfqGQQJe0bdpBOwvRmZEUWaabvhhy7Xs2+rx3qNzwB5Orj9l4Lbd6gj
         mgFR8Q09KpD9Vi9W9mHdITBSSmgGvRpkDfldiHmTocEo2UbUfjjbbURgdCwUmlyD/e29
         XgNyS1EpzuPWmm6InA+QA2DQgmXQ5VTfhsspoVNx9FI5wdTaTCbCHy0iHYUGGQUSuI+J
         RqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890847; x=1780495647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac+LtDDGjKLGYz9djmy+P3BUUxhc5yZd0r8RVqyk4dE=;
        b=UIm+T1yfT9gpTDtaD5xzQhYl3MjV/feXRotIHN4d7Wd6C3s1awg6ftPGnudNhcsRI+
         fFdmSoyrCA44UBxIbpW01c+Ld3AuCobehMVrDNyCqBCMB/YYemaB4H2rt0J0+EoNlyuh
         yqtL89W/ALSiNnKl6U1fJASRZn2Ozt0TDLqL3dqgJQXyIsfrdpZ+6He5C+MbmJYdsnKM
         BURCvpUjwpYMSOTqM1pPpSVFHkb9i0Sjr9VNm6MQNDgStOZS7L3VK2GvOu3G6vKPulZY
         GPcNceKaCuJR8DnZV+UHgls7WHGI36OP2edVjdOoOUqgnjuyGunY3fOxlk8Y9EWsvsvw
         cLGQ==
X-Gm-Message-State: AOJu0YzUqTM2GmLDGM+a2owW8E1vcX/hAD0aEzTZrOkTmLsDvZURwad/
	eUa2EnEDR0NtrVUo4a2u8zu6SIebjY640nXkK45ozkRssCCmjNY7nautYtAq4zKe
X-Gm-Gg: Acq92OFVKQ9v1nsK52iH37aalDpPtjqWCAx4FlFNwdm9FgeKAGwH89NKhv4bGYARYm0
	s/auY5sCI5zj5YeTPbewRdH8Uqr9uSu+uQweSNJbfP6MvHLomAshBdU/ay7DTKlstNi3CdYhEoH
	2S/PQXKWP71Zlu7dGey1wLBkplD+Ce7D8y1tRqpGGGfwKosRb+BzI0mB59c4HV2U3bCZBT6EqjJ
	B5AwCoch3/PKHDZjulX/ANRQJGDyWH4ddTT5s/T0yd2oUehaT9KqcWGdj7PJp1yMOL9M/sVF3e8
	w8OBAVeQpRhGvVNYQ3A5nsPdDv3QoGBh1QEGT9g6wp6C65pFR5ptmi0Rlh1jldvQlgHPO1WUutO
	xkFo7ZS7hkrLMRT8KraqngOB9m5qKJyF9OJ/nW8Oiye+KJwCuqLE+77xcIgnO+XcHlzJ/s34fqQ
	iodndsWtBkct8ZQej0aDsjeWT2hvbeE0rMXjA8pI/xBSKVvdOQpkl1iKVzI4HA5nmgCYcA3qoHK
	Txb0HcUH3B1IvnTkI+rqQ==
X-Received: by 2002:a05:600d:4453:20b0:490:2238:4021 with SMTP id 5b1f17b1804b1-49042494fe3mr278262485e9.8.1779890847376;
        Wed, 27 May 2026 07:07:27 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4907e6c7433sm19579085e9.8.2026.05.27.07.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:07:26 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v8 0/4] mptcp: MSG_ERRQUEUE support on the parent socket
Date: Wed, 27 May 2026 15:07:14 +0100
Message-ID: <cover.1779890764.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Changes in v8 (addresses Matt v7 review on patch 2 + sashiko v7
findings on patch 3,
https://sashiko.dev/#/patchset/20260509211651.104934-1-devnexen@gmail.com):
 - patch 2/4: drop the unnecessary <net/ip.h> include (transitively
   pulled in).
 - patch 2/4: explain the v4-on-AF_INET6-msk skip in
   mptcp_setsockopt_all_sf() inline and in the commit message; note
   the case was unreachable before this patch.
 - patch 2/4: drop the unreachable default: case in
   mptcp_setsockopt_recverr().
 - patch 2/4: drop the unrelated sk_family != AF_INET6 checks added
   to mptcp_setsockopt() / mptcp_getsockopt() — the v6 dispatch path
   already errors out further down.
 - patch 3/4: drop the offending skb when sock_queue_err_skb() fails
   on the parent under rmem pressure, instead of re-queueing it on
   the subflow. (sashiko v7 #2, High)
 - patch 3/4: remove mptcp_subflow_errqueue_pending() and its
   reference in mptcp_poll(). No skbs are retained on subflow queues
   anymore, so the lockless conn_list walk is no longer needed.
   (sashiko v7 #1, Critical)
 - patch 3/4: drop mptcp_recv_error() — with no on-subflow retention,
   the MSG_ERRQUEUE branch in mptcp_recvmsg() forwards directly to
   inet_recv_error().

v7: https://lore.kernel.org/mptcp/20260509211651.104934-1-devnexen@gmail.com/

David Carlier (4):
  mptcp: sockopt: factor inet_flags propagation into a mask
  mptcp: propagate RECVERR sockopts to subflows
  mptcp: support MSG_ERRQUEUE on the parent socket
  selftests: mptcp: cover IP_RECVERR sockopt propagation

 net/mptcp/protocol.c                          |  47 +++++-
 net/mptcp/sockopt.c                           | 136 ++++++++++++++----
 .../selftests/net/mptcp/mptcp_sockopt.c       |  55 +++++++
 3 files changed, 209 insertions(+), 29 deletions(-)


base-commit: 8b808b715575367c7e00bcd76a597b7b57d674b8
--
2.53.0

