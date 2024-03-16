Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C846BA
	for <mptcp@lists.linux.dev>; Sat, 16 Mar 2024 03:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710561086; cv=none; b=i+z1eyfc4GjpVCNHCPKiXkLT0id7lKUMbg91gJ/nBiRTJ2+/gVEGHX/IcSyyEXt7wknBtMg7nbgYRDedSRyYW2meIjVre+h7K4Q7R6TgDr016EzY5HxtUGo4YwfPe9dblf3J0evkpgT3pgZRuIvMofQvzwCVDVvENyh7ZMVd3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710561086; c=relaxed/simple;
	bh=vvafilXpSFxGpxTvsWaNvSRKn+0JFURQP1lsZgcAfds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XOvelNax2eS2NMG0W6jnDSGzJGZVQ9dAmNamZn0s43lcDU5wcJirz9rItDvZDMisZcW/9Duw0Tsegw4pWNYhxs6V2S3aXfiilUo3FmHUYy5ip8ohcrycJuxo5Wb/tcnPwcPUQ8Od9jRkiaw/7uvLvqHebDdBBPi260niO6fWunc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tesm+Bc6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tesm+Bc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A718C433F1;
	Sat, 16 Mar 2024 03:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710561086;
	bh=vvafilXpSFxGpxTvsWaNvSRKn+0JFURQP1lsZgcAfds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tesm+Bc60LoOETamQ9zpzepwVBzZFXaz1258Md4KPZBAhLPhv+cRdUNJEoOdFx8mI
	 xkudLJDLLTYwt0wYGQ4yW7DSeSOt7FuVASL7uNhUpqEjaQIh+iuUI43t0GPSoQCnC4
	 TqTgt7jgWe0dEHk7IWxzi1nPfnoIr9LmlBI8QbtX/HpjOfb9RF8dIfEyv7Sw+Z3PDE
	 KL0VM6b7pg7e9kPIKu7vjk7K963L/JP1llG6Czgfuv4d2fMM37q8cnfbZ0+z0MOyJQ
	 qQYI2dA5/z0elV8hjgNOkGXtCTZjWmvwVzPBL+6kBMoK5vAq0EpgA47IickvyCokfx
	 YeZygwllpLE1Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/9] selftests: mptcp: export ip_mptcp to mptcp_lib
Date: Sat, 16 Mar 2024 11:50:29 +0800
Message-Id: <62ed87e5e22bec5e5bb9775428e67a91e0f34662.1710560839.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710560839.git.tanggeliang@kylinos.cn>
References: <cover.1710560839.git.tanggeliang@kylinos.cn>
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

