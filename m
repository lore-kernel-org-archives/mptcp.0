Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF41C696
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935490; cv=none; b=f8BT5hyf2Qvf5zoCO4/YoPNSjhcW9zitv8+Bz3IG5mQxFWckEYXNUQH3dkh1xppAkmndPyUSZJu0H2pCrjl92WnP6Tfks5EKjMsDIw1Exb2eKEKKnYjYGRTOGoP9BVJBGZp9whgdE5ouJWQjHZPjninOpIFRGgUD6HFie2XGkm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935490; c=relaxed/simple;
	bh=AsYKZHM4Vkh2vInRTD66a/lR6QtG8JnarTaSy0Wg31I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0ereBcYeWRi58kU8P6t4LQtA3e8bZILxSHO8TOXUHQWyiuFyx0/xPO0ii8Y/TR0cZHK+suyrZ99dqABHgXpf7ckJJwLp9vrH7WuR9EQgGTWSXvbeqWCXbv9z/6Uy/JHHVNjLUwEjzYK+M6BPneAiSmYo6ucBfBuMnWstpRWq5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2tNkdZL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2tNkdZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D356C43390;
	Mon, 26 Feb 2024 08:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708935489;
	bh=AsYKZHM4Vkh2vInRTD66a/lR6QtG8JnarTaSy0Wg31I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2tNkdZLxWQLLOGoDo0GURG0hXBrJq+jsvI42DxeiJd2kyQi0T2WriXP0twavBf9O
	 aZBHbupwkSNrQ5hHFrw0ytier/80yBHDczX/hiSwSQR9eSrt/ef0gMAaTjKbfLJaz7
	 o0GqdB4AuDPXIEJMKQeWh1Xf5FP4vWSvgUtoT0EKEX29VSTSvnDDaxtI9id2SsgxMz
	 5GG0EQbIiSqRbDR7Hr9KRJuvPazFCNa3SGly4JpUFZi9gYyMnrGlQj/fDh3hAK/Yo2
	 h74ZK6Ns5+xtJrJEU4fsHDayUvf7LnpJWSAd8TXb8dD2BktOhIYggmjHQQ/2je+KIs
	 rY5L4R39pemHw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 03/13] selftests: mptcp: connect: fix misaligned OK/FAIL
Date: Mon, 26 Feb 2024 16:17:48 +0800
Message-Id: <57d3e04f51798ad454f1f028cd9a59a5066f0a96.1708935196.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708935196.git.tanggeliang@kylinos.cn>
References: <cover.1708935196.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The first [ OK ] and [FAIL] in the output of mptcp_connect.sh misalign
with the others:

New MPTCP socket can be blocked via sysctl		[ OK ]
INFO: validating network environment with pings
INFO: Using loss of 0.85% delay 16 ms reorder 95% 70% with delay 4ms on
ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP	(duration   184ms) [ OK ]
ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP  	(duration    50ms) [ OK ]
ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP	(duration    55ms) [ OK ]

This patch fixes them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index ab3bb3b17522..72be905bab1f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -254,7 +254,7 @@ check_mptcp_disabled()
 
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
-		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[FAIL]"
+		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t\t   [FAIL]"
 		mptcp_lib_result_fail "net.mptcp.enabled sysctl is not 1 by default"
 		ret=1
 		return 1
@@ -267,13 +267,13 @@ check_mptcp_disabled()
 	mptcp_lib_ns_exit "${disabled_ns}"
 
 	if [ ${err} -eq 0 ]; then
-		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t[FAIL]"
+		echo -e "New MPTCP socket cannot be blocked via sysctl\t\t\t   [FAIL]"
 		mptcp_lib_result_fail "New MPTCP socket cannot be blocked via sysctl"
 		ret=1
 		return 1
 	fi
 
-	echo -e "New MPTCP socket can be blocked via sysctl\t\t[ OK ]"
+	echo -e "New MPTCP socket can be blocked via sysctl\t\t\t   [ OK ]"
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
 }
-- 
2.40.1

