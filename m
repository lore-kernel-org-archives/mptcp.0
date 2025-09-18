Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74303148DA
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215711; cv=none; b=Tg7eP79pRShF4MjLY88uMTOmWih5WaHE5BElixMckPGYB6wjoTBJUSKjz/a2HNHDiAcSX2Ue0DSpd0CmugxxcjXf/uGjL8895C3u3eWyAOj529MdvO13vZ3aorBzdbCQlGXwLEh/KgD3MquD1wR1RP2QxBfwG/L7CLd0TthSogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215711; c=relaxed/simple;
	bh=tAjYju49qLgXKjidfuks9AApLyUOdj1R5DUObAhkE2o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=n9CqsnmBhcZNshtsbEZ1xzssF3ThcwlmKiKE4GuiSSOQ7GGn6iWjZZ8exUS39N7j7NigdR9DCVEubMi0O+nQoeHuGfRUdoyjh8z31FWwaixiYBmudkkjqJ+MX9h9Oj6Caixgx+zi840DK+1Pu170Macm0QKdWAbScpAO4C0Nu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SozmHuCu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SozmHuCu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758215708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+CckTl3ss84+JVzGPFjpsmjO/xblXYY18EunPs9Idc=;
	b=SozmHuCuooeXu5VgwNkbi6n1AhhSO9RDC/lgiELoQqn+VL1Dlclyp+EvvG3/IEk2hBgXzJ
	Sy8PefwReff1JkzHhaglj2KraZptOKUjhQqjg+yz6+X6MQD+N1v9rR72DXcWe68WtVKj3K
	yBrwrxDAZiUE1418u7CKz+8CUnHdDBQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-UN7r_sW4ND21j3n6GsYjJw-1; Thu,
 18 Sep 2025 13:15:07 -0400
X-MC-Unique: UN7r_sW4ND21j3n6GsYjJw-1
X-Mimecast-MFC-AGG-ID: UN7r_sW4ND21j3n6GsYjJw_1758215706
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AE93195608A
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61EC430002C5
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:15:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 01/12] mptcp: leverage skb deferral free
Date: Thu, 18 Sep 2025 19:14:43 +0200
Message-ID: <93b5f3f52220e59b5d22611b6fc0858353890105.1758214563.git.pabeni@redhat.com>
In-Reply-To: <cover.1758214563.git.pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 60-aa39766ebop1dQFRhRR8MKmvUT2FcnqZ0lu3sUdg_1758215706
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Usage of the skb deferral API is straight-forward; with multiple
subflows actives this allow moving part of the received application
load into multiple CPUs.

Also fix a typo in the related comment.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7933291e991ce..9d95d24781509 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1943,12 +1943,13 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 		}
 
 		if (!(flags & MSG_PEEK)) {
-			/* avoid the indirect call, we know the destructor is sock_wfree */
+			/* avoid the indirect call, we know the destructor is sock_rfree */
 			skb->destructor = NULL;
+			skb->sk = NULL;
 			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 			sk_mem_uncharge(sk, skb->truesize);
 			__skb_unlink(skb, &sk->sk_receive_queue);
-			__kfree_skb(skb);
+			skb_attempt_defer_free(skb);
 			msk->bytes_consumed += count;
 		}
 
-- 
2.51.0

