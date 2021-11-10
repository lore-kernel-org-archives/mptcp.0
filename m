Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C529CA
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 12:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636547550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4a/qbwOJYGo2JNdZdSHQulKDUGsFZfQ8BnGelwBCrE=;
	b=AcOdUPbvXcU49LZ/1yKwT7Y4tP20RN7xvvaV88QpSrUgbo8AD3b1Qx4zdc0qQSF1rycdH0
	8h3fLMArGhIxbP4PXOIJw2xIf9aldYxp93dkZpNmmjIpMqxqp86q5eByVl9LwIBDgxnU2l
	X3eh6cdkS15SICmahIQ0oNXamWmqCqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-yCxyzpEGNi2dg2V2HazmSA-1; Wed, 10 Nov 2021 07:32:29 -0500
X-MC-Unique: yCxyzpEGNi2dg2V2HazmSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ACC21006AA3
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 12:32:28 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CBD8560843
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 12:32:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next 1/7] mptcp: keep snd_una updated for fallback socket
Date: Wed, 10 Nov 2021 13:31:34 +0100
Message-Id: <b36bee8a4ded8116a9143f5017b5988c60960046.1636545174.git.pabeni@redhat.com>
In-Reply-To: <cover.1636545174.git.pabeni@redhat.com>
References: <cover.1636545174.git.pabeni@redhat.com>
Precedence: bulk
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

After shutdown, for fallback MPTCP sockets, we always have

write_seq == snd_una+1

The above will foul OUTQ ioctl(). Keep snd_una in sync with
write_seq even after shutdown.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 29b6f57b917e..3fef1b4e7780 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2690,6 +2690,7 @@ static void __mptcp_check_send_data_fin(struct sock *sk)
 	 * state now
 	 */
 	if (__mptcp_check_fallback(msk)) {
+		WRITE_ONCE(msk->snd_una, msk->write_seq);
 		if ((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
 			inet_sk_state_store(sk, TCP_CLOSE);
 			mptcp_close_wake_up(sk);
-- 
2.33.1

