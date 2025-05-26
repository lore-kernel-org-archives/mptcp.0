Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECD81C27
	for <mptcp@lists.linux.dev>; Mon, 26 May 2025 01:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748223972; cv=none; b=rrTRFi7IyxPTrG70kMGMy8cq3LF5wDB2c1ruHUcgvq/QwJUXZH7dlTNwsl6/MjPBvFXUVCMkOo20UifsVVkaXwjTpHlr6MzH+0oZnxFVllNSWprbdIQtoQHBhgaxb4F/OJOpC3u5IgSAthACmTlM5aByrcEV2KuruPHrgx27/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748223972; c=relaxed/simple;
	bh=Phpi70yBf0qAbK2zi8hYJYHrI7iM1hUCpxcFPZwX5yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlQXNbAZDU5Qc8es5t/+AF/13Eq8kIMX9JZ+CHqnK5P0rpPUXpd4ZyDisYcxniS5A9EGzxAScFnJ8/ad3y8JxC4wUe+HyEWzbwr1acUVGM/+2A7RoK2CvFfyB/LxmP5xFpsHc13dp4gDbKzfY92wap2eUcuTG+YbCnb14W2Cf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vs69vX67; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs69vX67"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso1225231b3a.2
        for <mptcp@lists.linux.dev>; Sun, 25 May 2025 18:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748223970; x=1748828770; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=facgs+KPb+zlHR19GzFHOwjVeRRei8la5g5c4Gaqs50=;
        b=Vs69vX67hDZ1hAu/dPCrI9UanM7X7ggAehe0UkGFll8XZKrSM+e2I1NBwfmNdaLlMm
         SE/dZQwuQavoTHBuEVDJ89t61UOdDvoHNYZ0rXT5wQabCe2e2iW/h6unFz0xYt+F4rqs
         PcC67H0+FO3ukpUX589FvtDlQWziZoktw1p6uzZct51BiKimNjLYCTwFqFRlzpUwTJpY
         5EbrD39B7azO7eRuWn1gTsHcvF6817CXM5TAIwHZphzkiBnwEIhkV5cDMk2GLpkcGz1E
         imb+aCrKZen9Uz0yRLyKA9I8rRr7wtg8z5HVhgFHA7no4G7CeWKm80Y23Bk5CAR8rJxG
         7JCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748223970; x=1748828770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=facgs+KPb+zlHR19GzFHOwjVeRRei8la5g5c4Gaqs50=;
        b=XFsT8ByPIyq5K5TMpbLJyuUSypANwG4k0RBIpaE/w3/s7MQvJYnbJFiEnyYJ1BjWS5
         3fUeJMu0mBWyOHQTY/6eY02BIH5zITrrCxiaZUif35GZZ+mld3jnN8nVq1Zm+Yq5ltA7
         zj/j/icmQg2rY/RM0qYYqs7nXaf9wt830UoDW1Akcu9pvfHBrHvP6zBvIjOukmL/oooz
         Q5d0c8UcfNtqlLJuk9BuKjj5R8+f/rEnYknftJtVUtBSZOcg5Qk4UGzHmgCArtSeMX/b
         PMmVLJJhh1biBraDoHNa8fp1PU6cx8vPQCy1jtr1LNcpuJq7rpUW/MNjRpTf28SHng7g
         C0PA==
X-Forwarded-Encrypted: i=1; AJvYcCVUOu2FNIKmftYVyYzD1d6CiW7yA7dJssQ5lg8RkMQczx2rLFC3GZcX2uiK33hzXIlg+whYUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhGlQQjlie03RvoUM4ZcwSKmI637vfT9ubTgL2IRIArxrPx2Qp
	4JoGzFaxSMQjByd8ZsVlhbYYvU2SAwCctaLdLZbhS1COHnE8uQidMeeM
X-Gm-Gg: ASbGncuz0JOxifX1ue2vNxqB+ZxchduparXsbQoCMjFDAg7wmzsvQsRwe2Ne8dBjv3h
	Xd3hlz+25D4imkDZyZAKcsUV6ZCAP9i5pRw3tAq1x/rvan2Q9y8RhgGBFQsmS8IQJ/eRwziGmuy
	Vx08vixrGsoX2VIXeWZ0U/uNpWKLAbu0ihPlCWLOwtJXCkMBQ5HP0zAnf8Af/Bpd5ZdAaZLAt0G
	dmdQIlCgxCakp3EVT5G2KZnRraeLFGRoDtoSp/dz8az3C41DtfJNLoW2i1023B2igorV7Qi78q/
	3eAKSyzKpQxwHdqI3EMQuULcywGOzwHJhspZCd0BioBCiPFYYJXZqCVeR38bq5lGwh35aGc=
X-Google-Smtp-Source: AGHT+IE+XOjpOycQh3SeSHCmvzK37FtZ9l6baKqpAB6r77io9uPLk8FPQOe6pfZM0Ppo7Qd7tVmaiw==
X-Received: by 2002:a05:6a00:1381:b0:736:339b:8296 with SMTP id d2e1a72fcca58-745fe035fb2mr12420124b3a.18.1748223969824;
        Sun, 25 May 2025 18:46:09 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97375e9sm16120638b3a.73.2025.05.25.18.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 18:46:09 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next] selftests: net: move wait_local_port_listen to lib.sh
Date: Mon, 26 May 2025 01:46:00 +0000
Message-ID: <20250526014600.9128-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function wait_local_port_listen() is the only function defined in
net_helper.sh. Since some tests source both lib.sh and net_helper.sh,
we can simplify the setup by moving wait_local_port_listen() to lib.sh.

With this change, net_helper.sh becomes redundant and can be removed.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

v2: remove net_helper in selftests/drivers (Matthieu Baerts)

---
 tools/testing/selftests/drivers/net/Makefile  |  1 -
 .../drivers/net/lib/sh/lib_netcons.sh         |  1 -
 .../selftests/drivers/net/netdevsim/peer.sh   |  2 +-
 tools/testing/selftests/net/Makefile          |  2 +-
 tools/testing/selftests/net/busy_poll_test.sh |  2 +-
 .../net/ipv6_route_update_soft_lockup.sh      |  1 -
 tools/testing/selftests/net/lib.sh            | 21 ++++++++++++++++
 tools/testing/selftests/net/mptcp/Makefile    |  2 +-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  1 -
 tools/testing/selftests/net/net_helper.sh     | 25 -------------------
 tools/testing/selftests/net/pmtu.sh           |  1 -
 tools/testing/selftests/net/udpgro.sh         |  2 +-
 tools/testing/selftests/net/udpgro_bench.sh   |  2 +-
 tools/testing/selftests/net/udpgro_frglist.sh |  2 +-
 tools/testing/selftests/net/udpgro_fwd.sh     |  2 +-
 15 files changed, 29 insertions(+), 38 deletions(-)
 delete mode 100644 tools/testing/selftests/net/net_helper.sh

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 17db31aa58c9..be780bcb73a3 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -3,7 +3,6 @@ CFLAGS += $(KHDR_INCLUDES)
 
 TEST_INCLUDES := $(wildcard lib/py/*.py) \
 		 $(wildcard lib/sh/*.sh) \
-		 ../../net/net_helper.sh \
 		 ../../net/lib.sh \
 
 TEST_GEN_FILES := \
diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 3c96b022954d..29b01b8e2215 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -33,7 +33,6 @@ NSIM_DEV_SYS_NEW="/sys/bus/netdevsim/new_device"
 
 # Used to create and delete namespaces
 source "${LIBDIR}"/../../../../net/lib.sh
-source "${LIBDIR}"/../../../../net/net_helper.sh
 
 # Create netdevsim interfaces
 create_ifaces() {
diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
index aed62d9e6c0a..1bb46ec435d4 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/peer.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0-only
 
-source ../../../net/net_helper.sh
+source ../../../net/lib.sh
 
 NSIM_DEV_1_ID=$((256 + RANDOM % 256))
 NSIM_DEV_1_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_1_ID
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 70a38f485d4d..ea84b88bcb30 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -115,7 +115,7 @@ YNL_GEN_FILES := busy_poller netlink-dumps
 TEST_GEN_FILES += $(YNL_GEN_FILES)
 
 TEST_FILES := settings
-TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
+TEST_FILES += in_netns.sh lib.sh setup_loopback.sh setup_veth.sh
 
 TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
 
diff --git a/tools/testing/selftests/net/busy_poll_test.sh b/tools/testing/selftests/net/busy_poll_test.sh
index 7db292ec4884..7d2d40812074 100755
--- a/tools/testing/selftests/net/busy_poll_test.sh
+++ b/tools/testing/selftests/net/busy_poll_test.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
-source net_helper.sh
+source lib.sh
 
 NSIM_SV_ID=$((256 + RANDOM % 256))
 NSIM_SV_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_SV_ID
diff --git a/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
index a6b2b1f9c641..c6866e42f95c 100755
--- a/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
+++ b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
@@ -69,7 +69,6 @@
 # which can affect the conditions needed to trigger a soft lockup.
 
 source lib.sh
-source net_helper.sh
 
 TEST_DURATION=300
 ROUTING_TABLE_REFRESH_PERIOD=0.01
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 7962da06f816..006fdadcc4b9 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -595,3 +595,24 @@ bridge_vlan_add()
 	bridge vlan add "$@"
 	defer bridge vlan del "$@"
 }
+
+wait_local_port_listen()
+{
+	local listener_ns="${1}"
+	local port="${2}"
+	local protocol="${3}"
+	local pattern
+	local i
+
+	pattern=":$(printf "%04X" "${port}") "
+
+	# for tcp protocol additionally check the socket state
+	[ ${protocol} = "tcp" ] && pattern="${pattern}0A"
+	for i in $(seq 10); do
+		if ip netns exec "${listener_ns}" awk '{print $2" "$4}' \
+		   /proc/net/"${protocol}"* | grep -q "${pattern}"; then
+			break
+		fi
+		sleep 0.1
+	done
+}
diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 340e1a777e16..e47788bfa671 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -11,7 +11,7 @@ TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
 
 TEST_FILES := mptcp_lib.sh settings
 
-TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh) ../net_helper.sh
+TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)
 
 EXTRA_CLEAN := *.pcap
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 55212188871e..09cd24b2ae46 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(dirname "${0}")/../lib.sh"
-. "$(dirname "${0}")/../net_helper.sh"
 
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
diff --git a/tools/testing/selftests/net/net_helper.sh b/tools/testing/selftests/net/net_helper.sh
deleted file mode 100644
index 6596fe03c77f..000000000000
--- a/tools/testing/selftests/net/net_helper.sh
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# Helper functions
-
-wait_local_port_listen()
-{
-	local listener_ns="${1}"
-	local port="${2}"
-	local protocol="${3}"
-	local pattern
-	local i
-
-	pattern=":$(printf "%04X" "${port}") "
-
-	# for tcp protocol additionally check the socket state
-	[ ${protocol} = "tcp" ] && pattern="${pattern}0A"
-	for i in $(seq 10); do
-		if ip netns exec "${listener_ns}" awk '{print $2" "$4}' \
-		   /proc/net/"${protocol}"* | grep -q "${pattern}"; then
-			break
-		fi
-		sleep 0.1
-	done
-}
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 66be7699c72c..88e914c4eef9 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -205,7 +205,6 @@
 #	Check that PMTU exceptions are created for both paths.
 
 source lib.sh
-source net_helper.sh
 
 PAUSE_ON_FAIL=no
 VERBOSE=0
diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index d5ffd8c9172e..1dc337c709f8 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -3,7 +3,7 @@
 #
 # Run a series of udpgro functional tests.
 
-source net_helper.sh
+source lib.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
index 815fad8c53a8..54fa4821bc5e 100755
--- a/tools/testing/selftests/net/udpgro_bench.sh
+++ b/tools/testing/selftests/net/udpgro_bench.sh
@@ -3,7 +3,7 @@
 #
 # Run a series of udpgro benchmarks
 
-source net_helper.sh
+source lib.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index 5f3d1a110d11..9a2cfec1153e 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -3,7 +3,7 @@
 #
 # Run a series of udpgro benchmarks
 
-source net_helper.sh
+source lib.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index f22f6c66997e..a39fdc4aa2ff 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-source net_helper.sh
+source lib.sh
 
 BPF_FILE="lib/xdp_dummy.bpf.o"
 readonly BASE="ns-$(mktemp -u XXXXXX)"
-- 
2.46.0

