Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65162DCBF3
	for <mptcp@lists.linux.dev>; Fri, 23 May 2025 03:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747971899; cv=none; b=qvPJFBQXU1FQzKqyM60giKauwjprN6eRjxTGeaqL6f592dLGnqkLP3SB2P3wHuJtVnv86I0xfgIWaxT4SXcYwZ2cqExT/9cnc7B/yFKIkdbLdkzyfPegByYJa4OIFaaR5QhPRjtM4ZOpupeBV5+PKKapGgl0Q5xG77tf6a3Dr9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747971899; c=relaxed/simple;
	bh=LF/0eyCryd6R0BPLTvNb7XpdEDWXdfK7ZOwDRuXOsfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NL8DOUjknReFNyMQa6lg19bvUNtTUveQ7CLZZDnI8oKiD8pfxxPMdbqN5Dp8EFH/0vKjWj/LfV+/VLAwIKfJGIuIxZUV5BsRw3Z8u71FpLHebp5+iy1c8wENyisA75yzF65HjXg2xl8StFeFvVNAcYmlaIfg9MM/kBLdNzJEbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz6NfUx6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz6NfUx6"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-231e8553248so59529565ad.1
        for <mptcp@lists.linux.dev>; Thu, 22 May 2025 20:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747971897; x=1748576697; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2o3j+2XgFpauGpmRYtOxgbJgOaGgnrT4xSP3hcSaRo0=;
        b=Iz6NfUx6ZHhVDzbfXZxly3KjJ0I1IHx9qzonY36c3g5p69Ct8enVsjqIYj9ifVfRFk
         LFEzPc4eE8MWxjimUfKeO+jBMrhRdAtBse2kVXGYMnTCzLEp+pFuDjl7eeiF8YLusGfU
         RC3g75ZMBIRycHF+eg9Trmk7J/M+N1RyKphpljWBC/r8NlrYRKm1SsU1tqahTuguAy4a
         ss+u+HCYvtfa7gKloDioaYtr4R0U90gEVnKH+tCqI9zqTi+6NTL/HSkG6PBDzXhrt4t6
         05xGavE2cnt/X7CwBQ+he/+5Qa5AAjWuvyV/E6KvYllYmFQgMVommdWEwi+bDsaaR315
         4A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747971897; x=1748576697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2o3j+2XgFpauGpmRYtOxgbJgOaGgnrT4xSP3hcSaRo0=;
        b=MJ2kaRwoFgpvjHqjtDLS27wlWD80CU4T7+Chndy9RqH2G/GPpWff71gj+UGNXxeB+j
         3GnsJzt5zSdr9j/1B2IWT3Re5YRslEW7QNdReQjDg0HEmO/Twsmcfged09tsdNO7zFbe
         C71v0ZsZj5jXvk4zpMY4dHzUpUTR8VPzTJ8Eu9OhxyWiTqT0DchmmSygpTP7Pu04zVgD
         jR3QN2zaipUpzOHF6RgjqH5s7Qe/MwNYLOSgqt0oM+DMG8S2x4XRLnu07+kdVJw+fIUM
         1otWNl26ocyanFIEHh9onLVipMxMuYpK4ClABzWkOWCjZq4a+jTPbE1Y6csxsHbtgWgP
         ZZLw==
X-Forwarded-Encrypted: i=1; AJvYcCXVgrvjqYg4BfBEE1a0lMSF8gpgKe8dHGmoUJ2EVpPWvb38YIVLijEboFjW9ulYxei0MtECWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAgYK7UPJhAFrWjkCvDTpb/WDqzpnYyPCfxPM5nUti1JxAU6vi
	7B+NOVjw6RiGa0jlR4x5tM+WJqCQpTDJeQvFOZdZv4tzP8A+PNTS2aep
X-Gm-Gg: ASbGncvtnos4znI2flMkNSQYPLQMA21vPxpUFVrPURSYm9rOIYoVNCx6sq0p0IFYinS
	W5sG+wKTXHs4g8z1KKIUAVDRuvE+rIltfsv4VxgNcjnhsCt94Pj3CeNukUEvSvoOGyXzNWmd+Hn
	0vi6hos8if1xaSVaRkOoME03mc39EMubNLTCCDDhfTswQYmvBs9LtbWJZl7y3jz0Pz/Hu1ChkaU
	7zx3DJB4DOSz43kMG0ov0VBqZpyDAbP/TTUZWkKXlzAvca8Lou4OlelKTKsB+vAKzZxmacOK38b
	gUvzlH55jovT1v7nAQZZ7Y4sJMJgweatHYB4LEOBhFXKzlgvpvFDSeq/FrRIwW3rFeT0Fs6qJiG
	+
X-Google-Smtp-Source: AGHT+IHnHhkwN4RPM1sZGax22UCxLFFyjDOfjBA1sS14FQa5RUuVu81bDcpKP9tc8IYZx8hL/mgG3Q==
X-Received: by 2002:a17:903:faf:b0:224:160d:3f5b with SMTP id d9443c01a7336-231de37ec9bmr350292425ad.49.1747971896792;
        Thu, 22 May 2025 20:44:56 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed5683sm115728625ad.245.2025.05.22.20.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 20:44:56 -0700 (PDT)
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
Subject: [PATCH net-next] selftests: net: move wait_local_port_listen to lib.sh
Date: Fri, 23 May 2025 03:44:33 +0000
Message-ID: <20250523034433.1373-1-liuhangbin@gmail.com>
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
 12 files changed, 28 insertions(+), 35 deletions(-)
 delete mode 100644 tools/testing/selftests/net/net_helper.sh

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

