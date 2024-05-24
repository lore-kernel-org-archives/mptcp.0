Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B412DD82
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563640; cv=none; b=LnJ6bdVJNERVXuZr3wncmQVkUxhsroAnq4t98QYZPxbJyeg0u++8aHeTJ6MO1/Kpr1x2uBv+aKnDFwDeO034BxNCoCyK/qSASOZrcVfCymNi+8psvL/jWj7gcHdJSOeM0sna8HYk3tvgH/FX6CxY3Ux122NcljocNzyEftLOL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563640; c=relaxed/simple;
	bh=CRkpD64FtxDqs5tvTLqLkgdEkfYYf7WaDTjqEk5a6Nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iM585TULAc/+J6CURuv8BiIS7Dnz82izzwENSifVLBU0GQxVx2QHyyN5ibigG7eRKjqjxUunO/SETa2hPcRq7s2rsmHiPfpZPip9wyzfcV1izfC1Tm2JOMU6LinqTJuaL7CA3/B8szGCe6YsMt7M+l/tsMip7UB2w9ilaURwh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caXEWwNH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caXEWwNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC28C32782;
	Fri, 24 May 2024 15:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716563640;
	bh=CRkpD64FtxDqs5tvTLqLkgdEkfYYf7WaDTjqEk5a6Nw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=caXEWwNHJh/4oDYc5b4TSqX+P3fj6jy4UXxyTUHp0HABxEa4TyY7F44gghEOls9DA
	 Ex/AWeIcu2v12V58TNu7GeXX5KJKBGjUtfNu8k987srXZOEpn4Suzmk6psUTCL13tF
	 7yknj42IZIyqhPT8MPW3gr6AoeH1jp7XHg36LiZ4eAWZEhf/c7sPsENv8vLykl8iSZ
	 0n9f+/xaZ7nFbMDkHCPmwOny0UR1NrjDUXxJdiryNG64nFafuaqjy2t7oQtr51lonH
	 5/x1FCS/RXaujacR3FMMB2PoOh3P0/YL6imNW93lTW0Id8EOkUErdKpg+aN1gz6y+z
	 S4i12ToGAs4Vg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 May 2024 17:13:26 +0200
Subject: [PATCH mptcp-next v5 3/9] selftests: net: lib: avoid error
 removing empty netns name
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-selftests-net-lib-fixes-v5-3-b9e0968571a3@kernel.org>
References: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
In-Reply-To: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CRkpD64FtxDqs5tvTLqLkgdEkfYYf7WaDTjqEk5a6Nw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUK6zdxo8gSy7+iBEVLTcvDr4L41Goc/9xLA1i
 ffJdGl92XOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlCuswAKCRD2t4JPQmmg
 cxWLEADvt4Urnf7gFuqZBUjV5bWpuy4dbZNJBnFrFVPEb3Cmyo3eCc/pcn9J1H+SKxrKzhPwtsB
 m8cFyGFCcVp3J17RwdqsMUeh476lCBwuMb/MK+4vE8CRr+VE681ohZ20sg7obSsVkyxR1gsTD2Z
 PekbLmpXgqVcLwxzdu8aJ3jPgRn/14005LH2GKU8Ja+/RXI3as0hp+hoJ8xX6oYb5IJD3Kz8F5D
 3RLITpx+3O9ga0w2dW+08AE+gwM8Ghh3g4Ps/c7B+8MxB8QsEbFasxVf/GVRxfR2sXX2rTH9xsu
 CRGj9gQtyi31s+QKS/XGNsu2Ysf5PzrdPijk4Z3PCy66e8AkCt+/KcgCBl7B5a0jcQr5tB74Ltd
 ZuyLHKNqNqUwKyB8NEO1RdyjIcoY2W0QJ04izewOePnDOevgSiIGkT3ZbQj8YHTmAGMz5VzbxyD
 9CZf0B8LyR/RquwPECuaSZFsQn4PjBi4ZPpbXa+yTA/4HI7ASCgVpSuXS3Ckt7b/djLbJDpVhuY
 YLRPALcZ/WLfNwWudWzfbV9fZaV9Al0rDo6IZh+MjUFch/Ps5AFuPWPZ2JqnjYFNq2cwedf0pcW
 gpSnJF85Jf81R0462p8x9dIoy4hObe7rJP0FU44bky+UBTYTx/ONad1Ypl7Z3BCT/JAl0vQRaws
 4za2jKQulMH7Jrg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If there is an error to create the first netns with 'setup_ns()',
'cleanup_ns()' will be called with an empty string as first parameter.

The consequences is that 'cleanup_ns()' will try to delete an invalid
netns, and wait 20 seconds if the netns list is empty.

Instead of just checking if the name is not empty, convert the string
separated by spaces to an array. Manipulating the array is cleaner, and
calling 'cleanup_ns()' with an empty array will be a no-op.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 2fbc01003b0f..9155c914c064 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -15,7 +15,7 @@ ksft_xfail=2
 ksft_skip=4
 
 # namespace list created by setup_ns
-NS_LIST=""
+NS_LIST=()
 
 ##############################################################################
 # Helpers
@@ -138,6 +138,7 @@ cleanup_ns()
 	fi
 
 	for ns in "$@"; do
+		[ -z "${ns}" ] && continue
 		ip netns delete "${ns}" &> /dev/null
 		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
 			echo "Warn: Failed to remove namespace $ns"
@@ -151,7 +152,7 @@ cleanup_ns()
 
 cleanup_all_ns()
 {
-	cleanup_ns $NS_LIST
+	cleanup_ns "${NS_LIST[@]}"
 }
 
 # setup netns with given names as prefix. e.g
@@ -160,7 +161,7 @@ setup_ns()
 {
 	local ns=""
 	local ns_name=""
-	local ns_list=""
+	local ns_list=()
 	local ns_exist=
 	for ns_name in "$@"; do
 		# Some test may setup/remove same netns multi times
@@ -176,13 +177,13 @@ setup_ns()
 
 		if ! ip netns add "$ns"; then
 			echo "Failed to create namespace $ns_name"
-			cleanup_ns "$ns_list"
+			cleanup_ns "${ns_list[@]}"
 			return $ksft_skip
 		fi
 		ip -n "$ns" link set lo up
-		! $ns_exist && ns_list="$ns_list $ns"
+		! $ns_exist && ns_list+=("$ns")
 	done
-	NS_LIST="$NS_LIST $ns_list"
+	NS_LIST+=("${ns_list[@]}")
 }
 
 tc_rule_stats_get()

-- 
2.43.0

