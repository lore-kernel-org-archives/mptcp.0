Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6FAD47
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 19:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680810138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vpsk1F9kPAk2HNvGGAI04w6NuQxcEFAwzufWxB0HYSU=;
	b=KSftbses4O8QyOT23STPSOeYPJdjd4KujtsKdFnRBj5wlKmZ5LLQorWcqggWYs9eSZay/s
	7DwQZ2lU5u2IWKqFqrDn8jHKkTVN2xXkJFTPkH26yJnghepEJvJEWvRGOIq3Cy8fN77g0Q
	L59NUVeUZy160GQgrQMeQ7/MSyxFSv4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-Isa8xP-sNwedLhzB4hYvew-1; Thu, 06 Apr 2023 15:42:17 -0400
X-MC-Unique: Isa8xP-sNwedLhzB4hYvew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E42A48996E1
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 19:42:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 73B4718EC6
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 19:42:16 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] Squash-to: "mptcp: fix accept vs worker race"
Date: Thu,  6 Apr 2023 21:41:58 +0200
Message-Id: <a0b61938d72605d35cd4d988ac533b88f45d7f89.1680810015.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Avoid the ugly timeout hack, we can rely simple on
the in_accept_queue flag.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c131315d833b..045570ebad96 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2387,8 +2387,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 		/* ensure later check in mptcp_worker will dispose the msk */
 		sock_set_flag(sk, SOCK_DEAD);
-		inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32 -
-							  TCP_TIMEWAIT_LEN -1;
 	}
 
 	dispose_it = !msk->subflow || ssk != msk->subflow->sk;
@@ -2495,12 +2493,12 @@ static void __mptcp_close_subflow(struct sock *sk)
 
 }
 
-static bool mptcp_check_close_timeout(const struct sock *sk)
+static bool mptcp_should_close(const struct sock *sk)
 {
 	s32 delta = tcp_jiffies32 - inet_csk(sk)->icsk_mtup.probe_timestamp;
 	struct mptcp_subflow_context *subflow;
 
-	if (delta >= TCP_TIMEWAIT_LEN)
+	if (delta >= TCP_TIMEWAIT_LEN || mptcp_sk(sk)->in_accept_queue)
 		return true;
 
 	/* if all subflows are in closed status don't bother with additional
@@ -2723,7 +2721,7 @@ static void mptcp_worker(struct work_struct *work)
 	 * even if it is orphaned and in FIN_WAIT2 state
 	 */
 	if (sock_flag(sk, SOCK_DEAD)) {
-		if (mptcp_check_close_timeout(sk)) {
+		if (mptcp_should_close(sk)) {
 			inet_sk_state_store(sk, TCP_CLOSE);
 			mptcp_do_fastclose(sk);
 		}
-- 
2.39.2

