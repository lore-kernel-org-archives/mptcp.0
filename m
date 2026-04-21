Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B989426290
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784944; cv=none; b=gN8EJTvIzJ3+8OwFengwzADQ15KxG5Si7vKsixI9k1E6XadFOpM0uZ9ahQn93Wsxc00+61QPR+DDLYIEXOveOr3htPNhLG90KVbFyZqoBbkhDuZHecsh/IKmq9jdf1kUqzp/MrWFaPaWtBBTYIO6US1PfaxC45nYmy2niVCSQwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784944; c=relaxed/simple;
	bh=ONNuuXNmYreZdsSkPA82yNoEEKq06J/t0dBvR50GDeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0VpS23Ty0LhxNdHH/kRT4fN4JgUtHX+k1txA/pce45fKz/EyEFOfRkYxXkY7D52nnQd4S5V3kXSCzV727+KPB7rax+Zs58idfpTyDr2onRA2f9pcWzeNr6RVRxosz00p8lHO++/C/st6nr5XRylGDTCkQSjirkv23Mzjv9T23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqPRantr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqPRantr"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483487335c2so44729305e9.2
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776784941; x=1777389741; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UtgPgZ4HlQnl8j98LJ7hw96CMdHc/eqoj0ut28JAbyc=;
        b=WqPRantrTuPtI6y8d59VwRosPX/z1bvHo5Iy/xhTTN51IMyFP5A09fLRmyg9e1xjLY
         B/lQLf4TIe10tzdBw9jby1ZPF+h5F1oWwSiVVfeXl0BbXHzNh6mUxRRUAXjzUSESChCz
         Z8Bp47LENqpG0JV24QS3xH86sm40QONKGiT37JxNuP77FrFVHwPEijF4U6VvjZDGuMQt
         mznGWdAXQ6sIJAVVexiuMu6/V1VqHqgBYCDiXndCcr8bEBmYcX9f7rAapgfIlPGyCquh
         MJjosDXJHqvgOdrZyA5gZ2OkFlWIGgGcxfvxuNJADRZDFHlJTMa6qbMLMn+ZGLgConkx
         SlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776784941; x=1777389741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtgPgZ4HlQnl8j98LJ7hw96CMdHc/eqoj0ut28JAbyc=;
        b=ZFGsv4QeeIOlqsLFoFl5jPjJJpbU/8ZM6as+qpphH3Apcr3OWYb7aw54pSxzGZ8Wgd
         /qfasyGsqyxD6E/9jrGXdFhWSf6nSWRf13FdlWn5/d1ehG5gwNvEOrdXnNrLVTwcevbR
         0x2s7T0x5k+Ze5ov1E8yayrGtV+P2EtAeCnE0N2QVpXZJ0KEQO05hrpBZPrCYrMiaIAv
         IuHrzROX7wWdsw6hfU1VoODQvrcA+2i6oHVaziwArgoYSZwxfRmLBS5jemeRvm8aQY1P
         7o4YZN+okegMew1OmHdzfFeP2G9Sg8d8h5L5BCp7nq3Ntuu0Q2kfUunffWy6OOQAJY8z
         CZhg==
X-Forwarded-Encrypted: i=1; AFNElJ+dwhHNCNP6PJirj+oZk6Uq8w6eV8h7m8XzfSa7L8urC55M2AicuaeUDx1P/L8Y1l/8K5pCjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVKYZV9f/iZIsSvIW9ZxnggcqFnoL8P7iQvL1euE6a8hi/CWHP
	rkFJlrifH4R4l/ifuWorRXUIx2aqMp0kvHdjDKc5Ht6suXB3jNyfr1cx
X-Gm-Gg: AeBDiev+d4GyQ3EqHd4BIYNbMrEnZCWy/IP/BzyyBonhZclVS2iAVKrF936xp0qIEjX
	Q/elGDPoQiHwJYPVB88dq6/BAqsMjCnn5WLX7QiWu7cu+rGYRZrwcHkWOICBEovYJ7W5lWtoEA/
	OAv4ovAlYX9HDOm4FmnEFTeY/dhp3Uk4yk1MloC5x/qRDZstxtkXBKQJ85GiPQgeHFCsiAK0vxp
	lIHdLgt/c9pbF0BPADGZ3T4ZAfABivgbCq3j1jjkHyLQbZ854Ap4p5C0BSPWMcbahnp5pxeKoIh
	cHl1h6a98Q7GDYCZGZY+/8vEz5mvahACgmplNkJ4K/XYRPhe73gHH8Avwn+bvxefrqOGn490+9k
	Cleef3CmVkmPzAk5EYvY+0dB6y8Z0aqXO4Z5f+zSa0Vx4HEsjHVlQGKSYcAGFFxaMfu9fjSov9k
	YhXVqDB8EUIjTu03Fuy3YHv0YCnMSzAFkVGS2IIOLZPkDZ31SoavomqLbSldUltMRowWmWaIRtD
	91dBVoo0fL5rHAlTg0Uvw==
X-Received: by 2002:a05:600c:3150:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-488fb7930famr275235665e9.24.1776784940756;
        Tue, 21 Apr 2026 08:22:20 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4411c9f4f03sm8975225f8f.1.2026.04.21.08.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:22:20 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 0/3] mptcp: add RECVERR and MSG_ERRQUEUE support
Date: Tue, 21 Apr 2026 16:22:08 +0100
Message-ID: <20260421152216.38127-1-devnexen@gmail.com>
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

Patch 1 propagates the RECVERR sockopts to subflows.
Patch 2 implements parent-socket MSG_ERRQUEUE handling and poll()
reporting.
Patch 3 adds selftest coverage for RECVERR sockopt round-trips and
timestamping-driven MSG_ERRQUEUE delivery on the MPTCP parent socket.

Testing:
- make -C tools/testing/selftests/net/mptcp mptcp_sockopt
- git diff --check

David Carlier (3):
  mptcp: propagate RECVERR sockopts to subflows
  mptcp: support MSG_ERRQUEUE on the parent socket
  selftests: mptcp: cover RECVERR and MSG_ERRQUEUE

 net/mptcp/protocol.c                          | 121 +++++++++++---
 net/mptcp/sockopt.c                           | 125 ++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.c       | 152 ++++++++++++++++++
 3 files changed, 380 insertions(+), 18 deletions(-)

-- 
2.53.0
