Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826671;
	b=M2emkK+Unt2Y3FiJOp3LZ80cxrDzGF5MFDc/GW88MplwywgFxInplP01LjjGWR/cY8Cr
	 eCeuK4v15coq046Lvesvrq2tFloBnYuVqE0wNQOWcfiKOn2OehtiJ0ZZlSAc6UYwQ0HEB
	 JCnmtsfB7Ztdeef3T+Nk0028GmuCsYKHJcd5nTCU6p1aYb6UuDNInhxHhIAgv+g6FhqaW
	 5JoB7yts/Qc9YLMI23gs3djzlMvo09yUIgoESQy5QlVlioQB+R6/DOt5mnH6zNSqhetXa
	 UYtB8Aci+oKo+3LkbcPjCL/MlsN3Gjejf/tgP8hhpsg2wmCoeDGKkR50vDzDdbWf70A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826671;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5bvLkya9c9sXwawH7UjaRizMdJ+XTqfRW44Ty5bx/RA=;
	b=GighVY9B8iH2ADxsu64nAbc13JzlX4RylLnojUQEWrQyhBad70CBecfHoJ9wdXY+Juy3
	 wYtos223dz4ZdrLPZsOtXb9BKMIU7gQQd2MhUI6BBJL5o0tVEyRIgRJep3dyrFSwAGI1D
	 ItAAcoe8EKBiAwWvS11tDy2RKg9RDrmd87kA2xMs8Rq3td32NIHR01mvlnWgsmbgBAoEC
	 FYtJckx2sbDcVgS2ZmQsnSypEHTDuwhjtVsZmK0dKduOZpxjGEQ/oATuoLAETOevxC2At
	 OekEp9ijNhEJUWk85ZVq9syS3FjMV4gKzhyrtqfw1qD4Zxl+XzjcdMDqy64T/DIw00g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boJHNNK8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974C606A323
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boJHNNK8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFD81F000C4
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826670;
	bh=5bvLkya9c9sXwawH7UjaRizMdJ+XTqfRW44Ty5bx/RA=;
	h=From:To:Subject:Date;
	b=boJHNNK8NE4k3OLxsHdmKMTiUQO7YBj5TUmMeTz/tWwjm91Tt3izTlptV+I4AT/09
	 mRLYto9AEcsPp8nQhnZiTK3G1yY+Nht+EHJr33EOD1i1M8fDoq/36LV1rCdS1pvYTs
	 x+tSd+Mgm5LRdB4bTbZEOYnFr6+aTZd5A4dllXyOC++PM/lfNpqn/3a8jxMkhvWVru
	 2x+TL/5R34fY0zUMaE35dXiwitjJY/Sf5OhmUr7nQBfyymxzxR4rH20ajJbOmw8OcC
	 Q/8DefRjLYiK3JBJQwB6j/P1q5+XvzPzHiPWdwg7q+uEoDBAoKHJ6wxA5LhwzhmEwK
	 7LBhHfHC/yeAw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 0/7] prepare interfaces for kTLS and sockmap support
Date: Mon, 16 Nov 2026 18:57:38 +0800
Message-ID: <cover.1794826541.git.geliang@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v8:
 - patch 1: change mptcp_inq_hint() to maintain TCP semantics by adding 1
   to hint_val when RCV_SHUTDOWN is set or sk_state is TCP_CLOSE, matching
   TCP behavior where FIN consumes a sequence number.
 - patch 2: update the test.
 - patches 3-7: no changes.

v7:
 - patch 1: add 1 to hint_val when RCV_SHUTDOWN is set to include the FIN
   byte, matching the previous ack_seq - map_seq behavior. Simplify the
   EOF condition accordingly.
 - patch 2: replace poll()-based check with a wait_for_remote_key() helper
   that polls MPTCP_INFO until MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED is set,
   ensuring the third ACK has been processed before checking SIOCINQ. Add
   SOL_MPTCP fallback definition and handle ENOPROTOOPT/EOPNOTSUPP for
   TCP or fallback sockets.
 - patches 3-7: no changes.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1794053683.git.tanggeliang@kylinos.cn/

v6:
 - patch 2: add Fixes tag, and use '-net' prefix.
 - patch 3: remove poll() call, check SIOCINQ directly after accept().
 - patch 6: add READ_ONCE() for msk->flags and msk->cb_flags reads in
   mptcp_rate_check_app_limited() to annotate intentionally racy accesses.
 - update commit logs.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1793860134.git.tanggeliang@kylinos.cn/

v5:
 - patch 2: new patch - rewrite mptcp_inq_hint() to use mptcp_data_avail()
   instead of ack_seq - map_seq, completely avoiding TFO overflow issues.
 - patch 3: new patch - add TFO SIOCINQ overflow detection in
   mptcp_connect test to catch INT_MAX returns on TFO connections.
 - patch 4: mptcp_inq() now returns INT_MAX instead of 0 when avail >=
   INT_MAX. Removed mptcp_inq_hint() changes (moved to patch 2).
 - patch 6: replace mptcp_rtx_head() check with MPTCP_WORK_RTX and
   MPTCP_RETRANSMIT flag checks in mptcp_rate_check_app_limited() to
   properly detect pending retransmissions without data race issues.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1793676064.git.tanggeliang@kylinos.cn/

v4:
 - patch 2: fix mptcp_inq_hint() to return 0 instead of INT_MAX on
   passive TFO overflow (ack_seq - map_seq >= INT_MAX).
 - patch 4: add mptcp_rtx_head(sk) to the early-return check in
   mptcp_rate_check_app_limited() so pending retransmissions also
   prevent false app-limited marking.
 - patch 5: update comment message.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1793588257.git.tanggeliang@kylinos.cn/

v3:
 - patch 2: drop DATA_FIN subtraction in mptcp_inq(), remove the
   intermediate 'answ' variable and return (unsigned int)avail
   directly. Update commit message accordingly.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1793324316.git.tanggeliang@kylinos.cn/

v2:
 - drop the patch "prevent dummy DATA_FIN on RST in fallback mode".
 - keep mptcp_inq_hint in mptcp_ioctl unchanged.
 - use mptcp_data_avail in mptcp_inq.
 - add msk_owned_by_me check in mptcp_sendmsg_locked.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1793258749.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1792999988.git.tanggeliang@kylinos.cn/

This series was previously posted as part of "Reduce the differences
between TCP and MPTCP for TLS usage" v15. It creates the mptcp_inq()
and mptcp_sendmsg_locked() interfaces that are required for the upcoming
MPTCP kTLS and MPTCP sockmap implementations.

The series has been rebased and no longer depends on Paolo's CB layout
refactoring patches (mptcp: drop the mptcp_ooo_try_coalesce() helper,
mptcp: drop the cant_coalesce CB field, mptcp: remove CB offset field,
mptcp: sync mptcp skb cb layout with tcp one, mptcp: defer read_sock
cleanup to mptcp_worker). Those patches are more complex and will be
sent in a separate series.

Patch overview:

1. mptcp: update mptcp_check_readable
 - Align with TCP's sock_is_readable for better TLS compatibility

2. mptcp: prevent dummy DATA_FIN on RST in fallback mode
 - Fix semantic issue where RST on fallback connections would create
   dummy DATA_FIN, causing unnecessary state transitions
 - Add sk_err check to subflow_is_done() to distinguish abortive
   closes (RST) from clean closes (FIN)

3. mptcp: implement peek_len for proto_ops
 - Add mptcp_inq() to report readable bytes at MPTCP level
 - Wire into .peek_len proto_ops for both IPv4 and IPv6
 - Handle 32-bit torn reads by returning 0 instead of INT_MAX
 - Prepare for TLS strparser integration

4. mptcp: add sendmsg_locked to proto_ops
 - Split mptcp_sendmsg() into locked/unlocked variants
 - Expose .sendmsg_locked in proto_ops for TLS send path

5. mptcp: track app-limited state in mptcp_sendmsg
 - Add mptcp_rate_check_app_limited() to mark subflows as app-limited
 - Bail out when MPTCP has unsent data (write_seq != snd_nxt or
   mptcp_send_head() != NULL) to avoid false app-limited marking
 - Enable accurate delivery rate estimation for BBR

6. selftests: mptcp: sockopt: check app_limited
 - Add regression test for app-limited accounting
 - Verify tcpi_delivery_rate_app_limited == 1 after small transfers

Gang Yan (1):
  mptcp: update mptcp_check_readable

Geliang Tang (6):
  mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
  selftests: mptcp: connect: check TFO SIOCINQ overflow
  mptcp: implement peek_len for proto_ops
  mptcp: add sendmsg_locked to proto_ops
  mptcp: track app-limited state in mptcp_sendmsg
  selftests: mptcp: sockopt: check app_limited

 net/mptcp/protocol.c                          | 95 +++++++++++++++----
 .../selftests/net/mptcp/mptcp_connect.c       | 64 +++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.c       |  5 +
 3 files changed, 145 insertions(+), 19 deletions(-)

-- 
2.55.0

