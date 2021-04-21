Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835632F83
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMH+7P2Uld2EVEc83PQBkDrK2YPJXeTZkuLl0BqNBdc=;
	b=NZJmlDVDIVYIULr40Po3JJb81vlu8rRXgE9vBD7lAjQ2cx/aKAfTKpZ947mbSiHxyLatWO
	zZC69sWUm3ovXOZPVDo4x/HRn8p81u2uFd7ZSIGER9Y8WAgIKKLNzk8oDEsiRY0GBZcGQk
	Uom2ZOZhQAsiIo0/crITQtwM0VIdSO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-FPIIww-1PlK1LdSBdHSJvg-1; Wed, 21 Apr 2021 16:20:56 -0400
X-MC-Unique: FPIIww-1PlK1LdSBdHSJvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 895128030B5;
	Wed, 21 Apr 2021 20:20:55 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AB57B6085A;
	Wed, 21 Apr 2021 20:20:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 15/21] mptcp: validate the data checksum
Date: Wed, 21 Apr 2021 22:18:04 +0200
Message-Id: <5f372469accc6cbc038c186188be696b8e8c473e.1619035356.git.pabeni@redhat.com>
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

This patch added three new members named data_csum, csum_len and map_csum
in struct mptcp_subflow_context, implemented a new function named
mptcp_validate_data_checksum(). Validate the data checksum in the function
__mptcp_move_skbs_from_subflow.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c | 35 +++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  3 +++
 net/mptcp/subflow.c  |  7 +++++--
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0d8005b480ab..5160256de731 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -520,6 +520,35 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	return ret;
 }
 
+static bool mptcp_validate_data_checksum(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	struct csum_pseudo_header header;
+	__wsum csum;
+
+	if (__mptcp_check_fallback(msk))
+		goto out;
+
+	if (subflow->csum_len < subflow->map_data_len)
+		goto out;
+
+	header.data_seq = subflow->map_seq;
+	header.subflow_seq = subflow->map_subflow_seq;
+	header.data_len = subflow->map_data_len;
+	header.csum = subflow->map_csum;
+
+	csum = csum_partial(&header, sizeof(header), subflow->data_csum);
+
+	if (csum_fold(csum))
+		return false;
+	subflow->data_csum = 0;
+	subflow->csum_len = 0;
+
+out:
+	return true;
+}
+
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk,
 					   unsigned int *bytes)
@@ -588,6 +617,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			if (tp->urg_data)
 				done = true;
 
+			if (READ_ONCE(msk->csum_enabled)) {
+				subflow->data_csum = skb_checksum(skb, offset, len,
+								  subflow->data_csum);
+				subflow->csum_len += len;
+				mptcp_validate_data_checksum(ssk);
+			}
 			if (__mptcp_move_skb(msk, ssk, skb, offset, len))
 				moved += len;
 			seq += len;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3ac61b8178fd..176f175a00bd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -399,6 +399,9 @@ struct mptcp_subflow_context {
 	u32	map_subflow_seq;
 	u32	ssn_offset;
 	u32	map_data_len;
+	__wsum	data_csum;
+	u32	csum_len;
+	__sum16	map_csum;
 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_join : 1,   /* send MP_JOIN */
 		request_bkup : 1,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fc39107b25ec..68efc81eaf2c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -948,9 +948,12 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	subflow->map_data_len = data_len;
 	subflow->map_valid = 1;
 	subflow->mpc_map = mpext->mpc_map;
-	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u",
+	subflow->data_csum = 0;
+	subflow->csum_len = 0;
+	subflow->map_csum = mpext->csum;
+	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%u",
 		 subflow->map_seq, subflow->map_subflow_seq,
-		 subflow->map_data_len);
+		 subflow->map_data_len, subflow->map_csum);
 
 validate_seq:
 	/* we revalidate valid mapping on new skb, because we must ensure
-- 
2.26.2

