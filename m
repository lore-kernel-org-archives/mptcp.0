Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF43770
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622045255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q9TASXkjYCOaCLRjEl7rDf96lqtgwY8FbmJcrQcT2F8=;
	b=A31UOFoR0Dw+iqKOlvNbsALKWHkptSLtYrouJMSphCtrJDG9yufRj5nApjnr3ok2Zfn2Au
	oPt4DjdBLFxCFnGpStB0NAUYjUtaLRBLeSygV0v0GkbK24CTTHmhdjOR3/qTH9WE+6CgGB
	FHi3wHH2El7IDZBfvCiXrqnLB9v/YAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-bbT_-oxRPt25q2kgu5iHiw-1; Wed, 26 May 2021 12:07:34 -0400
X-MC-Unique: bbT_-oxRPt25q2kgu5iHiw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EEC6803645
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:07:33 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-44.ams2.redhat.com [10.36.113.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B7A551ACB9
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:07:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: use fast lock for subflows when possible.
Date: Wed, 26 May 2021 18:07:21 +0200
Message-Id: <f18ab6d96263347de227dadcef3aff102f682ab9.1622045130.git.pabeni@redhat.com>
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

There are a bunch of callsite where the ssk socket
lock is acquired using the full-blown version eligible for
the fast variant. Let's move to the latter.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
The previous patch demonstrated that using lock_sock()
were the fast version is available can have worse side-effect
than slower performances.

This tries to address the topic.
---
 net/mptcp/pm_netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 09722598994d..d4732a4f223e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -540,6 +540,7 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 	subflow = list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node);
 	if (subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
 
 		spin_unlock_bh(&msk->pm.lock);
 		pr_debug("send ack for %s%s%s",
@@ -547,9 +548,9 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 			 mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]" : "",
 			 mptcp_pm_should_add_signal_port(msk) ? " [port]" : "");
 
-		lock_sock(ssk);
+		slow = lock_sock_fast(ssk);
 		tcp_send_ack(ssk);
-		release_sock(ssk);
+		unlock_sock_fast(ssk, slow);
 		spin_lock_bh(&msk->pm.lock);
 	}
 }
@@ -566,6 +567,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info local;
+		bool slow;
 
 		local_address((struct sock_common *)ssk, &local);
 		if (!addresses_equal(&local, addr, addr->port))
@@ -578,9 +580,9 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 
 		spin_unlock_bh(&msk->pm.lock);
 		pr_debug("send ack for mp_prio");
-		lock_sock(ssk);
+		slow = lock_sock_fast(ssk);
 		tcp_send_ack(ssk);
-		release_sock(ssk);
+		unlock_sock_fast(ssk, slow);
 		spin_lock_bh(&msk->pm.lock);
 
 		return 0;
-- 
2.26.3

