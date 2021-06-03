Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB570
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 15:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622733394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TShxfy1GIOgN/hXpIormDG6FjaDjGU277w/Lg9e6SFA=;
	b=DrcwEHrqGmPHr9JJKfjiqhFFTzlR50X/2Qf9Hux5SBCGsOJx4vRI97UmI55EMkCDHRwR6N
	I4l/jAEa+ODw83pSZPr1CPIIsQv+l0sRju8UhMOlg9R/tcCCz+Gc6iFJXPwAkZpFU6VwHx
	9dkch2RvQpBORbXT+wwFjFWUj9CuqBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-Qh3CnZ94NYKleyNylP5N9w-1; Thu, 03 Jun 2021 11:16:32 -0400
X-MC-Unique: Qh3CnZ94NYKleyNylP5N9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3EC2100C636;
	Thu,  3 Jun 2021 15:16:31 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-52.ams2.redhat.com [10.36.115.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66BBF16ED7;
	Thu,  3 Jun 2021 15:16:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Maxim Galaganov <max@internet.ru>
Subject: [PATCH v2 mptcp-next] mptcp: add MIB counter for invalid mapping
Date: Thu,  3 Jun 2021 17:16:22 +0200
Message-Id: <9ec7261d647d0360851f3029ead0b46d38ccedd7.1622733220.git.pabeni@redhat.com>
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

Account this exceptional events for better introspection.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - update mptcp_snmp_list accordingly - Max
---
 net/mptcp/mib.c     | 1 +
 net/mptcp/mib.h     | 1 +
 net/mptcp/subflow.c | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index e7e60bc1fb96..52ea2517e856 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -25,6 +25,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
+	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
 	SNMP_MIB_ITEM("DataCsumErr", MPTCP_MIB_DATACSUMERR),
 	SNMP_MIB_ITEM("OFOQueueTail", MPTCP_MIB_OFOQUEUETAIL),
 	SNMP_MIB_ITEM("OFOQueue", MPTCP_MIB_OFOQUEUE),
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

