Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E4A35
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121735; cv=none; b=kx6VH/o3DkaXUyFiIvECtQTUqh1QwLiDMjPvFBLeMXuA8E4u6v3WWIno3NIAOTpilnReoHnsFCIKDaXATvMbAqWC6qCoud9LuTSHwLWGdUDVaPXMkz90sRXu7NoUa3KEfgxtXECI+qTmjSC4MMe5rh0ZcqjeIW4ssur87LVhunA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121735; c=relaxed/simple;
	bh=0ycBCrRQyJ+rkajvlKwovdvZS4FvuvD05qgK0ULu7Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dYXhk3Pkmx67EdEE0sIEGUE3ySqG8WvGE6+n+97EPQ/VNjCiDz7fg3gsa1dq1CeRCX+oTpx0RlIa6cz6M4w80GIXEYSX3VZQbeY3/QOhRO+TqUmz6KV6W2ExVwtMiosQ3pht8kBzmfLaRbAhEICHJ4QOUhQl76fe7xLZ9fJGTDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMHrp2tI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMHrp2tI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C152AC433F1;
	Mon, 11 Mar 2024 01:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710121735;
	bh=0ycBCrRQyJ+rkajvlKwovdvZS4FvuvD05qgK0ULu7Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMHrp2tIC2uHE1wKOeh9fW/WO5yXw9wJAxU4Za76HxJPVY0cOplPK5xufQ1E6Z9Yp
	 kIvXq0CJTCjirLdUx/zDBNXdCT7Gs8yLZEjZiuy8M5QsTBSBG8MhtEpeNjVgH9lqA3
	 XKl/g/hsgUqaaUcWeznSufexRFlx5RYZJxJHNQRhv6FiWqNRP/s51yZHinVxZFjNQC
	 /fQCEwKcv6uWKdYBdOFTZwml9kaaDCCMHVkzCNSb9QuMa8Qb9MPC3qHf45nYFX+Kc1
	 P+9rDgH2GwUSOuvS/L05zsJGzfpxF6ANCxaVyW4TiUlTiQJaHV6WhoEqAGs894A24D
	 spfudeLWO9pgg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 01/10] selftests: mptcp: export ip_mptcp to mptcp_lib
Date: Mon, 11 Mar 2024 09:48:38 +0800
Message-Id: <79aa9c522bcbd104823284a9ea42a91bbbd1f9e2.1710121590.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710121590.git.tanggeliang@kylinos.cn>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch exports ip_mptcp into mptcp_lib.sh as a public variable,
named mptcp_lib_ip_mptcp. Add a helper mptcp_lib_set_ip_mptcp() to set
it, and a helper mptcp_lib_is_ip_mptcp() to test whether it is set. Use
these two helpers in mptcp_join.sh.

This patch is prepared for coming commits.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 ++++++++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 13 +++++++++++++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5e9211e89825..7fd32f645650 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -31,7 +31,6 @@ timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 capture=false
 checksum=false
-ip_mptcp=0
 check_invert=0
 validate_checksum=false
 init=0
@@ -610,7 +609,7 @@ pm_nl_set_limits()
 	local addrs=$2
 	local subflows=$3
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if mptcp_lib_is_ip_mptcp; then
 		ip -n $ns mptcp limits set add_addr_accepted $addrs subflows $subflows
 	else
 		ip netns exec $ns ./pm_nl_ctl limits $addrs $subflows
@@ -650,7 +649,7 @@ pm_nl_add_endpoint()
 		nr=$((nr + 1))
 	done
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if mptcp_lib_is_ip_mptcp; then
 		ip -n $ns mptcp endpoint add $addr ${_flags//","/" "} $dev $id $port
 	else
 		ip netns exec $ns ./pm_nl_ctl add $addr $flags $dev $id $port
@@ -663,7 +662,7 @@ pm_nl_del_endpoint()
 	local id=$2
 	local addr=$3
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if mptcp_lib_is_ip_mptcp; then
 		[ $id -ne 0 ] && addr=''
 		ip -n $ns mptcp endpoint delete id $id $addr
 	else
@@ -675,7 +674,7 @@ pm_nl_flush_endpoint()
 {
 	local ns=$1
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if mptcp_lib_is_ip_mptcp; then
 		ip -n $ns mptcp endpoint flush
 	else
 		ip netns exec $ns ./pm_nl_ctl flush
@@ -686,7 +685,7 @@ pm_nl_show_endpoints()
 {
 	local ns=$1
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if mptcp_lib_is_ip_mptcp; then
 		ip -n $ns mptcp endpoint show
 	else
 		ip netns exec $ns ./pm_nl_ctl dump
@@ -699,7 +698,7 @@ pm_nl_change_endpoint()
 	local id=$2
 	local flags=$3
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if mptcp_lib_is_ip_mptcp; then
 		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
 	else
 		ip netns exec $ns ./pm_nl_ctl set id $id flags $flags
@@ -749,7 +748,7 @@ pm_nl_check_endpoint()
 		return
 	fi
 
-	if [ $ip_mptcp -eq 1 ]; then
+	if mptcp_lib_is_ip_mptcp; then
 		# get line and trim trailing whitespace
 		line=$(ip -n $ns mptcp endpoint show $id)
 		line="${line% }"
@@ -3700,7 +3699,7 @@ while getopts "${all_tests_args}cCih" opt; do
 			checksum=true
 			;;
 		i)
-			ip_mptcp=1
+			mptcp_lib_set_ip_mptcp
 			;;
 		h)
 			usage
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d529b4b37af8..d84f2f4986a7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -23,6 +23,7 @@ MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
 MPTCP_LIB_TEST_COUNTER=0
 MPTCP_LIB_TEST_FORMAT="%02u %-50s"
+mptcp_lib_ip_mptcp=0
 
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
@@ -505,3 +506,15 @@ mptcp_lib_verify_listener_events() {
 	mptcp_lib_check_expected "type" "family" "saddr" "sport" || rc="${?}"
 	return "${rc}"
 }
+
+mptcp_lib_set_ip_mptcp() {
+	: "${mptcp_lib_ip_mptcp:?}"
+
+	mptcp_lib_ip_mptcp=1
+}
+
+mptcp_lib_is_ip_mptcp() {
+	: "${mptcp_lib_ip_mptcp:?}"
+
+	[ ${mptcp_lib_ip_mptcp} -eq 1 ]
+}
-- 
2.40.1

