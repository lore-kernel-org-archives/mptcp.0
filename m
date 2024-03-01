Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393967E79
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 06:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275625; cv=none; b=UcP1mSG7pIuQ0rLjV+ArBGHqSpXInwguPpokc68DUfLgNOuNr0M9msM2ZzTRyi8ipD9xb0oI/up0lUtD8pB2KC/w0qtSVgHUvBACIncoVhfsYuPBSP/RqKiYX8QstZoF+0ufRkZJ4SnYE04p8Q5Avphwn4Aofzx11ZH6DenTyQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275625; c=relaxed/simple;
	bh=tM2FAYP38AQTzmUVlaiXxSly71UfRUBXaU7PHM+dX0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nlxUY3EMOZbnX92XAecmTBfFhiM8xDVXE/7Ia59Ij8waz1kVYix+m6SDCl3TdhA5AARhIhQtlJcS9YSpaEeFjJ7WEkJMigsv5Zn8HyX492GIWt706NyI//aUU8UbOZXOocZZ8W8Z1I8dW0KsUGCdPJtRgl1/15nJkRMZl6bwufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH1TBESf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH1TBESf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DC2C433C7;
	Fri,  1 Mar 2024 06:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709275625;
	bh=tM2FAYP38AQTzmUVlaiXxSly71UfRUBXaU7PHM+dX0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DH1TBESf5ysYxOpsHzUmsOFwMyjZO6R1zpjN3IpziiFR30B4cchBbFesmx5pfugYi
	 DG1uRt7P9tbnZR/jWSTLIE5xgB/2zR5/gOtOUmi7SyFwD03lnCVGPYJbz0fhfCmPgs
	 ADuuhSfXeTt9mwrP2SDW7WcYXofLMmLslq11jg4h5A5ScHiCAbYLtDlZGEiSjZDUrx
	 FVoa7yWqkeNZ3r6/0ierO5jdrYvJztU6CkO+AQlmCGz5iKKBzeFeoivn6iMl33D90q
	 tQAox40wGiDZEsktCTYAv5COeXkEg7mJomxjXikcNn2WPOjtPytj+nSoklYab5a4JT
	 XQnZgshQyCL/g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 2/6] selftests: mptcp: connect: fix misaligned output
Date: Fri,  1 Mar 2024 14:46:32 +0800
Message-Id: <be219b7d53572a80e8e44d3be398e300b578427a.1709275290.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709275290.git.tanggeliang@kylinos.cn>
References: <cover.1709275290.git.tanggeliang@kylinos.cn>
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
index 4f40221a86cb..242407a1b4da 100755
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

