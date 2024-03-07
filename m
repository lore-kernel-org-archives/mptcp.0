Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23F12B148
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815746; cv=none; b=CKPc/W+ybTEwq5ThWvpRaZXZYGugZZOCF+1e3GtTYPUN7G9YAUgR8VbJ/hMYAVD94JFBQDq6icT60c03ry2Lo5EoqQdNHSjrWqm78rou5nGQxO2FBQMkibMXUC/W9IHudDhnc2sKne9NhDlmlZmJld3X8isqnv2UZpuSxLcUyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815746; c=relaxed/simple;
	bh=75lZYm5RnBVAJshl4hWLbg/xKVYZyfEzLM43y1KIANQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UPNNXgbh+TSFZfNUCOGosyQPWGVEce52oFr+38T40Gc5tW12R9vSz8uLKn4aFuvp12MWG4X4f40tVMi+xosKCW9PzsDglph7R8urlLM56WzoNcmugUpNjMlP8S2qe+IVjBXqNZV7DyCTm57SFJ4jVDEbe4yWpQfOLPpqFWH4SeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+8jgNMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+8jgNMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2285BC43390;
	Thu,  7 Mar 2024 12:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709815746;
	bh=75lZYm5RnBVAJshl4hWLbg/xKVYZyfEzLM43y1KIANQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+8jgNMXVWNz4iyc7zOxlSUVwOJJCjntTNTXE66vwX0mb1BJo+asx0OnovBaP26jO
	 YEQGgjar9zJsK4M8WBjrIGjhY/uUknp9Jx2v9ygnuKOwQqi5rnl3wFPJkbglCtd6js
	 w/aF4RjjEAlNKnkti1r3hDCvpTs/LDFjLUv8qO3xEWdx3sgjmnt9wHUxQz7k7dHjxA
	 4VBHR9JULkktzNPXF5d0ywH1IqUZDPLWbGEVmNeUrSEZ7VqeH7vEtQ/wh1gsdYnzKd
	 /Gr1WwXJfAk5ZlyGd819OVCKalDofs3k08rnWQh2IfTQNY1bP3SIC6/I6BJXZxtnvO
	 O82eND7d35NIw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/5] selftests: mptcp: join: use += operator to append strings
Date: Thu,  7 Mar 2024 20:48:44 +0800
Message-Id: <c8bd786e0c09f4f19d518ec998a36f9fbd64e0b5.1709815545.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709815545.git.tanggeliang@kylinos.cn>
References: <cover.1709815545.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses addition assignment operator (+=) to append strings instead
of open-coding in mptcp_join.sh. This can make the statements shorter.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6d725419b7d4..b70bd8e0088a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -753,18 +753,18 @@ pm_nl_check_endpoint()
 		line="${line% }"
 		# the dump order is: address id flags port dev
 		[ -n "$addr" ] && expected_line="$addr"
-		expected_line="$expected_line $id"
-		[ -n "$_flags" ] && expected_line="$expected_line ${_flags//","/" "}"
-		[ -n "$dev" ] && expected_line="$expected_line $dev"
-		[ -n "$port" ] && expected_line="$expected_line $port"
+		expected_line+=" $id"
+		[ -n "$_flags" ] && expected_line+=" ${_flags//","/" "}"
+		[ -n "$dev" ] && expected_line+=" $dev"
+		[ -n "$port" ] && expected_line+=" $port"
 	else
 		line=$(ip netns exec $ns ./pm_nl_ctl get $_id)
 		# the dump order is: id flags dev address port
 		expected_line="$id"
-		[ -n "$flags" ] && expected_line="$expected_line $flags"
-		[ -n "$dev" ] && expected_line="$expected_line $dev"
-		[ -n "$addr" ] && expected_line="$expected_line $addr"
-		[ -n "$_port" ] && expected_line="$expected_line $_port"
+		[ -n "$flags" ] && expected_line+=" $flags"
+		[ -n "$dev" ] && expected_line+=" $dev"
+		[ -n "$addr" ] && expected_line+=" $addr"
+		[ -n "$_port" ] && expected_line+=" $_port"
 	fi
 	if [ "$line" = "$expected_line" ]; then
 		print_ok
@@ -1032,7 +1032,7 @@ do_transfer()
 		fi
 	fi
 
-	extra_srv_args="$extra_args $extra_srv_args"
+	extra_srv_args+=" $extra_args"
 	if [ "$test_linkfail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
@@ -1048,7 +1048,7 @@ do_transfer()
 
 	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
 
-	extra_cl_args="$extra_args $extra_cl_args"
+	extra_cl_args+=" $extra_args"
 	if [ "$test_linkfail" -eq 0 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${connector_ns} \
@@ -1215,7 +1215,7 @@ chk_csum_nr()
 	print_check "sum"
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns1" ]; then
-		extra_msg="$extra_msg ns1=$count"
+		extra_msg+=" ns1=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1228,7 +1228,7 @@ chk_csum_nr()
 	print_check "csum"
 	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns2" ]; then
-		extra_msg="$extra_msg ns2=$count"
+		extra_msg+=" ns2=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1272,7 +1272,7 @@ chk_fail_nr()
 	print_check "ftx"
 	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ "$count" != "$fail_tx" ]; then
-		extra_msg="$extra_msg,tx=$count"
+		extra_msg+=",tx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1286,7 +1286,7 @@ chk_fail_nr()
 	print_check "failrx"
 	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ "$count" != "$fail_rx" ]; then
-		extra_msg="$extra_msg,rx=$count"
+		extra_msg+=",rx=$count"
 	fi
 	if [ -z "$count" ]; then
 		print_skip
@@ -1321,7 +1321,7 @@ chk_fclose_nr()
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_tx" ]; then
-		extra_msg="$extra_msg,tx=$count"
+		extra_msg+=",tx=$count"
 		fail_test "got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
 	else
 		print_ok
@@ -1332,7 +1332,7 @@ chk_fclose_nr()
 	if [ -z "$count" ]; then
 		print_skip
 	elif [ "$count" != "$fclose_rx" ]; then
-		extra_msg="$extra_msg,rx=$count"
+		extra_msg+=",rx=$count"
 		fail_test "got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
 	else
 		print_ok
@@ -1701,7 +1701,7 @@ chk_rm_nr()
 		count=$((count + cnt))
 		if [ "$count" != "$rm_subflow_nr" ]; then
 			suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
-			extra_msg="$extra_msg simult"
+			extra_msg+=" simult"
 		fi
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
-- 
2.40.1

