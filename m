Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588B3E834D
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134390; cv=none; b=la9hYw0wESsramyQdqrlUZLlGbHDlnb7Dd0+lbQyxAcge/IHbQZ8Nzr+UvqxjJl9g/8dhTgMxtoDKEAw6L7ZjZELkIc7yBmuTQSBqc1QgeY4PIGgFcPW7XCiXa0pPuwNBPbOb3u2Z4vOPLFpayHlfVhARtr1+CisFNAekOjDRg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134390; c=relaxed/simple;
	bh=xi4wma0sGCDs5YiP6qtrDom+w38RdUquNyiDTlBxcto=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=REuabk2vMWSXWVM6dzdoA8xrzAimWLRQjpFWT0huEMMo5arY6Qkn7xvJlaBA9Fbf+1R+wVGIbOLubGgCbwabmP3KoEOffuWd33M3ZmvR6I4sTWJAYpzo9TWqS/ODARYDY2SXBuMhsDWpyYplyftr1H8hOjwNQmifcVfMnRmxetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXeIxU6F; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXeIxU6F"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1023221a91.3
        for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787134388; x=1787739188; darn=lists.linux.dev;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xBSz3F9j/Epa660zRM520n+/TfZd4tjQ2wZhRda+wSY=;
        b=BXeIxU6FPbPDv5eCljFF1Tg27r1a9u/S86r022UksiK41rQz3rvna1ecSyyX+c9CS/
         NQZjD0+Y9PUJ+/J6YApad/8/3uNOoiIlG/1sRn+WtbyvcByDIZmnRkZ5rZwMvyGNRhIZ
         NGKYLArgITfaXMkUy4Zpy2ibxEF3IcZke3mnJXQYCbblKTvg+7he+VPuKCXX79NSxSew
         zbEd2XrIUuWcc0nTXBU2br1arAECf5FnlNOIQqdJ+sR/Q1AKR/zqUEYf/bskZxgZPLLg
         hzT4hBxcD43sfClPbZyFnVgNT0aLNt2eaDBthW6WCk5ywF7DofYB5Ov/OR46t8FKArhN
         2ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134388; x=1787739188;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xBSz3F9j/Epa660zRM520n+/TfZd4tjQ2wZhRda+wSY=;
        b=YF0ukjlwsnne7RfMK3DNQdGE8sxVi1KKqrMjxxKanO8KTbZUx9VWctfp1xQuo36Zhi
         Czigh73d+d87NCt897U3iuWqEOX0mI3Ggy4o7FPhNM5AmeydghjytxnfHB2IyxTqRJzp
         4OZbtrrAZlDMVXQT1Tbt2qSAZyxzkMttu57QY8+XWzVkN3Azi/4jiafgUma9ha9a4CI5
         bbjo3LVGqK/sNybyxkNm/HxV6W4eEQNlB6sxw17zJUAkICXLD42V+EAaiHBAaPl/HZmN
         HFK9c2zpbRgCX6hwCvojHYXUtsw2r23xSe/hrE6UMxil/tWt+/pjgoMq57zQlp+I7k1/
         kbvw==
X-Gm-Message-State: AFuF++kwpGEnhscwpF0QyuT5PFQ0n9/0s1E6rSrYo+gO8OoqkSxFKQw2
	tGKzvnpAfQ2i26v8weh5r8h8j1RGtlBYDX7wuHVxtnMbLDPdBNINZ1gG
X-Gm-Gg: AR+sD13vTSpitC/bz012jDhoWc14JHSeCoN9Avv8+1Q8rb7OGHEkqWllCBZp4CnYpBr
	Z8hWJ9Cl8aFFLpjVKifFhNHgeGfwNvWLkvMLIX8e0MC2dlEWsJKBb2VTBnzetfWA4YPQxBaGGab
	SD4yy7u4fyUG55cu/U2Z1uJ9l46fuqpa60PHEfG4Xtyw1ubnagtrMkPss0IeukNQ+SHWtk56BQv
	ECrjo/9ogrJL2nF60lN5J3SVExIZDP13Z/YtnK5kQbMjnSBv2aDmTTVBnJ+A7lSzNzTq4AyD2G3
	t/LtkJAEhYr6aMZsXS/Jw/oy5/vA1C6HEXeZtsHwuiz+q+pmSuaMibH8xj77k+n/kP5UnaLE7jc
	ZgYdkCBHakqNnyVVz7sY4RQz5XF+t3JFbTMovvLs8SQpHHTZivcUGtf+SJOQjftkpwfNDXpj0G8
	6chBtluxI8zizoCH/Kphbh3ed6YNrm9kwJDCka1gsGWSfhmy/vbWGVIiQxf06kPzCX+6dPRJxHA
	1Ej2pi8
X-Received: by 2002:a17:90b:2b8e:b0:38e:75f3:ad4d with SMTP id 98e67ed59e1d1-39580f03c97mr6855304a91.7.1787134387862;
        Wed, 19 Aug 2026 03:13:07 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb7cc17sm2480629a91.9.2026.08.19.03.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:13:06 -0700 (PDT)
Date: Wed, 19 Aug 2026 19:13:02 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
	pabeni@redhat.com
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] mptcp: fix use-after-free of the subflow context on the
 delegated list
Message-ID: <aoWBrkNwebJe-koh@v4bel>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

mptcp_subflow_delegate() links the subflow context into a per-CPU napi
list and takes a reference on the subflow socket. The context is a
separate allocation, reached through icsk_ulp_data, and the list holds
no reference to it.

inet_csk_destroy_sock() runs sk_prot->destroy() regardless of the
outstanding references. That path ends in tcp_cleanup_ulp(), which calls
subflow_ulp_release(). subflow_ulp_release() frees the context with
kfree_rcu() but does not remove it from the list. Once the grace period
elapses and the context is actually freed, the next mptcp_napi_poll()
dequeues that entry and mptcp_subflow_delegated_next() writes to the
freed context with list_del_init(). That is the use-after-free.

The freeing path cannot dequeue the entry itself: the list is per-CPU
and only the CPU that queued the subflow may touch it, as
tcp_release_cb_override() already notes.

Delay the free instead. Add MPTCP_DELEGATE_DEAD.
mptcp_subflow_free_ctx() sets it and frees the context only if the
subflow is not scheduled, while mptcp_napi_poll() frees it if the dead
bit is set when it clears the scheduled bit. Either
mptcp_subflow_free_ctx() gets there first, sees the scheduled bit and
leaves the free to mptcp_napi_poll(), or mptcp_napi_poll() gets there
first, does not see the dead bit and mptcp_subflow_free_ctx() does the
free.

Also skip mptcp_subflow_process_delegated() once the dead bit is set.
subflow_ulp_release() has already dropped the msk reference by then, so
the pending actions must not run.

Finally, move delegated_status out of struct_group(reset).
mptcp_subflow_ctx_reset() clears that group on disconnect, and clearing
the scheduled bit while the entry is still queued would let
mptcp_subflow_free_ctx() free a context the napi list still points to.
delegated_node is already outside the group.

Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/mptcp/protocol.c | 13 ++++++++++---
 net/mptcp/protocol.h | 16 ++++++++++++++--
 net/mptcp/subflow.c  |  4 ++--
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7c8180d8d5eff6..8aa276dfe88639 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2641,7 +2641,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	 */
 	if (!inet_csk(ssk)->icsk_ulp_ops) {
 		WARN_ON_ONCE(!sock_flag(ssk, SOCK_DEAD));
-		kfree_rcu(subflow, rcu);
+		mptcp_subflow_free_ctx(subflow);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
 		__tcp_close(ssk, 0);
@@ -4617,10 +4617,13 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 	delegated = container_of(napi, struct mptcp_delegated_action, napi);
 	while ((subflow = mptcp_subflow_delegated_next(delegated)) != NULL) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		long status;
 
 		bh_lock_sock_nested(ssk);
 		if (!sock_owned_by_user(ssk)) {
-			mptcp_subflow_process_delegated(ssk, xchg(&subflow->delegated_status, 0));
+			status = xchg(&subflow->delegated_status, 0);
+			if (!(status & BIT(MPTCP_DELEGATE_DEAD)))
+				mptcp_subflow_process_delegated(ssk, status);
 		} else {
 			/* tcp_release_cb_override already processed
 			 * the action or will do at next release_sock().
@@ -4628,11 +4631,15 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 			 * CPU that scheduled it.
 			 */
 			smp_wmb();
-			clear_bit(MPTCP_DELEGATE_SCHEDULED, &subflow->delegated_status);
+			status = set_mask_bits(&subflow->delegated_status,
+					       BIT(MPTCP_DELEGATE_SCHEDULED), 0);
 		}
 		bh_unlock_sock(ssk);
 		sock_put(ssk);
 
+		if (status & BIT(MPTCP_DELEGATE_DEAD))
+			kfree_rcu(subflow, rcu);
+
 		if (++work_done == budget)
 			return budget;
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1b80f2d6ec5a23..df9d0bf127febd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -538,8 +538,10 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 #define MPTCP_DELEGATE_SEND		1
 #define MPTCP_DELEGATE_ACK		2
 #define MPTCP_DELEGATE_SNDBUF		3
+#define MPTCP_DELEGATE_DEAD		4
 
-#define MPTCP_DELEGATE_ACTIONS_MASK	(~BIT(MPTCP_DELEGATE_SCHEDULED))
+#define MPTCP_DELEGATE_ACTIONS_MASK	(~(BIT(MPTCP_DELEGATE_SCHEDULED) | \
+					   BIT(MPTCP_DELEGATE_DEAD)))
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
@@ -608,11 +610,11 @@ struct mptcp_subflow_context {
 
 	u32	subflow_id;
 
-	long	delegated_status;
 	unsigned long	fail_tout;
 
 	);
 
+	long	delegated_status;
 	struct	list_head delegated_node;   /* link into delegated_action, protected by local BH */
 
 	u32	setsockopt_seq;
@@ -788,6 +790,16 @@ mptcp_subflow_delegated_next(struct mptcp_delegated_action *delegated)
 	return ret;
 }
 
+static inline void mptcp_subflow_free_ctx(struct mptcp_subflow_context *subflow)
+{
+	long old = set_mask_bits(&subflow->delegated_status, 0,
+				 BIT(MPTCP_DELEGATE_DEAD));
+
+	/* a scheduled subflow is owned by mptcp_napi_poll(), which will free it */
+	if (!(old & BIT(MPTCP_DELEGATE_SCHEDULED)))
+		kfree_rcu(subflow, rcu);
+}
+
 void __mptcp_inherit_memcg(struct sock *sk, struct sock *ssk, gfp_t gfp);
 void __mptcp_inherit_cgrp_data(struct sock *sk, struct sock *ssk);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e1f20ff8fdb424..b118594ab1b9a8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -786,7 +786,7 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
 			sock_put(ctx->conn);
 	}
 
-	kfree_rcu(ctx, rcu);
+	mptcp_subflow_free_ctx(ctx);
 }
 
 void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
@@ -2024,7 +2024,7 @@ static void subflow_ulp_release(struct sock *ssk)
 
 	mptcp_subflow_ops_undo_override(ssk);
 	if (release)
-		kfree_rcu(ctx, rcu);
+		mptcp_subflow_free_ctx(ctx);
 }
 
 static void subflow_ulp_clone(const struct request_sock *req,
-- 
2.43.0

