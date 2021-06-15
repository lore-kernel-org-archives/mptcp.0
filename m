Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3E2FB2
	for <mptcp@lists.linux.dev>; Tue, 15 Jun 2021 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623775473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=COMIV3BXghcj9ge1Rw7CYV8ZA4LrSxmJtLnsQFpk6Bo=;
	b=aJh5J0X2i4uZjheuz2xjKdW0bBDLzAnM4kIOdhuLm/R/xqNCWTaSM/tcH27zTiJbluso5W
	CiBNxg7mzEmbL4V9VYNyqGE3/Pdwvr+UbiaFl/Fwz4AXx/rDRLQKKxo131XR34isyTMOQa
	V6kxHi4i4nTd2UF9fx0xBJrRIjm89vY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-eAfhIuo2M6mXrCAIqxAnTA-1; Tue, 15 Jun 2021 12:44:30 -0400
X-MC-Unique: eAfhIuo2M6mXrCAIqxAnTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 787A41084F40;
	Tue, 15 Jun 2021 16:44:29 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-150.ams2.redhat.com [10.36.115.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B365D60C0F;
	Tue, 15 Jun 2021 16:44:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net] mptcp: fix 32 bit DSN expansion
Date: Tue, 15 Jun 2021 18:44:22 +0200
Message-Id: <54a9e415d257a18f8996a9d54cf0c03500ed8aea.1623775386.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The current implementation of 32 bit DNS expansion is buggy,
and the fix is quite similar to what we did for ack expansion.

There is a small caveat: DNS can both increment and decrement
(on MPTCP re-injection) so we need to use more care to catch
wrap-around and we must additionally look for reverse wrap.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/120
Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
@Christoph: sorry for the duplicate, I used a bad recipient
list for the previous attempt
---
 net/mptcp/subflow.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d55f4ef736a5..004718126345 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -781,13 +781,19 @@ enum mapping_status {
 	MAPPING_DUMMY
 };
 
-static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
+static u64 expand_seq(u64 old_seq, u64 cur_seq)
 {
-	if ((u32)seq == (u32)old_seq)
-		return old_seq;
+	u32 old_seq32 = (u32)old_seq;
+	u32 cur_seq32 = (u32)cur_seq;
 
-	/* Assume map covers data not mapped yet. */
-	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
+	cur_seq = (old_seq & GENMASK_ULL(63, 32)) + cur_seq32;
+	if (unlikely(cur_seq32 < old_seq32 && before(old_seq32, cur_seq32)))
+		return cur_seq + (1LL << 32);
+
+	/* on re-injection we can have wrap around towards bottom */
+	if (unlikely(cur_seq32 > old_seq32 && after(old_seq32, cur_seq32)))
+		return cur_seq - (1LL << 32);
+	return cur_seq;
 }
 
 static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
@@ -996,9 +1002,8 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	}
 
 	if (!mpext->dsn64) {
-		map_seq = expand_seq(subflow->map_seq, subflow->map_data_len,
-				     mpext->data_seq);
-		pr_debug("expanded seq=%llu", subflow->map_seq);
+		map_seq = expand_seq(READ_ONCE(msk->ack_seq), mpext->data_seq);
+		pr_debug("expanded seq=%llu->%llu", mpext->data_seq, map_seq);
 	} else {
 		map_seq = mpext->data_seq;
 	}
-- 
2.26.3

