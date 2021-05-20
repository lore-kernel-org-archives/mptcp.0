Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A971
	for <mptcp@lists.linux.dev>; Thu, 20 May 2021 13:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621518430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kN4Jzty5N452x+R/DZWg8ZaY3n6KUWMB0+pDX4JQjFk=;
	b=fmPfmeqbTmPVAEh5+1AEtUs6PufBOiGyXEAiFWlfpD3nB3Irn8FnALhrKtlvaEdJV6a0FL
	iyHYy7Tl0b102oKMuc3fc7wX3SHUOt5aLnnPnVIV+qSpYzqLc9nRrUrvck+9U5PXWUMnmu
	chp7rHNs/XGeMwKYfGRBYX73RvdCOxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-vgEiTG9GOJqGEuNmYizonA-1; Thu, 20 May 2021 09:47:07 -0400
X-MC-Unique: vgEiTG9GOJqGEuNmYizonA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53A831854E39;
	Thu, 20 May 2021 13:47:06 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-166.ams2.redhat.com [10.36.114.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6408E5D74D;
	Thu, 20 May 2021 13:47:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-net] Squash-to: "mptcp: fix sk_forward_memory corruption under memory pressure"
Date: Thu, 20 May 2021 15:46:57 +0200
Message-Id: <03e3ba49f6d847686dced53e915ace73928fd008.1621517601.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Commit message to be replaced as follow:

"""
mptcp: fix sk_forward_memory corruption on retransmission

MPTCP sk_forward_memory handling is a bit special, as such field
is protected by the msk socket spin_lock, instead of the plain
socket lock.

Currently we have a code path updating such field without handling
the relevant lock:

__mptcp_retrans() -> __mptcp_clean_una_wakeup()

Several helpers in __mptcp_clean_una_wakeup() will update
sk_forward_alloc, possibly causing such field corruption, as reported
by Matthieu.

Address the issue providing and using a new variant of blamed function
which explicitly acquires the msk spin lock.
"""

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0dcb9b753f80..446acfb85493 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1040,7 +1040,7 @@ static void dfrag_clear(struct sock *sk, struct mptcp_data_frag *dfrag)
 	put_page(dfrag->page);
 }
 
-static bool __mptcp_do_clean_una(struct sock *sk)
+static void __mptcp_clean_una(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
@@ -1081,6 +1081,12 @@ static bool __mptcp_do_clean_una(struct sock *sk)
 	}
 
 out:
+	if (cleaned) {
+		if (tcp_under_memory_pressure(sk)) {
+			__mptcp_update_wmem(sk);
+			sk_mem_reclaim_partial(sk);
+		}
+	}
 
 	if (snd_una == READ_ONCE(msk->snd_nxt)) {
 		if (msk->timer_ival && !mptcp_data_fin_enabled(msk))
@@ -1088,34 +1094,22 @@ static bool __mptcp_do_clean_una(struct sock *sk)
 	} else {
 		mptcp_reset_timer(sk);
 	}
-	return cleaned;
-}
-
-static void __mptcp_clean_una(struct sock *sk)
-{
-	if (__mptcp_do_clean_una(sk) && tcp_under_memory_pressure(sk)) {
-		__mptcp_update_wmem(sk);
-		sk_mem_reclaim_partial(sk);
-	}
 }
 
 static void __mptcp_clean_una_wakeup(struct sock *sk)
 {
+#ifdef CONFIG_LOCKDEP
+	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock.slock));
+#endif
 	__mptcp_clean_una(sk);
 	mptcp_write_space(sk);
 }
 
-/* variant __mptcp_clean_una_wakeup() for caller owning the msk socket lock,
- * but not the msk_data_lock/msk socket spin lock
- */
 static void mptcp_clean_una_wakeup(struct sock *sk)
 {
-#ifdef CONFIG_LOCKDEP
-	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock));
-#endif
-	if (__mptcp_do_clean_una(sk) && tcp_under_memory_pressure(sk))
-		mptcp_mem_reclaim_partial(sk);
-	mptcp_write_space(sk);
+	mptcp_data_lock(sk);
+	__mptcp_clean_una_wakeup(sk);
+	mptcp_data_unlock(sk);
 }
 
 static void mptcp_enter_memory_pressure(struct sock *sk)
-- 
2.26.3

