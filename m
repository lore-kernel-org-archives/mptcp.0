Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87B971747
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685885; cv=none; b=JwkQIWJ1qQWa5oJQrhjjxbji6hVzjwWyfSLNXHQr7x8y4DfUlEvPkjNCZKH6zJpah19LDk/tnfiNdJe8U2wz8O0Y/sXg+FTj4MMssThNtjr8mbEi2tQhk8DMYBFo/r+8l/7cd1oFBPv7wY5uBHzoLO/VdDsNOhBxelqoNp4FUeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685885; c=relaxed/simple;
	bh=8EhGqUCMxIIk6p7KP8vYHQCybb1CvLP6H+OObhWQp/M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNTZiSIVcLF9Hzdasb49ptf8m1a6UddIc+6iPFTm2aBi3V/ezUIkdfHYzKl6Emuf/i9lXd47uhrYEND7ouTMeZdPBEo1aVarCqHV7q91QLj9LFjEZcNnGlCwqiIWfl0OrnOYFEwtLAhw1JiQ4pRudljcS+Kw8EYPjt7Cxzdrir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWUqgWzP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWUqgWzP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727685882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hTp1s1JkUjPO136VB2qzG2QNGJAR3ldAx5vl4P30v5U=;
	b=hWUqgWzP8dc4fobz4IOo0Lu9+pr59uANUkFRc6zgF92gre7NUPeshoFYwQ2RDPPrIc2sy3
	QBDJ9W57bExc9vo0MPFbPOsLf0iDUdL0o/EAEzvQbHbbwpYd2wOEQGrT623U06e8aSl5h7
	HpgOWw5+Z8AlQGN4DDsaeOs5U7Vb8/Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-ETuy3xrmN7KtcHTp0JNbPg-1; Mon,
 30 Sep 2024 04:44:41 -0400
X-MC-Unique: ETuy3xrmN7KtcHTp0JNbPg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98E9719772C8
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 08:44:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.210])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BD29196BFEB
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 08:44:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [Patch v2 mptcp-net 1/2] mptcp: handle consistently DSS corruption.
Date: Mon, 30 Sep 2024 10:44:25 +0200
Message-ID: <c32cac999a1e87b93d48d42e6eb9dea8d51f61e6.1727685608.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Bugged peer implementation can send corrupted DSS options, consistently
hitting a few warning in the data path. Use DEBUG_NET assertions, to
avoid the splat on some builds and handle consistently the error, dumping
related MIBs and performing fallback and/or reset according to the
subflow type.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - move mibs definition and fix typo (Matttbe)
 - use list_is_singular (Matttbe)
---
 net/mptcp/mib.c      |  2 ++
 net/mptcp/mib.h      |  2 ++
 net/mptcp/protocol.c | 24 +++++++++++++++++++++---
 net/mptcp/subflow.c  |  4 +++-
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 38c2efc82b94..ad88bd3c58df 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -32,6 +32,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinSynTxBindErr", MPTCP_MIB_JOINSYNTXBINDERR),
 	SNMP_MIB_ITEM("MPJoinSynTxConnectErr", MPTCP_MIB_JOINSYNTXCONNECTERR),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("DSSCorruptionFallback", MPTCP_MIB_DSSCORRUPTIONFALLBACK),
+	SNMP_MIB_ITEM("DSSCorruptionReset", MPTCP_MIB_DSSCORRUPTIONRESET),
 	SNMP_MIB_ITEM("InfiniteMapTx", MPTCP_MIB_INFINITEMAPTX),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
 	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index c8ffe18a8722..3206cdda8bb1 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -27,6 +27,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINSYNTXBINDERR,	/* Not able to bind() the address when sending a SYN + MP_JOIN */
 	MPTCP_MIB_JOINSYNTXCONNECTERR,	/* Not able to connect() when sending a SYN + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
+	MPTCP_MIB_DSSCORRUPTIONFALLBACK,/* DSS corruption detected, fallback */
+	MPTCP_MIB_DSSCORRUPTIONRESET,	/* DSS corruption detected, MPJ subflow reset */
 	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
 	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence numbers */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c2317919fc14..c1a2397b9992 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -620,6 +620,18 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	return ret;
 }
 
+static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
+{
+	if (list_is_singular(&msk->conn_list) && msk->first == ssk) {
+		MPTCP_INC_STATS(sock_net(ssk),
+				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
+		mptcp_do_fallback(ssk);
+	} else {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
+		mptcp_subflow_reset(ssk);
+	}
+}
+
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk,
 					   unsigned int *bytes)
@@ -692,10 +704,16 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 				moved += len;
 			seq += len;
 
-			if (WARN_ON_ONCE(map_remaining < len))
-				break;
+			if (unlikely(map_remaining < len)) {
+				DEBUG_NET_WARN_ON_ONCE(1);
+				mptcp_dss_corruption(msk, ssk);
+			}
 		} else {
-			WARN_ON_ONCE(!fin);
+			if (unlikely(!fin)) {
+				DEBUG_NET_WARN_ON_ONCE(1);
+				mptcp_dss_corruption(msk, ssk);
+			}
+
 			sk_eat_skb(ssk, skb);
 			done = true;
 		}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1040b3b9696b..e1046a696ab5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -975,8 +975,10 @@ static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
 	unsigned int skb_consumed;
 
 	skb_consumed = tcp_sk(ssk)->copied_seq - TCP_SKB_CB(skb)->seq;
-	if (WARN_ON_ONCE(skb_consumed >= skb->len))
+	if (unlikely(skb_consumed >= skb->len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
 		return true;
+	}
 
 	return skb->len - skb_consumed <= subflow->map_data_len -
 					  mptcp_subflow_get_map_offset(subflow);
-- 
2.45.2

