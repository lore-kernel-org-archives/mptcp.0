Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04CC38CBA
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686155623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UO5AOo5K2/RV9r2flg3cBzhYBnjOXPO2mmpKzlEVEQ=;
	b=BWdunRuIQEEziJ/g2UKysR9M3Cmg16LLNHYAT/vnV518AaQTQnNiN2FadS4KNwThYe0KGD
	V0LozmE31Cy+QEyNCoWfl9DylaPduyjTFI1Lhuxc4bE0dUVvepqTEpi/g3YxIxTQ8wg7iD
	gg1+LamUnhReHYKY2h+1EdEQafBxp6s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-vEsfzGPaOX2gf9w-90gt-Q-1; Wed, 07 Jun 2023 12:33:42 -0400
X-MC-Unique: vEsfzGPaOX2gf9w-90gt-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCB8D85A5BE
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 16:33:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5C7A340D1B66
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 16:33:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/2] mptcp: fix potential msk leak
Date: Wed,  7 Jun 2023 18:33:36 +0200
Message-Id: <d9dcf7a0fd779b3d24d7c10cb21b881d62b1fdc7.1686155270.git.pabeni@redhat.com>
In-Reply-To: <f88902bdf5168d86a858575a95882e3fbbadf556.1686155270.git.pabeni@redhat.com>
References: <f88902bdf5168d86a858575a95882e3fbbadf556.1686155270.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

An orphaned msk releases the used resources via the worker,
when the latter first see the msk in CLOSED status.

If the msk status transitions to TCP_CLOSE in the release callback
invoked by the worker's final release_sock(), such instance of the
workqueue will not take any action.

Additionally the MPTCP code prevents scheduling the worker once the
socket reaches the CLOSE status: such msk resources will be leaked.

The only code path that can trigger the above scenario is the
__mptcp_check_send_data_fin() in fallback mode. Address the issue
simply removing the dangerous state change: the msk will be closed
soon by the worker itself, triggered by MPTCP_WORK_CLOSE_SUBFLOW.

Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 94229a318fc1..e93a678d057f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2936,16 +2936,14 @@ static void __mptcp_check_send_data_fin(struct sock *sk)
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 
 	/* fallback socket will not get data_fin/ack, can move to the next
-	 * state now
+	 * state now. But can't set TCP_CLOSE here, as this code path is
+	 * reachable from the mptcp_release_cb(). Anyway the subflow will
+	 * close soon and the msk state will follow via WORK_CLOSE_SUBFLOW.
 	 */
 	if (__mptcp_check_fallback(msk)) {
 		WRITE_ONCE(msk->snd_una, msk->write_seq);
-		if ((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
-			inet_sk_state_store(sk, TCP_CLOSE);
-			mptcp_close_wake_up(sk);
-		} else if (sk->sk_state == TCP_FIN_WAIT1) {
+		if (sk->sk_state == TCP_FIN_WAIT1)
 			inet_sk_state_store(sk, TCP_FIN_WAIT2);
-		}
 	}
 
 	mptcp_for_each_subflow(msk, subflow) {
-- 
2.40.1

