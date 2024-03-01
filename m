Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C145BACB
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709273892; cv=none; b=iyB+rjn13w2m9/TrEhGWmoJJboyWChNfS//R5Jw7ZN9jLnAfNejBAd+/StpNfKNNIHHUJKvpu4cKHn1xE5y0D9uyOc7eUv7RZwD4DoyPrdvZsSc4NC3Dln4LFviHAFWqj9DWR0N98d0dyWDpQrVIX0mtRHE7CJlgAigAELrU28g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709273892; c=relaxed/simple;
	bh=vfYKTCtOtdP9a8Xnju6WY2Da+kYlcxBhYFQH4BcpNuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pr9sDoLhnlfKao3sFO4fJU7Vdf42J/CaRJ6t6o9skdnuiylpf9mi7ikhrKsEhLz4Rj/lcRHC9bd33wGFCt1Zuk2yAx1BZ77PqjabXCLkQIPI1sHm7Bi7zJr9Sr/5yRCQKn2w3asTgupOeeLAYThXu9TwEYc8Tq8VisQUa+1FzwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugwPY0CU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugwPY0CU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715F3C433F1;
	Fri,  1 Mar 2024 06:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709273892;
	bh=vfYKTCtOtdP9a8Xnju6WY2Da+kYlcxBhYFQH4BcpNuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugwPY0CUq+DkFA6XN9x5Kcya7YbVCjp55KVH/h9hNyqa9TTg7BViS+RdGCQaNf6fa
	 CljdZSyR56c7XSoAUGe8gPDXNSL9rsySDK3JvQTKvW9S1oCaqOT0D/1JzPgR8JfRNu
	 qJ+5yUQED8YScMa7/9Mqf2siPBFhqJRNJKSUaSah3O3rGfZxBiDs2h2yViNPye0nYO
	 yP0PmUGsHPqwcUFKwSS5bX1ZdVsW1u+NYVLFleMNDVkqvnSDj9/M3caVLZm6UPm0hr
	 UTl4sRYFHIAwveMBBkE0jMZjMGRLFsSFEaCYUzkNNgoT1gP7N5fU7fvlDgZz6z2A5j
	 AAZAE+kbBP5cA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 2/6] selftests: mptcp: connect: fix misaligned output
Date: Fri,  1 Mar 2024 14:18:01 +0800
Message-Id: <ad6988e62a5c3ba40929a75ea349f99e624b88df.1709273774.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709273774.git.tanggeliang@kylinos.cn>
References: <cover.1709273774.git.tanggeliang@kylinos.cn>
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

