Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3EE84A35
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273731; cv=none; b=msJeWOwBUy3z1qZl14FHX1AjSXzC0ObTXMNwRnGy2ZKfnEq4v52lf7b9SxPHPZkwIDHGjrmmZQBHpXvTB31nvPuDf8FO7TiNTtTQ+xb+jvUd2Ec3g01KA1amWCcjYaTNuVCyTHaB7ZSVb8zkXACcExjUjNLe1QwvSKdghmw0SIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273731; c=relaxed/simple;
	bh=kl/TABK7TfITOkH1sVxyz/2Q4PJ1vcVpiKgGe/AZCfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXbtZup4jERYnaiPSnHuW29UddeSWer6ztJarnVnIb6u+BteZt4EwYJ7WSXN12kuNaJsE41iS4+EFqN0l9p1BKy0wJ/eEA2CScx7Vd20GjdbdmfrUtkZMK9snUtFLbyhxtoR4Sd9nYvqSwWh2oGH0/7oWrndO7rOtUkQd6MGsSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ElH8QXzI; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ElH8QXzI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770273728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVFEWIU/iyFnjtryoljgas1wdQL9lNlyk46ofJwNPyY=;
	b=ElH8QXzI+QnTVukWSSgJLJymx+pppKu9S+/i4puhyPocZI2YaGbkWB2TG0e/lBEVjjPdAh
	YE5AbYF6nfSydvv39uaVIW9LFQAb89EKpcq+Ji9pVbS52BzDwNTf/spdxVhngZBs/AUWLi
	iulQQaraRSSW60du8dwHLr3VqLCQYoA=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [Patch mptcp-net 1/3] mptcp: add backlog_list bug reproducer test
Date: Thu,  5 Feb 2026 14:41:29 +0800
Message-ID: <500a8fe690cb8718ea32c33ae8cdcb2df203ecd0.1770273341.git.yangang@kylinos.cn>
In-Reply-To: <cover.1770273341.git.yangang@kylinos.cn>
References: <cover.1770273341.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

This patch introduces a test program to reproduce bugs related to the
backlog_list in MPTCP. The test is derived from tls.c in the selftests
suite, but adapted to work without TLS configuration specifically for
MPTCP testing.

The program performs chunked sendfile operations with various payload
sizes to exercise different code paths and trigger backlog_list-related
issues.

It can be run in .virtme-exec-run:
        run_loop run_selftest_one ./multi_chunk.sh

'''
selftest Test: ./multi_chunk.sh
TAP version 13
1..1
[stalls for a while]
^C

'''

Co-developed-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 .../testing/selftests/net/mptcp/multi_chunk.c | 148 ++++++++++++++++++
 .../selftests/net/mptcp/multi_chunk.sh        |  37 +++++
 3 files changed, 186 insertions(+)
 create mode 100644 tools/testing/selftests/net/mptcp/multi_chunk.c
 create mode 100755 tools/testing/selftests/net/mptcp/multi_chunk.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 22ba0da2adb8..087e6ae6f0b8 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -24,6 +24,7 @@ TEST_GEN_FILES := \
 	mptcp_diag \
 	mptcp_inq \
 	mptcp_sockopt \
+	multi_chunk \
 	pm_nl_ctl \
 # end of TEST_GEN_FILES
 
diff --git a/tools/testing/selftests/net/mptcp/multi_chunk.c b/tools/testing/selftests/net/mptcp/multi_chunk.c
new file mode 100644
index 000000000000..8c97db58a6db
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/multi_chunk.c
@@ -0,0 +1,148 @@
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <sys/sendfile.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <arpa/inet.h>
+#include <sys/wait.h>
+
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
+#define TLS_PAYLOAD_MAX_LEN 16384
+#define TEST_PORT 12345
+
+static void chunked_sendfile(int cfd, int sfd,
+			     size_t chunk_size,
+			     size_t extra_payload_size)
+{
+	char buf[TLS_PAYLOAD_MAX_LEN];
+	uint16_t test_payload_size;
+	size_t recved = 0;
+	size_t sent = 0;
+	int size = 0;
+	int ret;
+	char filename[] = "/tmp/mytemp.XXXXXX";
+	int fd = mkstemp(filename);
+	off_t offset = 0;
+
+	unlink(filename);
+	if (fd <= 0) {
+		perror("tempfile");
+		exit(1);
+	}
+	if (chunk_size < 1) {
+		perror("chunksize");
+		exit(1);
+	}
+
+	test_payload_size = chunk_size + extra_payload_size;
+	if (test_payload_size > TLS_PAYLOAD_MAX_LEN) {
+		perror("payload_size");
+		exit(1);
+	}
+	memset(buf, 1, test_payload_size);
+	size = write(fd, buf, test_payload_size);
+	if (size != test_payload_size) {
+		perror("file write");
+		exit(1);
+	}
+	fsync(fd);
+
+	while (size > 0) {
+		ret = sendfile(sfd, fd, &offset, chunk_size);
+		if (ret <= 0)
+			exit(1);
+		size -= ret;
+		sent += ret;
+	}
+	printf("[client] sent %zu bytes\n", sent);
+
+	recved = recv(cfd, buf, test_payload_size, MSG_WAITALL);
+	printf("[server] receieved %zu bytes\n", recved);
+
+	if (recved != test_payload_size)
+		exit(1);
+
+	close(fd);
+}
+
+int main()
+{
+	int sfd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
+	int cfd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
+	struct sockaddr_in addr = {0};
+	socklen_t addrlen = sizeof(addr);
+
+	printf("==== multi_chunk_sendfile MPTCP test ====\n");
+
+	if (sfd < 0 || cfd < 0) {
+		perror("socket");
+		exit(1);
+	}
+
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	addr.sin_port = htons(TEST_PORT);
+
+	if (bind(sfd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		perror("bind");
+		exit(1);
+	}
+
+	if (listen(sfd, 1) < 0) {
+		perror("listen");
+		exit(1);
+	}
+
+	if (getsockname(sfd, (struct sockaddr *)&addr, &addrlen) < 0) {
+		perror("getsockname");
+		exit(1);
+	}
+
+	if (connect(cfd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		perror("connect");
+		exit(1);
+	}
+
+	int nfd = accept(sfd, NULL, NULL);
+	if (nfd < 0) {
+		perror("accept");
+		exit(1);
+	}
+
+	chunked_sendfile(cfd, nfd, 4096, 4096);
+	chunked_sendfile(cfd, nfd, 4096, 0);
+	chunked_sendfile(cfd, nfd, 4096, 1);
+	chunked_sendfile(cfd, nfd, 4096, 2048);
+	chunked_sendfile(cfd, nfd, 8192, 2048);
+	chunked_sendfile(cfd, nfd, 4096, 8192);
+	chunked_sendfile(cfd, nfd, 8192, 4096);
+	chunked_sendfile(cfd, nfd, 12288, 1024);
+	chunked_sendfile(cfd, nfd, 12288, 2000);
+	chunked_sendfile(cfd, nfd, 15360, 100);
+	chunked_sendfile(cfd, nfd, 15360, 300);
+	chunked_sendfile(cfd, nfd, 1, 4096);
+	chunked_sendfile(cfd, nfd, 2048, 4096);
+	chunked_sendfile(cfd, nfd, 2048, 8192);
+	chunked_sendfile(cfd, nfd, 4096, 8192);
+	chunked_sendfile(cfd, nfd, 1024, 12288);
+	chunked_sendfile(cfd, nfd, 2000, 12288);
+	chunked_sendfile(cfd, nfd, 100, 15360);
+	chunked_sendfile(cfd, nfd, 300, 15360);
+
+	close(cfd);
+	close(nfd);
+	close(sfd);
+
+	printf("==== test ends ====\n");
+	return 0;
+}
diff --git a/tools/testing/selftests/net/mptcp/multi_chunk.sh b/tools/testing/selftests/net/mptcp/multi_chunk.sh
new file mode 100755
index 000000000000..c0352c89087f
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/multi_chunk.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "${0}")/mptcp_lib.sh"
+
+cleanup()
+{
+	if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
+		kill "$pid" 2>/dev/null
+		wait "$pid" 2>/dev/null
+	fi
+
+	mptcp_lib_ns_exit "${ns1}"
+}
+
+init()
+{
+	mptcp_lib_ns_init ns1
+
+	local i
+	for i in $(seq 1 4); do
+		mptcp_lib_pm_nl_add_endpoint "${ns1}" "127.0.0.1" flags signal port 1000$i
+	done
+
+	mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
+
+	ip netns exec ${ns1} ip mptcp endpoint show
+	ip netns exec ${ns1} ip mptcp limits
+}
+
+init
+trap cleanup EXIT
+
+ip netns exec $ns1 ./multi_chunk &
+
+pid=$!
+wait $pid
-- 
2.43.0

