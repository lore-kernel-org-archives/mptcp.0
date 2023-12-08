Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8955912B74
	for <mptcp@lists.linux.dev>; Fri,  8 Dec 2023 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MRjc3Thv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702030039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DA0B/WxYL0Fr/S5CYhGClSumO+0rO/50LqqEy5nH5jU=;
	b=MRjc3ThvPfHjRaJzmHj6k29k7r/L3xkQdiyJMnDjoSXoV0H+l8lEjYqDvt8tNFcvmqZ9DM
	N02EOkhlstZSed8dt5MXcG/S0BV5uMNHErfBx1qfcjRbd8vksd4y9pRzfqtj0nzqypdBRf
	m6pEBCL6/QyvvXo8jic6+ds6vE1dPkw=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v14 13/25] selftests: mptcp: dump after creating id 0 subflow
Date: Fri,  8 Dec 2023 18:07:26 +0800
Message-Id: <b75b512c997af0544c1bbeb0aa8063266121b018.1702029538.git.geliang.tang@linux.dev>
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

The output of dump command after creating a ID 0 subflow should be
empty. Since ID 0 address doesn't list by dump command. This patch
uses check_output() helper to check whether the output is empty in
"userspace pm create id 0 subflow" test.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 16710e4b89d5..3a105f7239b8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3518,6 +3518,8 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		check_output "pm_nl_show_endpoints $ns2" \
+			     "" "      dump addrs id 0 subflow"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.35.3

