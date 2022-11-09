Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E655EBE2
	for <mptcp@lists.linux.dev>; Wed,  9 Nov 2022 14:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668005568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIQ7PrtQQKiM/Ge3a6CQ6FqaNFzFWAd8tuOv8cLP8IU=;
	b=TJ/AYTeboKsbkgTw62GLGpJPJEMSiYF3Lupl5hdCW6Md6RaHCFW0gQwgvuXz4Jo0CbFmsS
	oUabHjTUYS39G/8PIJD5/rg2R4MDgxYukQtYOR9Hn6NEyrvF1PEID95Nugxd1XtKJIQ0e6
	hg9qbCK5sL/CHPlN6e10cPoQPvNz9mw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-qVjuBVdMNO6qYn7W_YFZCA-1; Wed, 09 Nov 2022 09:52:44 -0500
X-MC-Unique: qVjuBVdMNO6qYn7W_YFZCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 533341C0CE61;
	Wed,  9 Nov 2022 14:52:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.116])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AD35D2028E90;
	Wed,  9 Nov 2022 14:52:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Subject: [PATCH net-next] Squash-to: "selftests: mptcp: mptfo Initiator/Listener"
Date: Wed,  9 Nov 2022 15:52:31 +0100
Message-Id: <41b40e837c47147ce713ae0d35a916471d36f82d.1667993466.git.pabeni@redhat.com>
In-Reply-To: <4edc02c8a8e040d0ac212ff61d9256c8148f2429.1667993416.git.pabeni@redhat.com>
References: <4edc02c8a8e040d0ac212ff61d9256c8148f2429.1667993416.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The TFO is allowed to send less data than the provided one,
we need to track more status info to properly allow the next sendmsg()
starting from the next to send byte.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 118 ++++++++----------
 1 file changed, 55 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 4bc855159c52..134e569cd75a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -26,13 +26,11 @@
 
 #include <netdb.h>
 #include <netinet/in.h>
-#include <netinet/tcp.h>
 
+#include <linux/tcp.h>
 #include <linux/time_types.h>
 #include <linux/sockios.h>
 
-
-
 extern int optind;
 
 #ifndef IPPROTO_MPTCP
@@ -93,6 +91,12 @@ struct tcp_inq_state {
 	bool expect_eof;
 };
 
+struct wstate {
+	char buf[8192];
+	unsigned int len;
+	unsigned int off;
+};
+
 static struct tcp_inq_state tcp_inq;
 
 static struct cfg_cmsg_types cfg_cmsg_types;
@@ -239,7 +243,7 @@ static void set_mptfo(int fd, int pf)
 {
 	int qlen = 25;
 
-	if (setsockopt(fd, SOL_TCP, TCP_FASTOPEN, &qlen, sizeof(qlen)) == -1)
+	if (setsockopt(fd, IPPROTO_TCP, TCP_FASTOPEN, &qlen, sizeof(qlen)) == -1)
 		perror("TCP_FASTOPEN");
 }
 
@@ -345,17 +349,14 @@ static int sock_listen_mptcp(const char * const listenaddr,
 static int sock_connect_mptcp(const char * const remoteaddr,
 			      const char * const port, int proto,
 			      struct addrinfo **peer,
-			      int infd,
-			      unsigned int *woff)
+			      int infd, struct wstate *winfo)
 {
 	struct addrinfo hints = {
 		.ai_protocol = IPPROTO_TCP,
 		.ai_socktype = SOCK_STREAM,
 	};
 	struct addrinfo *a, *addr;
-	unsigned int wlen = 0;
 	int syn_copied = 0;
-	char wbuf[8192];
 	int sock = -1;
 
 	hints.ai_family = pf;
@@ -374,13 +375,15 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			set_mark(sock, cfg_mark);
 
 		if (cfg_sockopt_types.mptfo) {
-			if (wlen == 0)
-				wlen = read(infd, wbuf, sizeof(wbuf));
+			winfo->len = read(infd, winfo->buf, sizeof(winfo->buf));
 
-			syn_copied = sendto(sock, wbuf, wlen, MSG_FASTOPEN,
+			syn_copied = sendto(sock, winfo->buf, winfo->len, MSG_FASTOPEN,
 					    a->ai_addr, a->ai_addrlen);
+			if (syn_copied < 0)
+				perror("sendto");
 			if (syn_copied) {
-				*woff = wlen;
+				winfo->off = syn_copied;
+				winfo->len -= syn_copied;
 				*peer = a;
 				break; /* success */
 			}
@@ -610,14 +613,13 @@ static void shut_wr(int fd)
 }
 
 static int copyfd_io_poll(int infd, int peerfd, int outfd,
-			  bool *in_closed_after_out, unsigned int woff)
+			  bool *in_closed_after_out, struct wstate *winfo)
 {
 	struct pollfd fds = {
 		.fd = peerfd,
 		.events = POLLIN | POLLOUT,
 	};
-	unsigned int wlen = 0, total_wlen = 0, total_rlen = 0;
-	char wbuf[8192];
+	unsigned int total_wlen = 0, total_rlen = 0;
 
 	set_nonblock(peerfd, true);
 
@@ -677,19 +679,19 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 		}
 
 		if (fds.revents & POLLOUT) {
-			if (wlen == 0) {
-				woff = 0;
-				wlen = read(infd, wbuf, sizeof(wbuf));
+			if (winfo->len == 0) {
+				winfo->off = 0;
+				winfo->len = read(infd, winfo->buf, sizeof(winfo->buf));
 			}
 
-			if (wlen > 0) {
+			if (winfo->len > 0) {
 				ssize_t bw;
 
 				/* limit the total amount of written data to the trunc value */
-				if (cfg_truncate > 0 && wlen + total_wlen > cfg_truncate)
-					wlen = cfg_truncate - total_wlen;
+				if (cfg_truncate > 0 && winfo->len + total_wlen > cfg_truncate)
+					winfo->len = cfg_truncate - total_wlen;
 
-				bw = do_rnd_write(peerfd, wbuf + woff, wlen);
+				bw = do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->len);
 				if (bw < 0) {
 					if (cfg_rcv_trunc)
 						return 0;
@@ -697,10 +699,10 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd,
 					return 111;
 				}
 
-				woff += bw;
-				wlen -= bw;
+				winfo->off += bw;
+				winfo->len -= bw;
 				total_wlen += bw;
-			} else if (wlen == 0) {
+			} else if (winfo->len == 0) {
 				/* We have no more data to send. */
 				fds.events &= ~POLLOUT;
 
@@ -878,7 +880,7 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
 	return err;
 }
 
-static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, unsigned int woff)
+static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct wstate *winfo)
 {
 	bool in_closed_after_out = false;
 	struct timespec start, end;
@@ -890,7 +892,7 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, unsigne
 
 	switch (cfg_mode) {
 	case CFG_MODE_POLL:
-		ret = copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out, woff);
+		ret = copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out, winfo);
 		break;
 
 	case CFG_MODE_MMAP:
@@ -1038,6 +1040,7 @@ static void maybe_close(int fd)
 int main_loop_s(int listensock)
 {
 	struct sockaddr_storage ss;
+	struct wstate winfo;
 	struct pollfd polls;
 	socklen_t salen;
 	int remotesock;
@@ -1072,7 +1075,8 @@ int main_loop_s(int listensock)
 
 		SOCK_TEST_TCPULP(remotesock, 0);
 
-		copyfd_io(fd, remotesock, 1, true, 0);
+		memset(&winfo, 0, sizeof(winfo));
+		copyfd_io(fd, remotesock, 1, true, &winfo);
 	} else {
 		perror("accept");
 		return 1;
@@ -1210,53 +1214,40 @@ void xdisconnect(int fd, int addrlen)
 
 int main_loop(void)
 {
-	int fd, ret, fd_in = 0;
+	int fd = 0, ret, fd_in = 0;
 	struct addrinfo *peer;
-	unsigned int woff = 0;
-
-	if (!cfg_sockopt_types.mptfo) {
-		/* listener is ready. */
-		fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer, 0, 0);
-		if (fd < 0)
-			return 2;
-again:
-		check_getpeername_connect(fd);
+	struct wstate winfo;
 
-		SOCK_TEST_TCPULP(fd, cfg_sock_proto);
-
-		if (cfg_rcvbuf)
-			set_rcvbuf(fd, cfg_rcvbuf);
-		if (cfg_sndbuf)
-			set_sndbuf(fd, cfg_sndbuf);
-		if (cfg_cmsg_types.cmsg_enabled)
-			apply_cmsg_types(fd, &cfg_cmsg_types);
-	}
-
-	if (cfg_input) {
+	if (cfg_input && cfg_sockopt_types.mptfo) {
 		fd_in = open(cfg_input, O_RDONLY);
 		if (fd < 0)
 			xerror("can't open %s:%d", cfg_input, errno);
 	}
 
-	if (cfg_sockopt_types.mptfo) {
-		/* sendto() instead of connect */
-		fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer, fd_in, &woff);
-		if (fd < 0)
-			return 2;
+	memset(&winfo, 0, sizeof(winfo));
+	fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer, fd_in, &winfo);
+	if (fd < 0)
+		return 2;
 
-		check_getpeername_connect(fd);
+again:
+	check_getpeername_connect(fd);
 
-		SOCK_TEST_TCPULP(fd, cfg_sock_proto);
+	SOCK_TEST_TCPULP(fd, cfg_sock_proto);
 
-		if (cfg_rcvbuf)
-			set_rcvbuf(fd, cfg_rcvbuf);
-		if (cfg_sndbuf)
-			set_sndbuf(fd, cfg_sndbuf);
-		if (cfg_cmsg_types.cmsg_enabled)
-			apply_cmsg_types(fd, &cfg_cmsg_types);
+	if (cfg_rcvbuf)
+		set_rcvbuf(fd, cfg_rcvbuf);
+	if (cfg_sndbuf)
+		set_sndbuf(fd, cfg_sndbuf);
+	if (cfg_cmsg_types.cmsg_enabled)
+		apply_cmsg_types(fd, &cfg_cmsg_types);
+
+	if (cfg_input && !cfg_sockopt_types.mptfo) {
+		fd_in = open(cfg_input, O_RDONLY);
+		if (fd < 0)
+			xerror("can't open %s:%d", cfg_input, errno);
 	}
 
-	ret = copyfd_io(fd_in, fd, 1, 0, 0);
+	ret = copyfd_io(fd_in, fd, 1, 0, &winfo);
 	if (ret)
 		return ret;
 
@@ -1273,6 +1264,7 @@ int main_loop(void)
 			xerror("can't reconnect: %d", errno);
 		if (cfg_input)
 			close(fd_in);
+		memset(&winfo, 0, sizeof(winfo));
 		goto again;
 	} else {
 		close(fd);
-- 
2.38.1

