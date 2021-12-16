Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38A82C82
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639665254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/T5bDPGlZhTkj3fm7orBGfwMxMMUCH7yToTR22nKMfk=;
	b=UCA54zjG1wgtqD14YQ8XDlSM9ahjG2yp8JBRqm/VoyjxrPnTiYYiZ2xWHebCM9q1uozUet
	Ya8qHyVF5paO1ckqLdEcopvr5rtdfY1cBwNX91i+5V9SegWQkTYgSieJ2tVMPWuhXNh9Ss
	gaKTE9kv/DuPKhDkpsyqvSU6F3pndQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-LDObtUoRPaOKTUCXyO4FXw-1; Thu, 16 Dec 2021 09:34:11 -0500
X-MC-Unique: LDObtUoRPaOKTUCXyO4FXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0551039393
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 14:34:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.243])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66ECD60C7F
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 14:34:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] Squash-to: "mptcp: cleanup MPJ subflow list handling"
Date: Thu, 16 Dec 2021 15:33:37 +0100
Message-Id: <70e15da075bab481ac07ed1ce8c2adc9740403c6.1639665203.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The self-tests in a loop triggered a UaF similar to:

https://github.com/multipath-tcp/mptcp_net-next/issues/250

The critical scenario is actually almost fixed by:

"mptcp: cleanup MPJ subflow list handling"

with a notable exception: if an MPJ handshake races with
mptcp_close(), the subflow enter the join_list and __mptcp_finish_join()
is processed at the msk socket lock release in mptcp_close(),
the subflow will preserver a danfling reference to the msk sk_socket.

Address the issue fragting the subflow only on successful
__mptcp_finish_join()

Note that issues/250 triggers even before
"mptcp: cleanup MPJ subflow list handling", as before such commit the join
list was not spliced by mptcp_close(). We could consider a net-only patch to
address that.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e81fd46a43c4..e89d7741aa7f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -810,9 +810,17 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 
 static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (((struct sock *)msk)->sk_state != TCP_ESTABLISHED)
+	struct sock *sk = (struct sock *)msk;
+
+	if (sk->sk_state != TCP_ESTABLISHED)
 		return false;
 
+	/* attach to msk socket only after we are sure we will deal with it
+	 * at close time
+	 */
+	if (sk->sk_socket && !ssk->sk_socket)
+		mptcp_sock_graft(ssk, sk->sk_socket);
+
 	mptcp_propagate_sndbuf((struct sock *)msk, ssk);
 	mptcp_sockopt_sync_locked(msk, ssk);
 	WRITE_ONCE(msk->allow_infinite_fallback, false);
@@ -3234,7 +3242,6 @@ bool mptcp_finish_join(struct sock *ssk)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct sock *parent = (void *)msk;
-	struct socket *parent_sock;
 	bool ret = true;
 
 	pr_debug("msk=%p, subflow=%p", msk, subflow);
@@ -3278,13 +3285,6 @@ bool mptcp_finish_join(struct sock *ssk)
 		return false;
 	}
 
-	/* attach to msk socket only after we are sure he will deal with us
-	 * at close time
-	 */
-	parent_sock = READ_ONCE(parent->sk_socket);
-	if (parent_sock && !ssk->sk_socket)
-		mptcp_sock_graft(ssk, parent_sock);
-
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
 
 out:
-- 
2.33.1

