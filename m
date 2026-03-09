Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E284B7FBAC
	for <mptcp@lists.linux.dev>; Mon,  9 Mar 2026 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773024899; cv=none; b=BvAw3i6xsBhVRcQq81XtTqj0iFEfr3qz0x0dFVc/u5w8pcKAY/hQ1ZM/XTI2uCSHti7aHMpRCkBf58FSZ7TSP7Lm9eV1rULbxMPc+oKcLKcvF13MHt/FCIyqek7KqDzg0yLj1AHl5Kgm4L3Ij8WkxU5xf8+FjAkpVQUBpdlESRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773024899; c=relaxed/simple;
	bh=QOsxnVCDMaECkLrDTb3w94Dx4ILJOAQVCYtHD5FfK0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/EbCuasdJKiPMim8zDUqS0Nz+i98m6FTs92sx3qE9NaDXikqDHXJ6N+Ho20bAj32CIfmUQAPELrZtvKblD1oEc0dwGKOEdHv5elIsVtMPFEk0G/D9GF8515DowQYeVXraJK7kyprtDNv4owKk1D22KwkdKekSmjOvFPGG8X+CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BfIv47vc; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BfIv47vc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773024896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KIQ6J8mi/Rva2d2R2S8c71NUO3FS88ZHsl4YT8Lr/bo=;
	b=BfIv47vc8l6GOLtFhaOqrASqNg5DiMvKxAq30PuUCUghsrPqfgfSmscQtwhOKuxrsoHxPy
	2cl/SnYKGdDhSnyOwqZh73r1XJQLs5nBveZVdb4WxHBz2v2mCyB96Bo6d2TSYm8vDjce4r
	UxhiDVG2PPcCZI2wZq1w0zvhHDuuOoY=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	geliang@kernel.org,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next] mptcp: preserve MSG_EOR semantics in sendmsg path
Date: Mon,  9 Mar 2026 10:54:31 +0800
Message-ID: <20260309025431.125943-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Extend MPTCP's sendmsg handling to recognize and honor the MSG_EOR flag,
which marks the end of a record for application-level message boundaries.

Data fragments tagged with MSG_EOR are explicitly marked in the
mptcp_data_frag structure and skb context to prevent unintended
coalescing with subsequent data chunks. This ensures the intent of
applications using MSG_EOR is preserved across MPTCP subflows,
maintaining consistent message segmentation behavior.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---

Notes:
      - This patch incorporates feedback and suggestions from Paolo Abeni
        and Geliang Tang, including memory alignment optimizations for the
        mptcp_data_frag struct (shrinking overhead to u8 and using bitfield
        for eor to avoid size increase) and compile-time checks with BUILD_BUG_ON.
      - Packetdrill test cases validating this feature are available at:
        https://github.com/multipath-tcp/packetdrill/pull/189/changes/d6ce92a4786704fe749bbd848ced0c047632282e

 net/mptcp/protocol.c | 24 ++++++++++++++++++++++--
 net/mptcp/protocol.h |  4 +++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 17e43aff4459..3e574c87301b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1174,6 +1174,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
+	dfrag->eor = 0;
 
 	return dfrag;
 }
@@ -1435,6 +1436,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mptcp_update_infinite_map(msk, ssk, mpext);
 	trace_mptcp_sendmsg_frag(mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
+
+	/* If this is the last chunk of a dfrag with MSG_EOR set,
+	 * mark the skb to prevent coalescing with subsequent data.
+	 */
+	if (dfrag->eor && info->sent + copy >= dfrag->data_len)
+		TCP_SKB_CB(skb)->eor = 1;
+
 	return copy;
 }
 
@@ -1895,7 +1903,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	long timeo;
 
 	/* silently ignore everything else */
-	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_FASTOPEN;
+	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
+			  MSG_FASTOPEN | MSG_EOR;
 
 	lock_sock(sk);
 
@@ -2002,8 +2011,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			goto do_error;
 	}
 
-	if (copied)
+	if (copied) {
+		/* Mark the last dfrag with EOR if MSG_EOR was set */
+		if (msg->msg_flags & MSG_EOR) {
+			struct mptcp_data_frag *dfrag = mptcp_pending_tail(sk);
+
+			if (dfrag)
+				dfrag->eor = 1;
+		}
 		__mptcp_push_pending(sk, msg->msg_flags);
+	}
 
 out:
 	release_sock(sk);
@@ -4621,6 +4638,9 @@ void __init mptcp_proto_init(void)
 	inet_register_protosw(&mptcp_protosw);
 
 	BUILD_BUG_ON(sizeof(struct mptcp_skb_cb) > sizeof_field(struct sk_buff, cb));
+	/* Compile-time check: ensure 'overhead' (alignment + struct size) fits in u8 */
+	BUILD_BUG_ON(ALIGN(1, sizeof(long)) + sizeof(struct mptcp_data_frag) > U8_MAX);
+
 }
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f5d4d7d030f2..db96f2945cbd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -264,7 +264,9 @@ struct mptcp_data_frag {
 	u64 data_seq;
 	u16 data_len;
 	u16 offset;
-	u16 overhead;
+	u8 overhead;
+	u8 eor:1,
+	   __unused:7;
 	u16 already_sent;
 	struct page *page;
 };
-- 
2.43.0

