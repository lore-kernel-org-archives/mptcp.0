Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1582410FF
	for <mptcp@lists.linux.dev>; Sat, 30 Dec 2023 02:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LOpmnQAn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703904578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nzZ8wKNp85moBzUTEOojjQzfk5kfKzJq/zvTsXTS2k=;
	b=LOpmnQAnoVTJDZej9NWefRYCYqfqS/naAPwQuuqhbSTHJhDkSvE5a4xYS6XkoPF81d9leh
	P6HJFH0t+dcrSuwMUNDVamaB0Y1giZkTRPQF8ngnDSunkLEHtp0Wz1OPWFxY5t+DOWjRUM
	HsPKnFO49+lozzRxyJnzs2mfMUNXW80=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v7 21/24] selftests: mptcp: userspace pm get addr tests
Date: Sat, 30 Dec 2023 10:48:16 +0800
Message-Id: <512929c8007a7b66c658d3776afa8e09fb28b36e.1703904325.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703904325.git.geliang.tang@linux.dev>
References: <cover.1703904325.git.geliang.tang@linux.dev>
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
index cec4bfc5193b..0b325b5efccf 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3373,6 +3373,18 @@ userspace_pm_dump()
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
@@ -3610,6 +3622,8 @@ userspace_tests()
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		local dump="id 10 flags signal 10.0.2.1"
+		check_output "userspace_pm_get_addr $ns1 10" \
+			     "$dump" "      get id 10 addr"
 		check_output "userspace_pm_dump $ns1" \
 			     "$dump" "      dump addrs signal"
 		kill_events_pids
@@ -3632,6 +3646,8 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		local dump="id 20 flags subflow 10.0.3.2"
+		check_output "userspace_pm_get_addr $ns2 20" \
+			     "$dump" "      get id 20 addr"
 		check_output "userspace_pm_dump $ns2" \
 			     "$dump" "      dump addrs subflow"
 		kill_events_pids
-- 
2.39.2

