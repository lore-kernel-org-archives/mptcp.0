Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35AC244661
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785173801; cv=none; b=HX2pfG69kd4JPhUpnFIgTAXcWB13XEIoekB2ZA1mKD/Jx95w/VGEXGQGe6osam11bsUwJKfM6TJtexspmskyaLqHxYzBZjfonuuNBWjFTrGsRawF4XAEytYXe1ieIJe6Ia0L0Tn3SiyAhc0pd3OL8nakkXV6Q8mAPhDe5Nyt08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785173801; c=relaxed/simple;
	bh=wpNhOPkoXCrzvM/cvVEWsKntvtwDgWuUx7Fj3YFFfkc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=SWEzKTdKzKWEAOSyPrIjhbjpDv+DElK/TUbngB6OwiJJ9jVHdW8WUKQLj65w9Wjqx3qpK56fBBaNywYJ+5awv0z1kKQhMo2StUd5wSyHa8TYyTr2rRyhrMjXraChNzrco0S4DRxKDE7Y94oyromtytaM0js/N0HKmt9yVOLcSyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5CfD0+2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5CfD0+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785173799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=10pM0XNxmcxLebk1FKSdCBF3f9X9vU303DWKi5zcrTc=;
	b=U5CfD0+2uWfcFnDeocXnW9GWVJ9I55osHMS9mqz7tIgZh1Bot/ihmEpuWUUkbT4XNr6jEo
	N2gdNqYg4InI0SfCfJFXva2nrfCmp2U2/wnvBRDordzsa1DG6EtloT676WQZBF6v48norQ
	1UNJDRF5CGt2VDg+DbTg2rwkg7hjtWM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-OBPkZhPJORaionG1D88elw-1; Mon,
 27 Jul 2026 13:36:37 -0400
X-MC-Unique: OBPkZhPJORaionG1D88elw-1
X-Mimecast-MFC-AGG-ID: OBPkZhPJORaionG1D88elw_1785173796
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D33B180137A
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 17:36:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.239])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AED641956041
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 17:36:35 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: reclaim forward-allocated memory on RX path errors
Date: Mon, 27 Jul 2026 19:36:31 +0200
Message-ID: <54ad24594f194dace522b8f1be3912b242708a6e.1785162224.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GjXTUmrK_JMk8ACyo65BGdXaf0xo77ZVM_kR50wMOrY_1785173796
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After commit 9db5b3cec4ec ("mptcp: borrow forward memory from subflow"),
errors in the receive path prior to queueing skbs into the receive
queue do not trigger forward-allocated memory reclaiming.

Prevent forward memory from growing unboundedly in pathological drop
scenarios by explicitly reclaiming memory when skbs are dropped.

Fixes: 9db5b3cec4ec ("mptcp: borrow forward memory from subflow")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 954e20bb27de..90dc894cb976 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -149,6 +149,13 @@ struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk)
 
 static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 {
+	/*
+	 * The skb forward memory was already transferred to sk by
+	 * mptcp_borrow_fwdmem(), even before setting the destructor.
+	 */
+	if (!skb->destructor)
+		sk_mem_reclaim(sk);
+
 	sk_drops_skbadd(sk, skb);
 	__kfree_skb(skb);
 }
-- 
2.55.0

