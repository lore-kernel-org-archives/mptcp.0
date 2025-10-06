Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3921919C553
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738344; cv=none; b=I9NqMy7U/vZbTW62l3gEu7GbBt6QBhPmPze0gxBGiWqmw4nbZMxb7sDXYHlic40mPd/LKFhmz6Xg3X4ojbtrGf+EI8TPFVXY25RLODBM8rzSBZC0VeETmidyG6Pxxq3aA8pG+jTj4KTzJt0kRMfHfJFDvYSaJMCRcbnLUhI/WnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738344; c=relaxed/simple;
	bh=4G1qiH9mi9BjJXE0vk3gEFLeEg8YRUX3K9gKDNLCCD4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=T3C7I/t5yILXdFa8ORN1V9bt+PLntMMpWP2R1F3ptlsYAOR7LFp2zd+fXTaTFXYhTTpmW+x2LNYkfvFcZdRC+vmAVRRT4w9EcL9s44E10oi38QsUrZuTDjjakjFJ8oKj0oQXeYQHgtsTMZigUoz60rNs20f1AwgJE5WKjp2EtUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PO7vj5KZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PO7vj5KZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759738341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0160zZRTbn9jo9Ehpi2hICUKWsygsRTZYPeTy4d9kbw=;
	b=PO7vj5KZWxgpDbhWtDBmBsIgkmylnbes5zdmT00pbgcQoZK39SJaLu1zkck6YTqGPwd7XK
	rNEw9rAjRwEbWgSovEeIVr3L8I5MmTdblfyH9YyOsBU2q2IrbYw9eP0zdEmn+O1GHM4Tgd
	32xwIQtukHfiwd5Vl+GjxOqPEWAgWWo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-_-3cQkw1Nfq7FzZn6eW51w-1; Mon,
 06 Oct 2025 04:12:20 -0400
X-MC-Unique: _-3cQkw1Nfq7FzZn6eW51w-1
X-Mimecast-MFC-AGG-ID: _-3cQkw1Nfq7FzZn6eW51w_1759738339
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A85C6180057D
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB119180035E
	for <mptcp@lists.linux.dev>; Mon,  6 Oct 2025 08:12:18 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 03/10] mptcp: cleanup fallback dummy mapping generation
Date: Mon,  6 Oct 2025 10:12:02 +0200
Message-ID: <97aa8b51782fb47cbc1a20c3ad0243f80929b1ee.1759737859.git.pabeni@redhat.com>
In-Reply-To: <cover.1759737859.git.pabeni@redhat.com>
References: <cover.1759737859.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sXA2tOHEuR54PeytWSfJ7G8KFBWctmRzJBdl_h-v2uE_1759738339
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

MPTCP currently access ack_seq outside the msk socket log scope to
generate the dummy mapping for fallback socket. Soon we are going
to introduce backlog usage and even for fallback socket the ack_seq
value will be significantly off outside of the msk socket lock scope.

Avoid relying on ack_seq for dummy mapping generation, using instead
the subflow sequence number. Note that in case of disconnect() and
(re)connect() we must ensure that any previous state is re-set.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - reordered before the backlog introduction to avoid transiently
   break the fallback
 - explicitly reset ack_seq
---
 net/mptcp/protocol.c | 3 +++
 net/mptcp/subflow.c  | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 34661ab979158..12f201aa81f43 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3234,6 +3234,9 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->bytes_retrans = 0;
 	msk->rcvspace_init = 0;
 
+	/* for fallback's sake */
+	WRITE_ONCE(msk->ack_seq, 0);
+
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
 	return 0;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b9455c04e8a46..ac8616e7521e8 100644
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
@@ -1435,9 +1438,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
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
 	return true;
 }
-- 
2.51.0

