Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB833FC3
	for <mptcp@lists.linux.dev>; Thu, 16 Sep 2021 16:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631808402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bEuaXyfQOu5u/+JCvqbiBHcW8UFLuVxbyVMngmczWMs=;
	b=L1V/VE3NlnUqBXyzu0xIVMz+RL+xX605G82rgl95PBvpwnIgu78oYOt9RazX/LAWc4yNUk
	K9/sweKtwbVP0r1x+ltFcSmbcohAeNGNkP+XYOqYyIKR6MX1V8fQjNNBRzz3jWpTDAPpG3
	8Hw/LYevOts8OTh/I7H7BMr9rraoSi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-ZZSo5O48PTWBQxSjiLJHsQ-1; Thu, 16 Sep 2021 12:06:41 -0400
X-MC-Unique: ZZSo5O48PTWBQxSjiLJHsQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5D6D800FF4
	for <mptcp@lists.linux.dev>; Thu, 16 Sep 2021 16:06:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 15BD35C1CF
	for <mptcp@lists.linux.dev>; Thu, 16 Sep 2021 16:06:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: always provide MPTCP skb ext for tx skb
Date: Thu, 16 Sep 2021 18:06:15 +0200
Message-Id: <0bcf04149918792f287bf56fb5a38e4a19be4fe0.1631808364.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The mptcp code will uses whatever skb is present into
ssk->sk_tx_skb_cache. If the skb tx cache is enabled, the
recycle operation will clean the MPTCP extension from the
cached skb, and the MPTCP would hit a later WARN.

Fix the issue always invoking the mptcp skb allocation
helper, which will safely check the cached skb for the extension
presence.

Fixes: 1094c6fe7280 ("mptcp: fix possible divide by zero")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2602f1386160..f0673541a764 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1325,7 +1325,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	}
 
 alloc_skb:
-	if (!must_collapse && !ssk->sk_tx_skb_cache &&
+	if (!must_collapse &&
 	    !mptcp_alloc_tx_skb(sk, ssk, info->data_lock_held))
 		return 0;
 
-- 
2.26.3

