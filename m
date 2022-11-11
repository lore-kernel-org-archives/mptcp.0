Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C598C20E7
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668161842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3iFITZu1pJpZkB2JS9xZW3r5b9BZfiSqo7VsLLhY/ag=;
	b=OHGowyag7Q7XNAroMzHv7rCyY4JQTWLnQ4NE2l0sOpiOWZaJhDnBmJSNH7PlCcES5mE9kF
	qJTBY8le1FyLxXJu6M1sPMZpSrB11esjF/UWKvTnuZpR7N3nxy2dSdWnGzL45SXVhh+xGe
	skegPWuAX0/S6iGEwk0TY9mbmoDI7Ss=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-7Ok7JzqrN0ap2bIOWNEJjw-1; Fri, 11 Nov 2022 05:17:21 -0500
X-MC-Unique: 7Ok7JzqrN0ap2bIOWNEJjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5540C3C0F23A;
	Fri, 11 Nov 2022 10:17:21 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 351FB200D8C0;
	Fri, 11 Nov 2022 10:17:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Subject: [PATCH mptcp-next] Squash-to: "selftests: mptcp: mptfo Initiator/Listener"
Date: Fri, 11 Nov 2022 11:17:00 +0100
Message-Id: <508587c12b02e0f33388aa2fe30add27eb8c13c8.1668161791.git.pabeni@redhat.com>
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

We need to cope with multiple iteration of the remote peer address
selection loop

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 134e569cd75a..8635619ab1fd 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -375,13 +375,12 @@ static int sock_connect_mptcp(const char * const remoteaddr,
 			set_mark(sock, cfg_mark);
 
 		if (cfg_sockopt_types.mptfo) {
-			winfo->len = read(infd, winfo->buf, sizeof(winfo->buf));
+			if (!winfo->len)
+				winfo->len = read(infd, winfo->buf, sizeof(winfo->buf));
 
 			syn_copied = sendto(sock, winfo->buf, winfo->len, MSG_FASTOPEN,
 					    a->ai_addr, a->ai_addrlen);
-			if (syn_copied < 0)
-				perror("sendto");
-			if (syn_copied) {
+			if (syn_copied >= 0) {
 				winfo->off = syn_copied;
 				winfo->len -= syn_copied;
 				*peer = a;
-- 
2.38.1

