Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497A1119E
	for <mptcp@lists.linux.dev>; Fri, 29 Dec 2023 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tHqZXIL4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703854129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IU2k4zQ15+YPk3PM7rccTLc+5h8Xe4ZxQDyLoKz/3z0=;
	b=tHqZXIL4gpaBrvBcz8RPgy9mEvNVdQbGWwvrG49yNx+zUUUve4mzhyhh3QC0Bi7omqZeUB
	mOIBIczgmqrHc1LUmZFT2HFc96ckO7gK4Ugp9aGlo/sdgxKf4oonTdCxx5bRwucVexQ3md
	jc2GmoF872teJLjtGe8dlzOykNX1TAE=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 15/24] selftests: mptcp: dump after creating id 0 subflow
Date: Fri, 29 Dec 2023 20:47:33 +0800
Message-Id: <49f4e9833a055f8125bf7f913998e8480add662f.1703853513.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703853512.git.geliang.tang@linux.dev>
References: <cover.1703853512.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds a new helper userspace_pm_dump() to dump addresses
for the userspace PM. Use this helper to check whether an ID 0 subflow
is listed in the output of dump command after creating an ID 0 subflow
in "userspace pm create id 0 subflow" test.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
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
2.39.2

