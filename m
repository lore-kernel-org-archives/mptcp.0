Received: from mta0.migadu.com (out-69.mta0.migadu.com [91.218.175.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9643BFE50
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716972; cv=none; b=CcC6Jy6EDUzp3Sls7b9IARqjmbwEG8TnrzSuCrXaXVzwEJH9v51upgeb7nZbu0vMcfaFiT07VFx5LYE8Lt26cEjC4TVYqm/A6KZEpaAd4Gwh2BnVqxrvKFxvM5efYjBagjGJrWCo/8m8pXCtSh5fSs9Q266vggxwc6QWQZtDV/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716972; c=relaxed/simple;
	bh=UAGdCuQRUNYTmz8p/J9/HTQcXYdW2EeNXSXkahTq3to=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnpUpTbVLL0RAg1gYKxrsKlEF7Pb6wK/l1h1f9mhu/rmyidr1rvHhEeDv38RKTyZlZ/5gXrWAIFYzenbg2ho1dbNDj2QM25Nq2rFBqm0k9ZYkXLR7lGXYv0Fz5sCeDr1q0+ehTxFHu+6C9rJv6kD1Tnmbf7Sbd9OH9NoxgKFcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gd8r885M; arc=none smtp.client-ip=91.218.175.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gd8r885M"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=UAGdCuQRUNYTmz8p/J9/HTQcXYdW2EeNXSXkahTq3to=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786716958; v=1; x=1787321758;
 b=Gd8r885M2gZGXvYZ6kPlP9epdca/5Z+QToGvpT1QKssTeUhdHxltEislIQMrGlvVEruTEs40
 rzeszSdtaQkHDoIMWKP97FkQKhx92quxTTwx10EXSsfRcZbuN8ykXH6jkUazbDiRkhc9vtqzaWS
 v36l79OrBqXKXAkUVBYphWUM=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (120.244.49.214)
	by smtp.migadu.com with ESMTPS id 9a1eeb0d806fa9f8;
	Fri, 14 Aug 2026 14:15:58 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net v2] selftests: mptcp: fix an UAF in mptcp_connect.c
Date: Fri, 14 Aug 2026 22:15:30 +0800
Message-ID: <20260814141530.102099-1-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

At the end of 'sock_connect_mptcp()', it calls 'freeaddrinfo(addr)',
the 'peer' pointer (which points into 'addr') remains. Later, the main
loop uses this peer pointer for reconnection attempts. If the memory has
been freed and reused, the address data could be overwritten, resulting
in an invalid remote address.

This patch keeps the addrinfo list allocated for the whole process
lifetime so "peer" remains valid across reconnects; the memory will be
released at exit() time.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
Changelog:
v2:
  - make fix as paolo suggested, and using AI to simplify the comment.
v1:
  Link: https://patchwork.kernel.org/project/mptcp/patch/20260814050625.80231-1-gang.yan@linux.dev/

---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ea4cb6c1bd5e..178d98d91fea 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -381,6 +381,9 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 
 	hints.ai_family = pf;
 
+	/* Keep the resolved address alive for the whole execution: it is
+	 * used again when reconnecting, and will be released at exit time.
+	 */
 	xgetaddrinfo(remoteaddr, port, &hints, &addr);
 	for (a = addr; a; a = a->ai_next) {
 		sock = socket(a->ai_family, a->ai_socktype, proto);
@@ -421,7 +424,6 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 		sock = -1;
 	}
 
-	freeaddrinfo(addr);
 	if (sock != -1)
 		SOCK_TEST_TCPULP(sock, proto);
 	return sock;
-- 
2.43.0

