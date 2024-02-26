Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282A605C2
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940615; cv=none; b=LZwgDFKs9YeqAu+G5Tn66C0rgVp/6CHS/0m9Bl3SRrMn7GFGgUnv/Czqk0SOF02E+PM3/5/IZ2FateWF+Q0CMveRNhRsj3lANUDMZeqb63O7BrMSEKjnncuX5cAxGX1TiS2Mm/WHbe6rsLZ/Tv/LrQmy6YqniClwBw316DahKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940615; c=relaxed/simple;
	bh=AsYKZHM4Vkh2vInRTD66a/lR6QtG8JnarTaSy0Wg31I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A2VFlgxFAwCwM4suuHEj4NUeS/fQSCL9dvoSA6tY9h8cX2lTyTNmbnE6hlDP1P8Dw3i2FBLYcfvUq5z3ntnzB7UYzwQc+Aet3O/BMa65WtXOqH91V+7CTlzyyn9y4irG76bpu5VCvUzNl3xvdY8ericf3Gs1AIVa/wftLVb54QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feVlHapB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feVlHapB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B70C433C7;
	Mon, 26 Feb 2024 09:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708940614;
	bh=AsYKZHM4Vkh2vInRTD66a/lR6QtG8JnarTaSy0Wg31I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=feVlHapBakTfTxNOf3S3NIizR3Svwuu2Ebjq7/wdhilYkycmvhujzmxBJJrxEqVxd
	 nv5AfzjsSBbk6AbbD5kLm+gsk682eUHmOGQk5Ww2QP+zzM5G0otJhixyMemLNL9dAD
	 Iis+K9XGGYsJGOcI/AKtF8XZlubHk4YEhgYwmcWoQIlD/WRfAtmldbCzH8qSqUV0it
	 UzvSgoz+3qJzuHHTEX3LbUd4eOYSwUkcgVhLOkphFDFX8rCcR13cdbuagmPtHjLQ7d
	 v4tsQWRvAGVrUTUS7t17eJPJIkvLKpyhvUw8c1u5FiqtsJBWBVsVPA8atIyfMV8LWC
	 tlFQLlYGkBWKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 03/12] selftests: mptcp: connect: fix misaligned OK/FAIL
Date: Mon, 26 Feb 2024 17:43:14 +0800
Message-Id: <57d3e04f51798ad454f1f028cd9a59a5066f0a96.1708939962.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708939962.git.tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
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

