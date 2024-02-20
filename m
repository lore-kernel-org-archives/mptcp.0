Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5556160244
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423126; cv=none; b=nd35oM62xZNtX6+QUQIMdkwa92OtMJNC6dBx36+4KX7SLNmIrBCChtymDg6Dy95UTvqDXiCCaZtI1VWDSWoaJxxBpPdoL40ehr7cCkY7f08O5oFa3+MoqfcL30YZ0thUUFHrkD7aeI02+I+Or3oxq7V96uO1iL+uGVAu5VAQXiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423126; c=relaxed/simple;
	bh=OCYHmGkNVsjeelHNXi4bZl08JeMepMy1AX07+sInQQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ie3QHKLrTWBWC142D+g5rX3zM9xSD9N5Uvq9SBep+yu27QzY9EJXcPFJFB8+fc2U0x0htosvmEoHD14v6t23IlmA6cMQnbEeVMn12ckI4XR9vSgrZkzrTqzbMO7PV86F2ZBTMV/fHzk/EwpdIRyZBxm4CpTAagqVq1XV0+Jt350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJbqwa+h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJbqwa+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F95C43390;
	Tue, 20 Feb 2024 09:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423125;
	bh=OCYHmGkNVsjeelHNXi4bZl08JeMepMy1AX07+sInQQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJbqwa+h6W42nHu6a+qAKWyq6sFbko5SQ4WAx893rgPMa+6kaq7QkwW2Zolzns9U9
	 EyCS38+s2ktec5xJ5DNmj7kaLVFbBu/w9WfvXnOHyTPuxwtKkyTTbXlr9/3dK3I8Jx
	 5BxRQE21g/sShtCA4zXdkgY/eX7kq3lfppotDAXSKYw5m5p5tMhk2c2uaVzalbAYV6
	 vqwKfIenAaljAtz++ZXm6nPlyRY4i5lvTdE6srvf0F9+dy+b2eb9gFUqQr3PMSRkpG
	 8IwGPE5H7Cz8Mi6AC7Uo3SzlSQLYcSusTgO+Yq/k58YO7rGaMG7l/+tor0r4AMFwua
	 qLQJpuCzt9ITg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 09/14] selftests: mptcp: dump userspace addrs list
Date: Tue, 20 Feb 2024 17:58:23 +0800
Message-Id: <d6b0e8ac180be83ffe19f069785b8712ce3fef19.1708422758.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708422758.git.tanggeliang@kylinos.cn>
References: <cover.1708422758.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper userspace_pm_dump() to dump addresses
for the userspace PM. Use this helper to check whether an ID 0 subflow
is listed in the output of dump command after creating an ID 0 subflow
in "userspace pm create id 0 subflow" test. Dump userspace PM addresses
list in "userspace pm add & remove address" test and in "userspace pm
create destroy subflow" test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4a8217bcc008..9bdf2b535e87 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -21,6 +21,7 @@ cinfail=""
 cinsent=""
 tmpfile=""
 cout=""
+err=""
 capout=""
 ns1=""
 ns2=""
@@ -163,6 +164,7 @@ init() {
 	cin=$(mktemp)
 	cinsent=$(mktemp)
 	cout=$(mktemp)
+	err=$(mktemp)
 	evts_ns1=$(mktemp)
 	evts_ns2=$(mktemp)
 
@@ -178,6 +180,7 @@ cleanup()
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
 	rm -f "$tmpfile"
 	rm -rf $evts_ns1 $evts_ns2
+	rm -f "$err"
 	cleanup_partial
 }
 
@@ -3330,6 +3333,50 @@ userspace_pm_rm_sf()
 	wait_rm_sf $1 "${cnt}"
 }
 
+check_output()
+{
+	local cmd="$1"
+	local expected="$2"
+	local msg="$3"
+	local rc=0
+
+	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" || rc=${?}
+	if [ ${rc} -eq 2 ]; then
+		fail_test "fail to check output # error ${rc}"
+	elif [ ${rc} -eq 0 ]; then
+		print_ok
+	elif [ ${rc} -eq 1 ]; then
+		fail_test "fail to check output # different output"
+	fi
+}
+
+# $1: ns
+userspace_pm_dump()
+{
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl dump token $tk
+}
+
+userspace_pm_chk_dump_addr()
+{
+	local ns="${1}"
+	local exp="${2}"
+	local check="${3}"
+
+	print_check "dump addrs ${check}"
+
+	if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
+		check_output "userspace_pm_dump ${ns}" "${exp}"
+	else
+		print_skip
+	fi
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3421,10 +3468,16 @@ userspace_tests()
 		chk_mptcp_info subflows 2 subflows 2
 		chk_subflows_total 3 3
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
+		userspace_pm_chk_dump_addr "${ns1}" \
+			$'id 10 flags signal 10.0.2.1\nid 20 flags signal 10.0.3.1' \
+			"signal"
 		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		userspace_pm_chk_dump_addr "${ns1}" \
+			"id 20 flags signal 10.0.3.1" "after rm_addr 10"
 		userspace_pm_rm_addr $ns1 20
 		userspace_pm_rm_sf $ns1 10.0.3.1 $SUB_ESTABLISHED
+		userspace_pm_chk_dump_addr "${ns1}" "" "after rm_addr 20"
 		chk_rm_nr 2 2 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -3445,8 +3498,14 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
+		userspace_pm_chk_dump_addr "${ns2}" \
+			"id 20 flags subflow 10.0.3.2" \
+			"subflow"
 		userspace_pm_rm_addr $ns2 20
 		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		userspace_pm_chk_dump_addr "${ns2}" \
+			"" \
+			"after rm_addr 20"
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -3466,6 +3525,8 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		userspace_pm_chk_dump_addr "${ns2}" \
+			"id 0 flags subflow 10.0.3.2" "id 0 subflow"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.40.1

