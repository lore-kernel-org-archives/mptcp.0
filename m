Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D186B212FA9
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527439; cv=none; b=dVEljIjK9vwY8UZyqhpbQhAouOuOgy1PnDshAqSOgzDvF9bRx68QJ4slaYeU7jn46/+1SUlE7Q9JOjaY2FPUlY1dtbEcLJLZFuoBf0Owdvvj62LM6lI+98s+Vi/htsCRrg9nl3AbVKU2QZaM4YZ2wYm4R1p/HKIQMYVe/LHC3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527439; c=relaxed/simple;
	bh=in49V4TM4ZqYwpOaBJaPHurecAWaWuZahITv/r09JfE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcX4zQbw/adCKZ48jJ8cBsvMw/aQD+HFmmOlf7r4i/whyYC6TkN4by3rQJBOwBw75FXhpF/vz3Ar15YTKTxShbnmNpw4GHNgVsHd5hTIYpwGY85QlWmvIibVlJed9aZfDz9nzanqcA5UgjSnt7da3RrrMlfjMLxjfQS//eoCdl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIWyQ6cu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIWyQ6cu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736527436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vGE/LkIJTgUi89uDRoPoFEk3kuBMgTQ0fwCEIdUWQk=;
	b=HIWyQ6cuVJY8/2xj+nEGeEQV7LDldOZGG8Fnx+r6JMDoAJCZ0A5jPiK3NXzePd7kW9fSL5
	hu86nyNSHmOP6tt2Drgunf4eWwy5nRTuuL4jsYkZ5VbzeBHZMyH8Oiv41srClHt+p/2nrW
	GGtdyPsl1NdFxUHzc8v0Y1CfMzigpbk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-zswFUiO_MJ-L5xq0CdBHVQ-1; Fri,
 10 Jan 2025 11:43:55 -0500
X-MC-Unique: zswFUiO_MJ-L5xq0CdBHVQ-1
X-Mimecast-MFC-AGG-ID: zswFUiO_MJ-L5xq0CdBHVQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA2CB1955DD0
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 16:43:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.199])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE27619560AD
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 16:43:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 3/3] selftests: mptcp: avoid spurious errors on disconnect
Date: Fri, 10 Jan 2025 17:43:43 +0100
Message-ID: <be1fa3944536edc745e897234a38ace68e912e55.1736527092.git.pabeni@redhat.com>
In-Reply-To: <cover.1736527092.git.pabeni@redhat.com>
References: <cover.1736527092.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u6kBH7B9DqBvkPO9qlHF0n5upeFR8gWPBNoo7q74sDg_1736527434
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The disconnect test-case generates spurious errors:

NFO: disconnect
INFO: extra options: -I 3 -i /tmp/tmp.r43niviyoI
01 ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP     Unexpected revents: POLLERR/POLLNVAL(19)
(duration   140ms) [FAIL] file received by server does not match (in, out):
-rw-r--r-- 1 root root 10028676 Jan 10 10:47 /tmp/tmp.r43niviyoI.disconnect
Trailing bytes are:
��\����R���!8��u2��5N%w------- 1 root root 9992290 Jan 10 10:47 /tmp/tmp.Os4UbnWbI1
Trailing bytes are:
��\����R���!8��u2��5N%2 ns1 MPTCP -> ns1 (dead:beef:1::1:10001) MPTCP     (duration   206ms) [ OK ]
03 ns1 MPTCP -> ns1 (dead:beef:1::1:10002) TCP       (duration    31ms) [ OK ]
04 ns1 TCP   -> ns1 (dead:beef:1::1:10003) MPTCP     (duration    26ms) [ OK ]
[FAIL] Tests of the full disconnection have failed
Time: 2 seconds

The root cause is actually in the user-space bits: the test program
currently disconnects as soon as all the pending data has been spooled,
generating an FASTCLOSE. If such option reaches the peer before that
the latter has reached the closed status, the msk socket will report an
error to the user-space, as per protocol specification, causing the above
failure.

Address the issue explicitly waiting for all the relevant sockets to reach
a closed status before performing the disconnect.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 44 ++++++++++++++-----
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 4209b9569039..5cfea1760431 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -25,6 +25,8 @@
 #include <sys/types.h>
 #include <sys/mman.h>
 
+#include <arpa/inet.h>
+
 #include <netdb.h>
 #include <netinet/in.h>
 
@@ -1211,23 +1213,43 @@ static void parse_setsock_options(const char *name)
 	exit(1);
 }
 
-void xdisconnect(int fd, int addrlen)
+void xdisconnect(int fd)
 {
-	struct sockaddr_storage empty;
+	socklen_t addrlen = sizeof(struct sockaddr_storage);
+	struct sockaddr_storage addr, empty;
 	int msec_sleep = 10;
-	int queued = 1;
-	int i;
+	void *raw_addr;
+	int i, cmdlen;
+	char cmd[128];
+
+	/* get the local address and convert it to string */
+	if (getsockname(fd, (struct sockaddr *)&addr, &addrlen) < 0)
+		xerror("getsockname");
+
+	if (addr.ss_family == AF_INET)
+		raw_addr= &(((struct sockaddr_in *)&addr)->sin_addr);
+	else if (addr.ss_family == AF_INET6)
+		raw_addr = &(((struct sockaddr_in6 *)&addr)->sin6_addr);
+	else
+		xerror("bad family");
+
+	strcpy(cmd, "ss -M | grep ");
+	cmdlen = strlen(cmd);
+	if (!inet_ntop(addr.ss_family , raw_addr, &cmd[cmdlen],
+		       sizeof(cmd) - cmdlen))
+		xerror("inet_ntop");
+	strcat(cmd, " >/dev/null");
 
 	shutdown(fd, SHUT_WR);
 
-	/* while until the pending data is completely flushed, the later
+	/*
+	 * wait until the pending data is completely flushed and all
+	 * the MPTCP sockets reached the closed status.
 	 * disconnect will bypass/ignore/drop any pending data.
 	 */
 	for (i = 0; ; i += msec_sleep) {
-		if (ioctl(fd, SIOCOUTQ, &queued) < 0)
-			xerror("can't query out socket queue: %d", errno);
-
-		if (!queued)
+		/* closed socket are not listed by 'ss' */
+		if (system(cmd))
 			break;
 
 		if (i > poll_timeout)
@@ -1281,9 +1303,9 @@ int main_loop(void)
 		return ret;
 
 	if (cfg_truncate > 0) {
-		xdisconnect(fd, peer->ai_addrlen);
+		xdisconnect(fd);
 	} else if (--cfg_repeat > 0) {
-		xdisconnect(fd, peer->ai_addrlen);
+		xdisconnect(fd);
 
 		/* the socket could be unblocking at this point, we need the
 		 * connect to be blocking
-- 
2.47.1

