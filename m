Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4B21BC23
	for <mptcp@lists.linux.dev>; Fri, 15 Mar 2024 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710499465; cv=none; b=n12Nt9pdBTEvQeEF7p+iYGMQTbbOfZs3TWnG17NgMq3TQwuz9+rrsPWBJJyQ4CqrLpaMxZpExHUQuOjUHtzi/me+LDqVpwzK1lAHmRVV8bW2Q8zro5vmVxpK4mUa2eQzAm7uuOXBqOONZXtzSmbXVdVkPmEC0HHt1LRjGq6Mdn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710499465; c=relaxed/simple;
	bh=PKBKQyhuH/F5Bm6d+p3QrjZ9gl+xPCz19GrO2xvRaX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ge6WgElXvLBvnajOuGC/ALmM54LwDQIToWWsY0ir9sK+8fWsqnlhp4yYeGLF0Rrd8+zXBihBXTbOCa5+PVh4HRFXw03uqFQCkj1+t0tsU4tMCiyTvbutJWcIDKHNczY5M/e5KMrkEabY2Xsu1bxNP0hj46S9qt9tonZGAv3ytoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1cGFcQz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1cGFcQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E479AC433C7;
	Fri, 15 Mar 2024 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710499465;
	bh=PKBKQyhuH/F5Bm6d+p3QrjZ9gl+xPCz19GrO2xvRaX4=;
	h=From:To:Cc:Subject:Date:From;
	b=r1cGFcQzQGxCqjk/ax/qpFB53Ipz+4QlQ6eQf4UIH6xTSlEJYYeLo66vF2tMtA1Vr
	 2uf5yIT/foRwE1ohoRAvqCJGzQIKF2ngW2EaWFKdaeQXCHoUDoWx3vv8C6UWMdBBnB
	 3+6QpTbIWIb28K004jgVmOGPJk9QyRq5KglDJujYHKWR3P6YfztGGd89jtxfMhOmYG
	 U3ZKb5Ky3fsWwWljlOq7nHtTsoP/7o8JZVFIFLJI7qwWPYUxfIi6N+/qfo4YsCkOqi
	 5fKAVWN3x0acFroXxA3GhsJ0BRok8QpQBiD2DQjePMQt/1cpKcwtKwH6H2Qmze/N+s
	 K8fAHcBY5ysbw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net] selftests: mptcp: join: fix dev in check_endpoint
Date: Fri, 15 Mar 2024 18:44:19 +0800
Message-Id: <c2b0609aa21bef01ea1191dec3c127612cff3ebc.1710499440.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
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

