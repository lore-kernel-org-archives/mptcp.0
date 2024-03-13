Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E823C13D
	for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710299594; cv=none; b=c+T6E9wsLzUSo89tqAw5ilmbdszU5srNrLiDGi+Iq4JzzOk9mGAaMto6oBrO/7gB/nnuu9SQNThMz52KNN+XmHbsdngvWYUDwHFxcncug8oHAVDdv6OGSH6gG14bUIeRoTUUd22FoBI7Yzm9q3xzAG+kTxtKeZLo3YMSM/PCg9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710299594; c=relaxed/simple;
	bh=9TldoPRGOHizoHdV5Hxc2yQFAg9h/bFUtboZBf4pWvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hg8LK3BMEEQ817YtKVmNkIbmrE4DnV0yuiAk4XcxIEFzGpbA2lCEGQBvB4w1QKs3nAd2LcEb7gEhafMgTLre4m1byDBBt9tkiQramJRY3Fa2O2BxRnE4qr+8i4YVZkfMiNeBi2dG/wat92HwMXdAXaQuxJ9GA3M4qx/xa9pil8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8ZGZ8vK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8ZGZ8vK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE24DC433F1;
	Wed, 13 Mar 2024 03:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710299593;
	bh=9TldoPRGOHizoHdV5Hxc2yQFAg9h/bFUtboZBf4pWvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8ZGZ8vK1WDKnqfYn8SWalhMcUEr77kWLT3/pNIUESgz+p/wiFHj9MRg0gmwCJUhy
	 V0BOcIznZh8XUV20CbTBdBfypKtwFQx8pZvHrc9uYIxMzECk+aqUpJJLYCDlY2rq/P
	 shvfOxCcohu1GCRpMn4OSnmgieNbgmwCGJKIA1k0+ReLIgQkSnQZwUhi6KHrYIY7iU
	 iSTmrI/z6wFCHZfjzIEwRwx2fAI2OziCIsfDXZV3HV8vaO+rAtDrEjxcbCLduQYju3
	 8Nemmiho1RZ+Zl6n3cYOri+YdRmnPSjhb6tElDQWfvsUYoi/gQ2Z8M5b9/fMTTuBT0
	 vk17jgB9xzFHg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] selftests: mptcp: add ms units for tc-netem delay
Date: Wed, 13 Mar 2024 11:13:05 +0800
Message-Id: <b83594277aa2ad30545e91d810f2a440a1f9c56c.1710299501.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710299501.git.tanggeliang@kylinos.cn>
References: <cover.1710299501.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

'delay 1' in tc-netem is confusing, not sure if it's a delay of 1 second or
1 millisecond. This patch explicitly adds millisecond units to make these
commands clearer.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 6 +++---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8f95e730f4e1..70621cbbab09 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -125,8 +125,8 @@ init_shapers()
 {
 	local i
 	for i in $(seq 1 4); do
-		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1
-		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1
+		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1ms
+		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1ms
 	done
 }
 
@@ -3212,7 +3212,7 @@ fail_tests()
 
 	# multiple subflows
 	if reset_with_fail "MP_FAIL MP_RST" 2; then
-		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 5
+		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 5ms
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 72ea563c923c..e129fcb5a598 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -216,8 +216,8 @@ run_test()
 	shift 4
 	local msg=$*
 
-	[ $delay1 -gt 0 ] && delay1="delay $delay1" || delay1=""
-	[ $delay2 -gt 0 ] && delay2="delay $delay2" || delay2=""
+	[ $delay1 -gt 0 ] && delay1="delay ${delay1}ms" || delay1=""
+	[ $delay2 -gt 0 ] && delay2="delay ${delay2}ms" || delay2=""
 
 	for dev in ns1eth1 ns1eth2; do
 		tc -n $ns1 qdisc del dev $dev root >/dev/null 2>&1
-- 
2.40.1

