Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA448A923
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 04:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707797684; cv=none; b=LzqRoyscmz2JP6UxvrEtlRwAcgITt3G3jDcPBuyscSEHZzU2UM0aRkfWOFZaAtzfNQ5Pqw/T9g1QNVcIU2mvS84CPzDGFbNjJ8cfKGFkFZM8DGuf7L8+WWhwF7F/IbnLxenLqMb8kZNWgRuv+uleUmV+Q7dWCTOh0lyzbza+TnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707797684; c=relaxed/simple;
	bh=SykQKnGYfbhFlzdD0qm/eExjndmb2FwyNJav13odpFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7BcDA7twW98JsZSfCyHz6+sjZQ006WxR8OOlASYadkFw+VMNj0IbHYKtjyJC7VFsvNucV37IMLj/oVPuUr7HJwbWZhW1a2ij3c+g568Z9FQpimxyfIDzBA5HNOP44vl+3QT8G47f7fTsvS4MqMpeVb1geaE3T2eq7PM07YIGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRGEtrsG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRGEtrsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B169EC433F1;
	Tue, 13 Feb 2024 04:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707797684;
	bh=SykQKnGYfbhFlzdD0qm/eExjndmb2FwyNJav13odpFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRGEtrsG7l83uZmjyN+njenEwAEB+FRdqWLId/hzCIENKx5ubZs10eZblKPB/2xic
	 pDthcE1xWa/HScGz1nV8wImzo4ScfcsAwQTssnZoLVFTsFqDcb8Rt2C4/bHMlolKDl
	 ht2IXHhzQisTMpWsT+8qrmW78rf5A9OgEr3RnMpPQSrVNFl0EKXZ/Ll0P/U9zpMvIO
	 aDvn08WOmy04NAu0JYfYu9QZQ6O4e5i2x/LtL0/40pxv13OBHZZgGXf2iffga9OcUa
	 H/JOLwzxhGd8rpuYuYzMNFfiZoH7KMJKLrvkGoQpi1yFYdfnstjuQUCXa3AaLo4diG
	 0lMPFJj1+pqtA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 4/5] selftests: mptcp: join: change capture/checksum as bool
Date: Tue, 13 Feb 2024 12:14:27 +0800
Message-Id: <616dadb2e22ba3e178d8baef90f43624cdc6e85f.1707797566.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707797566.git.tanggeliang@kylinos.cn>
References: <cover.1707797566.git.tanggeliang@kylinos.cn>
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

Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
Fixes: af66d3e1c3fa ("selftests: mptcp: enable checksum in mptcp_join.sh")
Fixes: 3c082695e78b ("selftests: mptcp: drop msg argument of chk_csum_nr")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5ca1512c3eae..b3dc17daf574 100755
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
@@ -386,7 +386,7 @@ reset_with_checksum()
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
 
-	validate_checksum=1
+	validate_checksum=true
 }
 
 reset_with_allow_join_id0()
@@ -419,7 +419,7 @@ reset_with_allow_join_id0()
 setup_fail_rules()
 {
 	check_invert=1
-	validate_checksum=1
+	validate_checksum=true
 	local i="$1"
 	local ip="${2:-4}"
 	local tables
@@ -1023,7 +1023,7 @@ do_transfer()
 	:> "$sout"
 	:> "$capout"
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 		local capuser
 		if [ -z $SUDO_USER ] ; then
 			capuser=""
@@ -1125,7 +1125,7 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	if [ $capture -eq 1 ]; then
+	if $capture; then
 	    sleep 1
 	    kill $cappid
 	fi
@@ -1513,7 +1513,7 @@ chk_join_nr()
 	else
 		print_ok
 	fi
-	if [ $validate_checksum -eq 1 ]; then
+	if $validate_checksum; then
 		chk_csum_nr $csum_ns1 $csum_ns2
 		chk_fail_nr $fail_nr $fail_nr
 		chk_rst_nr $rst_nr $rst_nr
@@ -3670,10 +3670,10 @@ while getopts "${all_tests_args}cCih" opt; do
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

