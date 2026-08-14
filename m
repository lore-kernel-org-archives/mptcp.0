Received: from mta1.migadu.com (out-27.mta1.migadu.com [95.215.58.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433B18FDDE
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 05:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786683997; cv=none; b=G8sBnxIw0ic2B2k+SOPYasroFWzumXT65Qnk1GNkuxXMLhIY+49O6Guz1loqCD5Pu2SX4rvXmxrBb0PAvyPzQd8a4fcCTh8MDhbdlHUXtOHx+TSf8TgdNkGlipaM4hzfw7+bXeOihM2oIogaoGiuz7XfI1Cdi14XZcH49RCDT0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786683997; c=relaxed/simple;
	bh=Sdu5Yt8DiJRtT5p+rS8VMOI8mXNXrCreT3vaZD6/Tps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dAp5fI0bwR+sr5xBS3YeCgMs7InVEycwWDvjM+1PQi1OkKQNFyGLl3pQ/XtbTGDpO4GUXb8p4y0/yqgoL58aSyQdbh1SGRnqJ3VLRuhnS6KVJctcy6d+8Hsi5UFY6KHpKLS01tutKSl2dReV6MprDZfoDXR0jaRD77KhHzdLqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qlW4vI2u; arc=none smtp.client-ip=95.215.58.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qlW4vI2u"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Sdu5Yt8DiJRtT5p+rS8VMOI8mXNXrCreT3vaZD6/Tps=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786683992; v=1; x=1787288792;
 b=qlW4vI2ubMkb07YH6Ey+KVqhj9r2YN9k8ds4F8fvFTMWbY7RxPg/FXGy8Ru43kFSbeirkwG9
 LlAmTFgWG74c/H6vNWWu7ZqbeLuElgYPvMmOjRRG7PM89h9Nhg2BhJlJikFAtr5x76oVjHD2WlU
 AbvsS1LUOVFhOGhgNL+jrKWo=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.160.239)
	by smtp.migadu.com with ESMTPS id 650afce5065ef3b9;
	Fri, 14 Aug 2026 05:06:32 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net] selftests: mptcp: fix an UAF in mptcp_connect.c
Date: Fri, 14 Aug 2026 13:06:25 +0800
Message-ID: <20260814050625.80231-1-gang.yan@linux.dev>
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

This patch removes the '**peer' out-parameter entirely and adds a
sock_reconnect() helper that resolves the address and connects in a
self-contained scope, so no pointer to freed memory escapes.
Also prints the reconnect destination address on stderr as suggested by
Paolo.

Assisted-by: Codex:GLM5.2
Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ea4cb6c1bd5e..9c083038c400 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -368,7 +368,6 @@ static int sock_listen_mptcp(const char * const listenaddr,
 
 static int sock_connect_mptcp(const char * const remoteaddr,
 			      const char * const port, int proto,
-			      struct addrinfo **peer,
 			      int infd, struct wstate *winfo)
 {
 	struct addrinfo hints = {
@@ -404,13 +403,11 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			if (syn_copied >= 0) {
 				winfo->off = syn_copied;
 				winfo->len -= syn_copied;
-				*peer = a;
 				break; /* success */
 			}
 			perror("sendto()");
 		} else {
 			if (connect(sock, a->ai_addr, a->ai_addrlen) == 0) {
-				*peer = a;
 				break; /* success */
 			}
 			perror("connect()");
@@ -427,6 +424,22 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 	return sock;
 }
 
+static int sock_reconnect(const char *host, const char *port, int fd)
+{
+	struct addrinfo hints = {
+		.ai_socktype = SOCK_STREAM,
+		.ai_family = pf,
+	};
+	struct addrinfo *addr;
+	int ret;
+
+	xgetaddrinfo(host, port, &hints, &addr);
+	ret = connect(fd, addr->ai_addr, addr->ai_addrlen);
+	freeaddrinfo(addr);
+
+	return ret;
+}
+
 static size_t do_rnd_write(const int fd, char *buf, const size_t len)
 {
 	static bool first = true;
@@ -1367,7 +1380,6 @@ void xdisconnect(int fd)
 
 int main_loop(void)
 {
-	struct addrinfo *peer = NULL;
 	int fd = 0, ret, fd_in = 0;
 	struct wstate winfo;
 
@@ -1378,7 +1390,7 @@ int main_loop(void)
 	}
 
 	memset(&winfo, 0, sizeof(winfo));
-	fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer, fd_in, &winfo);
+	fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, fd_in, &winfo);
 	if (fd < 0)
 		return 2;
 
@@ -1413,7 +1425,8 @@ int main_loop(void)
 		 * connect to be blocking
 		 */
 		set_nonblock(fd, false);
-		if (connect(fd, peer->ai_addr, peer->ai_addrlen))
+		fprintf(stderr, "reconnecting to %s:%s\n", cfg_host, cfg_port);
+		if (sock_reconnect(cfg_host, cfg_port, fd))
 			xerror("can't reconnect: %d", errno);
 		if (cfg_input)
 			close(fd_in);
-- 
2.43.0

