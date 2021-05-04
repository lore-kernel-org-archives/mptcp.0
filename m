Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF12F80
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620163807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VgMX0KVyfoQsaIODAjE4skMQv/z4FkzpqwYzbkZRJ70=;
	b=QQL5Rxc+hVzfkQfUo3cUnfmE+P9H4hHbCKu02Na0bVNj38y4EE2gfdDBYRYX13oegP5uIO
	1mH1TqnBK4EnBIN9fZGrtMJ7NzCnBzB+KAz9Iu9BEGFmGZGZWvCSD785LBh3CbyZRiMi2m
	7nm6w1/f6g00sN2ZpKFeNeY7A/Ao84c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-tVOpWHKKPJCtKrmo1_Iy1A-1; Tue, 04 May 2021 17:30:06 -0400
X-MC-Unique: tVOpWHKKPJCtKrmo1_Iy1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B65D18B9ECA;
	Tue,  4 May 2021 21:30:05 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4A9B96090F;
	Tue,  4 May 2021 21:30:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v5 mptcp-next 18/21] mptcp: add the mib for data checksum
Date: Tue,  4 May 2021 23:29:28 +0200
Message-Id: <c5ce2a3a0e41511310f326f27b75dfd7d5ecb277.1620162984.git.pabeni@redhat.com>
In-Reply-To: <cover.1620162984.git.pabeni@redhat.com>
References: <cover.1620162984.git.pabeni@redhat.com>
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
index 14bdad401ff8..db1bc0ff242f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -902,8 +902,10 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
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

