Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455E1CE53
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686155664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rxgZ1NuOd2Ctn0yRXywf+5/lWT6265DXkRFqCV4IL8Y=;
	b=a2YhqmOJv1fdkck/VJIy0tEKgN+tQSbaFis8mI+HMztI9g73sTpGij8e/bK93e9miU3y+p
	ct1JnDaTwf5XD05TzrHu9SBTPebe15azGgyjhLlxYrzn6INoIdwiDMjJJMiD1KxsnGiobZ
	M21smlEUDXT9Twg7KtGyIAWn6r7OOTs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-WKWuzunRMnW9OmgWHceO8A-1; Wed, 07 Jun 2023 12:34:15 -0400
X-MC-Unique: WKWuzunRMnW9OmgWHceO8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AB872823802
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 16:34:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 19BC19E8E
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 16:34:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: consolidate transition to TCP_CLOSE in mptcp_do_fastclose()
Date: Wed,  7 Jun 2023 18:34:06 +0200
Message-Id: <ca4ee22bcb340d3c07778259ce6c08b4d39e89d0.1686155634.git.pabeni@redhat.com>
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

The MPTCP code always set the msk state to TCP_CLOSE before
calling performing the fast-close. Move such state transition in
mptcp_do_fastclose() to avoid some code duplication.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e93a678d057f..a94d0f16e2c5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2707,6 +2707,7 @@ static void mptcp_do_fastclose(struct sock *sk)
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	inet_sk_state_store(sk, TCP_CLOSE);
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
 		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
 				  subflow, MPTCP_CF_FASTCLOSE);
@@ -2744,10 +2745,9 @@ static void mptcp_worker(struct work_struct *work)
 	 * even if it is orphaned and in FIN_WAIT2 state
 	 */
 	if (sock_flag(sk, SOCK_DEAD)) {
-		if (mptcp_should_close(sk)) {
-			inet_sk_state_store(sk, TCP_CLOSE);
+		if (mptcp_should_close(sk))
 			mptcp_do_fastclose(sk);
-		}
+
 		if (sk->sk_state == TCP_CLOSE) {
 			__mptcp_destroy_sock(sk);
 			goto unlock;
@@ -2994,7 +2994,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
 void __mptcp_unaccepted_force_close(struct sock *sk)
 {
 	sock_set_flag(sk, SOCK_DEAD);
-	inet_sk_state_store(sk, TCP_CLOSE);
 	mptcp_do_fastclose(sk);
 	__mptcp_destroy_sock(sk);
 }
@@ -3036,7 +3035,6 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		/* If the msk has read data, or the caller explicitly ask it,
 		 * do the MPTCP equivalent of TCP reset, aka MPTCP fastclose
 		 */
-		inet_sk_state_store(sk, TCP_CLOSE);
 		mptcp_do_fastclose(sk);
 		timeout = 0;
 	} else if (mptcp_close_state(sk)) {
-- 
2.40.1

