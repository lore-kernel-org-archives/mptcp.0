Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D023BC
	for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 09:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680254268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aUYitwYKgPv7RvSzuEys2mNKeh94a4ncm7I7Or66PT0=;
	b=dcmyPJqqkcVlKIm5Jl1U1P6QIsNdSc79BrUiAWkkAJjnP0ZDji1wgVuNlfGqVfMS+QcjNs
	XtLE2nZ2BXHOcbgaCiGFzYK5WRxuzHisn6kw29M0V6fCy2Ty+CCJXghSsoY1gZwPXm9S40
	5UK0iV04+Nw9NTP4j4/8ptpaUdR8jSM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-0LtTLWhEM06wLzXnC2qDxw-1; Fri, 31 Mar 2023 05:17:45 -0400
X-MC-Unique: 0LtTLWhEM06wLzXnC2qDxw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0F40185A791;
	Fri, 31 Mar 2023 09:17:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3AF65492C3E;
	Fri, 31 Mar 2023 09:17:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Subject: [PATCH mptcp-net] mptcp: fix NULL pointer dereference on fastopen early fallback
Date: Fri, 31 Mar 2023 11:17:34 +0200
Message-Id: <07059bdc844f97430ff5c92afc548485b1c20d74.1680253474.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In case of early fallback to TCP, subflow_syn_recv_sock() deletes
the subflow context before returning the newly allocated sock to
the caller.

The fastopen path does not cope with the above unconditionally
dereferencing the subflow context.

Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/fastopen.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index d237d142171c..bceaab8dd8e4 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -9,11 +9,18 @@
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req)
 {
-	struct sock *ssk = subflow->tcp_sock;
-	struct sock *sk = subflow->conn;
+	struct sock *sk, *ssk;
 	struct sk_buff *skb;
 	struct tcp_sock *tp;
 
+	/* on early fallback the subflow context is deleted by
+	 * subflow_syn_recv_sock()
+	 */
+	if (!subflow)
+		return;
+
+	ssk = subflow->tcp_sock;
+	sk = subflow->conn;
 	tp = tcp_sk(ssk);
 
 	subflow->is_mptfo = 1;
-- 
2.39.2

