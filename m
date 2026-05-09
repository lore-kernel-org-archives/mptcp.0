Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05F1E520A
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778361417; cv=none; b=c2a/YsotNBTT0PHOx0pxeWV1QrGKot6bTHOeF7gthVAWAVY9xAAc6uFNTwsQ30C3v2ilQodXeh3pIEOFEqxtAs11kafcE5Xc9CWLJvgyJZmFjVqNItNsj1qJbglREKvI1C1Ql5uQiev4IXcHs+Fx4+YPknfhRdUJ57Tn0syZGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778361417; c=relaxed/simple;
	bh=QFZUKRiDyIIBRdVhT/3dXMRqfE3lzElutwD/T1nrEqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pnMoiTQT4XQGWTnGEdz54ZZqgA3gcK8t+mYelKJF/DeXKBfhzugKtOWYN6qE+2cuDnZI3KcGpAkwNqgp/mUaiTvpCI2JwqoDry8fYrMsU6vuYO/KWYQv+dAF4DcJfLj2oSw2Fxa77/zKeDzTyvkyu9D5Nae+LJT9LNIP87R2lxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWfZih/D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWfZih/D"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso27335485e9.3
        for <mptcp@lists.linux.dev>; Sat, 09 May 2026 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778361414; x=1778966214; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OJLz+NaVsvmmrFieiWdnmgg0PPtTR1BJb6NdgzIF7hU=;
        b=gWfZih/DP5FM6cB/38imfvjwk0inOJA187syVspvV2xY5rLPSFhQhylou4vXu195GJ
         t5LMf4WA+x5PjAbYECQM8LLaCRROabFPusaKvcpfAOVg3ETuLs2sLhBcR+hYhiov6kok
         onwpDfqu6FwHYCGka230dzqbbDB9BvfZ2f4Xu4C5poCUJgmx3YsJvnLf8aks6nfFUyKp
         5rkr7KbAZeIY+K2I6SVvXRLS52e+n3R87oIfxKGyv5GOAh9c6nqxzTwHtX6QO5RI2tcO
         T4TfCf4Jvm0aPRdRxvSPtM4Vf1xSaf0sFaW8y1DD/cLXHM8pzyR6JAoAVCx39GA8oJYY
         8b/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778361414; x=1778966214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJLz+NaVsvmmrFieiWdnmgg0PPtTR1BJb6NdgzIF7hU=;
        b=pGwOQ+IIqbNDZyWoAMJVJLNAAA2rCdKKn+l2hNs1hLvIJuQyZqJN9JN0QnJVtHTzqY
         02L2gAO3xvx2057SzPAE+I9yWsbBvzAcJaoLPO89FmJajaQ2jxLxz3PopRL2gwQUOdc7
         ZtRijVxdy92X5Xjl70RKCbbMaJekJd/pUtBUtHwZcN8p4pWZpKW/OpBxWR8LvERhwwP6
         +YQ5WUO8zfoC5o6LWffMr8vt7yAqxdWCdr9hvHr47O5wQ6J2bkjfwF9xJA86pDJKeKnN
         lq0tINHpSDoYSDCybHK8TXpSWC7uBnC1mesfK8qtW00KjJvKPABgO6Q+KWSZR8vYKRrh
         x9XQ==
X-Gm-Message-State: AOJu0YwVRNHsm9Lrji2b4q/igAhaxdFrxt0kTJ90UzQcBx8+yPcMXqVv
	BmtPOtek8cEaNnXtVpcrXLUul5xX91MDFqbuPRHP74TmweCzBnVwJzL6b+EXowXUyAs=
X-Gm-Gg: Acq92OFQjn7mM7Ekw3MJ3BakViGSklMnJQugjZfNanRxPubuFYU2stSWm4YyzRMt0vU
	k+i2Jp4z8GDHbC3rZ94rnIulmIa2jAsI/yN8vxYCgP1GDHcu9XtNdSPcvYLu+I1Zkzty8WzsX9o
	jKBUGvQqSaOnTpwSG8ynsbekYV7slsKU3nDEoID4TpQ3nwa/abwmE2xbkTV04Mp9jJF3KqaLPRI
	4zRZnVtbsiPJLNzfKj1DwZjqsQe1o2YlJHh71IGDNvdL+gkg+ha+1FfaDXnrPvRMdhp29zq1vFe
	870XLirx2Ewz3gF2eAHHucn1G6Svpc8nytSoOAmZ+8QNl3oIKBdzmHshXcE5f/77Kfo/u4qtob4
	5DpNKLDTbV2wXxzV3kY24QQCkt5mJ5H92Opx5wFI59FOyPDWVqNEPoKgPcFy4kzI+I2UIB+fEnP
	XDMIMol9XQhs9IK7EtpXR0YJfkmcOSXj05lsfrHRiSEUJn9Nflmd+2NilQduumxlIkjlskfMAOM
	eYvuMvUVMfGdkuwS4dU8g==
X-Received: by 2002:a05:600c:26c8:b0:48a:9562:7a30 with SMTP id 5b1f17b1804b1-48e51f4934cmr183096355e9.24.1778361413615;
        Sat, 09 May 2026 14:16:53 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d89af2esm30110455e9.0.2026.05.09.14.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 14:16:53 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v7 0/4] mptcp: MSG_ERRQUEUE support on the parent socket
Date: Sat,  9 May 2026 22:16:43 +0100
Message-ID: <20260509211651.104934-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds MSG_ERRQUEUE support on the MPTCP parent socket, so
poll() and recvmsg(MSG_ERRQUEUE) observe TX timestamps and MSG_ZEROCOPY
completion notifications through the standard inet ABI. IP_RECVERR /
IPV6_RECVERR (and their RFC4884 variants) are propagated to existing
and future subflows.

Patch 1 factors per-flag inet_assign_bit() calls in
sync_socket_options() into a mask-driven loop so future propagated
flags only need to extend MPTCP_INET_FLAGS_MASK.

Patch 2 wires up RECVERR setsockopt/getsockopt: snapshot the value,
apply it on the parent, and forward to every subflow under lock_sock()
so concurrent setsockopt callers cannot leave parent and subflows
desynchronized. Newly-joining subflows pick up the four RECVERR bits
through sync_socket_options().

Patch 3 splices forwardable err skbs (TIMESTAMPING / ZEROCOPY / LOCAL)
from each subflow's error queue onto the parent's, so pollers see
EPOLLERR and recvmsg(MSG_ERRQUEUE) on the parent drains them. Subflow
ICMP errors are dropped — they will be carried by a future
MPTCP_RECERR channel.

Patch 4 covers IP_RECVERR / IPV6_RECVERR propagation and the empty-
errqueue EAGAIN contract on MSG_ERRQUEUE | MSG_DONTWAIT in selftest.

v6 -> v7:
 - patch 2: gate SOL_IPV6 setsockopt/getsockopt dispatch on
   sk_family == AF_INET6, returning -ENOPROTOOPT otherwise, mirroring
   plain TCP. Addresses the sashiko Medium finding on v6 where
   IPV6_RECVERR silently succeeded on AF_INET MPTCP sockets.
 - patch 3: track moved skbs in mptcp_recv_error() and retry
   inet_recv_error() when ret == -EAGAIN && moved, so a successful
   subflow splice is not masked by the initial drain returning EAGAIN
   (sashiko High #2 on v6).
 - patch 3: add mptcp_subflow_errqueue_pending() and OR it into the
   EPOLLERR check in mptcp_poll(), so events stranded on a subflow
   when the parent is under rmem pressure still wake userspace
   (sashiko High #1 on v6).
 - rebased on current export.

Tested with KVM-validation auto-normal: 25/25 pass.

David Carlier (4):
  mptcp: sockopt: factor inet_flags propagation into a mask
  mptcp: propagate RECVERR sockopts to subflows
  mptcp: support MSG_ERRQUEUE on the parent socket
  selftests: mptcp: cover IP_RECVERR sockopt propagation

 net/mptcp/protocol.c                          |  92 ++++++++++-
 net/mptcp/sockopt.c                           | 146 ++++++++++++++----
 .../selftests/net/mptcp/mptcp_sockopt.c       |  55 +++++++
 3 files changed, 261 insertions(+), 32 deletions(-)


base-commit: 63b133728231ebba5167bd1e53dda9bcf0bee7c7
-- 
2.53.0

