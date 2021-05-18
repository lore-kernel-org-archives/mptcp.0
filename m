Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80571
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621358160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p68WH9VLySDskaiMusnmvTj/VpfP+ltUb2MqzTApKS0=;
	b=ZZ7fvJLsVXQO3dm0IwMoz9uFOxq13cL9e2kh7fdPaCDsYuUlDTh6eoeaSkRLd1weF7jx95
	b+Uq2NE3ic2m0a1eInyrUoNgpA2DwQW0FeNsH4xAOeuO+aRs9q0QtHZEtA6hdwnsjmjklZ
	ZTSufWFcF33BoS6ct5aGzSeRRR8rRvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-m6-ZpTGFMm2W5ajyoe6CIA-1; Tue, 18 May 2021 13:15:59 -0400
X-MC-Unique: m6-ZpTGFMm2W5ajyoe6CIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C266180FD68
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 17:15:58 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-188.ams2.redhat.com [10.36.112.188])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C852118E47
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 17:15:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: drop unconditional pr_warn on bad opt
Date: Tue, 18 May 2021 19:15:53 +0200
Message-Id: <a4a3c36230b2aeb1315c6234fa39f9ef711be759.1621358150.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

This is a left-over of early day. A malicious peer can flood
the kernel logs with useless messages, just drop it.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b713828819b6..f5daccaaac99 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -141,7 +141,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			memcpy(mp_opt->hmac, ptr, MPTCPOPT_HMAC_LEN);
 			pr_debug("MP_JOIN hmac");
 		} else {
-			pr_warn("MP_JOIN bad option size");
 			mp_opt->mp_join = 0;
 		}
 		break;
-- 
2.26.3

