Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079B4A3E
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 11:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668426873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAaZkWdyiuIS+lYEZQRkkoKmudIzW4S/XCQDhuT8lvk=;
	b=gNPUON0SccOCKq61kzC0VpqT0mCUpqg7HynYXmDm/dW8egOHUNcIWgX2viOkI5SalZweaI
	T/cxuMeaqCtotGg+vvcEUMP/OHVifXKktzacNw8q2omCuRmtPX575KGf0HSVV8aXolEpHK
	inReLjMnC/yDdvOVukSZEG1ELHllqfg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-GoH8J7XkP1-LtZ2OFDhhDQ-1; Mon, 14 Nov 2022 06:54:31 -0500
X-MC-Unique: GoH8J7XkP1-LtZ2OFDhhDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B5271C0759A;
	Mon, 14 Nov 2022 11:54:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0C8FD40CA40C;
	Mon, 14 Nov 2022 11:54:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Subject: [PATCH mptcp-next 3/3] Squash-to: "selftests: mptcp: mptfo Initiator/Listener"
Date: Mon, 14 Nov 2022 12:54:07 +0100
Message-Id: <8a71a8cb0b7ae39eaf6ef29686c8a588f0ce8a38.1668426733.git.pabeni@redhat.com>
In-Reply-To: <cover.1668426733.git.pabeni@redhat.com>
References: <cover.1668426733.git.pabeni@redhat.com>
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

wrap a bunch of long lines, and insert needed empty line
after variable declaration.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ee8d320b071c..c8bd109c991f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -377,7 +377,8 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 
 		if (cfg_sockopt_types.mptfo) {
 			if (!winfo->total_len)
-				winfo->total_len = winfo->len = read(infd, winfo->buf, sizeof(winfo->buf));
+				winfo->total_len = winfo->len = read(infd, winfo->buf,
+								     sizeof(winfo->buf));
 
 			syn_copied = sendto(sock, winfo->buf, winfo->len, MSG_FASTOPEN,
 					    a->ai_addr, a->ai_addrlen);
@@ -837,6 +838,7 @@ static int do_sendfile(int infd, int outfd, unsigned int count,
 		       struct wstate *winfo)
 {
 	int ret = spool_buf(outfd, winfo);
+
 	if (ret < 0)
 		return ret;
 
@@ -920,21 +922,24 @@ static int copyfd_io(int infd, int peerfd, int outfd, bool close_peerfd, struct
 
 	switch (cfg_mode) {
 	case CFG_MODE_POLL:
-		ret = copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out, winfo);
+		ret = copyfd_io_poll(infd, peerfd, outfd, &in_closed_after_out,
+				     winfo);
 		break;
 
 	case CFG_MODE_MMAP:
 		file_size = get_infd_size(infd);
 		if (file_size < 0)
 			return file_size;
-		ret = copyfd_io_mmap(infd, peerfd, outfd, file_size, &in_closed_after_out, winfo);
+		ret = copyfd_io_mmap(infd, peerfd, outfd, file_size,
+				     &in_closed_after_out, winfo);
 		break;
 
 	case CFG_MODE_SENDFILE:
 		file_size = get_infd_size(infd);
 		if (file_size < 0)
 			return file_size;
-		ret = copyfd_io_sendfile(infd, peerfd, outfd, file_size, &in_closed_after_out, winfo);
+		ret = copyfd_io_sendfile(infd, peerfd, outfd, file_size,
+					 &in_closed_after_out, winfo);
 		break;
 
 	default:
-- 
2.38.1

