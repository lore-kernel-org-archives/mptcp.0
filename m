Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B823366DC5
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284841; cv=none; b=kz1+rAzQfkMdPSXmg9aEp/0vUWtsCrIW9pVkt2QaCZdb8wAO6mkHS0z2W+H2LOETSXb+mcbYHijegbflAZE9Nd9h8uIS50nv1MBCri2/8vZRqnyb47SviXVa2qcw3EhoRENtj1NF9ihkvDuZF4vOrIZY50uy3nUYG7bY8DRD/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284841; c=relaxed/simple;
	bh=QgcOK8gHhJAwc8+O/5aTxT9bEGlRJLknDJedT9CwB/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeGIFX05hCRusmqKYFD7Jc6NN1Lrzkep1FR+O9kzreEXZjfd1WQX3C759AuZAhn+Kw2R65L7N6HGAyJX+mN7w+KZHu0xbmq3n8Q1r6zncAs/T4Kwg7Drsz4shIcrKz1TwtTs5WKmkpFq/6/ns3ZLE4+Ude8HtWrae405yMG+DeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6NgOFQL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6NgOFQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFB1C116C6;
	Tue, 13 Jan 2026 06:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768284841;
	bh=QgcOK8gHhJAwc8+O/5aTxT9bEGlRJLknDJedT9CwB/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6NgOFQLpgLVHa0NUavRCMog6cxI4Ow1RoApYbP8USnCHz6jK/sTPheotPpNN5UCz
	 nXx8RRYMUNIjFgagnnY8Wrp2qZ3LhZdyOyHBbXgLXkTsD6QavZcC9jPDLuedl8UoHK
	 oQrRlAyWl3MNjE0OYKyjznR0wLK+45mTO0hdRoB0Jp0jatuTqarvdD0qFgrKGfTcw+
	 KovvTNS6mk8VqqARlrBShuyrwBQpAK/4MUR5sUaafWp6/eN88AUyf/dyPAg4i7Rtd3
	 RHZ0BCI7LHhpMs4dbmojCGoTkzInegW1ROWCvXvLzyJKVKr3H3o+f+nIjxj0XZ1AZz
	 sFf+9CDaiZd2A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v7 9/9] selftests: mptcp: add mptcp tls tests
Date: Tue, 13 Jan 2026 14:13:35 +0800
Message-ID: <ad16ca0963760453ce1453c3fa98c7e94ec28aef.1768284047.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768284047.git.tanggeliang@kylinos.cn>
References: <cover.1768284047.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

With KTLS being implemented, "tls" should no longer be used in
sock_test_tcpulp(), it breaks mptcp_connect.sh tests. Another ULP
name, "smc", is set instead in this patch.

Update the last two TCP TLS tests to MPTCP TLS tests.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c        |  2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh  | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 6fb3c0bf879b..5d1dd7b66ed6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -324,7 +324,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 		if (ret == 0)
 			X("setsockopt");
 	} else if (proto == IPPROTO_MPTCP) {
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "smc");
 		if (ret != -1)
 			X("setsockopt");
 	}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6f8c6a03e760..883b079d8e33 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4323,28 +4323,28 @@ tls_tests()
 		chk_join_nr 0 0 0
 	fi
 
-	# multiple subflows, tls, TCP
-	if reset "multiple subflows, tls, TCP"; then
+	# multiple subflows, tls, MPTCP
+	if reset "multiple subflows, tls, MPTCP"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		test_linkfail=1024 tls=1 \
-			run_tests $ns1 $ns2 10.0.1.1 TCP TCP
-		chk_join_nr 0 0 0
+			run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 2 2 2
 	fi
 
-	# multiple subflows, signal, tls, TCP
-	if reset "multiple subflows, signal, tls, TCP"; then
+	# multiple subflows, signal, tls, MPTCP
+	if reset "multiple subflows, signal, tls, MPTCP"; then
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
 		test_linkfail=2048 tls=1 \
-			run_tests $ns1 $ns2 10.0.1.1 TCP TCP
-		chk_join_nr 0 0 0
-		chk_add_nr 0 0
+			run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 3 3 3
+		chk_add_nr 1 1
 	fi
 }
 
-- 
2.51.0

