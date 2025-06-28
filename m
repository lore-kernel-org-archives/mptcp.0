Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0144A08
	for <mptcp@lists.linux.dev>; Sat, 28 Jun 2025 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751093882; cv=none; b=edRv/AtoTiPzx/EfY0t8L7CpExke+2WUHvT+LOo0v3cQ4kyjFcF1SdVq3dqIyoJofYzQx4YAWDc3Jz/5/UtaAHreMVTCbvTiTv2euZ/MDyes++J1gMd7650r0qF/49IlXSZpu7D1SHIgr65Cv6O2yghwCUy4kyjlJ3sMDK2Y4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751093882; c=relaxed/simple;
	bh=vBCSHusMthd3wYqtglA1rZINZLF8DuQCY7RGbljju3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBhLKK8kct4GQsmzTzMPNmO5JNVsjNZjeEukAqsaUwdmqu4zMdzTvCQzgTMOM0jub4My3d0ecgf6FSciK7WOKAw3p/2tVDe6iEiyZUT4vWw83TGCAmggz9dMn22k2S28RLQ5/8TwAMWcBlnbCaC85OsMwxHOrjTe8fkwIE2pH50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7hNErgi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7hNErgi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF2FC4CEEE;
	Sat, 28 Jun 2025 06:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751093881;
	bh=vBCSHusMthd3wYqtglA1rZINZLF8DuQCY7RGbljju3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7hNErgiY4hyromYyQJqjECycgsc6+bsHo8TXFOiggYLWXs7QZ5zYoItQPR2o55LD
	 DPqradS2HivOgtdV3Vn5+KmHJjAxUSsteEWYRNTeHVXgna3qjwSXNu95IJ6L+ifpFe
	 8siAsScteK5Gl+sJMN6mjXV7S+A0aSyVTUKnnYdYzyZJSBoNAd5QZbOF2LrwonIfpL
	 Aw9zv3iLT6ub8ktdBVQcEj+h6X+A/LYVzmiTbVdnAhH4ccxbCqtS5gHq/9BK2VJiC4
	 lxEGSrVGLJpgT2PjAEj3KuBUJ+REn+XD/idcs35h+NATXN84VXZiOjUm4e/cN5p/h+
	 SW66NSXJ1GsbQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 2/5] mptcp: add recvmsg_desc helper
Date: Sat, 28 Jun 2025 14:57:10 +0800
Message-ID: <5fcd0bddfcdca24ebe9b0ff66cad0913235a4df9.1751093346.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1751093346.git.tanggeliang@kylinos.cn>
References: <cover.1751093346.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to implement .read_sock interface of mptcp later, this patch
extends __mptcp_recvmsg_mskq() to a more general __mptcp_recvmsg_desc(),
which accepts read_descriptor_t and sk_read_actor_t parameters. In this
way, the original __mptcp_recvmsg_mskq() can be implemented by passing
a newly defined mptcp_recvmsg_actor() to __mptcp_recvmsg_desc(). This
mptcp_recvmsg_actor() is a wrapper for skb_copy_datagram_msg().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2f747ab730e5..2ebdad6b233d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1844,8 +1844,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
 
-static int __mptcp_recvmsg_mskq(struct sock *sk,
-				struct msghdr *msg,
+static int __mptcp_recvmsg_desc(struct sock *sk,
+				read_descriptor_t *desc,
+				sk_read_actor_t recv_actor,
 				size_t len, int flags,
 				struct scm_timestamping_internal *tss,
 				int *cmsg_flags)
@@ -1861,12 +1862,14 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 		int err;
 
 		if (!(flags & MSG_TRUNC)) {
-			err = skb_copy_datagram_msg(skb, offset, msg, count);
-			if (unlikely(err < 0)) {
+			err = recv_actor(desc, skb, offset, count);
+			if (err <= 0) {
 				if (!copied)
 					return err;
 				break;
 			}
+			if (!WARN_ON_ONCE(err > count))
+				count = err;
 		}
 
 		if (MPTCP_SKB_CB(skb)->has_rxtstamp) {
@@ -1902,6 +1905,32 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 	return copied;
 }
 
+static int mptcp_recvmsg_actor(read_descriptor_t *rd_desc, struct sk_buff *skb,
+			       unsigned int offset, size_t len)
+{
+	struct msghdr *msg = rd_desc->arg.data;
+	int err;
+
+	err = skb_copy_datagram_msg(skb, offset, msg, len);
+	if (unlikely(err < 0))
+		return err;
+	return len;
+}
+
+static int __mptcp_recvmsg_mskq(struct sock *sk,
+				struct msghdr *msg,
+				size_t len, int flags,
+				struct scm_timestamping_internal *tss,
+				int *cmsg_flags)
+{
+	read_descriptor_t desc = {
+		.arg.data = msg,
+	};
+
+	return __mptcp_recvmsg_desc(sk, &desc, mptcp_recvmsg_actor,
+				    len, flags, tss, cmsg_flags);
+}
+
 /* receive buffer autotuning.  See tcp_rcv_space_adjust for more information.
  *
  * Only difference: Use highest rtt estimate of the subflows in use.
-- 
2.48.1

