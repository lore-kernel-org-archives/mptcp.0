Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B09E1CD13
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077053; cv=none; b=YzqhV12L1jJezmon1IFJSD55JS5ZV1SmQk/6pQzX0RSP/FS1Y65agn7C/OVWTNuE0EYs/ljS8chzVZyZ04jjCxkeVD16vLDlYMjZXHzuNzL759zi72nd7eFIz9W66tUCQCt2S3o+tf7kArAwIwXi+HPfnIOoAlFBRZD83xBXU4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077053; c=relaxed/simple;
	bh=z0NhTB092mg6YDXAk7JdFQ8yb3lDCuESpUqDY2Wge1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pN7pnIMDyXKieqUinS/FUjjyMVvkqFeGIHtPnHWe/RFXB2xeE8ohy9wG23UdB1sx29YP56opN72XCQnoie94GEg+T93p/diDRdB1v7JTvRNfE4RH9oAa7yQ9EO4oRh7BwKx76oaS+EAIXScQ/dK0C8iVCZ9vZFOuk9enT0zYUJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8fS/zbH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8fS/zbH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF178C433C7;
	Fri, 16 Feb 2024 09:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077053;
	bh=z0NhTB092mg6YDXAk7JdFQ8yb3lDCuESpUqDY2Wge1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8fS/zbHkEg+rM2rP32uiJY4ZRr3Eh0UseF5+lFODVn9vMhR1bYHehYqc5iL+/PqP
	 Fs10YcXWQvkbcWhMm4W4vzLluuIs8kYUx7aawhCVEKuQv4RyPHOuJwLXO59hwCsV7R
	 lTbLObNbnSGXl1A/GMPlREMzGxhOxCrrqx/3MTRpx9/qFFjqLmaxnllavrHKbQL0jt
	 gRVqUiwmKUSMWHtB9AtTQkb4yiJ83frub0cGZGDvM2x8Fm8eGh7KFa2EXDg/Ttuq1E
	 4LeeDVjtUc8eNfYlvaj41Us8ZHLBuCX++4wnNcOHljUTIOcGZWjTpc9Ta1tZET5tAp
	 NPrETi4cAdRIg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/7] selftests: mptcp: join: change capture/checksum as bool
Date: Fri, 16 Feb 2024 17:50:31 +0800
Message-Id: <f04dc2507b0778a913a48c26bc950f1750eee1b5.1708076886.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708076886.git.tanggeliang@kylinos.cn>
References: <cover.1708076886.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To maintain consistency with other scripts, this patch changes vars
'capture' and 'checksum' as bool vars in mptcp_join.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b807e2a42c61..88074f64f0a7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -29,11 +29,11 @@ iptables="iptables"
 ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-capture=0
-checksum=0
+capture=false
+checksum=false
 ip_mptcp=0
 check_invert=0
-validate_checksum=0
+validate_checksum=false
 init=0
 evts_ns1=""
 evts_ns2=""
@@ -100,7 +100,7 @@ init_partial()
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
-		if [ $checksum -eq 1 ]; then
+		if $checksum; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
 	done
@@ -376,7 +376,7 @@ reset_with_checksum()
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
 
-	validate_checksum=1
+	validate_checksum=true
 }
 
 reset_with_allow_join_id0()
@@ -409,7 +409,7 @@ reset_with_allow_join_id0()
 setup_fail_rules()
 {
 	check_invert=1
-	validate_checksum=1
+	validate_checksum=true
 	local i="$1"
 	local ip="${2:-4}"
 	local tables
@@ -1013,7 +1013,7 @@ do_transfer()
 	:> "$sout"
 	:> "$capout"
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 		local capuser
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
@@ -1115,7 +1115,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 	    sleep 1
 	    kill $cappid
 	fi
@@ -1503,7 +1503,7 @@ chk_join_nr()
 	else
 		print_ok
 	fi
-	if [ $validate_checksum -eq 1 ]; then
+	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
@@ -3664,10 +3664,10 @@ while getopts "${all_tests_args}cCih" opt; do
 			tests+=("${all_tests[${opt}]}")
 			;;
 		c)
-			capture=1
+			capture=true
 			;;
 		C)
-			checksum=1
+			checksum=true
 			;;
 		i)
 			ip_mptcp=1
-- 
2.40.1

