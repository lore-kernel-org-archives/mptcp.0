Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D7E35BDA3
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143530; cv=none; b=F314ZP2b2rntsGuARbr5LKNhu6n++Y3gobwU0xh0UlcLj/33ApbPuAwd9VH1xovcFxztbpFrkzCwKzP0zzV2EhX98HGAaOQ4uXLflN1dvpzq5acxobDsLIpDDw6VN3Xww9MjyGVMtCHGLlY1eKa/5Cc8+C8QItp255Y/6n1OODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143530; c=relaxed/simple;
	bh=znx2HFTd2rH6xUuCooNzlawKI4U39jMC5Vp6ONfKKQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=PpYz9OIlJC5g4495mrLEzxUDRaRZ3rvMopGtDPMKQIq68YkTGMR1oJXEgRN+ypaicyi2EUkytjIKeHXiGkx9YoSVfea2m6C70r8jSyeeD2x1zySgooDByVUb71nwK8j2W8TR3WZvJco5vaT9JvqQbrJZ2aIQUm01jsGFpqCl+Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVLRXpz1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVLRXpz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761143527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPyAyZpLsNM5P/F8f0f6Eg9OvJ4UQF9u7d6wBBCteYs=;
	b=UVLRXpz1sVCP8Eawle1zK4/POPnh+BYVFpysITMkfdlBVe2DJ4kZhx1GUc3oNTdl4yCcnh
	tMDS8luoqzSZoZFKb4azfQUu9KUeFkdwuv4F+zbzy2+536+uwx2QIc4De4pUHRthriMCg0
	j+yOE9SQKF5bpbvgt109VDzpLd5ijF8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-9hr0l-J2MNSvczXTrQNakQ-1; Wed,
 22 Oct 2025 10:32:03 -0400
X-MC-Unique: 9hr0l-J2MNSvczXTrQNakQ-1
X-Mimecast-MFC-AGG-ID: 9hr0l-J2MNSvczXTrQNakQ_1761143522
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA0DC1805802;
	Wed, 22 Oct 2025 14:32:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 511561956056;
	Wed, 22 Oct 2025 14:32:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v6 mptcp-next 01/11] mptcp: drop bogus optimization in __mptcp_check_push()
Date: Wed, 22 Oct 2025 16:31:44 +0200
Message-ID: <a3f82e1c1d44bebc6bc9bb4d7dc944605d1f3afe.1761142784.git.pabeni@redhat.com>
In-Reply-To: <cover.1761142784.git.pabeni@redhat.com>
References: <cover.1761142784.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zpZQDEgQaTnrjPGgI3w5_80V9g7htpb3wTEj6roXZu4_1761143522
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Accessing the transmit queue without owning the msk socket lock is
inherently racy, hence __mptcp_check_push() could actually quit early
even when there is pending data.

That in turn could cause unexpected tx lock and timeout.

Dropping the early check avoids the race, implicitly relaying on later
tests under the relevant lock. With such change, all the other
mptcp_send_head() call sites are now under the msk socket lock and we
can additionally drop the now unneeded annotation on the transmit head
pointer accesses.

Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 11 ++++-------
 net/mptcp/protocol.h |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f42e28a031f39a..804227736638e3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -998,7 +998,7 @@ static void __mptcp_clean_una(struct sock *sk)
 			if (WARN_ON_ONCE(!msk->recovery))
 				break;
 
-			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+			msk->first_pending = mptcp_send_next(sk);
 		}
 
 		dfrag_clear(sk, dfrag);
@@ -1543,7 +1543,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		msk->first_pending = mptcp_send_next(sk);
 
 		if (msk->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
@@ -1903,7 +1903,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			get_page(dfrag->page);
 			list_add_tail(&dfrag->list, &msk->rtx_queue);
 			if (!msk->first_pending)
-				WRITE_ONCE(msk->first_pending, dfrag);
+				msk->first_pending = dfrag;
 		}
 		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d\n", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
@@ -2874,7 +2874,7 @@ static void __mptcp_clear_xmit(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_data_frag *dtmp, *dfrag;
 
-	WRITE_ONCE(msk->first_pending, NULL);
+	msk->first_pending = NULL;
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list)
 		dfrag_clear(sk, dfrag);
 }
@@ -3414,9 +3414,6 @@ void __mptcp_data_acked(struct sock *sk)
 
 void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 {
-	if (!mptcp_send_head(sk))
-		return;
-
 	if (!sock_owned_by_user(sk))
 		__mptcp_subflow_push_pending(sk, ssk, false);
 	else
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 0545eab231250d..a3bbce8950a5e0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -415,7 +415,7 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 
-	return READ_ONCE(msk->first_pending);
+	return msk->first_pending;
 }
 
 static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
-- 
2.51.0

