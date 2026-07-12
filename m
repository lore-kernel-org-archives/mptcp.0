Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55916373BEE
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783850103; cv=none; b=NG7W8yLw954zs1RY2jciQHeFjnHIQozBYpXKtiurw3bvdWoO4p4Atxh8mRd4qaMdtrndT2MdnUlgl3arm/A7jr03vD2JgzTecvqEq92c5e1X97n6hbl45ILReIpt+72VeTjJwWWzs+qzjm98myd00k/4jaBkHrL35qHN1ZbJhfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783850103; c=relaxed/simple;
	bh=/RrrCrRv8+e84cE1JmIKiobD2c8QFIDMJqwPH93BwIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhg1W6sTunAk4tztb2cGB3o3XP4j5XEcnp0MmjyiSLCKtB36zoEVq+ibYquqig5vYvL1l4sEgfXle0rJQvD6400qfhXLk/jswBlrT/EoSAyOaN9qqZtCDAcmZ1QoKlo88mNWtXGLTRAtOrF+9VxYpzly/CbQQOPpYkf21wzsiZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL+SDG5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL+SDG5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4123C1F000E9;
	Sun, 12 Jul 2026 09:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783850101;
	bh=Q/s0UPbkn5SRhC2cwk0HTX4ntEsHsEoSFmTicKFg9Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QL+SDG5OWKfuSUo+pFC5nLyiWeqi0scp8/QwX2E/2lauxZerVuePT9ax7get1K2QR
	 0uLltXiUh+ESNe1AtGHIXe9r6ApArKSIcYv0Eh4ukxMVkZgFRDU8iLGte5Bf5UJP68
	 wpu5bo7IHREwpBpKaUsiU8chX19P7XRmlovY2flKV1onTxIQgakVLIut9X5iFNQCnI
	 CeEur8fGS9JUHzdeqvJRSQkOy9QOycQ+rEcIaCAlD6hIPLrnS8OhQIst/jf5LUOWE6
	 LXG8Xc4Oo5eiJ5lPM4riQjK/aLe8nlft57rF4KwkiR8So1zg2mW2kaAaAPOuV7Of68
	 OBH3iYUYmbegw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 09/15] selftests: mptcp: sockopt: pass echo length over unixfd
Date: Sun, 12 Jul 2026 17:54:15 +0800
Message-ID: <bbf92a00eba167df9fe69f037f019fdffafcd66c.1783849522.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783849522.git.tanggeliang@kylinos.cn>
References: <cover.1783849522.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Pass the payload length ('len') from the client to the server via the
unixfd control channel. This allows the server to know the exact amount
of data to expect, enabling precise FIONREAD loop and later TCP_CM_INQ
validation.

Also keep the unixfd open for the second write by moving 'close(unixfd)'
to the end of connect_one_server(), so that the same control channel
remains available for subsequent huge data transfer tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index e717dddc6734..610e3af040c3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -625,10 +625,12 @@ static void connect_one_server(int fd, int unixfd)
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
@@ -666,12 +668,14 @@ static void connect_one_server(int fd, int unixfd)
 	if (proto_tx == IPPROTO_MPTCP && proto_rx == IPPROTO_MPTCP)
 		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
+	close(unixfd);
 }
 
 static void process_one_client(int fd, int unixfd)
 {
 	ssize_t ret, r, w;
 	struct so_state s;
+	size_t expect_len;
 	char buf[4096];
 
 	memset(&s, 0, sizeof(s));
@@ -680,6 +684,12 @@ static void process_one_client(int fd, int unixfd)
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

