Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F02FA1
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619189440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hh/KWjnlOIvcl0s+M/wB81PKxmqUi7R7c8uYVBrx4XA=;
	b=ZdChO3XwPO0l4VkQOCz0TdIocdI4BtzKmPm53qNR2rbs8UgVIDP6gY3sK/4AASS1lKEHl0
	hl7BuriJbuYikYFcc8UzqL4xz+1UzRZSDQ0EB/u639YUGoUzJ0lMeo0GLQvPIBXjDOPyRv
	xWwY4O7yS1Bijadb9VhIXTeVKiRQmM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-Lw3AwGdDOdCR69NZX1Y6nw-1; Fri, 23 Apr 2021 10:50:37 -0400
X-MC-Unique: Lw3AwGdDOdCR69NZX1Y6nw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E418E6A2A0;
	Fri, 23 Apr 2021 14:50:36 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-60.ams2.redhat.com [10.36.115.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0DCEA19D9B;
	Fri, 23 Apr 2021 14:50:35 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v4 mptcp-next 19/22] mptcp: add the mib for data checksum
Date: Fri, 23 Apr 2021 16:49:58 +0200
Message-Id: <926bd1799e9ccc01e980378bd316afd014ae4c11.1619189145.git.pabeni@redhat.com>
In-Reply-To: <cover.1619189145.git.pabeni@redhat.com>
References: <cover.1619189145.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

From: Geliang Tang <geliangtang@gmail.com>

This patch added the mib for the data checksum, MPTCP_MIB_DSSCSUMERR.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/mib.c     | 1 +
 net/mptcp/mib.h     | 1 +
 net/mptcp/subflow.c | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index eb2dc6dbe212..c7042e3317b5 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -25,6 +25,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
+	SNMP_MIB_ITEM("DSSCsumErr", MPTCP_MIB_DSSCSUMERR),
 	SNMP_MIB_ITEM("OFOQueueTail", MPTCP_MIB_OFOQUEUETAIL),
 	SNMP_MIB_ITEM("OFOQueue", MPTCP_MIB_OFOQUEUE),
 	SNMP_MIB_ITEM("OFOMerge", MPTCP_MIB_OFOMERGE),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index f0da4f060fe1..c407358eced8 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -18,6 +18,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
+	MPTCP_MIB_DSSCSUMERR,		/* The DSS checksum fail */
 	MPTCP_MIB_OFOQUEUETAIL,	/* Segments inserted into OoO queue tail */
 	MPTCP_MIB_OFOQUEUE,		/* Segments inserted into OoO queue */
 	MPTCP_MIB_OFOMERGE,		/* Segments merged in OoO queue */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b61ebadd796c..4182dff3d5d4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -898,8 +898,10 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 	header.csum = 0;
 
 	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
-	if (unlikely(csum_fold(csum)))
+	if (unlikely(csum_fold(csum))) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCSUMERR);
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
+	}
 
 	return MAPPING_OK;
 }
-- 
2.26.2

