Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A542F2B
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668184771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a1TnaJDBVe/gagjUqEYZceZOjeesMKqsI9srwp61VNM=;
	b=LeMRpifUyEzJ1Hs57uBdZH4IAJruMzspOV20SB71jamSV8jWiDP4KwnIJAhOCuVGSgnwGm
	bWO9bmUdvFwsAKc8Tg9JmjHs3zqNoKEEz7vZj3x8QBLgKxzDYHTDchfaOB7eFO5/tV6Pah
	KHUueXGIz7ynqlVmL+HLZvrIKDvo0Ng=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-zjMQafq3OHe1uWZH0PRmAA-1; Fri, 11 Nov 2022 11:39:30 -0500
X-MC-Unique: zjMQafq3OHe1uWZH0PRmAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A08E88027F5;
	Fri, 11 Nov 2022 16:39:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 053F340C83DD;
	Fri, 11 Nov 2022 16:39:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Subject: [PATCH mptcp-next] Squash-to: "selftests: mptcp: mptfo Initiator/Listener": fix mmap failure
Date: Fri, 11 Nov 2022 17:39:20 +0100
Message-Id: <81db127b6a12947e39a6715d567e22c0bfd3d9b8.1668184713.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In TFO scenarios we need to completelly spool the partially xmitted
buffer (and accunt for that) before starting sendfile/mmap xmit,
otherwise the relevant tests will fail.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 57 ++++++++++++++-----
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 8635619ab1fd..ee8d320b071c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -95,6 +95,7 @@ struct wstate {
 	char buf[8192];
 	unsigned int len;
 	unsigned int off;
+	unsigned int total_len;
 };
 
 static struct tcp_inq_state tcp_inq;
@@ -375,8 +376,8 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			set_mark(sock, cfg_mark);
 
 		if (cfg_sockopt_types.mptfo) {
-			if (!winfo->len)
-				winfo->len = read(infd, winfo->buf, sizeof(winfo->buf));
+			if (!winfo->total_len)
+				winfo->total_len = winfo->len = read(infd, winfo->buf, sizeof(winfo->buf));
 
 			syn_copied = sendto(sock, winfo->buf, winfo->len, MSG_FASTOPEN,
 					    a->ai_addr, a->ai_addrlen);
@@ -757,10 +758,26 @@ static int do_recvfile(int infd, int outfd)
 	return (int)r;
 }
 
-static int do_mmap(int infd, int outfd, unsigned int size)
+static int spool_buf(int fd, struct wstate *winfo)
+{
+	while (winfo->len) {
+		int ret = write(fd, winfo->buf + winfo->off, winfo->len);
+
+		if (ret < 0) {
+			perror("write");
+			return 4;
+		}
+		winfo->off += ret;
+		winfo->len -= ret;
+	}
+	return 0;
+}
+
+static int do_mmap(int infd, int outfd, unsigned int size,
+		   struct wstate *winfo)
 {
 	char *inbuf = mmap(NULL, size, PROT_READ, MAP_SHARED, infd, 0);
-	ssize_t ret = 0, off = 0;
+	ssize_t ret = 0, off = winfo->total_len;
 	size_t rem;
 
 	if (inbuf == MAP_FAILED) {
@@ -768,7 +785,11 @@ static int do_mmap(int infd, int outfd, unsigned int size)
 		return 1;
 	}
 
-	rem = size;
+	ret = spool_buf(outfd, winfo);
+	if (ret < 0)
+		return ret;
+
+	rem = size - winfo->total_len;
 
 	while (rem > 0) {
 		ret = write(outfd, inbuf + off, rem);
@@ -812,8 +833,15 @@ static int get_infd_size(int fd)
 	return (int)count;
 }
 
-static int do_sendfile(int infd, int outfd, unsigned int count)
+static int do_sendfile(int infd, int outfd, unsigned int count,
+		       struct wstate *winfo)
 {
+	int ret = spool_buf(outfd, winfo);
+	if (ret < 0)
+		return ret;
+
+	count -= winfo->total_len;
+
 	while (count > 0) {
 		ssize_t r;
 
@@ -830,7 +858,8 @@ static int do_sendfile(int infd, int outfd, unsigned int count)
 }
 
 static int copyfd_io_mmap(int infd, int peerfd, int outfd,
-			  unsigned int size, bool *in_closed_after_out)
+			  unsigned int size, bool *in_closed_after_out,
+			  struct wstate *winfo)
 {
 	int err;
 
@@ -839,9 +868,9 @@ static int copyfd_io_mmap(int infd, int peerfd, int outfd,
 		if (err)
 			return err;
 
-		err = do_mmap(infd, peerfd, size);
+		err = do_mmap(infd, peerfd, size, winfo);
 	} else {
-		err = do_mmap(infd, peerfd, size);
+		err = do_mmap(infd, peerfd, size, winfo);
 		if (err)
 			return err;
 
@@ -855,7 +884,7 @@ static int copyfd_io_mmap(int infd, int peerfd, int outfd,
 }
 
 static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
-			      unsigned int size, bool *in_closed_after_out)
+			      unsigned int size, bool *in_closed_after_out, struct wstate *winfo)
 {
 	int err;
 
@@ -864,9 +893,9 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
 		if (err)
 			return err;
 
-		err = do_sendfile(infd, peerfd, size);
+		err = do_sendfile(infd, peerfd, size, winfo);
 	} else {
-		err = do_sendfile(infd, peerfd, size);
+		err = do_sendfile(infd, peerfd, size, winfo);
 		if (err)
 			return err;
 
@@ -898,14 +927,14 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct
 		file_size = get_infd_size(infd);
 		if (file_size < 0)
 			return file_size;
-		ret = copyfd_io_mmap(infd, peerfd, outfd, file_size, &in_closed_after_out);
+		ret = copyfd_io_mmap(infd, peerfd, outfd, file_size, &in_closed_after_out, winfo);
 		break;
 
 	case CFG_MODE_SENDFILE:
 		file_size = get_infd_size(infd);
 		if (file_size < 0)
 			return file_size;
-		ret = copyfd_io_sendfile(infd, peerfd, outfd, file_size, &in_closed_after_out);
+		ret = copyfd_io_sendfile(infd, peerfd, outfd, file_size, &in_closed_after_out, winfo);
 		break;
 
 	default:
-- 
2.38.1

