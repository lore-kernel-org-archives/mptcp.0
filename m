Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD11170D
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H/NR0d+2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702974048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdzLm6bVu2drPN48mINIesrGgiK0TBHVz/DyGjVUDz0=;
	b=H/NR0d+2ejTuhtAA2hhqcIeagbS/HeXb8kM8McO8wNWEKbcbkBFEVEBg9hkfnbuQ94CacT
	2AluR28qbHISc8PMyunPWBJ5DjZ+PD7DYqBX+TZ/nnd9eo5iiXTXdFvrRkpmCZ6htE/HDN
	XJOpyNCGMvlAQsjIp6P8s28fbDNz/Jg=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v3 14/14] selftests: mptcp: userspace pm get addr tests
Date: Tue, 19 Dec 2023 16:19:25 +0800
Message-Id: <9a8034c76311d8871fb8d9e69aefc459b2e607ec.1702973751.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702973751.git.geliang.tang@linux.dev>
References: <cover.1702973751.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds a new helper userspace_pm_get_addr() in mptcp_join.sh.
In it, parse the token value from the output of 'pm_nl_ctl events', then
pass it to pm_nl_ctl get_addr command. Use this helper in userspace pm
dump tests.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 403200394aa7..e603baa1d4a8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3372,6 +3372,18 @@ userspace_pm_dump()
 	ip netns exec $1 ./pm_nl_ctl dump token $tk
 }
 
+# $1: ns ; $2: id
+userspace_pm_get_addr()
+{
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl get $2 token $tk
+}
+
 check_output()
 {
 	local cmd="$1"
@@ -3602,6 +3614,8 @@ userspace_tests()
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		local dump="id 10 flags signal 10.0.2.1"
+		check_output "userspace_pm_get_addr $ns1 10" \
+			     "$dump" "      get id 10 addr"
 		check_output "userspace_pm_dump $ns1" \
 			     "$dump" "      dump addrs signal"
 		kill_events_pids
@@ -3624,6 +3638,8 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		local dump="id 20 flags subflow 10.0.3.2"
+		check_output "userspace_pm_get_addr $ns2 20" \
+			     "$dump" "      get id 20 addr"
 		check_output "userspace_pm_dump $ns2" \
 			     "$dump" "      dump addrs subflow"
 		kill_events_pids
-- 
2.35.3

