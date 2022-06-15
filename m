Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6B97A
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 20:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655324904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyEw0Hxej3KhuemgaxQYg9IJahwM7VHtKclJqGNymzw=;
	b=WdIfNpFaGu8y85j5K7i2xxKkQFWKLHlYRTNWfmFk3r/5HNlEa800OayVO28l0BOVB9Scf9
	7ZsfB1BW/pm7m441TfZNjfoe+XLmUzbMz9IZ3nA9NRWtXdtT8usxFgB21wt/Cn27NfoTf/
	NRaXCPL35U3lJH8/3/0U7wDey3kf5oM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-n6HjqHW8PEKvQPzI8tUMLA-1; Wed, 15 Jun 2022 16:28:23 -0400
X-MC-Unique: n6HjqHW8PEKvQPzI8tUMLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C36303C0D850
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 20:28:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53C8340C1289
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 20:28:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 2/6] mptcp: introduce MAPPING_BAD_CSUM
Date: Wed, 15 Jun 2022 22:28:09 +0200
Message-Id: <dd078642fb80c4bb1f3184393cee1907026df46c.1655324843.git.pabeni@redhat.com>
In-Reply-To: <cover.1655324843.git.pabeni@redhat.com>
References: <cover.1655324843.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This allow moving a couple of conditional out of the fast path,
making the code more easy to follow and will simplify the next
patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 57d2d8d933d0..98b12a9c4eb5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -843,7 +843,8 @@ enum mapping_status {
 	MAPPING_INVALID,
 	MAPPING_EMPTY,
 	MAPPING_DATA_FIN,
-	MAPPING_DUMMY
+	MAPPING_DUMMY,
+	MAPPING_BAD_CSUM
 };
 
 static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
@@ -958,9 +959,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 				 subflow->map_data_csum);
 	if (unlikely(csum)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
-		if (subflow->mp_join || subflow->valid_csum_seen)
-			subflow->send_mp_fail = 1;
-		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
+		return MAPPING_BAD_CSUM;
 	}
 
 	subflow->valid_csum_seen = 1;
@@ -1178,10 +1177,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 		status = get_mapping_status(ssk, msk);
 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
-		if (unlikely(status == MAPPING_INVALID))
-			goto fallback;
-
-		if (unlikely(status == MAPPING_DUMMY))
+		if (unlikely(status == MAPPING_INVALID || status == MAPPING_DUMMY ||
+			     status == MAPPING_BAD_CSUM))
 			goto fallback;
 
 		if (status != MAPPING_OK)
@@ -1223,7 +1220,10 @@ static bool subflow_check_data_avail(struct sock *ssk)
 fallback:
 	if (!__mptcp_check_fallback(msk)) {
 		/* RFC 8684 section 3.7. */
-		if (subflow->send_mp_fail) {
+		if (status == MAPPING_BAD_CSUM &&
+		    ((subflow->mp_join || subflow->valid_csum_seen))) {
+			subflow->send_mp_fail = 1;
+
 			if (!READ_ONCE(msk->allow_infinite_fallback)) {
 				ssk->sk_err = EBADMSG;
 				tcp_set_state(ssk, TCP_CLOSE);
-- 
2.35.3

