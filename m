Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163E835C188
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580838; cv=none; b=u7U0nfGfDdCX74a/CbG44N0xDu5aMBd6B6tX32di5/ob4Pei/Lj5u7s1wtEXQ4Y7tX1srG1/u+WCsp/Um2kr+OucrEFfQv+aXSq3Db+ZSIGP+ayeSza8Y8s7sYKWjdbCogJeXD75W1Zog0HJUnS5Q84AEnQQdY9WkBHcbgvOEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580838; c=relaxed/simple;
	bh=dkswvKAJgsFlLMS6lsBQBdAZ4JCDJw4TKohPfNsvdZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqdfJYIeWfbZvCbZuhkqA5tHrmaMhQsJEQKan4tL7O9372JBG1YUggSuDkqZaut5Fy4bXlZQ44vU1vd4t4GjPUQcnWXVPiLsu3j4y8L5JA8VEqoBchosxmAO5KgSnXm7jRXNJVArEX3toDQ7HV24m8IATJQ7HFm6NnAxmChUbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5lW1E3y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5lW1E3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717041F00A3A;
	Thu,  9 Jul 2026 07:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580836;
	bh=rQTSREqO3gUx94N6Vmsnt/A16wDKySyE0U+0g66ryk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d5lW1E3yqXgxmzo/8ZpvtbQ9/CTAuSBZ/DVaVh5LQZPH2AFIyOpIdPFaIxxdkA9QX
	 CSrUkHKcDLU2OkKT4RQNDYOZ46NGOWOifwYBNSaUzzi8+GxzeFGgN9T8N25VzTveLW
	 pXMWZMGFSJVa4oa3mYwBPXHyunS8cVmx+0WvsFcaNSG57iFY7Kc0Nu5bdP/oDxUviT
	 UHyZgUQmIbCIiZucm5BdYJ3m6D/qlQX35X7zFDuBByP8ayklG/ZO9d9xjlf3t6irlx
	 Rpi41oaIa7LrJBPLuNhClfh3lk67kYmuMruXp2yBrGBfj1dGq4Mj2xBeSq0eU1kRP5
	 ph73Gf0F0BECA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 11/12] selftests: mptcp: sockopt: replace mptcp_inq with sockopt
Date: Thu,  9 Jul 2026 15:06:20 +0800
Message-ID: <a7f06226f2defe955159bd4ebf1b5a307dc61824.1783579976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783579976.git.tanggeliang@kylinos.cn>
References: <cover.1783579976.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index e850a87429b6..a39265555438 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -308,7 +308,7 @@ run_tests()
 do_tcpinq_test()
 {
 	print_title "TCP_INQ cmsg/ioctl $*"
-	ip netns exec "$ns_sbox" ./mptcp_inq "$@"
+	ip netns exec "$ns_sbox" ./mptcp_sockopt "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
 		ret=$lret
@@ -334,19 +334,19 @@ do_tcpinq_tests()
 
 	local args
 	for args in "-t tcp" "-r tcp"; do
-		do_tcpinq_test $args
+		do_tcpinq_test $args -i
 		lret=$?
 		if [ $lret -ne 0 ] ; then
 			return $lret
 		fi
-		do_tcpinq_test -6 $args
+		do_tcpinq_test -6 $args -i
 		lret=$?
 		if [ $lret -ne 0 ] ; then
 			return $lret
 		fi
 	done
 
-	do_tcpinq_test -r tcp -t tcp
+	do_tcpinq_test -r tcp -t tcp -i
 
 	return $?
 }
-- 
2.53.0

