Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28806FBF
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kyl2RasT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705376147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYZQYFJ8NNp2iUe81pLO09vqSAcqAU6SbdPUuHyMdqs=;
	b=Kyl2RasTgKIC+dMxlK4hRpuhTP9MT+ZEgmW8kqcT667S1jLoKwJp6azHakCVV91ROEsQUl
	foHZGM+11D+EOYPtw5w6E4pNGCwAyxSXayuyQKbzfqq52XmZMZQS515tL/cifO/jP5mbry
	pFau/ROW8gDxeugJI0BAUU029wLo7mU=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 14/23] selftests: mptcp: dump after creating id 0 subflow
Date: Tue, 16 Jan 2024 11:35:02 +0800
Message-Id: <7bc5cafb30bb38c23928b8c5208ec1e2ee304306.1705375746.git.tanggeliang@kylinos.cn>
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

This patch adds a new helper userspace_pm_dump() to dump addresses
for the userspace PM. Use this helper to check whether an ID 0 subflow
is listed in the output of dump command after creating an ID 0 subflow
in "userspace pm create id 0 subflow" test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4043baa59c6..a92fb5469621 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3361,6 +3361,18 @@ userspace_pm_rm_sf()
 	wait_rm_sf $1 "${cnt}"
 }
 
+# $1: ns
+userspace_pm_dump()
+{
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl dump token $tk
+}
+
 check_output()
 {
 	local cmd="$1"
@@ -3522,6 +3534,9 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		check_output "userspace_pm_dump $ns2" \
+			     "id 0 flags subflow 10.0.3.2" \
+			     "      dump addrs id 0 subflow"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.40.1

