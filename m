Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1C70
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 08:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623831556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w/O5l1SaQqCn7/Krowq6GKltM9WKI7qABgnlEJXufg0=;
	b=gXXEOyIXJ6irZ7akfMgZijgAidQJploPrhIX3AMuLj1DqlJI3c38LrP9PN3MCpf4EBbsH3
	6FrcvhAtoRmgUIAfztuybL51qFXpJdWTLZpyALGKyHOHSZBl4sWMPRs6MA39nuuIUHo9Gw
	auudEo7ZRgfJx1HYn8lljeCjeG9cX/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-umL16IYrMUOYPB1W8NCbsw-1; Wed, 16 Jun 2021 04:19:14 -0400
X-MC-Unique: umL16IYrMUOYPB1W8NCbsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C86C100C618
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 08:19:13 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-145.ams2.redhat.com [10.36.114.145])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E7BCC19C66
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 08:19:12 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net] mptcp: fix bad handling of 32 bit ack wrap-around.
Date: Wed, 16 Jun 2021 10:19:08 +0200
Message-Id: <140f8561f1ba22d171c1acc35812b571b63c8836.1623831447.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

When receiving 32 bits DSS ack from the peer, the MPTCP need
to expand them to 64 bits value. The current code is buggy
WRT detecting 32 bits ack wrap-around: when the wrap-around
happens the current unsigned 32 bit ack value is lower than
the previous one.

Additionally check for possible reverse wrap and make the helper
visible, so that we could re-use it for the next patch.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/204
Fixes: cc9d25669866 ("mptcp: update per unacked sequence on pkt reception")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - fix comment typos
 - refactor to unify the code with the next patch.
   [yep I did just the opposite of my own plan ;)]
---
 net/mptcp/options.c  | 29 +++++++++++++++--------------
 net/mptcp/protocol.h |  8 ++++++++
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a05270996613..b5850afea343 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -942,19 +942,20 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	return false;
 }
 
-static u64 expand_ack(u64 old_ack, u64 cur_ack, bool use_64bit)
+u64 __mptcp_expand_seq(u64 old_seq, u64 cur_seq)
 {
-	u32 old_ack32, cur_ack32;
-
-	if (use_64bit)
-		return cur_ack;
-
-	old_ack32 = (u32)old_ack;
-	cur_ack32 = (u32)cur_ack;
-	cur_ack = (old_ack & GENMASK_ULL(63, 32)) + cur_ack32;
-	if (unlikely(before(cur_ack32, old_ack32)))
-		return cur_ack + (1LL << 32);
-	return cur_ack;
+	u32 old_seq32, cur_seq32;
+
+	old_seq32 = (u32)old_seq;
+	cur_seq32 = (u32)cur_seq;
+	cur_seq = (old_seq & GENMASK_ULL(63, 32)) + cur_seq32;
+	if (unlikely(cur_seq32 < old_seq32 && before(old_seq32, cur_seq32)))
+		return cur_seq + (1LL << 32);
+
+	/* reverse wrap could happen, too */
+	if (unlikely(cur_seq32 > old_seq32 && after(old_seq32, cur_seq32)))
+		return cur_seq - (1LL << 32);
+	return cur_seq;
 }
 
 static void ack_update_msk(struct mptcp_sock *msk,
@@ -972,7 +973,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 	 * more dangerous than missing an ack
 	 */
 	old_snd_una = msk->snd_una;
-	new_snd_una = expand_ack(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
+	new_snd_una = mptcp_expand_seq(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
 
 	/* ACK for data not even sent yet? Ignore. */
 	if (after64(new_snd_una, snd_nxt))
@@ -1009,7 +1010,7 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool us
 		return false;
 
 	WRITE_ONCE(msk->rcv_data_fin_seq,
-		   expand_ack(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
+		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
 	WRITE_ONCE(msk->rcv_data_fin, 1);
 
 	return true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f4eaa5f57e3f..41f2957bf50c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -615,6 +615,14 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
 int mptcp_getsockopt(struct sock *sk, int level, int optname,
 		     char __user *optval, int __user *option);
 
+u64 __mptcp_expand_seq(u64 old_seq, u64 cur_seq);
+static inline u64 mptcp_expand_seq(u64 old_seq, u64 cur_seq, bool use_64bit)
+{
+	if (use_64bit)
+		return cur_seq;
+
+	return __mptcp_expand_seq(old_seq, cur_seq);
+}
 void __mptcp_check_push(struct sock *sk, struct sock *ssk);
 void __mptcp_data_acked(struct sock *sk);
 void __mptcp_error_report(struct sock *sk);
-- 
2.26.3

