Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFEB71
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620986753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JJSB9OvVs96iyeN4oMH088olTJEZQMpqDqKIm/zFJ24=;
	b=ikYvsCDpL7vOd+hWNaY/kw7G9JQLMMYILp/1Pua0sBq76DJcSlvTrVYmLbw5TmBbf982vR
	KYTnLa6jsIoxwSmZOQ1afCnnZuyHVGH472KgJ18vT3PaWEA1PCzHviqRftzEbXi0faHtyP
	on0n37l5KErP8jXybWVSBgXT4QTNcRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-33TRmp-hMVW6Iz4gGjW_WQ-1; Fri, 14 May 2021 06:05:51 -0400
X-MC-Unique: 33TRmp-hMVW6Iz4gGjW_WQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A52D98015F5
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 10:05:50 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-166.ams2.redhat.com [10.36.112.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1CB4810016F9
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 10:05:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: [PATCH mptcp-net] mptcp: fix sk_forward_memory corruption under memory pressure
Date: Fri, 14 May 2021 12:05:45 +0200
Message-Id: <b84d11a2f4c33e69637567e64138a453611064dc.1620986525.git.pabeni@redhat.com>
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

MPTCP sk_forward_memory handling is a bit special, as such field
is protected by the msk socket spin_lock, instead of the plain
socket lock.

Currently we have a code path updating such field without handling
the relevant lock:

__mptcp_retrans() -> __mptcp_clean_una_wakeup() -> __mptcp_update_wmem()

We can hit the above only under memory pressure. When that happen,
forward memory accounting could be corrupted, as reported by Mat.

Address the issue creating a new variant of __mptcp_clean_una_wakeup()
which handle fwd memory updates with the proper care and invoking
such new helper in the relevant code path.

Reported-by: 'Matthieu Baerts <matthieu.baerts@tessares.net>'
Fixes: 64b9cea7a0af ("mptcp: fix spurious retransmissions")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2d21a4793d9d..1d5d451e9211 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -947,6 +947,10 @@ static void __mptcp_update_wmem(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+#ifdef CONFIG_LOCKDEP
+	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock.slock));
+#endif
+
 	if (!msk->wmem_reserved)
 		return;
 
@@ -1027,7 +1031,7 @@ static void dfrag_clear(struct sock *sk, struct mptcp_data_frag *dfrag)
 	put_page(dfrag->page);
 }
 
-static void __mptcp_clean_una(struct sock *sk)
+static bool __mptcp_do_clean_una(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
@@ -1068,12 +1072,6 @@ static void __mptcp_clean_una(struct sock *sk)
 	}
 
 out:
-	if (cleaned) {
-		if (tcp_under_memory_pressure(sk)) {
-			__mptcp_update_wmem(sk);
-			sk_mem_reclaim_partial(sk);
-		}
-	}
 
 	if (snd_una == READ_ONCE(msk->snd_nxt)) {
 		if (msk->timer_ival && !mptcp_data_fin_enabled(msk))
@@ -1081,6 +1079,15 @@ static void __mptcp_clean_una(struct sock *sk)
 	} else {
 		mptcp_reset_timer(sk);
 	}
+	return cleaned;
+}
+
+static void __mptcp_clean_una(struct sock *sk)
+{
+	if (__mptcp_do_clean_una(sk) && tcp_under_memory_pressure(sk)) {
+		__mptcp_update_wmem(sk);
+		sk_mem_reclaim_partial(sk);
+	}
 }
 
 static void __mptcp_clean_una_wakeup(struct sock *sk)
@@ -1089,6 +1096,19 @@ static void __mptcp_clean_una_wakeup(struct sock *sk)
 	mptcp_write_space(sk);
 }
 
+/* variant __mptcp_clean_una_wakeup() for caller owning the msk socket lock,
+ * but not the msk_data_lock/msk socket spin lock
+ */
+static void mptcp_clean_una_wakeup(struct sock *sk)
+{
+#ifdef CONFIG_LOCKDEP
+	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock));
+#endif
+	if (__mptcp_do_clean_una(sk) && tcp_under_memory_pressure(sk))
+		mptcp_mem_reclaim_partial(sk);
+	mptcp_write_space(sk);
+}
+
 static void mptcp_enter_memory_pressure(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -2299,7 +2319,7 @@ static void __mptcp_retrans(struct sock *sk)
 	struct sock *ssk;
 	int ret;
 
-	__mptcp_clean_una_wakeup(sk);
+	mptcp_clean_una_wakeup(sk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
-- 
2.26.3

