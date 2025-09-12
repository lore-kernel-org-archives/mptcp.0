Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437F3126C0
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686856; cv=none; b=Ov93MxPrDEbXeOamXrH3SSiFlcz3uaceywPiUgdwVpEtPRNbpl7t1iokdK3w4nrunqg7zgcCm8PyyiEcfw0yTIoh1nZHu2OQ/Z+QPyb0WBs2YinuQYbl73MBESVUzAtjW6Fl5BT9HtG50awYTx2wXQ4hYykux12O/Fic+3SuN4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686856; c=relaxed/simple;
	bh=au+xRsOdcCORZSmkzgY3n1jdn4NKfNqrnuDb3mbtBNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s97bBh+mfNtalJXZyFAkeyGApLMDJx2JrkSecENaotTYWsNu/ROyCE6J8akQyD1F0QFnAP6zdVrSdxvn98Dvpe5hdzbF7g7C/L9z9DDaM4XUryfS9o7gohL99u22UL0r4hal7udyIYQZdsEQ0rW00GoENZnN8NFXbfEN+QjZfVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWkLw+Ar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWkLw+Ar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C783BC4CEF1;
	Fri, 12 Sep 2025 14:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757686854;
	bh=au+xRsOdcCORZSmkzgY3n1jdn4NKfNqrnuDb3mbtBNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XWkLw+Ar3YfQiMxtp3IoyJQSkmvt70ZfR/uUwlp5hlW+S26ShPa2foMr5EeeRSSCz
	 134giomfV8EqykNNh38YNdNx+STF0y0e44BrLqj4TghYyxXURCznO4KyEStPLsNitD
	 SFjjP6wqjB/vsaEt5LCtpSkZdgnuP/aiVQUz1IZHU/B3P+b2Ng50iInpeVMm5BUMtp
	 0BD/vXrV6dRn2wqzHuqSOFTtE63yPxgISuQGPuvMZS+4ho1Gd+NB8GH/nM5BrpjxFr
	 gGzG/7EaguGzm0R1EX4Mow1VgNDbh5e9M72L3s34RWpeGUJbAy1tOl2isGUOqKeSeI
	 o3yloksgF93lw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 8/9] selftests: mptcp: sockopt: replace mptcp_inq with sockopt
Date: Fri, 12 Sep 2025 22:19:55 +0800
Message-ID: <314b9dc0ce40664b06b1c12f796528482b830d1e.1757686538.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757686538.git.tanggeliang@kylinos.cn>
References: <cover.1757686538.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch updates mptcp_sockopt.sh to use mptcp_sockopt binary instead
of mptcp_inq. This consolidates TCP_INQ testing into a single test binary
while maintaining equivalent test coverage.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index f01989be6e9b..14c18692065a 100755
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

