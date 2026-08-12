Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF71EB5E3
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554518; cv=none; b=usyODdUPah/LTwEbwnmS8TjLGXFkhXU6Rumn+BSCqGhupnfaEtkXOuLDzQdGS/kf5fRn1KscjgM8zE7wsysJMUX6acwIg5Zx+6Bi8oPiAzxALWuAzxL5W6/+npntCcCDbz/cJ+YZam9pnJrd6PFEl89CCBUOkDcmIbheBPGnt9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554518; c=relaxed/simple;
	bh=d8cwGVFd84R3sRf3QGbL+ZTKVfllRBG/KvtEndzphiQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=eNNBORe0Di6xb95fa9XsO4W8Wvxo9xUZ7iC1sOcD2ICs/fcc1LgIAN8KJARpPGmcaV17XpMMxGD2cv3yT5fEN+kh01rVT3vExohB8JjqOT4s/s+SSnhIpmRELDwsI+AAwaUGNP9ylhzOoaT8GRj3TxciQ4B0acTcJgu+s0KAHqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LI6WJbh1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LI6WJbh1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786554516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeKsFUb8JjkoQLAxa0Oj/id2+piQDNFZVZMf9yiNSII=;
	b=LI6WJbh1b3yXOKf4LOWVQdNX3ksSTzv1QeBXOAOG+4MUoD6Jh8nTFCs1arlM0MP8S0GWUK
	W2osjmznAtBRJlishnJQH2NV3PP0rL2nTteNFEs5XIFgodAFndxTStEV8Yc404qTF8nDf3
	Lovl26VMPArt53Hf9deg6JG4lOqUkck=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148--W_Hb74HNLO8Wf9p2M0RTQ-1; Wed,
 12 Aug 2026 13:08:25 -0400
X-MC-Unique: -W_Hb74HNLO8Wf9p2M0RTQ-1
X-Mimecast-MFC-AGG-ID: -W_Hb74HNLO8Wf9p2M0RTQ_1786554504
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 705DA1956095
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.162])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6A8A18005BC
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/4] mptcp: being below memory limit is a likely() condition
Date: Wed, 12 Aug 2026 19:08:13 +0200
Message-ID: <93777494d7c03ae68a72357e95b4f54c49addb46.1786553006.git.pabeni@redhat.com>
In-Reply-To: <cover.1786553006.git.pabeni@redhat.com>
References: <cover.1786553006.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KXULbzrvIa3HeWPgXhcEWPWk_9M9JDBXToNiRwjBvao_1786554504
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The current compiler hint annotation is wrong, due to inverted
logic in the previous revision of the relevant code.

Fixes: e468d371180d ("mptcp: implemented OoO queue pruning")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 68d766c0206e..f879b1061f2d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -289,7 +289,7 @@ static void mptcp_prune_ofo_queue(struct sock *sk,
  */
 static bool mptcp_can_ingest(const struct sock *sk)
 {
-	return unlikely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)) ||
+	return likely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)) ||
 	       __mptcp_check_fallback(mptcp_sk(sk));
 }
 
-- 
2.55.0

