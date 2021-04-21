Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C6F2F9C
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2yflXfPe/WVMVjAlAq2iiV8lrlSkLd4aMHnTQKTuWk=;
	b=I7XZzo53elx6J6cs2j0nY0boRDfiCCRiuS/7DWYl7/US10fnpZ9nDfJY1MkFugM3Ca9N4E
	8/JiLac8BCbJcTcaegpto8veQu0SSzUYrzUqD8klm/yFdm06JwexPhgJFNmQ3OiqU6wDEv
	qy+tFmtJ3uzsgqZN0rAoqVdC+p4QdCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-9EMnTFbCODWuNFH_z_ZHEg-1; Wed, 21 Apr 2021 16:21:01 -0400
X-MC-Unique: 9EMnTFbCODWuNFH_z_ZHEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A99151008061;
	Wed, 21 Apr 2021 20:21:00 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D5B46085A;
	Wed, 21 Apr 2021 20:20:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 18/21] mptcp: add the mib for data checksum
Date: Wed, 21 Apr 2021 22:18:07 +0200
Message-Id: <0ea2fdf868c525c568d39146cf2c00ecdcb46fb9.1619035356.git.pabeni@redhat.com>
In-Reply-To: <cover.1619035356.git.pabeni@redhat.com>
References: <cover.1619035356.git.pabeni@redhat.com>
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
index 6a3c161ebe34..fa777bf344b0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -893,8 +893,10 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
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

