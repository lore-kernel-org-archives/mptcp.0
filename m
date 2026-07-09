Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698AD3DDDB8
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 07:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580827; cv=none; b=KZCcnsmv7/0VbHpExYatsDa4efYX3+C/Mve6+kusVWKomAIQgAzukzrzArtxhS940J5kwOgYVjVA/n7kQCZBI3EXxaQ2pxwHONOUxvRUUypeB1NeTyZjRoXRm816eVzVeh+Uql3mkBE5kwUL4TwCcJIoluocYR9PU7bTPdwNXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580827; c=relaxed/simple;
	bh=BdnTCPjlXR6bjdNAYKpaamtQgkfulfiTu1eHR3d1HQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cloxl1k8Q0+AguAGuKeze5mHkyG50Gg6s6Es0kg3Jg1uJLmkLbMdfrpkapN4k2Q7k5YvztuLM/e9V+YfaFtChc8B5Vad3MGoB3vzzrDYCHSnhI1ghvRO7Y2VwWVfTOOyfFwlvQR8No0ghnG7p1eLnIquNUlhlfvS5/EecTatSME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzATAZT5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzATAZT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F280C1F00A3D;
	Thu,  9 Jul 2026 07:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580825;
	bh=pHvnr71QJwENXLvoJedloCMOxpR9IVA+nEr8EXMaMG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PzATAZT59HvvqjEMo0U0KNgfYnclBKRKc3s2IuGpixvVXetUgML7sYCNHlzCAVWJu
	 oVfLyWojcsE0aDRAmTpsCpmVJ9et8bjNTh3+T9cHju5B3LDK4mXcGFyO4sEJGz/Fx5
	 M4/5CKgd3Zq2dsnTLTUV5mD/S1Rf9WD/x4fsPUgCYS06l9mdjWPJFqT5BFySfCWHd5
	 ZfaAclDtrFceT/5Z87Ez8Ktydg36a79JFwjvZ88URTbJ8SLIldVMy6rS6RuGISAkKq
	 SbJrm/iRS3bKJKyMOWOHsOUBDS40cdp9yeAgwDt23xGSOILRYVNjbA3Xpf1lpZ3jMj
	 rtY8CGpN5pZHA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 05/12] selftests: mptcp: sockopt: pass echo length over unixfd
Date: Thu,  9 Jul 2026 15:06:14 +0800
Message-ID: <9c55800b7800971f03600521d5841589452f5db2.1783579976.git.tanggeliang@kylinos.cn>
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

Pass 'len' from the server to the client over the unixfd control channel so
that the client knows the server's payload size in advance for the FIONREAD
loop and TCP_CM_INQ validation. Also keep the unixfd open for the second
write by moving 'close(unixfd)' to the end of connect_one_server().

These codes are from mptcp_inq.c.

Note: Additionally, silence a -Wstringop-overflow false positive by using
'len - total' as the read size, which lets GCC prove the destination is
large enough.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 6738ad45b9eb..15c9f8dbae47 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -619,10 +619,12 @@ static void connect_one_server(int fd, int unixfd)
 	/* un-block server */
 	ret = read(unixfd, buf2, 4);
 	assert(ret == 4);
-	close(unixfd);
 
 	assert(strncmp(buf2, "xmit", 4) == 0);
 
+	ret = write(unixfd, &len, sizeof(len));
+	assert(ret == (ssize_t)sizeof(len));
+
 	ret = write(fd, buf, len);
 	if (ret < 0)
 		die_perror("write");
@@ -632,7 +634,7 @@ static void connect_one_server(int fd, int unixfd)
 
 	total = 0;
 	do {
-		ret = read(fd, buf2 + total, sizeof(buf2) - total);
+		ret = read(fd, buf2 + total, len - total);
 		if (ret < 0)
 			die_perror("read");
 		if (ret == 0) {
@@ -659,12 +661,14 @@ static void connect_one_server(int fd, int unixfd)
 
 	assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
+	close(unixfd);
 }
 
 static void process_one_client(int fd, int unixfd)
 {
 	ssize_t ret, ret2, ret3;
 	struct so_state s;
+	size_t expect_len;
 	char buf[4096];
 
 	memset(&s, 0, sizeof(s));
@@ -673,6 +677,12 @@ static void process_one_client(int fd, int unixfd)
 	ret = write(unixfd, "xmit", 4);
 	assert(ret == 4);
 
+	ret = read(unixfd, &expect_len, sizeof(expect_len));
+	assert(ret == (ssize_t)sizeof(expect_len));
+
+	if (expect_len > sizeof(buf))
+		xerror("expect len %zu exceeds buffer size", expect_len);
+
 	ret = read(fd, buf, sizeof(buf));
 	if (ret < 0)
 		die_perror("read");
-- 
2.53.0

