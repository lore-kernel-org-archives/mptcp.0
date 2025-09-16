Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24892F7AA6
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040069; cv=none; b=NBlAj9LwKAt0vncQ8rd+qDk0Y0qYiXnhZbabvjHY/wGXaKiChiLRlqqHPyrvjr0LRZPZa3K5yPJ0l1lmddRvKOuKctj6g9XLVi1k9OCHsgDbYEE/tVcO3AvAVEpC/sd4AQN2HUSCPtNTJfv2Knu3qxz3MOhkDDGi+f+T5lgFO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040069; c=relaxed/simple;
	bh=pJyzsL3Ix0u5cgdVaKyoArqSER4UMTDQpnulcFnl64o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Qpg7dua4430XrFYCr0ygme31SWUJ9TFHBbDtt8hzcpEUuC2qVoWwTHzo34D5ffBGbhtKACXvPwIdZpFHbShdWPyZc6IKZ7+nQe6uurkEmAXQd2YOLVYh06rHHtn8XApBp0v1mB1P2ZRynJhtdSNuwtD7z+JFGlZcAtE62oCM590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UlfPjlrk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlfPjlrk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758040066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRm3UYvPTTHEruegNJeNiN2HTqTNZ83y0Qlvq+PF4T0=;
	b=UlfPjlrkwgQ9NhnAE5zs0Ny/YHZLCgfFsgUMnd57XsaJMSuN+lYICBsKtKGt7MCvvPSRy6
	OAxdATrKsYONiWaMNFTG6IlYtKpmPgYlRnjiljtimGIVMeRZ8eAq0HfGAXZwxgkWBYmkZD
	Wr93mivOJjf3vKusnTLHb5rdy32FCog=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-bcljUIhWMXKxMZo3aox7Bw-1; Tue,
 16 Sep 2025 12:27:45 -0400
X-MC-Unique: bcljUIhWMXKxMZo3aox7Bw-1
X-Mimecast-MFC-AGG-ID: bcljUIhWMXKxMZo3aox7Bw_1758040064
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C063019560BB
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.160])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E64EF19560B8
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 16:27:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [MPTCP next 12/12] mptcp: make fallback backlog aware
Date: Tue, 16 Sep 2025 18:27:22 +0200
Message-ID: <f1e09edfda414995754f7c40425cb3a80f0c6234.1758039775.git.pabeni@redhat.com>
In-Reply-To: <cover.1758039775.git.pabeni@redhat.com>
References: <cover.1758039775.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wAejePXujbKSqiSwwjvGsZWoU_bbC5jMLNsXjXXfKvA_1758040064
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

MPTCP can't relay on ack_seq outside the msk socket log scope. With
packets pending in the backlog, such value can be quite far from the
actual dummy correct sequence map value.

Fallback dummy mapping are in sequence by definition, generate the
data seq from the subflow sequence.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5339a00528a7a..02bf89f6b5a1a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -491,6 +491,9 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
 	subflow->iasn++;
 
+	/* for fallback's sake */
+	subflow->map_seq = subflow->iasn;
+
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
@@ -1421,9 +1424,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 	skb = skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid = 1;
-	subflow->map_seq = READ_ONCE(msk->ack_seq);
 	subflow->map_data_len = skb->len;
 	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
+					      subflow->iasn +
+					      TCP_SKB_CB(skb)->seq -
+					      subflow->ssn_offset - 1);
 	WRITE_ONCE(subflow->data_avail, true);
 
 	/* last skb in closed fallback subflow: we are at data fin */
-- 
2.51.0

