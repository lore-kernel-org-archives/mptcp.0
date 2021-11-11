Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4F92C82
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636647712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4a/qbwOJYGo2JNdZdSHQulKDUGsFZfQ8BnGelwBCrE=;
	b=bwEMXT9Mc9mv0VwohcQ/pl3iapxUYrgSkA6ZRAQtOSoqeUuZmlaaJdag9DD9C6MEFXlBw7
	S1pMf237HaTlO31+hzsR1h+OEyVBQNyzA6euyA7PlE2+/EVZiSAh2e5t1dsPItlTsryshb
	wjMSLX7/Aq5FEK+69GE+qlmPmiSuP8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-Eh0ir2j6MSapxYpqB8tujA-1; Thu, 11 Nov 2021 11:21:51 -0500
X-MC-Unique: Eh0ir2j6MSapxYpqB8tujA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DDE91006AA0
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:50 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F03175D6B1
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 16:21:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 1/7] mptcp: keep snd_una updated for fallback socket
Date: Thu, 11 Nov 2021 17:21:36 +0100
Message-Id: <6266a63f37bccd9d6f791a62417cdb227eb3910d.1636647623.git.pabeni@redhat.com>
In-Reply-To: <cover.1636647623.git.pabeni@redhat.com>
References: <cover.1636647623.git.pabeni@redhat.com>
Precedence: bulk
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

