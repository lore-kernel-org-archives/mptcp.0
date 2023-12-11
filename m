Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B86920B30
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="trK4gqkW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702282512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAJIdXHkFN1OiToruJPWCMzHhuVfrGxsAHkLsD5Xyrc=;
	b=trK4gqkWSYy8VOj2BXVUDGc6csn+p5FFDqoES0X7/nUDugNeQl+DNA3OImUBwNMtoD2PE7
	Bhi7E3Rh7V0k+T+7MfqvL70zOJ3PMEnjithR1MnF9rWnUc4oKCBsIqeVbT86sOGLgC1tn3
	+G5oeijVKLQuAfIk/tUoq1hRr5/hIN4=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next 12/12] selftests: mptcp: userspace pm get addr tests
Date: Mon, 11 Dec 2023 16:15:34 +0800
Message-Id: <6bb5f7f97fb38b71312104c9755ed9ca24e8bdb1.1702282411.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702282411.git.geliang.tang@linux.dev>
References: <cover.1702282411.git.geliang.tang@linux.dev>
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
dump & flush tests.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 16710e4b89d5..a6b80cfc2436 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3359,6 +3359,18 @@ userspace_pm_rm_sf()
 	wait_rm_sf $1 "${cnt}"
 }
 
+# $1: ns ; $2: id
+userspace_pm_get_addr()
+{
+	local evts=$server_evts
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$client_evts
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl get $2 token $tk
+}
+
 check_output() {
 	: "${check_output_err:?}"
 	: "${ret:?}"
@@ -3591,6 +3603,8 @@ userspace_tests()
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		local dump="id 10 flags signal 10.0.2.1"
+		mptcp_lib_check_output "userspace_pm_get_addr $ns1 10" \
+				       "$dump" "      get id 10 addr"
 		[ $ip_mptcp -eq 1 ] && dump="10.0.2.1 id 10 signal "
 		check_output "pm_nl_show_endpoints $ns1" \
 			     "$dump" "      dump addrs signal"
@@ -3614,6 +3628,8 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		local dump="id 20 flags subflow 10.0.3.2"
+		mptcp_lib_check_output "userspace_pm_get_addr $ns2 20" \
+				       "$dump" "      get id 20 addr"
 		[ $ip_mptcp -eq 1 ] && dump="10.0.3.2 id 20 subflow "
 		check_output "pm_nl_show_endpoints $ns2" \
 			     "$dump" "      dump addrs subflow"
-- 
2.35.3

