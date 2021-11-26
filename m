Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B42168
	for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 12:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637929162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jD308C1QiczBhX/LAxWPZcxwrxlTOMg31rQYGjXNCDY=;
	b=Q7veN72NPXQZeQQUOWdUepk5hBMW/7dItP3V4Z2Cey14OSFdKEZk9NC7jRhwXu+VBcZZKt
	zzwvAi+HFIn9Bx8tZbzQD+M6jW/ywe6qhGmdrnAZQ8mPrT4Jm8G4zp3/ecwwBbXGOouoOj
	VuEMm5CrgdHZK09IICXjG3U/Tf0qcM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-jCzBSTdANoOF6D3fbuypUQ-1; Fri, 26 Nov 2021 07:19:19 -0500
X-MC-Unique: jCzBSTdANoOF6D3fbuypUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3BCF190A7A0
	for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 12:19:18 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.163])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5C03719C46
	for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 12:19:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 2/4] mptcp: keep track of used local endpoint
Date: Fri, 26 Nov 2021 13:19:07 +0100
Message-Id: <a44a4d8c356f2318b75d174e701c42d5ea50edbc.1637929034.git.pabeni@redhat.com>
In-Reply-To: <cover.1637929034.git.pabeni@redhat.com>
References: <cover.1637929034.git.pabeni@redhat.com>
Precedence: bulk
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

So that we can skip already used endpoint at local address
selection time.
This allows for fair local endpoints usage in case of subflow
failure.

As a side effect, this patch also enforces that each endpoint
is used at most once for each mptcp connection.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm.c         | 1 +
 net/mptcp/pm_netlink.c | 8 +++++++-
 net/mptcp/protocol.h   | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 761995a34124..1ff856dd92c4 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -376,6 +376,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	WRITE_ONCE(msk->pm.accept_subflow, false);
 	WRITE_ONCE(msk->pm.remote_deny_join_id0, false);
 	msk->pm.status = 0;
+	bitmap_zero(msk->pm.endpoint_usage_mask, 256);
 
 	mptcp_pm_nl_data_init(msk);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3186d33b5208..78b68a8216b6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -173,6 +173,9 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
 
+		if (test_bit(entry->addr.id, msk->pm.endpoint_usage_mask))
+			continue;
+
 		if (entry->addr.family != sk->sk_family) {
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 			if ((entry->addr.family == AF_INET &&
@@ -512,8 +515,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			check_work_pending(msk);
 			nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
 			spin_unlock_bh(&msk->pm.lock);
-			for (i = 0; i < nr; i++)
+			for (i = 0; i < nr; i++) {
+				set_bit(local->addr.id, msk->pm.endpoint_usage_mask);
 				__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+			}
 			spin_lock_bh(&msk->pm.lock);
 			return;
 		}
@@ -1282,6 +1287,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
 		if (remove_subflow)
 			mptcp_pm_remove_subflow(msk, &list);
+		clear_bit(addr->id, msk->pm.endpoint_usage_mask);
 		release_sock(sk);
 
 next:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a6a4bd7de5b4..d384f285b6c1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -190,6 +190,7 @@ struct mptcp_pm_data {
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
+	DECLARE_BITMAP(endpoint_usage_mask, 256);
 	u8		addr_signal;
 	bool		server_side;
 	bool		work_pending;
-- 
2.33.1

