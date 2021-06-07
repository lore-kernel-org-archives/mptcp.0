Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981029CA
	for <mptcp@lists.linux.dev>; Mon,  7 Jun 2021 14:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623074925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qfwxWteKyI6bG3bXmyCCqTU9bo3Ds6J9JWCU/O3ZTn0=;
	b=ARWhkipXMjit8RwOylvrVsBRKt5QTn8IHrJGB6CChv97BL2FwS8zVb0wGgyfnRzhHZC6z4
	YoQzvhJ1PFKA+0Uqsv5GbYPIen91PvNke8wgw29WF7YFAfTYx7OZdCIoDF1dAT5ley88Dn
	mnRVlJBO1gWuP+E4+3ABoZ5+FYrLRRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-liIfvsrwOjWuUOPbA2HSwg-1; Mon, 07 Jun 2021 10:08:44 -0400
X-MC-Unique: liIfvsrwOjWuUOPbA2HSwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C329653;
	Mon,  7 Jun 2021 14:08:43 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-203.ams2.redhat.com [10.36.115.203])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 67B3310023B0;
	Mon,  7 Jun 2021 14:08:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH] Squash-to: "mptcp: wake-up readers only for in sequence data"
Date: Mon,  7 Jun 2021 16:08:38 +0200
Message-Id: <8c07c4b90aac3f1d3bdd64c5ba8f5c83372005a1.1623074917.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

We need to flip the DATA_READY bit under the mptcp_data_lock()
(or before acquiring it, as the old code did), or the BH could
end-up flipping the bit after that the user-space already
flushed the just-appended data.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8e7cf4c480a6..8ef60e415d9a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -687,8 +687,6 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	if (inet_sk_state_load(sk) == TCP_CLOSE)
 		return false;
 
-	mptcp_data_lock(sk);
-
 	__mptcp_move_skbs_from_subflow(msk, ssk, &moved);
 	__mptcp_ofo_queue(msk);
 	if (unlikely(ssk->sk_err)) {
@@ -705,8 +703,6 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
 	 */
 	if (mptcp_pending_data_fin(sk, NULL))
 		mptcp_schedule_work(sk);
-	mptcp_data_unlock(sk);
-
 	return moved > 0;
 }
 
@@ -733,10 +729,12 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		return;
 
 	/* Wake-up the reader only for in-sequence data */
+	mptcp_data_lock(sk);
 	if (move_skbs_to_msk(msk, ssk)) {
 		set_bit(MPTCP_DATA_READY, &msk->flags);
 		sk->sk_data_ready(sk);
 	}
+	mptcp_data_unlock(sk);
 }
 
 static bool mptcp_do_flush_join_list(struct mptcp_sock *msk)
-- 
2.26.3

