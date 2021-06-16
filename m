Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CACD70
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 08:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623831595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uuQfZOgJ7JktZiq2DrHGjTYhG4M4iwvaRXggKBx7VQM=;
	b=cl/ktWM+q648rDvMUW0DRPORw5lEspY8A8NzLdghlGQw5N9j4n31xtIveWJ7qA+3hi9C1T
	6Y5PhuIEWhnvvOHjufrAQk0toL+QdFelXPvGdYh6Ezuvm3Coh97w7PSgMGxmmCNjXCl5cl
	zFuAqGr74U2P/pAazRflCv/OZqarsWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-kxEZGqBzMuKs4-xZ5b3qMA-1; Wed, 16 Jun 2021 04:19:53 -0400
X-MC-Unique: kxEZGqBzMuKs4-xZ5b3qMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 727648015C6
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 08:19:52 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-145.ams2.redhat.com [10.36.114.145])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E0C24620DE
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 08:19:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net] mptcp: fix 32 bit DSN expansion
Date: Wed, 16 Jun 2021 10:19:43 +0200
Message-Id: <b451ef55b7debb519f42202e75696a79954b32b6.1623831569.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The current implementation of 32 bit DSN expansion is buggy.
After the previous patch, we can simply reuse the newly
introduced helper to do the expansion safely.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/120
Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - fix typo in the commit message
 - use the common helper
---
 net/mptcp/subflow.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d55f4ef736a5..6772802737e4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -781,15 +781,6 @@ enum mapping_status {
 	MAPPING_DUMMY
 };
 
-static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
-{
-	if ((u32)seq == (u32)old_seq)
-		return old_seq;
-
-	/* Assume map covers data not mapped yet. */
-	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
-}
-
 static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
 {
 	pr_debug("Bad mapping: ssn=%d map_seq=%d map_data_len=%d",
@@ -995,13 +986,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		data_len--;
 	}
 
-	if (!mpext->dsn64) {
-		map_seq = expand_seq(subflow->map_seq, subflow->map_data_len,
-				     mpext->data_seq);
-		pr_debug("expanded seq=%llu", subflow->map_seq);
-	} else {
-		map_seq = mpext->data_seq;
-	}
+	map_seq = mptcp_expand_seq(READ_ONCE(msk->ack_seq), mpext->data_seq, mpext->dsn64);
 	WRITE_ONCE(mptcp_sk(subflow->conn)->use_64bit_ack, !!mpext->dsn64);
 
 	if (subflow->map_valid) {
-- 
2.26.3

