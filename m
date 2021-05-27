Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DEB2FB1
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622131877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q97RnTopCYV2gEx+TkjEckQ7lJ6quz2C25Mggs3mQxQ=;
	b=MeJ6Gm1B0tR4pjBwj9yNIdD73wK/QfhrBvoJ2CcLH1L2NhlJ1krkCUC7wrwcmua8/tF1jt
	l7YzPnz8hxcMUyN4HxJ4jB7dShcfMFPnj7O8UH9CJHWvekzDxxVEQf2JapcwB3SQdHE2bS
	spuscUewIDqEos/glPKURGS/WoH5IAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-Fbl0jYaROfqeoflY7ndSvg-1; Thu, 27 May 2021 12:11:15 -0400
X-MC-Unique: Fbl0jYaROfqeoflY7ndSvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B12DD801B15
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 16:11:14 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-53.ams2.redhat.com [10.36.114.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2797060CDE
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 16:11:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next] mptcp: use fast lock for subflows when possible.
Date: Thu, 27 May 2021 18:11:10 +0200
Message-Id: <ef0582a975599149d8a127d6f6914760bb64f136.1622131853.git.pabeni@redhat.com>
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

There are a bunch of callsite where the ssk socket
lock is acquired using the full-blown version eligible for
the fast variant. Let's move to the latter.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - add more chunks in protocol.c
---
 net/mptcp/pm_netlink.c | 10 ++++++----
 net/mptcp/protocol.c   | 15 +++++++++------
 2 files changed, 15 insertions(+), 10 deletions(-)

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
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 785e74c13b3c..786f09d83d35 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -433,23 +433,25 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
 
-		lock_sock(ssk);
+		slow = lock_sock_fast(ssk);
 		if (tcp_can_send_ack(ssk))
 			tcp_send_ack(ssk);
-		release_sock(ssk);
+		unlock_sock_fast(ssk, slow);
 	}
 }
 
 static bool mptcp_subflow_cleanup_rbuf(struct sock *ssk)
 {
+	bool slow;
 	int ret;
 
-	lock_sock(ssk);
+	slow = lock_sock_fast(ssk);
 	ret = tcp_can_send_ack(ssk);
 	if (ret)
 		tcp_cleanup_rbuf(ssk, 1);
-	release_sock(ssk);
+	unlock_sock_fast(ssk, slow);
 	return ret;
 }
 
@@ -2252,13 +2254,14 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
 
-		lock_sock(tcp_sk);
+		slow = lock_sock_fast(tcp_sk);
 		if (tcp_sk->sk_state != TCP_CLOSE) {
 			tcp_send_active_reset(tcp_sk, GFP_ATOMIC);
 			tcp_set_state(tcp_sk, TCP_CLOSE);
 		}
-		release_sock(tcp_sk);
+		unlock_sock_fast(tcp_sk, slow);
 	}
 
 	inet_sk_state_store(sk, TCP_CLOSE);
-- 
2.26.3

