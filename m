Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AD012B83
	for <mptcp@lists.linux.dev>; Fri,  8 Dec 2023 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rClM4mWF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702030044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avmygBuXEEQP5wgkYQggw8bWgd4xinzbcONrnzf/o4M=;
	b=rClM4mWFHhZ1Vd6vaLaqdNUQ8VIDLv02xXyN3gZ5XGHWy9IuHbhgde8RU6oDYEKW2zidVF
	ZyilDVbfwNzIYK4pN08tFSWUaF7pnTOKkM0W6YPUNH+MRvNX//QQwaD+ZtXxQcWUNS0iRz
	+Q6NbyzYa39tEtvLZvma0U095EmAIow=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v14 18/25] selftests: mptcp: flush userspace addrs list
Date: Fri,  8 Dec 2023 18:07:31 +0800
Message-Id: <05a2cb3d56e7e35691acf9847568169d6f4f51dc.1702029539.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702029538.git.geliang.tang@linux.dev>
References: <cover.1702029538.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds a new helper userspace_pm_flush() to flush all addresses
for the userspace PM. Invoke it in userspace pm dump address and subflow
tests. And use dump commands to check if the userspace pm local address
list is empty after addresses flushing.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 +++++++++++++++++--
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 49416324b4c2..a6f60f3896d5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3360,6 +3360,31 @@ userspace_pm_rm_sf()
 	wait_rm_sf $1 "${cnt}"
 }
 
+# $1: ns ; $2: addr
+userspace_pm_flush()
+{
+	local ns=$1
+	local line
+
+	pm_nl_show_endpoints $ns | while read -r line; do
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
+		userspace_pm_rm_sf $ns "$addr" $SUB_ESTABLISHED
+	done
+}
+
 check_output() {
 	: "${check_output_err:?}"
 	: "${ret:?}"
@@ -3582,8 +3607,8 @@ userspace_tests()
 		wait $tests_pid
 	fi
 
-	# userspace pm dump address
-	if reset_with_events "userspace pm dump address" &&
+	# userspace pm dump & flush address
+	if reset_with_events "userspace pm dump & flush address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
@@ -3601,12 +3626,18 @@ userspace_tests()
 		[ $ip_mptcp -eq 1 ] && dump="10.0.2.1 id 10 signal "
 		check_output "pm_nl_show_endpoints $ns1" \
 			     "$dump" "      dump addrs signal"
+		userspace_pm_flush $ns1
+		check_output "pm_nl_show_endpoints $ns1" \
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
@@ -3624,6 +3655,12 @@ userspace_tests()
 		[ $ip_mptcp -eq 1 ] && dump="10.0.3.2 id 20 subflow "
 		check_output "pm_nl_show_endpoints $ns2" \
 			     "$dump" "      dump addrs subflow"
+		userspace_pm_flush $ns2
+		check_output "pm_nl_show_endpoints $ns2" \
+			     "" "      dump addrs after flush"
+		chk_rm_nr 1 1
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
-- 
2.35.3

