Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676534844B;
	Fri, 21 Nov 2025 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719090; cv=none; b=Tj9mpXQ8kv5/3UqfG7P6XHJORl0N2Qq2OqtDLqf24oi6FQjjMX1kKRnYGhSEBFwV515KIyzvJdImOWJeuRZUc8evLYxhfYRctCCRDKXC5lFVPX7rVNvam0d5dkKoocHtXE4sE8rSmyZAwT5UOQjc9tqQOP0/JgXoJ6uqmi7adbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719090; c=relaxed/simple;
	bh=foIZAITlbJnMtClLNIHPb1yM8sbAba6wyWQDOCljLXo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=NpSTjWt2pHAHSMqezRwmMqHxisB2sWmUguVoo+qJs6VHMsjgjAhNrF3TGznY1Ya/1s7jcpk6BjfMyPNABtuWhtpA/blUYuDadsYtF/jxbvHUy5K/5PvoN1akz0ygkew4ZmRc/6S+dhCZNJy0YgdfbAj7yCfAkXmBY/hcOnuOCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gmciclvs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gmciclvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E650CC116D0;
	Fri, 21 Nov 2025 09:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763719089;
	bh=foIZAITlbJnMtClLNIHPb1yM8sbAba6wyWQDOCljLXo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=gmciclvs1sD6pidoKRKvhJ6NxSRcmNnSuYJBeLDcjpdPK7TEgxgb1JzpIbS+XO9tH
	 v94DyJODlqmptp+pJCK0eynhARXGpPdaVjG+6iY0g68Af3s7nT4kMWex2DLwJPKixZ
	 RyUonupo/L7rRBsal0MDpBL0Q3o8KmyqrNwhKL2c=
Subject: Patch "mptcp: fix MSG_PEEK stream corruption" has been added to the 6.12-stable tree
To: geliang@kernel.org,gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 21 Nov 2025 10:57:41 +0100
In-Reply-To: <20251104121515.1093006-2-matttbe@kernel.org>
Message-ID: <2025112141-recent-lend-65b7@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    mptcp: fix MSG_PEEK stream corruption

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-msg_peek-stream-corruption.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-192373-greg=kroah.com@vger.kernel.org Tue Nov  4 13:17:04 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue,  4 Nov 2025 13:15:16 +0100
Subject: mptcp: fix MSG_PEEK stream corruption
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
Message-ID: <20251104121515.1093006-2-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 8e04ce45a8db7a080220e86e249198fa676b83dc ]

If a MSG_PEEK | MSG_WAITALL read operation consumes all the bytes in the
receive queue and recvmsg() need to waits for more data - i.e. it's a
blocking one - upon arrival of the next packet the MPTCP protocol will
start again copying the oldest data present in the receive queue,
corrupting the data stream.

Address the issue explicitly tracking the peeked sequence number,
restarting from the last peeked byte.

Fixes: ca4fb892579f ("mptcp: add MSG_PEEK support")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251028-net-mptcp-send-timeout-v1-2-38ffff5a9ec8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note: this is the patch Sasha sent for the v6.6 which applies on v6.12
without conflicts. On v6.12, Sasha sent another version with dependences
that caused some issues, see:
 https://lore.kernel.org/bbe84711-95b2-4257-9f01-560b4473a3da@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1977,19 +1977,35 @@ static void mptcp_rcv_space_adjust(struc
 
 static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 				struct msghdr *msg,
-				size_t len, int flags,
+				size_t len, int flags, int copied_total,
 				struct scm_timestamping_internal *tss,
 				int *cmsg_flags)
 {
 	struct sk_buff *skb, *tmp;
+	int total_data_len = 0;
 	int copied = 0;
 
 	skb_queue_walk_safe(&msk->receive_queue, skb, tmp) {
-		u32 offset = MPTCP_SKB_CB(skb)->offset;
+		u32 delta, offset = MPTCP_SKB_CB(skb)->offset;
 		u32 data_len = skb->len - offset;
-		u32 count = min_t(size_t, len - copied, data_len);
+		u32 count;
 		int err;
 
+		if (flags & MSG_PEEK) {
+			/* skip already peeked skbs */
+			if (total_data_len + data_len <= copied_total) {
+				total_data_len += data_len;
+				continue;
+			}
+
+			/* skip the already peeked data in the current skb */
+			delta = copied_total - total_data_len;
+			offset += delta;
+			data_len -= delta;
+		}
+
+		count = min_t(size_t, len - copied, data_len);
+
 		if (!(flags & MSG_TRUNC)) {
 			err = skb_copy_datagram_msg(skb, offset, msg, count);
 			if (unlikely(err < 0)) {
@@ -2006,22 +2022,19 @@ static int __mptcp_recvmsg_mskq(struct m
 
 		copied += count;
 
-		if (count < data_len) {
-			if (!(flags & MSG_PEEK)) {
+		if (!(flags & MSG_PEEK)) {
+			msk->bytes_consumed += count;
+			if (count < data_len) {
 				MPTCP_SKB_CB(skb)->offset += count;
 				MPTCP_SKB_CB(skb)->map_seq += count;
-				msk->bytes_consumed += count;
+				break;
 			}
-			break;
-		}
 
-		if (!(flags & MSG_PEEK)) {
 			/* we will bulk release the skb memory later */
 			skb->destructor = NULL;
 			WRITE_ONCE(msk->rmem_released, msk->rmem_released + skb->truesize);
 			__skb_unlink(skb, &msk->receive_queue);
 			__kfree_skb(skb);
-			msk->bytes_consumed += count;
 		}
 
 		if (copied >= len)
@@ -2245,7 +2258,8 @@ static int mptcp_recvmsg(struct sock *sk
 	while (copied < len) {
 		int err, bytes_read;
 
-		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags, &tss, &cmsg_flags);
+		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags,
+						  copied, &tss, &cmsg_flags);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.12/selftests-mptcp-join-endpoints-longer-transfer.patch
queue-6.12/selftests-mptcp-connect-trunc-read-all-recv-data.patch
queue-6.12/selftests-mptcp-join-rm-set-backup-flag.patch
queue-6.12/selftests-mptcp-connect-fix-fallback-note-due-to-ooo.patch
queue-6.12/mptcp-fix-msg_peek-stream-corruption.patch
queue-6.12/selftests-mptcp-join-properly-kill-background-tasks.patch
queue-6.12/selftests-mptcp-join-userspace-longer-transfer.patch
queue-6.12/gcov-add-support-for-gcc-15.patch
