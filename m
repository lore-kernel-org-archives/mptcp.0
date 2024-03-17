Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BB37F6
	for <mptcp@lists.linux.dev>; Sun, 17 Mar 2024 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710637138; cv=none; b=PPu+mS6V5ESAKGaWpHdwCAcUz+/YU/Pm89JAjQHc8tyAZsFfUxU6L2PYwQmkqnHAukXKSHWXBPQuEqE3NJ9yteJMK9SVB6dcouSf8johk9sT+wuSuOpqK3U4nGhx2A5r2btv5nniq2xDDKaS/C7iJDwmMaYst+zX/WnzMnd2W/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710637138; c=relaxed/simple;
	bh=PKBKQyhuH/F5Bm6d+p3QrjZ9gl+xPCz19GrO2xvRaX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRlQ6iN6+qivBWkdwt4n+1ePwMNbCdAyTjfygh+r5d19zKmhK3RWiuJiKLYg7mrCVg0YDdyxEoS+EU8Yll6L+iIgEfbHWSkO5wK8N08j9Rf+1j+vIIRIEt6JU34yXSNMzuRwRSHJVYZFyZJxJ5OScPoOV6+gPuUKoad0BPvUQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8FIYwqu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8FIYwqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FB3C43390;
	Sun, 17 Mar 2024 00:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710637137;
	bh=PKBKQyhuH/F5Bm6d+p3QrjZ9gl+xPCz19GrO2xvRaX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q8FIYwquEaCQx5Os/1hicKS0sSn0N6JCm9qffUH9T1OJObTKslFqDe5ppl/3grOqg
	 CfqWm2P96aPWUMKEcLVY9UcVYXA55NkaXLUmU1cG/mIYbf2uih0oXSIo2NUPW1Jgjn
	 RxxgxkeunTdAuDsfs1opR/SSzf2Yij3Kyr3v/U++JYWnqPRBT4z7F8Q97GMUAVK3uR
	 ugaQiHmRlhd4qPn9V1YOcosNclHJ9JAAHy7dJm+KNuxDxQEpBsEpHqbQL7t5LWl1zx
	 pOk9sfEDF53Dor+IRPaU4WJ/bCIEow79Z1DmFEv15ctls+7Wolj3WrNcUuIV1oDscj
	 5u7FiFXQu+4wA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v3 01/12] selftests: mptcp: join: fix dev in check_endpoint
Date: Sun, 17 Mar 2024 08:58:00 +0800
Message-Id: <90aec2d19e5bc959eedbd8fe515bd6f3d81f7cb0.1710636726.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710636726.git.tanggeliang@kylinos.cn>
References: <cover.1710636726.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

There's a bug in pm_nl_check_endpoint(), 'dev' didn't be parsed correctly.
If calling it in the 2nd test of endpoint_tests() too, it fails with an
error like this:

 creation  [FAIL] expected '10.0.2.2 id 2 subflow dev dev' \
                     found '10.0.2.2 id 2 subflow dev ns2eth2'

The reason is '$2' should be set to 'dev', not '$1'. This patch fixes it.

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 70621cbbab09..73a2131e6da2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -729,7 +729,7 @@ pm_nl_check_endpoint()
 			[ -n "$_flags" ]; flags="flags $_flags"
 			shift
 		elif [ $1 = "dev" ]; then
-			[ -n "$2" ]; dev="dev $1"
+			[ -n "$2" ]; dev="dev $2"
 			shift
 		elif [ $1 = "id" ]; then
 			_id=$2
@@ -3610,6 +3610,8 @@ endpoint_tests()
 		local tests_pid=$!
 
 		wait_mpj $ns2
+		pm_nl_check_endpoint "creation" \
+			$ns2 10.0.2.2 id 2 flags subflow dev ns2eth2
 		chk_subflow_nr "before delete" 2
 		chk_mptcp_info subflows 1 subflows 1
 
-- 
2.40.1

