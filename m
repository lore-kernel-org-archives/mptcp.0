Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0529372
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1626210840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uj/iQMHU4MXU9ebSzkA0SaOUO8pbisQiKCHnxX+VxSI=;
	b=Dlzd3Yuxzkyp+ZXEhUcCqz4ipOQE8opshBOw9k3Y4tqy+MY2+HRD+BT38Die6pZNqeq9F1
	LYdLNn9FHS6RSK3RYspOE0/Laikk61ZshBMTdQ+BauJjoYkg+DwCFvGUiy9xP6ArSc86GJ
	9cfVZgoV9rXuJ0fgqvGM/DwWsLIWRqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-v7AvnKBlNHik0aMthYs0-Q-1; Tue, 13 Jul 2021 17:13:59 -0400
X-MC-Unique: v7AvnKBlNHik0aMthYs0-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D70D5074C
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:58 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-114.ams2.redhat.com [10.36.113.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EC2C760CA0
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 21:13:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 7/8] mptcp: backup flag from incoming MPJ ack option
Date: Tue, 13 Jul 2021 23:13:37 +0200
Message-Id: <e4a7c2bae5fdd5f41862cb76fdc04ee6e3dbc7f6.1626210682.git.pabeni@redhat.com>
In-Reply-To: <cover.1626210682.git.pabeni@redhat.com>
References: <cover.1626210682.git.pabeni@redhat.com>
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

the parsed incoming backup flag is not propagated
to the subflow itself, the client may end-up using it
to send data.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/191
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 966f777d35ce..1151926d335b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -435,10 +435,12 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			goto do_reset;
 		}
 
+		subflow->backup = mp_opt.backup;
 		subflow->thmac = mp_opt.thmac;
 		subflow->remote_nonce = mp_opt.nonce;
-		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u", subflow,
-			 subflow->thmac, subflow->remote_nonce);
+		pr_debug("subflow=%p, thmac=%llu, remote_nonce=%u backup=%d",
+			 subflow, subflow->thmac, subflow->remote_nonce,
+			 subflow->backup);
 
 		if (!subflow_thmac_valid(subflow)) {
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINACKMAC);
-- 
2.26.3

