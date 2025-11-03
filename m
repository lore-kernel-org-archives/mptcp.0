Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BDB347C3
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197596; cv=none; b=Ps22BgA9/EICxAL6H9uv0S04Nre14zk3zvN/c8ysvs/B5b0qeq9O4103nfxajXyw9pINcfTp9+NNw+1UfUMaCnZIAn4cT64pS41mfTBhGO/nIp+n+FBPoHhDOiKNEhlaPcRHX3EcxKlWbCrtW+8ErADkcvfAk1ROFVXtiLvfY1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197596; c=relaxed/simple;
	bh=HRCMiSFufMhJZkGZEyhso8MOl2qrm3bOsvs8o9hMto8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rES0OpttGb4KFSD79HF0bDkOZRl/2JSu7YoSXajuWLK5RkAsaQJ5alrmpDmRfHTaJutRVLmOVGnNCwcDYK1+fbbEhtixcOzDCEL+AJSjeTxWhbvW/iQUibXNVG8+z7mGcnW4WKpLSMYPCyss5dS26LHK6ERaZhnPddMYeNMUzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtFNMLGs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtFNMLGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45ED3C4CEF8;
	Mon,  3 Nov 2025 19:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762197595;
	bh=HRCMiSFufMhJZkGZEyhso8MOl2qrm3bOsvs8o9hMto8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BtFNMLGsUXu7HM8QOHXCvtoHZV5Z0n234kSdpQJ4G8z0XBIEVSpMZxj3bLJZYfOa5
	 ufVPvsl5b6FdTbPkZlSxTVXkfmpeAIJ+qqHyS1iEV942VywalFsaUQtekuSmRGv8y2
	 1Kj9dbyd2o5fmvEDixwqufZDbHgjk3WaQBWaPMF2UjfJh87Xv+kImJQGBzG43pJURl
	 dlZWuLgI+PPI5o3AB3PcN8b9wXHXekAu92zQmOySgOwQatFxagaAcODXkXjArrIn4y
	 CEPpzQo4FV6LOvqOuBTnWSNoVW+mq7YQfbRGbwcK6FIyYoWYeOo4k5iULmvUuzumCJ
	 8Xx9NXSM7flcA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 03 Nov 2025 20:19:35 +0100
Subject: [PATCH mptcp-next 5/5] selftests: mptcp: lib: get counters from
 nstat history
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-slft-nstat-cache-v1-5-56025c09e56a@kernel.org>
References: <20251103-slft-nstat-cache-v1-0-56025c09e56a@kernel.org>
In-Reply-To: <20251103-slft-nstat-cache-v1-0-56025c09e56a@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9412; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HRCMiSFufMhJZkGZEyhso8MOl2qrm3bOsvs8o9hMto8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI5GcIu9reHqn45eei8YX/nLo1rXz4ZWt75KfZM9/8cw
 +t/19253FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjARjusM/90+937PdTm6TNt3
 c/Wa17v+7GOSZnb25Mp0PzPJoCIsuIiR4bfMFP9vBnoe17a7uLd7mfuXy/6cUxd34QZbYlODfLg
 gJwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before, 'nstat' was used to retrieve each individual counter: this means
querying 4 different sources from /proc/net and iterating over 100+
counters each time. Instead, the stats could be retrieved once, and the
output file could be parsed for each counter. Even better, such file is
already present: the nstat history file.

To be able to get this working, the nstat history file also needs to
contains zero counters too, so it is still possible to know if a counter
is missing or set to 0.

This also simplifies mptcp_connect.sh: instead of checking multiple
counters before and after a test to compute the difference, the stats
history files can be reset before each test, and nstat can display only
the difference.

mptcp_lib_get_counter() continues to work when no history file is
available: by fetching nstat directly, like before. This is the case in
diag.sh and userspace_pm.sh where there is no need to save the history
file. This is also the case in mptcp_join.sh, when 'run_tests' is
executed in the background: easier to continue fetching counters than
updating the history each time it is needed.

Note: 'nstat' is called with '-s' in mptcp_lib_nstat_get(), so this
helper can be called multiple times during the test if needed.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 85 +++++++++-------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 16 +++-
 2 files changed, 46 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 4ff2d02429d3..3a804abebd2c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -389,21 +389,6 @@ do_transfer()
 		mptcp_lib_nstat_init "${connector_ns}"
 	fi
 
-	local stat_synrx_last_l
-	local stat_ackrx_last_l
-	local stat_cookietx_last
-	local stat_cookierx_last
-	local stat_csum_err_s
-	local stat_csum_err_c
-	local stat_tcpfb_last_l
-	stat_synrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
-	stat_ackrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
-	stat_cookietx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
-	stat_cookierx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
-	stat_csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
-	stat_csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
-	stat_tcpfb_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
-
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
 			./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -458,38 +443,38 @@ do_transfer()
 	rets=$?
 
 	local extra=""
-	local stat_synrx_now_l
-	local stat_ackrx_now_l
-	local stat_cookietx_now
-	local stat_cookierx_now
-	local stat_ooo_now
-	local stat_tcpfb_now_l
-	stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
-	stat_ackrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
-	stat_cookietx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
-	stat_cookierx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
-	stat_ooo_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
-	stat_tcpfb_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
+	local stat_synrx
+	local stat_ackrx
+	local stat_cookietx
+	local stat_cookierx
+	local stat_ooo
+	local stat_tcpfb
+	stat_synrx=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
+	stat_ackrx=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
+	stat_cookietx=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
+	stat_cookierx=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
+	stat_ooo=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
+	stat_tcpfb=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
 
-	expect_synrx=$((stat_synrx_last_l))
-	expect_ackrx=$((stat_ackrx_last_l))
+	expect_synrx=0
+	expect_ackrx=0
 
 	cookies=$(ip netns exec ${listener_ns} sysctl net.ipv4.tcp_syncookies)
 	cookies=${cookies##*=}
 
 	if [ ${cl_proto} = "MPTCP" ] && [ ${srv_proto} = "MPTCP" ]; then
-		expect_synrx=$((stat_synrx_last_l+connect_per_transfer))
-		expect_ackrx=$((stat_ackrx_last_l+connect_per_transfer))
+		expect_synrx=${connect_per_transfer}
+		expect_ackrx=${connect_per_transfer}
 	fi
 
-	if [ ${stat_synrx_now_l} -lt ${expect_synrx} ]; then
-		mptcp_lib_pr_fail "lower MPC SYN rx (${stat_synrx_now_l})" \
+	if [ ${stat_synrx} -lt ${expect_synrx} ]; then
+		mptcp_lib_pr_fail "lower MPC SYN rx (${stat_synrx})" \
 				  "than expected (${expect_synrx})"
 		retc=1
 	fi
-	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ]; then
-		if [ ${stat_ooo_now} -eq 0 ]; then
-			mptcp_lib_pr_fail "lower MPC ACK rx (${stat_ackrx_now_l})" \
+	if [ ${stat_ackrx} -lt ${expect_ackrx} ]; then
+		if [ ${stat_ooo} -eq 0 ]; then
+			mptcp_lib_pr_fail "lower MPC ACK rx (${stat_ackrx})" \
 					  "than expected (${expect_ackrx})"
 			rets=1
 		else
@@ -503,47 +488,45 @@ do_transfer()
 		csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
 		csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
 
-		local csum_err_s_nr=$((csum_err_s - stat_csum_err_s))
-		if [ $csum_err_s_nr -gt 0 ]; then
-			mptcp_lib_pr_fail "server got ${csum_err_s_nr} data checksum error[s]"
+		if [ $csum_err_s -gt 0 ]; then
+			mptcp_lib_pr_fail "server got ${csum_err_s} data checksum error[s]"
 			rets=1
 		fi
 
-		local csum_err_c_nr=$((csum_err_c - stat_csum_err_c))
-		if [ $csum_err_c_nr -gt 0 ]; then
-			mptcp_lib_pr_fail "client got ${csum_err_c_nr} data checksum error[s]"
+		if [ $csum_err_c -gt 0 ]; then
+			mptcp_lib_pr_fail "client got ${csum_err_c} data checksum error[s]"
 			retc=1
 		fi
 	fi
 
-	if [ ${stat_ooo_now} -eq 0 ] && [ ${stat_tcpfb_last_l} -ne ${stat_tcpfb_now_l} ]; then
+	if [ ${stat_ooo} -eq 0 ] && [ ${stat_tcpfb} -gt 0 ]; then
 		mptcp_lib_pr_fail "unexpected fallback to TCP"
 		rets=1
 	fi
 
 	if [ $cookies -eq 2 ];then
-		if [ $stat_cookietx_last -ge $stat_cookietx_now ] ;then
+		if [ $stat_cookietx -eq 0 ] ;then
 			extra+=" WARN: CookieSent: did not advance"
 		fi
-		if [ $stat_cookierx_last -ge $stat_cookierx_now ] ;then
+		if [ $stat_cookierx -eq 0 ] ;then
 			extra+=" WARN: CookieRecv: did not advance"
 		fi
 	else
-		if [ $stat_cookietx_last -ne $stat_cookietx_now ] ;then
+		if [ $stat_cookietx -gt 0 ] ;then
 			extra+=" WARN: CookieSent: changed"
 		fi
-		if [ $stat_cookierx_last -ne $stat_cookierx_now ] ;then
+		if [ $stat_cookierx -gt 0 ] ;then
 			extra+=" WARN: CookieRecv: changed"
 		fi
 	fi
 
-	if [ ${stat_synrx_now_l} -gt ${expect_synrx} ]; then
+	if [ ${stat_synrx} -gt ${expect_synrx} ]; then
 		extra+=" WARN: SYNRX: expect ${expect_synrx},"
-		extra+=" got ${stat_synrx_now_l} (probably retransmissions)"
+		extra+=" got ${stat_synrx} (probably retransmissions)"
 	fi
-	if [ ${stat_ackrx_now_l} -gt ${expect_ackrx} ]; then
+	if [ ${stat_ackrx} -gt ${expect_ackrx} ]; then
 		extra+=" WARN: ACKRX: expect ${expect_ackrx},"
-		extra+=" got ${stat_ackrx_now_l} (probably retransmissions)"
+		extra+=" got ${stat_ackrx} (probably retransmissions)"
 	fi
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 603f33885f8e..ce6c92826be7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -111,7 +111,7 @@ mptcp_lib_pr_nstat() {
 	local hist="/tmp/${ns}.out"
 
 	if [ -f "${hist}" ]; then
-		awk '{ print "  "$0 }' "${hist}"
+		awk '$2 != 0 { print "  "$0 }' "${hist}"
 	else
 		ip netns exec "${ns}" nstat -as | grep Tcp
 	fi
@@ -367,6 +367,7 @@ mptcp_lib_is_v6() {
 mptcp_lib_nstat_init() {
 	local ns="${1}"
 
+	rm -f "/tmp/${ns}."{nstat,out}
 	NSTAT_HISTORY="/tmp/${ns}.nstat" ip netns exec "${ns}" nstat -n
 }
 
@@ -374,18 +375,25 @@ mptcp_lib_nstat_get() {
 	local ns="${1}"
 
 	# filter out non-*TCP stats, and the rate (last column)
-	NSTAT_HISTORY="/tmp/${ns}.nstat" ip netns exec "${ns}" nstat |
+	NSTAT_HISTORY="/tmp/${ns}.nstat" ip netns exec "${ns}" nstat -sz |
 		grep -o ".*Tcp\S\+\s\+[0-9]\+" > "/tmp/${ns}.out"
 }
 
 # $1: ns, $2: MIB counter
+# Get the counter from the history (mptcp_lib_nstat_{init,get}()) if available.
+# If not, get the counter from nstat ignoring any history.
 mptcp_lib_get_counter() {
 	local ns="${1}"
 	local counter="${2}"
+	local hist="/tmp/${ns}.out"
 	local count
 
-	count=$(ip netns exec "${ns}" nstat -asz "${counter}" |
-		awk 'NR==1 {next} {print $2}')
+	if [[ -s "${hist}" && "${counter}" == *"Tcp"* ]]; then
+		count=$(awk "/^${counter} / {print \$2; exit}" "${hist}")
+	else
+		count=$(ip netns exec "${ns}" nstat -asz "${counter}" |
+			awk 'NR==1 {next} {print $2}')
+	fi
 	if [ -z "${count}" ]; then
 		mptcp_lib_fail_if_expected_feature "${counter} counter"
 		return 1

-- 
2.51.0

