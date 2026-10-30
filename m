Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327421;
	b=Trpcwp1Nbwpqe1M7MlV81b8YdoOasksFaKiOYjNdgi2V6pbWBQFJoLF//hc4Svg2W7cw
	 AIiBFXLIBzVDU5pzIyP0s8hMufsZxQ8GJ2yDWv4xhra+QkUUno4YCaW3zLXXJ9fked+r5
	 7pobKUBb/56ca42uq/XgN6qvfc8ixpLIzHgTkwYJU+94Ke5Qd64NJ8J5q3siwDidEli/k
	 XZEWJV/4pwz+v/r7tka/dqk62QfNuZtD8blyJGC7X84a69uowbINTM0q9SQJXhq/3/KM1
	 SNAlK6LEX9pv6Nj0zjGOJEEi6qkjQVyJccC2tkasp74ZJECvdpINOHs2ar7fPLmmcDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327421;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OfNgjOE+8lrMz4zXRjD9MnU/ex8yQ0VzEfLYEz+c/ZQ=;
	b=WhkVA7p0Aeyo2BFy+IWT9F4W2I5DiDEdJq+nzHg/EUMdzdAWrYYzswE3MZmUK7mXLK3i
	 aScgTaqUUvtBUc/6wlPWqAeKdD6W+AiCr4knZQe1w+BMNErwjuo+t+nhGv/w4NTQ1ViWs
	 hXapfFDPcvHQgJzSbP4ecvEzIHNNZtjdLi6/cpPOmPBb3jl9KuIGft/T5nykkrZsiO4Oy
	 KGOgckBJWvpAppxrB9jozlW57sL43i0ljMfOQrohTKBKZZTVQskHtiNh8CvQM1wzWiDE1
	 JwxFj3og1am3jspSC2GEZsScDLAmos3Ap+JQWJMSzJMdlN/0Eyl65d2AnoB64AB5f8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+1Hwz1+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75DD606A31F
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+1Hwz1+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561701F00A02;
	Fri, 30 Oct 2026 02:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793327420;
	bh=OfNgjOE+8lrMz4zXRjD9MnU/ex8yQ0VzEfLYEz+c/ZQ=;
	h=From:To:Cc:Subject:Date;
	b=e+1Hwz1+6/9xo9anJUbUMpUbcPvKaiirCJx2QBT+t+f34jW7LFrZdNXwq3ZTGe2kl
	 LJyu6lGwjmBDtH6rtH2QVcBsW5IOybiWdglsu0+/lqomRQAWIPE9yRZ8lFWIj/n6T9
	 3SLFJaq+1sk2rWtkKLb9AlYFsj32EkEuWEHiEjhuMEHl0Hs2PGsSNjA5YUaffR65AI
	 boz56pq5v8YuO+hoCJi50nOlXswnkkNwD9PVsvXXNAJDP92Q8d3sgyhezWN9FYijp+
	 5U+wm0597wdtDo8s8hGW1LSk6a3i02F8F5rfXIZHkCPrIyWhZ990jIr8fgsOAKl3R/
	 6+qcY0ytPLwOw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v17 0/4] Reduce the differences between TCP and MPTCP for TLS usage
Date: Fri, 30 Oct 2026 10:30:11 +0800
Message-ID: <cover.1793326853.git.tanggeliang@kylinos.cn>
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

From: Geliang Tang <tanggeliang@kylinos.cn>

v17:
 - Patch 2: add TFO synchronization: subflow_set_remote_key() preserves
   partial read progress by checking copied_seq against the initial TFO
   value before updating. Add WRITE_ONCE/READ_ONCE for ordering between
   BH (3rd ACK processing) and user-space readers. Add underflow guard
   (copied_seq >= map_seq) before offset subtraction in
   __mptcp_recvmsg_mskq() to protect MSG_PEEK traversals. Skip skbs
   entirely before copied_seq. Update subflow.c to set both map_seq
   (u32) and map_seq64 (u64) for TFO.
 - Patch 3: adapt to the new map_seq (u32) + map_seq64 (u64) layout
   introduced in patch 2.

v16:
 - Simplified the series to retain only the core changes required by both
   kTLS and sockmap: drop the CB offset field, add copied_seq tracking,
   and sync the MPTCP skb CB layout with the TCP one.
 - Dropped patch 2, leaving the fastopen code unchanged.
 - Moved patches 6-11 into a separate series "prepare interfaces for kTLS
   and sockmap support".
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1793255126.git.tanggeliang@kylinos.cn/

v15:
 - Patch 2: drop mptcp_data_lock() in mptcp_inq_hint(), use READ_ONCE()
   and __test_and_clear_bit() instead. This issue is unrelated to this
   series and will be addressed in a separate patch later.
 - Patch 5: Guard mptcp_cleanup_rbuf() with read_copied > 0. Initialize/
   reset msk->read_copied. Drop redundant mptcp_recv_skb() in
   __mptcp_read_sock().
 - Patch 6: simplify memory ordering, drop smp_mb()/smp_rmb(), keep
   existing smp_mb__before_atomic(). Check SOCK_DONE inline.
 - Patch 9: drop tcp_sock_rate_check_app_limited() split, call
   tcp_rate_check_app_limited() directly as Paolo suggested. Add
   write_seq != snd_nxt early bail-out.
 - Patch 10: wrap assertion behind expect_all_features().
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1792718041.git.tanggeliang@kylinos.cn/

v14:
 - v13 can no longer be applied to the export branch, so it has been
   rebased here with the following corrections:
 - Patch 2: move locking in mptcp_inq_hint() to avoid races with ack_seq
   change from patch 3 to here. Update commit log.
 - Patch 3: add mptcp_data_lock() in __mptcp_move_skb() around copied_seq
   update. Remove local delta variable in __mptcp_ofo_queue(). Initialize
   msk->copied_seq to 0 in mptcp_propagate_state() fallback path.
 - Patch 4: add map_seq64 comparison in __mptcp_try_coalesce() for 64-bit
   sequence consistency.
 - New patch 11: rename mptcp_check_readable to mptcp_stream_is_readable,
   and align with TCP by calling sk_is_readable() for KTLS support.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1790734083.git.tanggeliang@kylinos.cn/

v13:
 - use smp_mb instead of smp_mb__before_atomic in mptcp_check_data_fin.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1788245079.git.tanggeliang@kylinos.cn/

v12:
 - Move sock_set_flag(SOCK_DONE) to after smp_mb__before_atomic() in
   mptcp_check_data_fin() and reuse the existing barrier rather than adding
   a new smp_wmb().
 - Sample SOCK_DONE before smp_rmb() in mptcp_inq_hint() and mptcp_inq(),
   so the smp_rmb() only orders SOCK_DONE read relative to the subsequent
   ack_seq/copied_seq reads.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1788171508.git.tanggeliang@kylinos.cn/

v11:
 - __mptcp_move_skb(): gate __mptcp_sync_rcv_sequence() on
   test_and_clear_bit(MPTCP_SYNC_SEQ) so the dummy mapping is only re-based
   after ack_seq = iasn.
 - a new patch to set and test SOCK_DONE.
 - use SOCK_DONE in mptcp_inq_hint() and mptcp_inq().
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1788099847.git.tanggeliang@kylinos.cn/

v10:
 - Drop "mptcp: use atomic64_t for locklessly accessed u64 fields"
   (v9 patch 1) and the squash to bpf_burst test (v9 patch 11).
   Series reduced from 11 to 9 patches.
 - Revert all atomic64_read()/atomic64_set() on msk->ack_seq back to
   plain reads and WRITE_ONCE() in patches 1-4. Remove the local u64
   ack_seq variables that only existed to hold atomic64_read() results.
 - mptcp_inq_hint: move test_bit(MPTCP_SYNC_SEQ) inside mptcp_data_lock()
   to close the race between the flag check and the ack_seq read. Revert
   atomic64_read() to plain msk->ack_seq under the lock.
 - mptcp_inq (patch 6): use READ_ONCE() for both ack_seq and copied_seq
   instead of atomic64_read(). Add comment for the FIN subtraction,
   mirroring tcp_inq(). Update commit log.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1787888115.git.tanggeliang@kylinos.cn/

v9:
 - Extend atomic64_t conversion from only msk->ack_seq to all locklessly
   accessed u64 fields: write_seq, snd_nxt, snd_una, wnd_end,
   bytes_received, bytes_consumed.
 - Add mptcp_data_lock() in mptcp_inq_hint() to read ack_seq and
   copied_seq atomically.
 - Add read_copied field and drain it under mptcp_data_lock() in
   mptcp_read_complete() to fix the BH vs worker data race.
 - New patches: mptcp_inq/peek_len and sendmsg_locked proto_ops.
 - Squash to "selftests/bpf: Add bpf_burst scheduler & test".
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1787827525.git.tanggeliang@kylinos.cn/

v8:
 - check MPTCP_SYNC_SEQ in mptcp_inq_hint:
       if (hint_val >= INT_MAX) {
               if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
                       return 0;
               return INT_MAX;
       }
 - rename mptcp_sock_rate_check_app_limited to
   mptcp_rate_check_app_limited.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1787644449.git.tanggeliang@kylinos.cn/

v7:
 - Patch 1 is a new one to fix the existing issue Sashiko mentioned -
   using atomic64_t for msk->ack_seq.
 - Fix the map_subflow_seq setting in fallback mode in patch 4.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1787537436.git.tanggeliang@kylinos.cn/

v6:
 - Memory ordering for MPTCP_SYNC_SEQ: Add smp_wmb() before set_bit() in
   subflow_set_remote_key() and smp_rmb() after test_and_clear_bit() in
   __mptcp_move_skb() and mptcp_release_cb() to prevent data races on
   weakly-ordered architectures, ensuring ack_seq updates are visible
   before the flag is set and readers see the updated sequence after
   observing the flag.
 - Lockdep nested locking: Use lock_sock_fast_nested(ssk) instead of
   lock_sock_fast(ssk) in mptcp_sock_rate_check_app_limited() to suppress
   false positive recursive locking warnings when acquiring subflow socket
   locks while holding the parent MPTCP socket lock.
 - Receive window advertisement order: Swap mptcp_rcv_space_adjust() and
   mptcp_cleanup_rbuf() in mptcp_read_complete() to expand the receive
   buffer before evaluating window updates, ensuring ACKs advertise the
   new (larger) window size instead of delaying the advertisement until
   the next cycle.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1787446274.git.tanggeliang@kylinos.cn/

v5:
 - only patch 3 changed.
 - Fallback offset underflow: Initialize MPTCP sequence space to 0 in
   mptcp_propagate_state() when mp_opt == NULL, ensuring SKB's map_seq
   starts from 0 to match msk->copied_seq and prevent offset calculation
   underflow in fallback mode.
 - Stale peek_seq: Move peek_seq recomputation into the mptcp_move_skbs()
   continue path and add another recomputation after sk_wait_data(),
   ensuring peek_seq stays synchronized with msk->copied_seq updates from
   MPTCP_SYNC_SEQ processing in both paths.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1787368526.git.tanggeliang@kylinos.cn/

v4:
 - mptcp_recvmsg: move the peek_seq recompute from after sk_wait_data()
   to before the mptcp_move_skbs() continue check.
   mptcp_move_skbs() -> __mptcp_move_skb() may shift the head skb's
   map_seq to the IASN frame via __mptcp_sync_rcv_sequence(); if
   'continue' then exits the loop, the recompute is skipped, and the
   next __mptcp_recvmsg_mskq() computes offset with peek_seq in the old
   frame minus map_seq in the new frame. The underflow makes the offset
   test fail and the skb is skipped (and mptcp_recv_skb() actually frees
   the TFO skb via mptcp_eat_recv_skb()).
 - Make all three MPTCP_SYNC_SEQ bit accesses atomic:
   - subflow_set_remote_key:   __set_bit            -> set_bit
   - __mptcp_move_skb:         __test_and_clear_bit -> test_and_clear_bit
   - mptcp_release_cb:         __test_and_clear_bit -> test_and_clear_bit
   The flag is set in BH under mptcp_data_lock() (msk slock held) and
   cleared in user context under lock_sock() slow path (only owned=1,
   slock not held). The non-atomic RMW on the two sides races, which can
   lose the IASN sync.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1787295147.git.tanggeliang@kylinos.cn/

v3:
 - Patch 2, handle "offset" in __mptcp_sync_rcv_sequence().
 - Patch 3, update __mptcp_move_skb() in response to Sashiko comments:

 	if (__test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags))
		msk->copied_seq += mptcp_iasn(msk);

 - Patch 4, replace after64() to after() in mptcp_prune_ofo_queue(). The
   pre-existing issue raised by Sashiko regarding changing the type of
   ack_seq to atomic64_t is not addressed in this series.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1786445142.git.tanggeliang@kylinos.cn/

v2:
 - Patch 3, updated in response to Sashiko comments:

        if (unlikely(msk->rcvd_dummy_seq)) {
                msk->copied_seq += mptcp_iasn(msk);
                __mptcp_sync_rcv_sequence(sk);
                /* Release cb() would otherwise re-base copied_seq
                 * again.
                 */
                test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags);
        }

        /* Skip the already peeked data. */
        if (offset >= skb->len) {
                *last = skb;
                continue;
        }
 - Patch 5, replaced with Paolo's patch.
 - Patch 6, 7, new patches addressing app-limited conditions.
 - The patch "trim the duplicated skb head at receive enqueue" has been
   dropped, as it is no longer needed after Paolo updated the "mptcp:
   out-of-order queue pruning" series.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1786158416.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1785150300.git.tanggeliang@kylinos.cn/

The goal of this series is to reduce the differences between TCP and MPTCP
for TLS usage, in preparation for adding TLS over MPTCP support in the
future.

In previous versions [1], a struct tls_prot_ops was defined to represent
the interface differences between TCP and MPTCP, which contained the
following callbacks:

	struct sk_buff *(*recv_skb)(struct sock *sk, u32 *off);
	bool (*lock_is_held)(struct sock *sk);
	void (*read_done)(struct sock *sk, size_t len);
	u32 (*get_skb_seq)(struct sk_buff *skb);
	int (*skb_get_header)(const struct sk_buff *skb, int offset,
	                      void *to, int len);
	bool (*epollin_ready)(const struct sock *sk);
	void (*check_app_limited)(struct sock *sk);

In reality, some of these callbacks are unnecessary. This series aims to
eliminate the get_skb_seq(), skb_get_header(), and lock_is_held()
callbacks.

The first four patches come from Paolo's "mptcp: address stall under memory
pressure" series v5 [2], with only minor cleanup from my side.

They remove the CB offset field and sync the MPTCP skb CB layout with the
TCP one, so that we can obtain the TCP or MPTCP sequence number in a
unified way, e.g.:

	struct tls_skb_cb {
	    u32 seq;
	};

	#define TLS_SKB_CB(__skb) ((struct tls_skb_cb *)&((__skb)->cb[0]))

This eliminates the need for a separate get_skb_seq() callback.

Building on the removal of the CB offset field, I also added patch 5 that
trims the duplicated skb head at receive enqueue. With that in place, KTLS
can retrieve the record header via skb_copy_bits() directly, so there is no
longer any need for a dedicated MPTCP helper like mptcp_skb_get_header().
The skb_get_header() callback can thus be removed.

Patch 6 defers sk_data_ready to the worker, which avoids recursive locking
when TLS calls back into MPTCP under mptcp_data_lock(). With this change,
the lock_is_held() callback is no longer needed and can be removed.

[1]
https://patchwork.kernel.org/project/mptcp/cover/cover.1782123118.git.tanggeliang@kylinos.cn/
[2]
https://patchwork.kernel.org/project/mptcp/cover/cover.1778446731.git.pabeni@redhat.com/

Paolo Abeni (4):
  mptcp: drop the mptcp_ooo_try_coalesce() helper
  mptcp: remove CB offset field
  mptcp: sync mptcp skb cb layout with tcp one
  mptcp: defer read_sock cleanup to mptcp_worker

 net/mptcp/fastopen.c |  14 +++-
 net/mptcp/protocol.c | 193 +++++++++++++++++++++++++------------------
 net/mptcp/protocol.h |  11 ++-
 net/mptcp/subflow.c  |  23 +++++-
 4 files changed, 151 insertions(+), 90 deletions(-)

-- 
2.55.0

