Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838CB70
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 13:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622726762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EZ6NJxtqCkfi02gomPBv5KlemkBEYwLkpjS4/TEjD4o=;
	b=NCtlbIQDF2qaX5+ALAgptvXIyakjvOCUT4wJss4yuEn1GUZNxlo874ZnySVfck5E0Hpuke
	nZjew25M7EjffY8YIAhbs2WrQJ1OM8qULeiQhCjX/q3CumKSfNV7qn2gSfUqF9Ou5OIXas
	LzCjKhBDRfwaE05MzkZwBE+TpI4lfi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-9VNj0LIDOy-8ZXLxQ9edHQ-1; Thu, 03 Jun 2021 09:26:00 -0400
X-MC-Unique: 9VNj0LIDOy-8ZXLxQ9edHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D95C6800D62
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 13:25:59 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-52.ams2.redhat.com [10.36.115.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4F5595DEAD
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 13:25:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: add MIB counter for invalid mapping
Date: Thu,  3 Jun 2021 15:25:45 +0200
Message-Id: <89666f3fb8f14bbe545f2079794ab78ba24fbbc4.1622720045.git.pabeni@redhat.com>
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

Account this exceptional events for better introspection.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/mib.h     | 1 +
 net/mptcp/subflow.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 92e56c0cfbdd..193466c9b549 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -18,6 +18,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
+	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence numbers */
 	MPTCP_MIB_DATACSUMERR,		/* The data checksum fail */
 	MPTCP_MIB_OFOQUEUETAIL,	/* Segments inserted into OoO queue tail */
 	MPTCP_MIB_OFOQUEUE,		/* Segments inserted into OoO queue */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 259f99b61c35..ccc07cbab867 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1046,8 +1046,10 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	/* we revalidate valid mapping on new skb, because we must ensure
 	 * the current skb is completely covered by the available mapping
 	 */
-	if (!validate_mapping(ssk, skb))
+	if (!validate_mapping(ssk, skb)) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSTCPMISMATCH);
 		return MAPPING_INVALID;
+	}
 
 	skb_ext_del(skb, SKB_EXT_MPTCP);
 
-- 
2.26.3

