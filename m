Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454A30F8E
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695213944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAGhM2x9AmTbT1g/aNTGIp7MROgU4Jmcptz0HROixL4=;
	b=JJJGYgLkxxKeffoTRfn4/h2r60ibpAMEhdHTTUbCD8FRG8znXd58ooideZjUIVDBdFqIfh
	1zFdiKbEJkJC7CGJUDp9fJl9P4xANRSyymgVMFYvVrtqs5Unw6fWyiwswJr84gA+7pjkWD
	30liEkhi0hAb9u6fRbWHkcvupEVQcNk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-wz8eHeMNMCiHUzFip6fySQ-1; Wed, 20 Sep 2023 08:45:42 -0400
X-MC-Unique: wz8eHeMNMCiHUzFip6fySQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8231C85A5BF
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.123])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 10A1310F1BE7
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/4] mptcp: use plain bool instead of custom binary enum
Date: Wed, 20 Sep 2023 14:45:35 +0200
Message-ID: <a114bf32be09aaac7cf5acaa589b38c10e5ef985.1695208066.git.pabeni@redhat.com>
In-Reply-To: <cover.1695208066.git.pabeni@redhat.com>
References: <cover.1695208066.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The 'data_avail' subflow field is already used as plain boolean,
drop the custom binary enum type and switch to bool.

No functional changed intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.h |  7 +------
 net/mptcp/subflow.c  | 12 ++++++------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ab775e48c11d..158b6fc19217 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -433,11 +433,6 @@ mptcp_subflow_rsk(const struct request_sock *rsk)
 	return (struct mptcp_subflow_request_sock *)rsk;
 }
 
-enum mptcp_data_avail {
-	MPTCP_SUBFLOW_NODATA,
-	MPTCP_SUBFLOW_DATA_AVAIL,
-};
-
 struct mptcp_delegated_action {
 	struct napi_struct napi;
 	struct list_head head;
@@ -494,7 +489,7 @@ struct mptcp_subflow_context {
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		__unused : 9;
-	enum mptcp_data_avail data_avail;
+	bool	data_avail;
 	bool	scheduled;
 	u32	remote_nonce;
 	u64	thmac;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0eae952064b1..0a4465dcf56d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1237,7 +1237,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	struct sk_buff *skb;
 
 	if (!skb_peek(&ssk->sk_receive_queue))
-		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
+		WRITE_ONCE(subflow->data_avail, false);
 	if (subflow->data_avail)
 		return true;
 
@@ -1271,7 +1271,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			continue;
 		}
 
-		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
+		WRITE_ONCE(subflow->data_avail, true);
 		break;
 	}
 	return true;
@@ -1293,7 +1293,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 				goto reset;
 			}
 			mptcp_subflow_fail(msk, ssk);
-			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
+			WRITE_ONCE(subflow->data_avail, true);
 			return true;
 		}
 
@@ -1310,7 +1310,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
 			tcp_send_active_reset(ssk, GFP_ATOMIC);
-			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
+			WRITE_ONCE(subflow->data_avail, false);
 			return false;
 		}
 
@@ -1322,7 +1322,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
 	subflow->map_data_len = skb->len;
 	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
-	WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
+	WRITE_ONCE(subflow->data_avail, true);
 	return true;
 }
 
@@ -1334,7 +1334,7 @@ bool mptcp_subflow_data_available(struct sock *sk)
 	if (subflow->map_valid &&
 	    mptcp_subflow_get_map_offset(subflow) >= subflow->map_data_len) {
 		subflow->map_valid = 0;
-		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
+		WRITE_ONCE(subflow->data_avail, false);
 
 		pr_debug("Done with mapping: seq=%u data_len=%u",
 			 subflow->map_subflow_seq,
-- 
2.41.0

