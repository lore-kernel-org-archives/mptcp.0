Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538619ABD8
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 04:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438530; cv=none; b=ippVDieFtGPG81obWAjOKQuG1doNWyJTiF6W8ffEKWClQqKKnDS6hq8f0Rgq0yXlH6DeskIkmy20F5Y1sJz4o95V2XToYIITfE2CTsAr1Ns15s3f4qth0sAHjMoG9rg2+c/CvKOvLVPcA/MyV7wsv0sMQs99G3xfuGnO2dK6x50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438530; c=relaxed/simple;
	bh=P9vErjI21uPXYmIYih8k3QLX5Sscexp8nsNnagepxBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmZrobwnL5hQYg9/O28Sjk3JhQH9ErrT8pZPrj+XGlGzWaALmlaFIBPu9T/KVFtjeMJAqI/s7n+wOOao3N6gyYCFcPMzl0/s+Q7ZMldww14NAKIhUJDh/CnXxwj6ixMT8NJ4YSN6mik2jmhGTVFqXVQOTj3wQt47avucFADwfBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dto4deOL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dto4deOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78505C19422;
	Tue, 18 Nov 2025 04:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763438527;
	bh=P9vErjI21uPXYmIYih8k3QLX5Sscexp8nsNnagepxBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dto4deOLEBFnQX5liwNW0TLcfh/ddw5GhnEZH4TQ74zymdKJKfPQlpJJC8hoWo0Pu
	 WarbsYgKelDCSgW1FXoseT8kg5cBG7ilEeu/Yh9LdURGn8EZIVmk/jU+/rf9mJBkrN
	 BZRMho0jj0TLaxtjgZOzFh2WEPnA7TODjNiWrG7g4SKOmX8nEfNlq4aOz08m8XldqA
	 nPcXaUwim2wpIXg0qZnUnrEDSM7EhTRqYGlIgNpJvJ8VWsgPv4Eb9wD2de6vD87bmT
	 +zT8M/yEGMSlfqZ7e+ajJoY9zs+bUZwJH8uhzhX2Al/ID+2KYtYy4hTFrnhNUeVSXU
	 PpOVdLLLMO2Eg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next 10/10] selftests: mptcp: sockopt: add MPTCP TLS test cases
Date: Tue, 18 Nov 2025 12:01:31 +0800
Message-ID: <60f58a85a9f059a197633ddcbd7622a5ab09e2c8.1763438045.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763438045.git.tanggeliang@kylinos.cn>
References: <cover.1763438045.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Extend KTLS testing to cover MPTCP protocol by adding:
- MPTCP-specific TLS test scenarios for IPv4 and IPv6
- Adjustments to handle MPTCP-specific behavior in test validation
- Skip certain checks that don't apply to TLS-enabled connections

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c  |  5 ++++-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 8058b1fd5a35..96cba6df6a56 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -623,6 +623,9 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 
 static void do_getsockopts(struct so_state *s, int fd, size_t r, size_t w)
 {
+	if (tls)
+		return;
+
 	do_getsockopt_mptcp_info(s, fd, w);
 
 	do_getsockopt_tcp_info(s, fd, r, w);
@@ -730,7 +733,7 @@ static void process_one_client(int fd, int pipefd)
 
 	/* wait for hangup */
 	ret3 = read(fd, buf, 1);
-	if (ret3 != 0)
+	if (!tls && ret3 != 0)
 		xerror("expected EOF, got %lu", ret3);
 
 	do_getsockopts(&s, fd, ret, ret2);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 4d6ab4a63e3f..8840be8adea3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -382,6 +382,18 @@ do_tls_tests()
 	fi
 	do_tls_test -6 -c -t tcp -r tcp
 	lret=$?
+	if [ $lret -ne 0 ] ; then
+		return $lret
+	fi
+
+	# MPTCP KTLS
+	do_tls_test -c
+	lret=$?
+	if [ $lret -ne 0 ] ; then
+		return $lret
+	fi
+	do_tls_test -6 -c
+	lret=$?
 	return $lret
 }
 
-- 
2.51.0

