Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBF3DC0
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 15:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629386196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAnQr2BYLHGnmUbVnC6CXyIBED4b8WR7xFc3DPXHI4o=;
	b=QzNoopSG4G6ubbkoSMnqWXEfs8sfwD+Y69yatdxsJI3VHZnfCNCvlZFbrhwgwUqEAcBrpG
	4VI+zJjK5tSYv+kyHm83/7DXpeT74QRymAiEPcZNnB4SVBlWaRiWyjLs7Z6WnK/YJuZhJp
	RR+CAn9u4bfWX3T5i8gqzn61SEC1JzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-WZ3QybR2MX-JeI_G7I1DOg-1; Thu, 19 Aug 2021 11:16:34 -0400
X-MC-Unique: WZ3QybR2MX-JeI_G7I1DOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91F00801AC5
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 15:16:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F31F07A8D7
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 15:16:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 4/4] mptcp: optimize the input options processing.
Date: Thu, 19 Aug 2021 17:16:17 +0200
Message-Id: <1eb5eb91a3cdb5d0f03e20120b1c5c109d690fc8.1629386016.git.pabeni@redhat.com>
In-Reply-To: <cover.1629386016.git.pabeni@redhat.com>
References: <cover.1629386016.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Most MPTCP packets carries a single MPTCP subption: the
DSS containing the mapping for the current packet.

Check explicitly for the above, so that is such scenario we
replace most conditional statements with a single likely() one.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 70 +++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0d33c020062f..af22d76f1699 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1111,48 +1111,50 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return sk->sk_state != TCP_CLOSE;
 
-	if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
-	    msk->local_key == mp_opt.rcvr_key) {
-		WRITE_ONCE(msk->rcv_fastclose, true);
-		mptcp_schedule_work((struct sock *)msk);
-	}
+	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
+		if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
+		    msk->local_key == mp_opt.rcvr_key) {
+			WRITE_ONCE(msk->rcv_fastclose, true);
+			mptcp_schedule_work((struct sock *)msk);
+		}
 
-	if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) && add_addr_hmac_valid(msk, &mp_opt)) {
-		if (!mp_opt.echo) {
-			mptcp_pm_add_addr_received(msk, &mp_opt.addr);
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
-		} else {
-			mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-			mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
+		if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) && add_addr_hmac_valid(msk, &mp_opt)) {
+			if (!mp_opt.echo) {
+				mptcp_pm_add_addr_received(msk, &mp_opt.addr);
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
+			} else {
+				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
+				mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
+			}
+
+			if (mp_opt.addr.port)
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
 		}
 
-		if (mp_opt.addr.port)
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
-	}
+		if (mp_opt.suboptions & OPTION_MPTCP_RM_ADDR)
+			mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
 
-	if (mp_opt.suboptions & OPTION_MPTCP_RM_ADDR)
-		mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
+		if (mp_opt.suboptions & OPTION_MPTCP_PRIO) {
+			mptcp_pm_mp_prio_received(sk, mp_opt.backup);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
+		}
 
-	if (mp_opt.suboptions & OPTION_MPTCP_PRIO) {
-		mptcp_pm_mp_prio_received(sk, mp_opt.backup);
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
-	}
+		if (mp_opt.suboptions & OPTION_MPTCP_FAIL) {
+			mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
+		}
 
-	if (mp_opt.suboptions & OPTION_MPTCP_FAIL) {
-		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
-	}
+		if (mp_opt.suboptions & OPTION_MPTCP_RST) {
+			subflow->reset_seen = 1;
+			subflow->reset_reason = mp_opt.reset_reason;
+			subflow->reset_transient = mp_opt.reset_transient;
+		}
 
-	if (mp_opt.suboptions & OPTION_MPTCP_RST) {
-		subflow->reset_seen = 1;
-		subflow->reset_reason = mp_opt.reset_reason;
-		subflow->reset_transient = mp_opt.reset_transient;
+		if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
+			return true;
 	}
 
-	if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
-		return true;
-
 	/* we can't wait for recvmsg() to update the ack_seq, otherwise
 	 * monodirectional flows will stuck
 	 */
@@ -1179,7 +1181,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	memset(mpext, 0, sizeof(*mpext));
 
-	if (mp_opt.use_map) {
+	if (likely(mp_opt.use_map)) {
 		if (mp_opt.mpc_map) {
 			/* this is an MP_CAPABLE carrying MPTCP data
 			 * we know this map the first chunk of data
-- 
2.26.3

