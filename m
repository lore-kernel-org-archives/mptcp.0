Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3386D2B
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629282965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=chYnhNBy/brXOSOwW1MI/arzxmVDb/RtirWYGJ0fgss=;
	b=OLHVj+asZROuWd9oKEp75WZg4kV1M+ppdfoSusUwRSKV2zNe8QQGNxEDRb26y19VvbdE4i
	tD+Vm/NrfrQx94qI8UKY17h/SZf8QEAqQ03E8zuZ2PyRy6KYa0LQhRzcNVhy65oFpY/2Ya
	NnVFN01q6dxzBUYsLFlfBLFSfFss2uE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-gbzI1OqIPyCmJmzN6kOVpg-1; Wed, 18 Aug 2021 06:36:04 -0400
X-MC-Unique: gbzI1OqIPyCmJmzN6kOVpg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D77BA1008060
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:36:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4CC75100EBAD
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:36:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next 4/4] mptcp: optimize the input options processing.
Date: Wed, 18 Aug 2021 12:35:49 +0200
Message-Id: <a9d6141b27791d0a339de98503363ab83b03106f.1629133749.git.pabeni@redhat.com>
In-Reply-To: <4209d5f5217483e4c06a43afb8e3e8322566085d.1629133749.git.pabeni@redhat.com>
References: <4209d5f5217483e4c06a43afb8e3e8322566085d.1629133749.git.pabeni@redhat.com>
Precedence: bulk
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

Most MPTCP packets carries a single MPTCP subption: the
DSS containing the mapping for the current packet.

Check explicitly for the above, so that is such scenario we
replace most conditional statements with a single likely() one.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 70 +++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 18ad028ed589..61ef080ed46c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1115,48 +1115,50 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
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
@@ -1183,7 +1185,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	memset(mpext, 0, sizeof(*mpext));
 
-	if (mp_opt.use_map) {
+	if (likely(mp_opt.use_map)) {
 		if (mp_opt.mpc_map) {
 			/* this is an MP_CAPABLE carrying MPTCP data
 			 * we know this map the first chunk of data
-- 
2.26.3

