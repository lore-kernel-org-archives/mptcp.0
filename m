Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBAB3FC1
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 09:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630921288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uz0teKYvVl8MQPi1nUSalB6FarhhgxQmn5UIoqEVeu4=;
	b=bRisGjD1gqqp17uBKku6M2+rXFeFFzdaGtabMKNAnUCgeHM8uVpXi15OWn7agZjgHPbZ+a
	YhYrdjw4QdfTIU93sF4BSNwzQzUk/ZJ/Ihu2FLWcshLWusXPRkBU1auplvnhifU/ip1PMn
	pBR2YCb/RNpQ4priRYtyBXeF5JFHU5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-m4tf7kWuMJ-Ua-l7MmWmig-1; Mon, 06 Sep 2021 05:41:27 -0400
X-MC-Unique: m4tf7kWuMJ-Ua-l7MmWmig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9148100960E
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 09:41:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F34D68D79
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 09:41:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] Squash-to: "mptcp: stop relying on tcp_tx_skb_cache"
Date: Mon,  6 Sep 2021 11:41:21 +0200
Message-Id: <a4b897af7a6c7dcf4258d2ad90ddb5a676250ea1.1630921280.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

A small cleanup for the tcp_tx_skb_cache removal: we don't
need to check for skb in zero win probe (matttbe)

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2a525c7ae920..8c34c6339454 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1336,7 +1336,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (copy == 0) {
 		u64 snd_una = READ_ONCE(msk->snd_una);
 
-		if (skb || snd_una != msk->snd_nxt) {
+		if (snd_una != msk->snd_nxt) {
 			tcp_remove_empty_skb(ssk, tcp_write_queue_tail(ssk));
 			return 0;
 		}
-- 
2.26.3

