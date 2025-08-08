Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74E227FD5A
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664233; cv=none; b=MoDPaYz0z1wWEH+6/idwiFj+lgFuvV4qiknevxWkahLqm2A/krZh2WRio+O6N0VKnpncr8nSWB0g/mjTzT2jf0gm2sBn/+GiNgDOCFJarWVoY1Vt+PMCyez7iV9RMDeuGvNroZI3PRGMFoTkxzO9IYUocnG+rcPv4v1FLiDzorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664233; c=relaxed/simple;
	bh=jOTyncc6EWjzQ0xyqefGzIOH93ZK4g0LxFYw2/qVbWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFPEcuFABvgo9ZnVK7pi9WMkrIXgoOLsr2f7e5xgPrRvyxxtYhrUtv6fxbrDJkm0aKrGCHfWCbdPnOOYCNCgcpySiuJeHp0E3oksyYS67MDxOIqKzzX8xioAd9l5AqkQDua6FoqKidItpJBr+v9zntWaPh2GDn4r6bJMysHR4Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2olaz6q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2olaz6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8999C4CEED;
	Fri,  8 Aug 2025 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754664233;
	bh=jOTyncc6EWjzQ0xyqefGzIOH93ZK4g0LxFYw2/qVbWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2olaz6qfGogflfFvCFDwGFGIqE5nyqlxTy0tTGrpJE9jUcDTjebBtFAvYQrR3Ruk
	 baEwyAK3zRQe5HoGcNE6ZVrMzpLpwxvBgx4BprgaZxcRpevHwkqoSc8xxGE/u/+ykU
	 lV0dvczpCQas6UiwmzGoCSunAF7Oo2eazfZK8vyeQ6MOKdBf0HMsZ1eoUav5kKa4/G
	 iNZhrZ9IdBlpfqcKqtmX4zOu/qx9BGZ3fOOVQtX99YrLgAMCJiTYOhEYQA/p68hqaA
	 gtGtAvshoedvwP2cqVLd+6SehCnK+iCS8jxDm9rqKWU7NAFxd5z/lwnWe88xmVlP0I
	 Cba/AN50er1hA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 8/9] selftests: mptcp: sockopt: replace mptcp_inq with sockopt
Date: Fri,  8 Aug 2025 22:42:53 +0800
Message-ID: <a6c3a55cfc9fb5934f94eaa565fd84c4a83b5573.1754664106.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754664106.git.tanggeliang@kylinos.cn>
References: <cover.1754664106.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update mptcp_sockopt.sh to use mptcp_sockopt binary instead of
mptcp_inq. This consolidates TCP_INQ testing into a single test binary
while maintaining equivalent test coverage.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 418a903c3a4d..41201c5fa6af 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -305,7 +305,7 @@ run_tests()
 do_tcpinq_test()
 {
 	print_title "TCP_INQ cmsg/ioctl $*"
-	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
+	ip netns exec "$ns_sbox" ./mptcp_sockopt "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
@@ -330,7 +330,7 @@ do_tcpinq_tests()
 	fi
 
 	local args
-	for args in "-t tcp" "-r tcp"; do
+	for args in "-t tcp -i" "-r tcp -i"; do
 		do_tcpinq_test $args
 		lret=$?
 		if [ $lret -ne 0 ] ; then
@@ -343,7 +343,7 @@ do_tcpinq_tests()
 		fi
 	done
 
-	do_tcpinq_test -r tcp -t tcp
+	do_tcpinq_test -r tcp -t tcp -i
 
 	return $?
 }
-- 
2.48.1

