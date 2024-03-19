Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2E50A80
	for <mptcp@lists.linux.dev>; Tue, 19 Mar 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832583; cv=none; b=i0hGWzDc8DyvPOGqvr58HBoCXsQhvn1VDRGgHwRfJh4O/zLuo3ITEV4tDESY1qY0LRJL5he2PZCArLZ+qnLtxbKWMh9KzHU4md15ujPnAjDr8W/PAkSRr6ePfyEkuHH99JUEMe2Lbu2b1N1IM8VaTRNRtw9OWTucMehprWAxHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832583; c=relaxed/simple;
	bh=vvafilXpSFxGpxTvsWaNvSRKn+0JFURQP1lsZgcAfds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zj2U9JHutadg08JxROPdNyighw3TUBPrQcsjOoYefZxDAFAf2IvQsOsqDd1E6B9EaPkeFZN/femSFtIe4FlAY/EqBbjJy2FK870LHVvTHd/6u34g3Sx7nzj+5fDyY8e8UM1C8btyMXT2uvG9IFOeFhDsqM7V+cMP/IvLFUY5FBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOltdeZo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOltdeZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EDEC43390;
	Tue, 19 Mar 2024 07:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710832583;
	bh=vvafilXpSFxGpxTvsWaNvSRKn+0JFURQP1lsZgcAfds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LOltdeZo0WYKqKFeJT5vm2N9buM2yx+GHXbke8jbqW4F1mxyoxgOufrI8aa9HpokG
	 fCD6DDWYdmp2RAA0b7NyqjYjOv635G4RFVNpKQ653rp1pfq+PI+SzITBTsegq2V3Rp
	 uckK3U5TlLCZMOY+7JdBCzRPU3KaqL+hpyRGXSNxalOQlF6Ti7US2tfg+u+/HJU4Hq
	 92jZyTDZGLCSUCrLcBMXleuKcCq7b1M2NOGTCdsTIil/k7+N/mmyCMB+UgWHFiMRkz
	 lDhKaMDrhNKXv1vVRBr/z4yHnild0pWrkv8dABduQ0jz7802chw2PavOmvUjKUCzX2
	 FtkM8Zkin58Fg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/9] selftests: mptcp: export ip_mptcp to mptcp_lib
Date: Tue, 19 Mar 2024 15:16:07 +0800
Message-Id: <66e7a9d75b360322b163c25d4ccde2c804e3ee1c.1710832493.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710832493.git.tanggeliang@kylinos.cn>
References: <cover.1710832493.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch exports ip_mptcp into mptcp_lib.sh as a public variable,
named MPTCP_LIB_IP_MPTCP. Add a helper mptcp_lib_set_ip_mptcp() to set
it, and a helper mptcp_lib_is_ip_mptcp() to test whether it is set. Use
these two helpers in mptcp_join.sh.

This patch is prepared for coming commits.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 ++++++++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  9 +++++++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 73a2131e6da2..62fcfeaa3430 100755
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
@@ -3702,7 +3701,7 @@ while getopts "${all_tests_args}cCih" opt; do
 			checksum=true
 			;;
 		i)
-			ip_mptcp=1
+			mptcp_lib_set_ip_mptcp
 			;;
 		h)
 			usage
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1fa05405f65e..ca01d949fad8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -23,6 +23,7 @@ MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
 MPTCP_LIB_TEST_COUNTER=0
 MPTCP_LIB_TEST_FORMAT="%02u %-50s"
+MPTCP_LIB_IP_MPTCP=0
 
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
@@ -511,3 +512,11 @@ mptcp_lib_verify_listener_events() {
 	mptcp_lib_check_expected "type" "family" "saddr" "sport" || rc="${?}"
 	return "${rc}"
 }
+
+mptcp_lib_set_ip_mptcp() {
+	MPTCP_LIB_IP_MPTCP=1
+}
+
+mptcp_lib_is_ip_mptcp() {
+	[ "${MPTCP_LIB_IP_MPTCP}" = "1" ]
+}
-- 
2.40.1

