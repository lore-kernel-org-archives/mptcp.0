Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A59A2D29C4;
	Tue, 10 Jun 2025 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560401; cv=none; b=J6u6/dZeM4+vQZG0md6L9thUxHZixRRaIptUoEz+PG4WPFxGTs7S53XHiCQ/qVrmqdvrI0i/mj6JfONvkLd3BTlgcRhFicesSntKCUFS8mtXe70rRemVCa25QkPFSbjIxQuF/mLHab1gfAZmRewmEfER0QHBLIZlp4OWk0U4unc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560401; c=relaxed/simple;
	bh=+BLFLrllz1J78kqDxqSGCpszH0IJLr1P8ZkyAohB4Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpAPsW4tFLefhpag9YB5Ba6x23oz2dqG5oKPNUN/kNyRbdwx5TYe7mT+8uwYk1Jc4o7oeIKlefWOyQlQI4UB/kUibnfm+YEHAF51ha5j9N+KawhKBb7mJncHkllxLlQ1++LMu+qZ0bV/AimRm/XrH9iETphcLdeJ++dyhSIoxJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9ztC8na; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9ztC8na"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so64941775e9.1;
        Tue, 10 Jun 2025 05:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560397; x=1750165197; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2jf0bqIzemKYIXkakyySlUtmWmhD9x5Ni3JII1U00U=;
        b=T9ztC8narQFSQGlMvmBGAhOPa4TZz7uSDlIGweIkcZQP3p5+482t93IVim382ODGOE
         tgxtEQo6GsB81mZgqqOjYaq5Bg13yLRBI+5pn9dRjl3vHJquR5PRtrqRmRs/JTKFByVS
         UIu1Dr8RXhP7ZeNlK9zjmcGq+7P4/SzembuXPMA00j7JuvfN9AzcOyWAbAA9tIiTReOU
         50wm86+wm9L4Tf09cwD7+5B3GluajIiVEZY+8fzXlPx47s70OFI2M1JQjd9TYKFRaAk6
         1o2y0h20U/KoxwHH9pbofjYE42nVLcDCGotu+bELUpEY5vTSn4LZ67EQp39/zvHezjmm
         yrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560397; x=1750165197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2jf0bqIzemKYIXkakyySlUtmWmhD9x5Ni3JII1U00U=;
        b=eAP7pWGFSsA/W3vT0aM7o/AiErD8ECrxU+b0dn6MgKy3idArKeoixXEVZosNfy28WT
         /nam3tE0cHuuWuIWbCGraGKKP7ud1z01rdvlhjIuqH/3UwtsbxCzR2iFcymKYIzy3YGx
         uhDurDooE2FWatV0yML8gZk9TljXcZ0EL5WgBeAxGmHOoIsAMnh7pDeWPTTgwhHSfPzB
         oQXtE9A9OVN/lP1hyBfLy8mFQ2l2ieWK4dOp43nEItNhF9orxrGtcTwdPAjDviG5Gswu
         yvcxpKtaKDeXg58+7bl8ws1YA/XKqMyG2uAkuQ4xti6P2X7oXpkscA3ACo2yPU4IeyTv
         jQNw==
X-Forwarded-Encrypted: i=1; AJvYcCUOr66rarWIqBVDLgPM54dXQWTojQnuUqxiVU6peM+na2pSv7R/9YQPN1LpGgPz+pemJ9mJnhTewXov1b9dbSXLwN2AEw==@lists.linux.dev, AJvYcCX2oPi8skkzYPsBCzC/Stp/SnZ2v6VBsG/hoxdO9jmnTiZQ5gnzm+L5tMYaL9DsvbuYy1VWV0c=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf85sXDINGyRK+P5JVdiVycGJbMK4883R9G2yJ3ajgv0WXY6iI
	DToSjMbUdsNXiMX4m10TK/sHFomYnLJ2NkKikUq6F1POOWhLHTo7PcSe
X-Gm-Gg: ASbGnctW8mvOe0ubedPZFWxPkeK6We16CEyQ9qmXHbm4zI8PzPFDEGRKzCi5bjgDb2P
	zeTx2qcdMjXAArjAM0r0FIq5GBG+o73muZke8NnpT51mWUK8FGIl9gey9mh//pguIooL3noWBg5
	72DUomL6Fp8Lkig3CLEshzu1UCH6k1WVBcDptCylodKyP4gQj3bBowazqIisiuM+HiCwfJ29MtY
	ir2CAyr6zoAZ9YlzvsDLvPAT+WcxzbC/7mhkhX0HTuvIbJ13cSj6hriWiq2uJpjgEcrk7jTrDsO
	q5Paw2P6RLHNjVv+AQGlhY6PWdqJeJEtSa1uZibzmtzUq9ewpgebZAzIjQtiZinMf7/cMjyrgUf
	BfgfG
X-Google-Smtp-Source: AGHT+IHxaPUkSpK4p/0zzDJa+3SZDES6FfsGUU/vr0VQymRd3Lgr3mZZ1qpeUaWHuy3FZI13xT7R4g==
X-Received: by 2002:a7b:cc07:0:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-452015d90a2mr133772685e9.10.1749560397077;
        Tue, 10 Jun 2025 05:59:57 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:6117:17d9:610b:9e0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452fb381abfsm130563485e9.17.2025.06.10.05.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 05:59:56 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev,
	kernel-tls-handshake@lists.linux.dev,
	bpf@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 1/7] netlink: specs: add doc start markers to yaml
Date: Tue, 10 Jun 2025 13:59:38 +0100
Message-ID: <20250610125944.85265-2-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125944.85265-1-donald.hunter@gmail.com>
References: <20250610125944.85265-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up all document-start warnings reported by yamllint in the
netlink specs:

    warning  missing document start "---"  (document-start)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/conntrack.yaml    | 2 +-
 Documentation/netlink/specs/devlink.yaml      | 2 +-
 Documentation/netlink/specs/dpll.yaml         | 2 +-
 Documentation/netlink/specs/ethtool.yaml      | 2 +-
 Documentation/netlink/specs/fou.yaml          | 2 +-
 Documentation/netlink/specs/handshake.yaml    | 2 +-
 Documentation/netlink/specs/lockd.yaml        | 2 +-
 Documentation/netlink/specs/mptcp_pm.yaml     | 2 +-
 Documentation/netlink/specs/net_shaper.yaml   | 1 +
 Documentation/netlink/specs/netdev.yaml       | 2 +-
 Documentation/netlink/specs/nfsd.yaml         | 2 +-
 Documentation/netlink/specs/nftables.yaml     | 2 +-
 Documentation/netlink/specs/nl80211.yaml      | 2 +-
 Documentation/netlink/specs/nlctrl.yaml       | 2 +-
 Documentation/netlink/specs/ovpn.yaml         | 2 +-
 Documentation/netlink/specs/ovs_datapath.yaml | 2 +-
 Documentation/netlink/specs/ovs_flow.yaml     | 2 +-
 Documentation/netlink/specs/ovs_vport.yaml    | 2 +-
 Documentation/netlink/specs/rt-addr.yaml      | 2 +-
 Documentation/netlink/specs/rt-link.yaml      | 2 +-
 Documentation/netlink/specs/rt-neigh.yaml     | 2 +-
 Documentation/netlink/specs/rt-route.yaml     | 2 +-
 Documentation/netlink/specs/rt-rule.yaml      | 2 +-
 Documentation/netlink/specs/tc.yaml           | 2 +-
 Documentation/netlink/specs/tcp_metrics.yaml  | 2 +-
 Documentation/netlink/specs/team.yaml         | 2 +-
 26 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/Documentation/netlink/specs/conntrack.yaml b/Documentation/netlink/specs/conntrack.yaml
index 840dc4504216..e48add669b6d 100644
--- a/Documentation/netlink/specs/conntrack.yaml
+++ b/Documentation/netlink/specs/conntrack.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: conntrack
 protocol: netlink-raw
 protonum: 12
diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 05fee1b7fe19..b76b162ce607 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: devlink
 
 protocol: genetlink-legacy
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 8feefeae5376..0865692bc9ca 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: dpll
 
 doc: DPLL subsystem.
diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 9f98715a6512..90453ab0e0fa 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: ethtool
 
 protocol: genetlink-legacy
diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
index 0af5ab842c04..944463fcae91 100644
--- a/Documentation/netlink/specs/fou.yaml
+++ b/Documentation/netlink/specs/fou.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: fou
 
 protocol: genetlink-legacy
diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index b934cc513e3d..21e0381e878c 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -4,7 +4,7 @@
 #
 # Copyright (c) 2023, Oracle and/or its affiliates.
 #
-
+---
 name: handshake
 
 protocol: genetlink
diff --git a/Documentation/netlink/specs/lockd.yaml b/Documentation/netlink/specs/lockd.yaml
index bbd4da5fe54b..f99244a7dc41 100644
--- a/Documentation/netlink/specs/lockd.yaml
+++ b/Documentation/netlink/specs/lockd.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: lockd
 protocol: genetlink
 uapi-header: linux/lockd_netlink.h
diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index dfd017780d2f..fd2ea7f90441 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: mptcp_pm
 protocol: genetlink-legacy
 doc: Multipath TCP.
diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/netlink/specs/net_shaper.yaml
index 8ebad0d02904..4fb9c7b6ac19 100644
--- a/Documentation/netlink/specs/net_shaper.yaml
+++ b/Documentation/netlink/specs/net_shaper.yaml
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+---
 name: net-shaper
 
 doc: |
diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index c0ef6d0d7786..fda8a9667bf3 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: netdev
 
 doc:
diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index c87658114852..fcca5a06ddf5 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: nfsd
 protocol: genetlink
 uapi-header: linux/nfsd_netlink.h
diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netlink/specs/nftables.yaml
index bd938bd01b6b..ed9c5cf68477 100644
--- a/Documentation/netlink/specs/nftables.yaml
+++ b/Documentation/netlink/specs/nftables.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: nftables
 protocol: netlink-raw
 protonum: 12
diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index 3611b11a7d8f..8d380670ea6a 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: nl80211
 protocol: genetlink-legacy
 
diff --git a/Documentation/netlink/specs/nlctrl.yaml b/Documentation/netlink/specs/nlctrl.yaml
index a36535350bdb..e9f5328a688d 100644
--- a/Documentation/netlink/specs/nlctrl.yaml
+++ b/Documentation/netlink/specs/nlctrl.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: nlctrl
 protocol: genetlink-legacy
 uapi-header: linux/genetlink.h
diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index 096c51f0c69a..b3a5bd00b8a5 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -4,7 +4,7 @@
 #
 # Copyright (c) 2024-2025, OpenVPN Inc.
 #
-
+---
 name: ovpn
 
 protocol: genetlink
diff --git a/Documentation/netlink/specs/ovs_datapath.yaml b/Documentation/netlink/specs/ovs_datapath.yaml
index df6a8f94975e..0c0abf3f9f05 100644
--- a/Documentation/netlink/specs/ovs_datapath.yaml
+++ b/Documentation/netlink/specs/ovs_datapath.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: ovs_datapath
 version: 2
 protocol: genetlink-legacy
diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 46f5d1cd8a5f..02ef3597ea94 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: ovs_flow
 version: 1
 protocol: genetlink-legacy
diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
index 306da6bb842d..e254537f6192 100644
--- a/Documentation/netlink/specs/ovs_vport.yaml
+++ b/Documentation/netlink/specs/ovs_vport.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: ovs_vport
 version: 2
 protocol: genetlink-legacy
diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 4f86aa1075da..bafe3bfeabfb 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: rt-addr
 protocol: netlink-raw
 uapi-header: linux/rtnetlink.h
diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index b41b31eebcae..8024580c4293 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: rt-link
 protocol: netlink-raw
 uapi-header: linux/rtnetlink.h
diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index e9cba164e3d1..25cc2d528d2f 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: rt-neigh
 protocol: netlink-raw
 uapi-header: linux/rtnetlink.h
diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 800f3a823d47..9c514c543b1f 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: rt-route
 protocol: netlink-raw
 uapi-header: linux/rtnetlink.h
diff --git a/Documentation/netlink/specs/rt-rule.yaml b/Documentation/netlink/specs/rt-rule.yaml
index 003707ca4a3e..46b1d426e7e8 100644
--- a/Documentation/netlink/specs/rt-rule.yaml
+++ b/Documentation/netlink/specs/rt-rule.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: rt-rule
 protocol: netlink-raw
 uapi-header: linux/fib_rules.h
diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index cb7ea7d62e56..52f62ab11136 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: tc
 protocol: netlink-raw
 uapi-header: linux/pkt_cls.h
diff --git a/Documentation/netlink/specs/tcp_metrics.yaml b/Documentation/netlink/specs/tcp_metrics.yaml
index 1bd94f43e526..2e57e4c19e58 100644
--- a/Documentation/netlink/specs/tcp_metrics.yaml
+++ b/Documentation/netlink/specs/tcp_metrics.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: tcp_metrics
 
 protocol: genetlink-legacy
diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
index c13529e011c9..83a9d088594e 100644
--- a/Documentation/netlink/specs/team.yaml
+++ b/Documentation/netlink/specs/team.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
-
+---
 name: team
 
 protocol: genetlink-legacy
-- 
2.49.0

