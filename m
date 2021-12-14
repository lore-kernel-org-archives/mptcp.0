Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB7468
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639501162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMR1hYkvoUwefVKooQD8Jdkgq7b6DI69kqlt/t+9Rd8=;
	b=FHHlFKrVdcRJHeO3EPzdhg5Gk10FuUWt6rba86NcftiTlkf15HzracDUiNoZfi4m9uDjGG
	RTr1ZSUsdLdDwhHiD3KAg3LTX7hRWtFBzJJtMI40r4bvRomnckqeBjzLWJeTkZxAtVDyPy
	BjyXob/B03ToHJwciGwE0KkSv7Cac7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-lgZzfA32Ms6pKbAY7OGMKQ-1; Tue, 14 Dec 2021 11:59:21 -0500
X-MC-Unique: lgZzfA32Ms6pKbAY7OGMKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA37A760C5
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.135])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DC92C106A7AE
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:59:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next 1/7] mptcp: fix per socket endpoint accounting.
Date: Tue, 14 Dec 2021 17:58:51 +0100
Message-Id: <1d4b99ad2e25c5b37aa5a57314b154d41a4c401c.1639500873.git.pabeni@redhat.com>
In-Reply-To: <cover.1639500873.git.pabeni@redhat.com>
References: <cover.1639500873.git.pabeni@redhat.com>
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

Since full-mesh endpoint support, the reception of a single ADD_ADDR
option can cause multiple subflows creation. When such option is
accepted we increment 'add_addr_accepted' by one. When we received
a paired RM_ADDR option, we deleted all the relevant subflows,
decrementing 'add_addr_accepted' by one for each of them.

We have a similar issue for 'local_addr_used'

Fix them moving the pm endpoint accounting outside the subflow
traversal.

Fixes: 1a0d6136c5f0 ("mptcp: local addresses fullmesh")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3186d33b5208..d18b13e3e74c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -710,6 +710,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		return;
 
 	for (i = 0; i < rm_list->nr; i++) {
+		bool removed = false;
+
 		list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
@@ -729,15 +731,19 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 
-			if (rm_type == MPTCP_MIB_RMADDR) {
-				msk->pm.add_addr_accepted--;
-				WRITE_ONCE(msk->pm.accept_addr, true);
-			} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
-				msk->pm.local_addr_used--;
-			}
+			removed = true;
 			msk->pm.subflows--;
 			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
+		if (!removed)
+			continue;
+
+		if (rm_type == MPTCP_MIB_RMADDR) {
+			msk->pm.add_addr_accepted--;
+			WRITE_ONCE(msk->pm.accept_addr, true);
+		} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
+			msk->pm.local_addr_used--;
+		}
 	}
 }
 
-- 
2.33.1

