Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164170
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624896453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5TQyKTO3Obj8n6Hg8T6uTrNeRVzV82/nnowdhOrzjw=;
	b=AuCWa1Rjig/6tKDteTIE9iXT5ZXPo99DdCXS38Lfy8z440PgUax2OpbCfULJF9+WcQy+tt
	w994sjzemremOS50RSYTaaZhMd3AN+HmlpK9UsGuXglMRNKgBKmmOgYH5ZEjf+cmiaRxv2
	IuezXzHJwAeCKXop/m5grjylxwtn6zE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-ZY0BNrvAN_26I_dNQBQh-w-1; Mon, 28 Jun 2021 12:07:26 -0400
X-MC-Unique: ZY0BNrvAN_26I_dNQBQh-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BC081063C16
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 15:54:32 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-129.ams2.redhat.com [10.36.114.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7665060875;
	Mon, 28 Jun 2021 15:54:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: fwestpha@redhat.com
Subject: [PATCH mptcp-next 6/7] mptcp: backup flag from incoming MPJ ack option
Date: Mon, 28 Jun 2021 17:54:10 +0200
Message-Id: <162d876d8096b2ac1ff851c8ee5a437c00a95019.1624895054.git.pabeni@redhat.com>
In-Reply-To: <cover.1624895054.git.pabeni@redhat.com>
References: <cover.1624895054.git.pabeni@redhat.com>
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

the parsed incoming backup flag is not propagated
to the subflow itself, the client may end-up using it
to send data.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/191
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0b5d4a3eadcd..04bd8783f52c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -440,10 +440,12 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
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

