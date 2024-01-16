Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F636FD0
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iJzGxUmq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705376157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lh92hpeUfWqYwupaVmKja05tkoyecwWTMdlvuxSPfbM=;
	b=iJzGxUmqIry9HJuCJXDg3H6FIZHQbmocklh4DVxd+GY95AUKgUuAelzvzBvurnFOGjzovv
	wvia/nV8LTnFn0Eag1Mo052+buX0LLQQjjlnJZbNIqZMuGrbTWcs1A8YhjrdwtQxwV1NMk
	XFZzSxPx3CvBShuTV5C8ug4mDYL8djA=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 23/23] selftests: mptcp: flush userspace addrs list
Date: Tue, 16 Jan 2024 11:35:11 +0800
Message-Id: <7bf6b2a10a756ce5fdc739663cf9eb2e3ae72d87.1705375746.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1705375746.git.tanggeliang@kylinos.cn>
References: <cover.1705375746.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper userspace_pm_flush() to flush all addresses
for the userspace PM. Invoke it in userspace pm dump address and subflow
tests. And use dump commands to check if the userspace pm local address
list is empty after addresses flushing.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 +++++++++++++++++--
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0b325b5efccf..65e8d9d61ac9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3385,6 +3385,31 @@ userspace_pm_get_addr()
 	ip netns exec $1 ./pm_nl_ctl get $2 token $tk
 }
 
+# $1: ns ; $2: addr
+userspace_pm_flush()
+{
+	local ns=$1
+	local line
+
+	userspace_pm_dump $ns | while read -r line; do
+		local arr=($line)
+		local nr=0
+		local id
+		local addr
+		local i
+		for i in "${arr[@]}"; do
+			if [ $i = "id" ]; then
+				id=${arr[$nr+1]}
+			fi
+			nr=$((nr + 1))
+		done
+		addr=${arr[$nr-1]}
+		[ $ip_mptcp -eq 1 ] && addr=${arr[0]}
+		userspace_pm_rm_addr $ns $id
+		userspace_pm_rm_sf $ns "$addr" $MPTCP_LIB_SUB_ESTABLISHED
+	done
+}
+
 check_output()
 {
 	local cmd="$1"
@@ -3606,8 +3631,8 @@ userspace_tests()
 		wait $tests_pid
 	fi
 
-	# userspace pm dump address
-	if reset_with_events "userspace pm dump address" &&
+	# userspace pm dump & flush address
+	if reset_with_events "userspace pm dump & flush address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
@@ -3626,12 +3651,18 @@ userspace_tests()
 			     "$dump" "      get id 10 addr"
 		check_output "userspace_pm_dump $ns1" \
 			     "$dump" "      dump addrs signal"
+		userspace_pm_flush $ns1
+		check_output "userspace_pm_dump $ns1" \
+			     "" "      dump addrs after flush"
+		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
 
-	# userspace pm dump subflow
-	if reset_with_events "userspace pm dump subflow" &&
+	# userspace pm dump & flush subflow
+	if reset_with_events "userspace pm dump & flush subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
@@ -3650,6 +3681,12 @@ userspace_tests()
 			     "$dump" "      get id 20 addr"
 		check_output "userspace_pm_dump $ns2" \
 			     "$dump" "      dump addrs subflow"
+		userspace_pm_flush $ns2
+		check_output "userspace_pm_dump $ns2" \
+			     "" "      dump addrs after flush"
+		chk_rm_nr 1 1
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
-- 
2.40.1

