Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5362E34C121
	for <mptcp@lists.linux.dev>; Wed, 22 Oct 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143537; cv=none; b=UY4gULbkQa8vWDpWpQoIaeqGpYgW6vCZb7x0kr5XPvZSsJmn1FO+A48xNtbLzHb9N4MwhJAyP+zxMLThBmToaYq46C85A6xz8aLEoAsZkyS9NI7wZsya4AYy6fN/IAAXUiv9DinznV+ZjNAAGaIYGh2rmUfuppEBJJvUUjI1nyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143537; c=relaxed/simple;
	bh=kA8vd/GNw50g13H/UPvsPo9sv6I4n3K82Ytjd2I4QUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=jbkqzx9rI9petibXTX6wVk8CsSzx4QQUuXKnRUIxyQ/H5OtJ+81adwtbJfGFAm2Kzs/7QMinBNLhrQBbr8j39pO8MjJgx1DVgP2LgzsrVyb4k3GR2ijLeYJ/IIMvp4VmyTLBdnP8rRg6UGEEOz4JRMcwDR4ry3zf46QKl6bvjmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1ToBCQh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1ToBCQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761143533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMKRN/j7zUvuRprYvSHHKMxMhHAR3ssijBExuINanhM=;
	b=T1ToBCQhplSC/F62PtsVuJFY0EhWn/ji78Nbp4RolweCYLDgWq/Xu042fNvS8Vf5TrlwiH
	IvXMRDumCg/ZQwot1ZhLG2FHgtyJEWSKxYsPEZnOzTIy6es6vb+W0qfaGroV8uELxv//19
	pG+zru+X+wjK0mTf0zWVbhLBx07+oAk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-KAaQRkaYNWy6zi5BhS0GBg-1; Wed,
 22 Oct 2025 10:32:09 -0400
X-MC-Unique: KAaQRkaYNWy6zi5BhS0GBg-1
X-Mimecast-MFC-AGG-ID: KAaQRkaYNWy6zi5BhS0GBg_1761143528
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 949B418001D1;
	Wed, 22 Oct 2025 14:32:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.237])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 330E41956056;
	Wed, 22 Oct 2025 14:32:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v6 mptcp-next 04/11] mptcp: cleanup fallback dummy mapping generation
Date: Wed, 22 Oct 2025 16:31:47 +0200
Message-ID: <dfd37538092f345bda372801284506ff90d03a78.1761142784.git.pabeni@redhat.com>
In-Reply-To: <cover.1761142784.git.pabeni@redhat.com>
References: <cover.1761142784.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GoXjq_YbmVoyfirPeGi1ZCTuTUfFyFyvbl_HejvHzXI_1761143528
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
index 372ae2d9fd229e..51c55a45aeaccd 100644
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
index b9455c04e8a462..ac8616e7521e8a 100644
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

