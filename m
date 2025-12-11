Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C11FF1B5
	for <mptcp@lists.linux.dev>; Thu, 11 Dec 2025 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765476565; cv=none; b=F4tUGwbiYJoC0F7IZz4q2esSiYCebTG5MTBymRKc8GULyT1C/H5KRxYbDpHeYmhaR9FCCPj8ArTY6Z6R3WkcOcQpGD5L0EzRrvKzMwjstyCbZiBIJ7R4hrn3AnIV0xQ1cJ1UjtVvo9fJLTj3b3XKck3/MCVNqL8D/92IGKTHdj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765476565; c=relaxed/simple;
	bh=DrP/g+/6/jxYUPy2k8ui1CHaPtApS+Rro30muplrmxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WExHX6yavIQfuVt3W5LKp/vcnlhBo1cvebPjVKHq7k4ZizNXaWyAWIEfgOc0I3AJ1ZzrZinDQHzZ2XaNBEjesjrI5kpHyGJQ9MSpLGRBqpf3RD6ISMkAStD4fe9GJPAq0u3WffSQq8YFiSsW5lvwOmQ5Q8TJOoj7McVKW/cZ8eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5kiMfMh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5kiMfMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B3CC4CEF7;
	Thu, 11 Dec 2025 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765476565;
	bh=DrP/g+/6/jxYUPy2k8ui1CHaPtApS+Rro30muplrmxc=;
	h=From:Date:Subject:To:Cc:From;
	b=e5kiMfMhMjnnDpluRJ2l1swpkJMDhzDjNVveRBQ46QYGRdL8Yj0e7PPNDQPefVDnF
	 splYyz80wXgb25xszfW3XEcrkJh+ic33rhzic5cLbHsLvp8CaVChsRPTMRbGQYxA0B
	 cQ4cPelv4WoBT4uN1gKHy6iwEcdGWlvStjFozi0udF/03l+RN97vTViqTdCCazyTEU
	 872sokNxyDJ0Q0QglmUpFgs/9tUofTiObF8xaF92m9P7CScdOxrFe3rKE1vyUj15/y
	 naY+euavsQXtTrtPsP12A0KllZ8sBH8/iXrCr5+GEOpWh3qHraXLKE+Kyqi5+f5DCT
	 G6a5yuu4/Au5w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 11 Dec 2025 19:09:12 +0100
Subject: [PATCH mptcp-next] selftests: mptcp: join: no SKIP mark for group
 checks
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-sft-no-skip-new-cnt-v1-1-6dd6d70f8242@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMcIO2kC/x2M0QqDMAwAf0XyvICpG8h+ZexB0nQLsliaMgXx3
 +32eHB3O7gUFYd7t0ORr7ou1oAuHfB7spegxsYQ+nCjQISeKtqCPmtGkxXZKl77KQ6JKTKP0Mp
 cJOn2vz7gkyv/1K3C8zhO0LJKa3EAAAA=
X-Change-ID: 20251211-sft-no-skip-new-cnt-40ad3fc1dcc8
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5572; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DrP/g+/6/jxYUPy2k8ui1CHaPtApS+Rro30muplrmxc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKtOS5X8Wyf+96FRyNrse4D3cdGLF73jr6/5XNugUXFB
 8tFrWtUO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbC94Phn12+q9Sz1X8jq66+
 j633fnZE9dfd5eVPj1RUb/qytPm0FCPDP9M4YY0ZWzgCjk3YnHQyQajjx4KP8Td4lvaU+fJfVTA
 8xw8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When executing the last MPTCP selftests on older kernels, this output is
printed:

  # 001 no JOIN
  #       join Rx                             [SKIP]
  #       join Tx                             [SKIP]
  #       fallback                            [SKIP]

In fact, behind each line, a few counters are checked, and likely not
all of them have been skipped because the they are not available on
these kernels. Instead, "new" and unsupported counters for these groups
are now ignored, and [ OK ] will be printed instead of [SKIP].

Note that on the MPTCP CI, when validating the dev versions, any
unsupported counter will cause the tests to fail. So this is safe not to
print 'SKIP' for these group checks.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b2e6e548f796..77370b10651a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1407,7 +1407,7 @@ chk_join_tx_nr()
 
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxCreatSkErr")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$create" ]; then
 		rc=${KSFT_FAIL}
 		print_check "syn tx create socket error"
@@ -1416,7 +1416,7 @@ chk_join_tx_nr()
 
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxBindErr")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$bind" ]; then
 		rc=${KSFT_FAIL}
 		print_check "syn tx bind error"
@@ -1425,7 +1425,7 @@ chk_join_tx_nr()
 
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTxConnectErr")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$connect" ]; then
 		rc=${KSFT_FAIL}
 		print_check "syn tx connect error"
@@ -1451,7 +1451,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtInfiniteMapTx")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$infinite_map_tx" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns infinite map tx fallback"
@@ -1460,7 +1460,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtDSSCorruptionFallback")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$dss_corruption" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns dss corruption fallback"
@@ -1469,7 +1469,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtSimultConnectFallback")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$simult_conn" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns simult conn fallback"
@@ -1478,7 +1478,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableFallbackACK")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$mpc_passive" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns mpc passive fallback"
@@ -1487,7 +1487,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableFallbackSYNACK")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$mpc_active" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns mpc active fallback"
@@ -1496,7 +1496,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMPCapableDataFallback")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$mpc_data" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns mpc data fallback"
@@ -1505,7 +1505,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtMD5SigFallback")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$md5_sig" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns MD5 Sig fallback"
@@ -1514,7 +1514,7 @@ chk_fallback_nr()
 
 	count=$(mptcp_lib_get_counter ${!ns} "MPTcpExtDssFallback")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$dss" ]; then
 		rc=${KSFT_FAIL}
 		print_check "$ns dss fallback"
@@ -1590,7 +1590,7 @@ chk_join_nr()
 
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckHMacFailure")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "0" ]; then
 		rc=${KSFT_FAIL}
 		print_check "synack HMAC"
@@ -1599,7 +1599,7 @@ chk_join_nr()
 
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$ack_nr" ]; then
 		rc=${KSFT_FAIL}
 		print_check "ack rx"
@@ -1608,7 +1608,7 @@ chk_join_nr()
 
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckHMacFailure")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "0" ]; then
 		rc=${KSFT_FAIL}
 		print_check "ack HMAC"
@@ -1617,7 +1617,7 @@ chk_join_nr()
 
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinRejected")
 	if [ -z "$count" ]; then
-		rc=${KSFT_SKIP}
+		: # ignore skip
 	elif [ "$count" != "$syn_rej" ]; then
 		rc=${KSFT_FAIL}
 		print_check "syn rejected"

---
base-commit: ff3fd5f60460ba1ba338bfff405f13001e7131b8
change-id: 20251211-sft-no-skip-new-cnt-40ad3fc1dcc8

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

