Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17417AD2C
	for <mptcp@lists.linux.dev>; Sun,  3 Mar 2024 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709459598; cv=none; b=WsbM8j+Sarvhk3MaG1ay8a6c3mnPh4lIqVftE81GyeA2RuWXH1yA+21zXcThZc3YuPxazRx/zrTNKR5c+WA1PvaivGTfAYG+mwmf4V0eIHlMjSXxsBNLNuM2ZYRYMVfDVVAboeAi2He31m4LpfRfm0cr84iLQP1Ywcwdv3PTCQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709459598; c=relaxed/simple;
	bh=holYYEyW861sX5VEYUNymnC4CT33ulQhMN/hUeMvVlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TRcbRmp1kMwQfKqpjV9sL4OqBw7LgNcht6dZ3xv26KBmYEw9fb8BqvYl9o0TgLwcZi3KGOu5jMNlakLxko1ofO+SJ2yGKuRjnGCVdrxwI8O1fOIPRg/2jDKiDJy+vTyHX6WWmkrpNnuVwOro3RFho57gmiBP9E+ly1BnYZLb600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUbg1P1m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUbg1P1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB727C433F1;
	Sun,  3 Mar 2024 09:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709459597;
	bh=holYYEyW861sX5VEYUNymnC4CT33ulQhMN/hUeMvVlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUbg1P1msee2c+JGtCBULnNcO15kFDYBlAz8RfRDFRKOAFID/RzJm2qoJ9wiB8z17
	 0Xd0USknn0nNqlF9nbRlI23bs6PYiCUwV7SVeTspCrb69fEBvpiBZH8EkV7fWj5MlY
	 IuT+hu1L+IIQul+OiquJSDB2Xp0snYgbxeWOjwU3wqq+5hbYtvJbjD6nYGEO1F1dPT
	 DmoCIl+c0Dg5YmLDS41RDi2eVgBJ3e9r+qC9vVeR9kJJt0uZCwyHRcg8g3I5uhfXbl
	 Yow13LkjEGw3ZdL1xdFaKHXdV+8MF+5MYq/PYEwPIXhAY2W+I3EyQ2suWhC4spItAh
	 2RuXOxAeo3fiA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 3/8] selftests: mptcp: connect: fix misaligned output
Date: Sun,  3 Mar 2024 17:52:23 +0800
Message-Id: <fc174aeda4567d024fde1cf0053600545285196a.1709459360.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709459360.git.tanggeliang@kylinos.cn>
References: <cover.1709459360.git.tanggeliang@kylinos.cn>
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
index 30f44900ad38..be598e1e25f5 100755
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

