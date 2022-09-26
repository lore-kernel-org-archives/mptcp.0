Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649A2F50
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664198819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H5lT0dB6qY1U/Cyg0NMmCANYB7S5xfuQUNNe8F7qVac=;
	b=iSEdan2LubfHzfcmrZT5PaF2xHQTQPLtdgDJfopm81xKU8PW7z/Lcpqye9lxNZ7VcSwmss
	VixltQOze1c1/zJZw/rPv/NRXzlQepcnfVcsQavqUdyQyv36MUZYryHX61zqDHRvqJ+cDS
	DWlbjz07QiQC3BWogJMhqozq3zgEQvk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-aMexDX3vO6a5Ng4dsCCWOw-1; Mon, 26 Sep 2022 09:26:58 -0400
X-MC-Unique: aMexDX3vO6a5Ng4dsCCWOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59AB1185A7A8
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 13:26:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.223])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E0D2BC15BA4
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 13:26:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] Squash-to: "mptcp: use fastclose on more edge scenarios"
Date: Mon, 26 Sep 2022 15:26:53 +0200
Message-Id: <0a7720e1aebc9ae8babf8b4881b7ad2acf672352.1664198754.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The orginal commit applied fastclose too aggressivly.
Specifically, we don't need a fastclose after the completion of
the data_fin handshakr for an orphaned socket.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
paired pktdrill update:
https://github.com/multipath-tcp/packetdrill/pull/88
---
 net/mptcp/protocol.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0eeb8115c9d0..c99eb4ce948e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2607,12 +2607,15 @@ static void mptcp_worker(struct work_struct *work)
 	 * closed, but we need the msk around to reply to incoming DATA_FIN,
 	 * even if it is orphaned and in FIN_WAIT2 state
 	 */
-	if (sock_flag(sk, SOCK_DEAD) &&
-	    (mptcp_check_close_timeout(sk) || sk->sk_state == TCP_CLOSE)) {
-		inet_sk_state_store(sk, TCP_CLOSE);
-		mptcp_do_fastclose(sk);
-		__mptcp_destroy_sock(sk);
-		goto unlock;
+	if (sock_flag(sk, SOCK_DEAD)) {
+		if (mptcp_check_close_timeout(sk)) {
+			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_do_fastclose(sk);
+		}
+		if (sk->sk_state == TCP_CLOSE) {
+			__mptcp_destroy_sock(sk);
+			goto unlock;
+		}
 	}
 
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
-- 
2.37.3

