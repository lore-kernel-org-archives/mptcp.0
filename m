Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A4670
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 11:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622719926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6vy2FUFlE0euhpM0LXrnnj/xaPX8G4HMKe3YDTHk9nY=;
	b=gbaSqGEQLuwXRxCZbOBrnvtlydAM25/CojzPSQAAo4CjlYj/ZzB+XHobtFvRcTzdQGIc/T
	4ujR5jrhGEoPHlw+X7IIz3JAX4+nlmJFN+Tf+iTpePTpFbmxP5g1k8F30ca2yqEJ7sQdhG
	tGMDROG84xa+NALS9J6OrYUwEIIFQoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-NHGy61tjPuaXk3gkreBYNg-1; Thu, 03 Jun 2021 07:32:02 -0400
X-MC-Unique: NHGy61tjPuaXk3gkreBYNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F6FD800D62
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 11:32:01 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-52.ams2.redhat.com [10.36.115.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 18EBB5C6B8
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 11:32:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net] mptcp: do not warn on bad input from the network
Date: Thu,  3 Jun 2021 13:31:47 +0200
Message-Id: <637fc17e2c0f833e820f7f8097fdc1212b4c968f.1622719886.git.pabeni@redhat.com>
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

warn_bad_map() produces a kernel WARN on bad input coming
from the network. Use pr_debug() to avoid spamming the system
log.

Additionally, when the right bound check fails, warn_bad_map() reports
the wrong ssn value, let's fix it.

Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/107
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
I think we should really abvoid the warn here. Later patches will add
MIB counters for the relevant event
---
 net/mptcp/subflow.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5ef31aa16cc1..259f99b61c35 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -787,10 +787,10 @@ static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
 	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
 }
 
-static void warn_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
+static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
 {
-	WARN_ONCE(1, "Bad mapping: ssn=%d map_seq=%d map_data_len=%d",
-		  ssn, subflow->map_subflow_seq, subflow->map_data_len);
+	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d",
+		 ssn, subflow->map_subflow_seq, subflow->map_data_len);
 }
 
 static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
@@ -815,13 +815,13 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
 		/* Mapping covers data later in the subflow stream,
 		 * currently unsupported.
 		 */
-		warn_bad_map(subflow, ssn);
+		dbg_bad_map(subflow, ssn);
 		return false;
 	}
 	if (unlikely(!before(ssn, subflow->map_subflow_seq +
 				  subflow->map_data_len))) {
 		/* Mapping does covers past subflow data, invalid */
-		warn_bad_map(subflow, ssn + skb->len);
+		dbg_bad_map(subflow, ssn);
 		return false;
 	}
 	return true;
-- 
2.26.3

