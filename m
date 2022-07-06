Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63DA2F3A
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 11:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657106328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n/+33ewEEP3NNc8FkZf4PAVIf5CFGh0Xsp8W3PvO8KM=;
	b=YSlA0npo9y++eZsCzc5RruCbNaZsnaTPm6MzeC+hdtDP+ETMltMHZRgfaoBF/pM4IySwrz
	kOU6VIHnRSLWEDM+pMRZ1J70p4SOkszjnrUVg7LH1IddD2/TYp+mthcSY0OS6M+pr9NlHc
	ebUkEMquM//sP/bEzWftH1wLy6edadc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-LT9AhhAdN8-1cBnvjcP2OA-1; Wed, 06 Jul 2022 07:18:47 -0400
X-MC-Unique: LT9AhhAdN8-1cBnvjcP2OA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63593101A586
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 11:18:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D85DB1121315
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 11:18:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix subflow traveral at disconnect time
Date: Wed,  6 Jul 2022 13:18:29 +0200
Message-Id: <2c5147569717a1c879b291230d460e8e85992878.1657106043.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

At disconnect time the MPTCP protocol traverse the subflows
list closing each of them. In some circumstances - MPJ subflow,
passive MPTCP socket, the latter operation can remove the
subflow from the list, invalidating the current iterator.

Address the issue using the safe list traversing helper
variant.

Reported-by: van fantasy <g1042620637@gmail.com>
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
I think this should go soon upstream, sending here to trigger the CI

A pktdrill test will follow.
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 10bfa2b78206..0264642f133f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2881,12 +2881,12 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 
 static int mptcp_disconnect(struct sock *sk, int flags)
 {
-	struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	inet_sk_state_store(sk, TCP_CLOSE);
 
-	mptcp_for_each_subflow(msk, subflow) {
+	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
-- 
2.35.3

