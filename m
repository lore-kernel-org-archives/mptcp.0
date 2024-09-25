Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782013DDAE
	for <mptcp@lists.linux.dev>; Wed, 25 Sep 2024 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254930; cv=none; b=TXAkXbGvST+mxhKTP7k6wwiAHPPwJUAA0NMjGx0LRbBJCk9VRxtUUSla6SzQQyfz73fNnF+MsbAnEFIelFr1XtFgzShzvMQkZVZ/7eTbRacaDKpYIaqf+6eHovFA3AAc2dFbD2XAMhiip9zYrXRpAqcjtwxbzwuKuQG8eTRWiSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254930; c=relaxed/simple;
	bh=dJZt4O95UzY2N82u4wRafZMAEuk0dQPGHBWLnrw7qAo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DgCnhcBgJ28y3bO1fDtx4ZioPheLvKtdpmuum5v/B5Utp96TbYm7bakhBIFEjDKfWD0fKqUjlrvRufZ0U/57j4OVWUMrRmJr8spV/leMvfEsXNj5zaX6EUVh6ujiPq5VBrOsNDkmEW0d4RnMlhJeA12Svc5R6AoiFSQOv2K0BlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnpGYMjd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnpGYMjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727254927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bVcEAqgfTZvisrUwQN+WcGwDr5DLijaXTYtcaefadu8=;
	b=YnpGYMjdUSTd4CWf1k9MziFNqAb5bZuXgvB9gIZ/h5TDucgHuSnXVRueSTka0khUErv/hn
	OnicshKa4HCd3iPx9H1TDcBwlRsIWiQkgZBPn75WdeC9A4ou5DQ50SIjbPzCosvVCFbMYI
	43JyMoRRM7cSPsmlUI3Y4Uiu3rtEfJY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-OHP22jWvNdSH98f-klV6uA-1; Wed,
 25 Sep 2024 05:02:06 -0400
X-MC-Unique: OHP22jWvNdSH98f-klV6uA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D911193586C
	for <mptcp@lists.linux.dev>; Wed, 25 Sep 2024 09:02:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.57])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AD40195608A
	for <mptcp@lists.linux.dev>; Wed, 25 Sep 2024 09:02:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/2] mptcp: handle consistently DSS corruption.
Date: Wed, 25 Sep 2024 11:01:48 +0200
Message-ID: <e2c96390fa3980d3aca9c41671b90f645eab6523.1727254866.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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
 net/mptcp/mib.c      |  2 ++
 net/mptcp/mib.h      |  2 ++
 net/mptcp/protocol.c | 24 +++++++++++++++++++++---
 net/mptcp/subflow.c  |  4 +++-
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 38c2efc82b94..3168cde41593 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -76,6 +76,8 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
 	SNMP_MIB_ITEM("MPCurrEstab", MPTCP_MIB_CURRESTAB),
 	SNMP_MIB_ITEM("Blackhole", MPTCP_MIB_BLACKHOLE),
+	SNMP_MIB_ITEM("DssCorruptionFallaback", MPTCP_MIB_DSSCORRUPTIONFALLBACK),
+	SNMP_MIB_ITEM("DssCorruptionReset", MPTCP_MIB_DSSCORRUPTIONRESET),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index c8ffe18a8722..40f66556297a 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -77,6 +77,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
 	MPTCP_MIB_CURRESTAB,		/* Current established MPTCP connections */
 	MPTCP_MIB_BLACKHOLE,		/* A blackhole has been detected */
+	MPTCP_MIB_DSSCORRUPTIONFALLBACK,/* DSS corruption detected, fallback */
+	MPTCP_MIB_DSSCORRUPTIONRESET,	/* DSS corruption detected, MPJ subflow reset */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c2317919fc14..23231c758ee0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -620,6 +620,18 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	return ret;
 }
 
+static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
+{
+	if (msk->first == ssk) {
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

