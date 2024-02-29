Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C26089C
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200284; cv=none; b=MGwXuSWVkngQ51BGjssWAdjJb++Lc03zvKp7UiwREHNH5pFd9nPimgfXgI0zN4+Kv6dwJWrFy28JjVDHBd1VBJmeDtZRQ4Wscd0dCQEXDx1cJG7l43SEafiXZXN0W4gsZl/79NI58+Pe0a1AcGCwgeLaSc2d1VMkJ7QGZw4jqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200284; c=relaxed/simple;
	bh=vfYKTCtOtdP9a8Xnju6WY2Da+kYlcxBhYFQH4BcpNuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FatcIEqw++2vv21HwHQf3Cc4B0CAkR9xWTmX/Fq5qa2AIQMeJEx1DxSVaOXztMBiemgjN8o2JnNqBOBioAEK4KM5ATQ/9nrVjPfCbWznFjfPGEM9K/8qHvOHoPJML5HInSiEiY8us7VAUMK2cfymk/SrnzOLCzXpb+Ydf8qH21k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0JAXJ97; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0JAXJ97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B4DC433F1;
	Thu, 29 Feb 2024 09:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709200284;
	bh=vfYKTCtOtdP9a8Xnju6WY2Da+kYlcxBhYFQH4BcpNuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n0JAXJ97uIPAdbjJ0RCBpPl4n4BQakM3cujk2TVLqsDcmeLqNSYPfZuhwalhd75dp
	 9/6Zv36BJ+Tq3+UmrZxbbRG7Bk/kYcPep5t8CzypGLLcH16gF/aQxSxxtEMC+Hz5D9
	 wIrUQpSsBaX5Dhgrx1XdIlFpzkMW0RCQGCjqgx7XAjye1x1oPlVyBpGyGRQ0wNPnZG
	 /z1elpEKpDlh8ptb39HQojmaG2hKO1M/JUj2yjAwjKpttsk6lAUkvqRa29gOd+nAeI
	 eK3aijfukcUXoQ4wrm9uNooDf6Hyi/JMeP9nK4q7tkB7a1wXQleAaSSEbYeq0kk+6h
	 bwz7GmGi5E7Eg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 3/8] selftests: mptcp: connect: fix misaligned output
Date: Thu, 29 Feb 2024 17:51:06 +0800
Message-Id: <7dbd446f210d2d66896275da66567bfd113ee2af.1709200070.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709200070.git.tanggeliang@kylinos.cn>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 4f40221a86cb..77b0b9d5aca0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -274,7 +274,8 @@ check_mptcp_disabled()
 		return 1
 	fi
 
-	echo -e "New MPTCP socket can be blocked via sysctl\t\t[ OK ]"
+	printf "%-69s" "New MPTCP socket can be blocked via sysctl"
+	echo "[ OK ]"
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
 }
@@ -343,7 +344,7 @@ do_transfer()
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
 	local result_msg
 	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
-	printf "%s\t" "${result_msg}"
+	printf "%-50s" "${result_msg}"
 
 	if $capture; then
 		local capuser
@@ -836,7 +837,7 @@ check_mptcp_disabled
 
 stop_if_error "The kernel configuration is not valid for MPTCP"
 
-echo "INFO: validating network environment with pings"
+printf "%-69s" "Validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
 	do_ping "$ns1" $sender dead:beef:1::1
@@ -858,6 +859,7 @@ done
 mptcp_lib_result_code "${ret}" "ping tests"
 
 stop_if_error "Could not even run ping tests"
+echo "[ OK ]"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
 echo -n "INFO: Using loss of $tc_loss "
-- 
2.40.1

