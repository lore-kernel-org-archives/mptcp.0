Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F5CA50
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 01:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709689271; cv=none; b=M+4AB1pghrCydRU4izR248XsQU35gIKtwLQhyUY9HWwKvg9i4dPYLhgBGabGlhdN/FIKL57yX72ScYpa3/INdlaW/VB/pMHLfMgLGAMOdpr4+8Cky/wgs65fnR1dKkTTJFQTzcxpt+cyRpXm9XelAFo4LLGy8wetHK/+DWTden0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709689271; c=relaxed/simple;
	bh=r2pIfJgq0ihDAIcnTI4H5W5MoR3cRgq2gzhAw956buo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KC/NwPyeF9rw4nVvZLWa/tnkJfGa9pFEFdPKYpUVdkHpG8PmQEs1RnyLkrmeEPU5ppw5M3zH/QmBowqyL3/NDg0MexMFLB/TVODrzD+pTxcsj9HVmEf8sHRp6KBot35gsZ34PvxkySU72sYg9jH2BOwg8M8kyJ+4iDx0gLEAXu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWAxZDTU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWAxZDTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2B1C433C7;
	Wed,  6 Mar 2024 01:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709689271;
	bh=r2pIfJgq0ihDAIcnTI4H5W5MoR3cRgq2gzhAw956buo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWAxZDTUmLSqzeqJcnQ0EjSyW705HrYEbBAImvjoNqvIQpqyUI+njOKK9hm1ml7V4
	 ijayVqdZRKk7YYgW98rnvl277IsmhAp3Eu/c5PbNAjK3zI8n+g1TJTZcL8kcyW0onJ
	 0EG1Xc0lG2/mUV3lR2wLdIyphkJvMcsN+aY9jAnXXGnnkDKAHeMLbxlcP28fAnpIYi
	 QBOwwa9qxqqQwl61MP+GHuM8maHYlI6RZ4mIWHrbQ8krvAjJfH1NsBJj5jrU5kMSSa
	 Az15kV1S/Mb3QoIB8esB7tSzDgOXmGiGHhwA+oIbWYm43enTASXLqZkLoU1COCttoE
	 ztEeA0unKYL7A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 3/9] selftests: mptcp: connect: fix misaligned output
Date: Wed,  6 Mar 2024 09:40:53 +0800
Message-Id: <a0b2a2fdd645dd1e036c7cfaeda7bdf9eee37086.1709688778.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709688778.git.tanggeliang@kylinos.cn>
References: <cover.1709688778.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The first [ OK ] in the output of mptcp_connect.sh misaligns with the
others:

New MPTCP socket can be blocked via sysctl              [ OK ]
INFO: validating network environment with pings
INFO: Using loss of 0.85% delay 16 ms reorder 95% 70% with delay 4ms on
ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP   (duration   184ms) [ OK ]
ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP     (duration    50ms) [ OK ]
ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP   (duration    55ms) [ OK ]

This patch aligns them by using 69 chars to display the first two lines,
and 50 chars for the other. Since 19 chars are used to display duration
time. Also print out a [ OK ] at the end of the 2nd line for consistency.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index c47ea779145d..709233ffa305 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -248,11 +248,17 @@ else
 	set_ethtool_flags "$ns4" ns4eth3 "$ethtool_args"
 fi
 
+print_larger_title() {
+	# here we don't have the time, a bit longer for the alignment
+	printf "%-69s" "${@}"
+}
+
 check_mptcp_disabled()
 {
 	local disabled_ns
 	mptcp_lib_ns_init disabled_ns
 
+	print_larger_title "New MPTCP socket can be blocked via sysctl"
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
 		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[ FAIL ]"
@@ -274,7 +280,7 @@ check_mptcp_disabled()
 		return 1
 	fi
 
-	echo -e "New MPTCP socket can be blocked via sysctl\t\t[ OK ]"
+	echo "[ OK ]"
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
 }
@@ -343,7 +349,7 @@ do_transfer()
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
 	local result_msg
 	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
-	printf "%s\t" "${result_msg}"
+	printf "%-50s" "${result_msg}"
 
 	if $capture; then
 		local capuser
@@ -836,7 +842,7 @@ check_mptcp_disabled
 
 stop_if_error "The kernel configuration is not valid for MPTCP"
 
-echo "INFO: validating network environment with pings"
+print_larger_title "Validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
 	do_ping "$ns1" $sender dead:beef:1::1
@@ -858,6 +864,7 @@ done
 mptcp_lib_result_code "${ret}" "ping tests"
 
 stop_if_error "Could not even run ping tests"
+echo "[ OK ]"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
 echo -n "INFO: Using loss of $tc_loss "
-- 
2.40.1

