Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB61623D7DA
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197593; cv=none; b=KWAZeUZNeBlRlPOz0eQXjOTOv/odioSTdf9NKx8ehwftyg8xQr7i9rp+XhbxNKp+Zf9FbXjC7KasShh8/UP3gwqIYz2uJ+PaLvtKWtQLrR1laFcljTXo1/DsPK+gLRrJrvLMlIO2GmUke9glJ+7nkat/lSjCsswPM9dAoVh1Yrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197593; c=relaxed/simple;
	bh=Uh6Gvvx2to8FRM4FPvuDyTAWF8CAfBSLIXQJy2VoyT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=if1ANu1EINOtyLzutxsZS9TuFBNH1KWwy0Trt++JwPNA48N0k9X5S0pUQXAEm+UmuCgt9ScWwatiy3cwrLKYmSL722VTBtjBJoKySTxmACHPgZ8jlyP4OAuwG3s4LvFBqIVEC+cNL5faVUJMw1Zcp5HpfP7XLWL8HZrDRA4hWUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5V02PXb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5V02PXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C71C4CEF8;
	Mon,  3 Nov 2025 19:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762197592;
	bh=Uh6Gvvx2to8FRM4FPvuDyTAWF8CAfBSLIXQJy2VoyT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M5V02PXbCZnWQ55oMSNTvLQYXQyoJ2XgbeUV3BQp4ajghwCt+MVEc9/XqI24Dl1gC
	 ALle9TaFuhqai9kT0Ol2YH6DFErpdp7Q97Jt3r8FeHO9x6LW3D3vKTZUtZbziX0bQP
	 ksogR9WCmp3yxZlLDsBSCxOya6E2XDtEgMCsBkM8wiP7YayMjCVSNccC9uPnYuQaYv
	 0iwPXZ6a+5EWlkZ/SezQHV+j01cpNiMsTxPc+THWkpHP6SMk42OztzzUD2Nh2O7ZKG
	 8dSc9D2WmNtNi4BZoT7WlSTbby0oVfo1afcLDpjAPV1KMux3ik0v/YKk+/RVuOggXL
	 /Jq8sq/vdx1NA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 03 Nov 2025 20:19:31 +0100
Subject: [PATCH mptcp-next 1/5] selftests: mptcp: lib: introduce
 'nstat_{init,get}'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-slft-nstat-cache-v1-1-56025c09e56a@kernel.org>
References: <20251103-slft-nstat-cache-v1-0-56025c09e56a@kernel.org>
In-Reply-To: <20251103-slft-nstat-cache-v1-0-56025c09e56a@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5854; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Uh6Gvvx2to8FRM4FPvuDyTAWF8CAfBSLIXQJy2VoyT4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI5GQLXNKnGhCR5xM8yZFn7bOWdryz1bWtOr+Fc/ligR
 ue1Dvu/jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImo5TEyPBDNsI9ylin+ELVW
 8ceunhssNiLvtK4WGaxXT8naZXlZleF/aP0k7aNOrKWFMfMFDKsMTn2pVH+3P3P2y9mXoxsiulP
 YAQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These new helpers are easier to read than the long and multi lines
commands. Plus it will ease the addition of new features related to that
in the next commits.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 12 ++++--------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 12 ++++--------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 14 ++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 12 ++++--------
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 12 ++++--------
 5 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 9b7b93f8eb0c..e1f34508490a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -384,11 +384,9 @@ do_transfer()
 		sleep 1
 	fi
 
-	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
-		nstat -n
+	mptcp_lib_nstat_init "${listener_ns}"
 	if [ ${listener_ns} != ${connector_ns} ]; then
-		NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
-			nstat -n
+		mptcp_lib_nstat_init "${connector_ns}"
 	fi
 
 	local stat_synrx_last_l
@@ -436,11 +434,9 @@ do_transfer()
 		kill ${cappid_connector}
 	fi
 
-	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
-		nstat | grep Tcp > /tmp/${listener_ns}.out
+	mptcp_lib_nstat_get "${listener_ns}"
 	if [ ${listener_ns} != ${connector_ns} ]; then
-		NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
-			nstat | grep Tcp > /tmp/${connector_ns}.out
+		mptcp_lib_nstat_get "${connector_ns}"
 	fi
 
 	local duration
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 495b14baccba..ee24adbcfb0c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1000,10 +1000,8 @@ do_transfer()
 
 	cond_start_capture ${listener_ns}
 
-	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
-		nstat -n
-	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
-		nstat -n
+	mptcp_lib_nstat_init "${listener_ns}"
+	mptcp_lib_nstat_init "${connector_ns}"
 
 	local extra_args
 	if [ $speed = "fast" ]; then
@@ -1085,10 +1083,8 @@ do_transfer()
 
 	cond_stop_capture
 
-	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
-		nstat | grep Tcp > /tmp/${listener_ns}.out
-	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
-		nstat | grep Tcp > /tmp/${connector_ns}.out
+	mptcp_lib_nstat_get "${listener_ns}"
+	mptcp_lib_nstat_get "${connector_ns}"
 
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		fail_test "client exit code $retc, server $rets"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d62e653d48b0..d03aa817ac27 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -355,6 +355,20 @@ mptcp_lib_is_v6() {
 	[ -z "${1##*:*}" ]
 }
 
+mptcp_lib_nstat_init() {
+	local ns="${1}"
+
+	NSTAT_HISTORY="/tmp/${ns}.nstat" ip netns exec "${ns}" nstat -n
+}
+
+mptcp_lib_nstat_get() {
+	local ns="${1}"
+
+	# filter out non-*TCP stats
+	NSTAT_HISTORY="/tmp/${ns}.nstat" ip netns exec "${ns}" nstat |
+		grep Tcp > "/tmp/${ns}.out"
+}
+
 # $1: ns, $2: MIB counter
 mptcp_lib_get_counter() {
 	local ns="${1}"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index f01989be6e9b..343615908558 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -169,10 +169,8 @@ do_transfer()
 		cmsg+=",TCPINQ"
 	fi
 
-	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
-		nstat -n
-	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
-		nstat -n
+	mptcp_lib_nstat_init "${listener_ns}"
+	mptcp_lib_nstat_init "${connector_ns}"
 
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -194,10 +192,8 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
-		nstat | grep Tcp > /tmp/${listener_ns}.out
-	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
-		nstat | grep Tcp > /tmp/${connector_ns}.out
+	mptcp_lib_nstat_get "${listener_ns}"
+	mptcp_lib_nstat_get "${connector_ns}"
 
 	print_title "Transfer ${ip:2}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 1903e8e84a31..fbd1685d1adc 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -155,10 +155,8 @@ do_transfer()
 		sleep 1
 	fi
 
-	NSTAT_HISTORY=/tmp/${ns3}.nstat ip netns exec ${ns3} \
-		nstat -n
-	NSTAT_HISTORY=/tmp/${ns1}.nstat ip netns exec ${ns1} \
-		nstat -n
+	mptcp_lib_nstat_init "${ns3}"
+	mptcp_lib_nstat_init "${ns1}"
 
 	timeout ${timeout_test} \
 		ip netns exec ${ns3} \
@@ -185,10 +183,8 @@ do_transfer()
 		kill ${cappid_connector}
 	fi
 
-	NSTAT_HISTORY=/tmp/${ns3}.nstat ip netns exec ${ns3} \
-		nstat | grep Tcp > /tmp/${ns3}.out
-	NSTAT_HISTORY=/tmp/${ns1}.nstat ip netns exec ${ns1} \
-		nstat | grep Tcp > /tmp/${ns1}.out
+	mptcp_lib_nstat_get "${ns3}"
+	mptcp_lib_nstat_get "${ns1}"
 
 	cmp $sin $cout > /dev/null 2>&1
 	local cmps=$?

-- 
2.51.0

