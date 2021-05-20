Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56512FB6
	for <mptcp@lists.linux.dev>; Thu, 20 May 2021 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621521997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mJ6y/tuZY8G8WlPWiDMnosrwD/p+d0dNtBl3nY5UuIA=;
	b=GQVirmZa7/Xybit9TLQjBlQ4Fl93HJGfFk2Fxpz/sUucbkJL8j9bXAH1voAneCfNfd5xhi
	UOo6uUvKAT2rtaOsb9wB77BLUECUWJRDjdjZJXXqzhsHnl5d/ocedGiERskc4IaMAFi1yq
	bAAGDhC/ZnPQe7doZmd+fgDLdtbHPVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-CQ6pddeCPxy6YHJiKTyUWQ-1; Thu, 20 May 2021 10:46:31 -0400
X-MC-Unique: CQ6pddeCPxy6YHJiKTyUWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72743106BAEE
	for <mptcp@lists.linux.dev>; Thu, 20 May 2021 14:46:29 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-166.ams2.redhat.com [10.36.114.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B53C610013C1
	for <mptcp@lists.linux.dev>; Thu, 20 May 2021 14:46:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-net 1/3] mptcp: always parse mptcp options for MPC reqsk
Date: Thu, 20 May 2021 16:46:13 +0200
Message-Id: <7e97e8e3c7d9265dcbf098b57f12da11d0b383b1.1621521884.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

In subflow_syn_recv_sock() we currently skip options parsing
for OoO packet, given that such packets may not carry the relevant
MPC option.

If the peer generates an MPC+data TSO packet and some of the early
segments are lost or get reorder, we server will ignore the peer key,
causing transient, unexpected fallback to TCP.

The solution is always parsing the incoming MPTCP options, and
do the fallback only for in-order packets. This actually cleans
the existing code a bit.

Reported-by:  Matthieu Baerts <matthieu.baerts@tessares.net>
Fixes: d22f4988ffec ("mptcp: process MP_CAPABLE data option")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
a note on data ack len: with this patch the server will use
ack32 for OoO MPC+data pkts, and will move to ack64 ASA will get
the first in order MPC+data pkt.

We can clean-up/make more consistent the behavior with some additional
check in mptcp_sk_clone and/or subflow_syn_recv_sock(), but I prefer
to not introduce only partially related changes here
---
 net/mptcp/subflow.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 554e7ccee02a..278986585088 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -633,21 +633,20 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 	/* if the sk is MP_CAPABLE, we try to fetch the client key */
 	if (subflow_req->mp_capable) {
-		if (TCP_SKB_CB(skb)->seq != subflow_req->ssn_offset + 1) {
-			/* here we can receive and accept an in-window,
-			 * out-of-order pkt, which will not carry the MP_CAPABLE
-			 * opt even on mptcp enabled paths
-			 */
-			goto create_msk;
-		}
-
+		/* we can receive and accept an in-window, out-of-order pkt,
+		 * which may not carry the MP_CAPABLE opt even on mptcp enabled
+		 * paths: always try to extract the peer key, and fallback
+		 * for packets missing it.
+		 * Even OoO DSS packets coming legitly after dropped or
+		 * reordered MPC will cause fallback, but we don't have other
+		 * options.
+		 */
 		mptcp_get_options(sk, skb, &mp_opt);
 		if (!mp_opt.mp_capable) {
 			fallback = true;
 			goto create_child;
 		}
 
-create_msk:
 		new_msk = mptcp_sk_clone(listener->conn, &mp_opt, req);
 		if (!new_msk)
 			fallback = true;
-- 
2.26.3

