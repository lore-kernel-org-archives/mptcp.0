Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216260;
	b=MfhtppS+m0ESDF3CyP3gXn7hWrre6l9GQTNa3nVgdPbR0ULFBmR5fBYDmK9fMVOXmQZE
	 jtSveXJ+KZWhnZglf1tvUoeymKEudUSizncZHlI3H8aZnnR7sPdXwkve4Kl+To84FQmcl
	 uNJgYfktrurSygRqCaSVfR+mC3r3CuKSsUkz24ygNFMVComh+h0j1/eBpPoMC6bHE3F3s
	 FyhH9x7agog4z9ueV+yr6hHtHZ37dfeMz4SZ5Nls4ozcg+XVmQ9MCDOiui6oOVtAQBXsI
	 JiJxTuOlBUGPDw8+ZuFfXx5uwx8tLhLWFFR5qgTcsv4ffkjhOEB1Ye6YzoAWo0CzrcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216260;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YLSwidnVulo/duXwYls3yNmzTGz4ybvOKeMV6C79DOI=;
	b=YircvViSpoZtN2kFAz7QxY6UKHvukkt6zxBktVBYDkLyfMrHR3j6bH976fO3bD4qQtBz
	 ly2NnwJiwwMbDH8/YabSANHLulbsh8ZnhioukLhrGc2Bpmp02wQQQSwExQUO06b+AeFnu
	 0HH/YObt66BRUM/ZeX+xEMRTUXMBugMjmQX5VT2yRzq/IhGf9qi/htkqnQqFuJ10/yCNC
	 TfX7iTGuXhrL8HtBe8diNjyiWCCeGZV9dNH2N/tjK9odr3bVmIeAjPWUqH6xwsbuJa34N
	 cGXd3DM/6dDV8zEtp4LPpPFDupZQH2ZR8yUGaye6D6BUYgQTaqgaGfrRWcr4CqBu6Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=os1qUY76;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2D606EEAF
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=os1qUY76
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A561F008A2
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 09:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216259;
	bh=YLSwidnVulo/duXwYls3yNmzTGz4ybvOKeMV6C79DOI=;
	h=From:To:Subject:Date;
	b=os1qUY76I1ZuzMn+pYdJ/fjbmG4PNHSYhmx6euXUX8jGWsrgoKp9cAEQFIwv7G2Tl
	 hxbn42TbfmnKM1ZRLeoxEIMh5aQp8q25LaO7xC3nyPTU9ZLg1pTwbHJWR933NYhOSp
	 +ul53aV8P/4nR4s2ZRy+xtu0oqDKgNUdk7CtqOZ25eNJgO+QcgAMF8K77riXR6fZQe
	 v1OLatv3wBZzLKCPEdz//7Qzwa+9n95zM4edkewjtAWAkXteVPpQtG/V8U2k3nmsX/
	 D0LTVVbU9AChxDelJEY/KAvARTjOt92ms34OFkqbqjMClN9+7h79keiNpws/SztcEW
	 ZD2S7Y//dlCnA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v24 0/8] Reduce the differences between TCP and MPTCP for TLS usage
Date: Mon,  9 Nov 2026 17:24:02 +0800
Message-ID: <cover.1794215614.git.tanggeliang@kylinos.cn>
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

v24:
 - patch 1: fix mptcp_inq_hint() EOF hint logic. Only return 1 when
   queue is empty AND (TCP_CLOSE OR RCV_SHUTDOWN), not unconditionally
   when RCV_SHUTDOWN is set. This avoids returning N+1 instead of N when
   there is unread data after local shutdown or MP_FASTCLOSE.
 - patch 2: fix IPv4 TCP socket handling in wait_for_remote_key() by
   checking EOPNOTSUPP in addition to ENOPROTOOPT. Use poll_timeout
   instead of fixed 100ms timeout to avoid false failures on slow CI
   systems. Return different values for success/timeout/error to provide
   better diagnostics. Timeout is now a warning, not a failure, allowing
   the SIOCINQ check to proceed.
 - patch 6: fix pskb_pull() truesize corruption in mptcp_init_skb() when
   offset > skb_headlen(). Use skb_orphan() before pskb_pull() to allow
   pskb_expand_head() to properly update truesize, then recompute truesize
   manually and reattach with skb_set_owner_r(). Separate linear pull
   (skb_pull) from paged pull (pskb_pull) handling. Add MPTCP_MIB_RCVPRUNED
   counter for failure tracking. Fix failure path in
   __mptcp_move_skbs_from_subflow() to increment seq and maintain TCP/MPTCP
   state consistency, allowing MPTCP retransmission to fill gaps.

v23:
 - patch 2: add SOL_MPTCP fallback definition for compatibility with
   older libc headers. Handle ENOPROTOOPT error from getsockopt() to
   skip the wait for TCP sockets or MPTCP sockets that fell back to TCP.
 - patch 5: move end_seq calculation change from patch 6 to patch 5,
   using MPTCP_SKB_CB(skb)->map_seq + skb->len instead of msk->tfo_iasn
   in __mptcp_sync_rcv_sequence().
 - patch 6: fix error handling in __mptcp_move_skbs_from_subflow() when
   mptcp_init_skb() fails. Instead of using continue which skips updating
   seq and more_data_avail, update seq and jump to the cleanup path to
   ensure tp->copied_seq and more_data_avail are properly updated.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1793969127.git.tanggeliang@kylinos.cn/

v22:
 - Squashed "mptcp: fix TFO map_seq sign extension in fastopen" into patch
   6 "mptcp: remove CB offset field" (series reduced from 9 to 8 patches).
 - patch 1: add RCV_SHUTDOWN check to increment hint_val by 1 when
   DATA_FIN is received, matching the previous ack_seq - map_seq behavior
   that included the FIN byte.
 - patch 2: replace fixed 10ms sleep with MPTCP_INFO polling for
   MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED flag. Add timeout handling with
   retries to ensure third ACK is processed before checking SIOCINQ.
 - patch 6: use before() for wrap-safe sequence comparison in mapping
   boundary detection. Use pskb_pull() instead of skb_pull() to handle
   non-linear skbs safely. Add bool return value to indicate
   success/failure.
 - patch 8: restore backlog flush in mptcp_recv_skb() with
   sock_owned_by_user() check to maintain existing behavior for process
   context callers while avoiding deadlock for future BH context callers.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1793964796.git.tanggeliang@kylinos.cn/

v21:
 - patch 1: new patch. Fix mptcp_inq_hint() to use mptcp_data_avail()
   which computes bytes_received - bytes_consumed instead of
   ack_seq - map_seq. This fixes INT_MAX overflow on passive TFO
   connections before the MPC 3rd ACK arrives.
 - patch 2: new patch. Add selftest to check TFO SIOCINQ doesn't return
   INT_MAX after accept().
 - patch 4: new patch. Fix fallback dummy mapping anchor in
   subflow_check_data_avail() by anchoring map_subflow_seq at
   TCP_SKB_CB(skb)->seq instead of copied_seq. This ensures
   mptcp_subflow_get_mapped_dsn() returns the correct DSN at copied_seq.
 - patch 7: added mapping boundary detection in mptcp_init_skb(). When
   offset > 0 and skb starts before current mapping, prefix bytes are
   removed via skb_pull() to prevent data corruption. Removed redundant
   fallback initialization in mptcp_propagate_state().
 - patch 9: kept msk_owned_by_me() assertion (reverted the
   DEBUG_NET_WARN_ON_ONCE replacement from v20).
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1793870710.git.tanggeliang@kylinos.cn/

v20:
 - patch 2: fix Medium issues from review. Move MPTCP_SYNC_SEQ check
   inside the loop under mptcp_data_lock() protection to avoid race with
   concurrent non-atomic cb_flags updates. Change from atomic
   test_and_clear_bit() to non-atomic __test_and_clear_bit() since we're
   under lock. Add msk->tfo_iasn = 0 reset in mptcp_disconnect() to
   prevent stale tfo_iasn from corrupting passive TFO fallback.
 - patch 3: new patch. Fix TFO map_seq sign extension in fastopen.c by
   casting to u64 before negation: -(u64)skb->len instead of -skb->len.
 - patch 4: updated from v19 patch 3. Moved the -(u64)skb->len fix to
   patch 3. Added comment in mptcp_init_skb() explaining why offset > 0
   with out-of-order mapping is correct: mptcp_subflow_get_mapped_dsn()
   returns the DSN for the byte at tp->copied_seq (position 'offset' in
   the skb), and consumed prefix bytes are part of the same logical DSN
   range.
 - patch 6: updated from v19 patch 5. Replace msk_owned_by_me() assertion
   with DEBUG_NET_WARN_ON_ONCE using lockdep_sock_is_held() for both
   process and BH contexts. Add conditional defer logic: inline cleanup
   when caller owns socket lock, defer to worker when caller doesn't.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1793695518.git.tanggeliang@kylinos.cn/

v19:
 - Replace mptcp_iasn() computed function with msk->tfo_iasn immutable
   snapshot (set in subflow_set_remote_key()), removing tfo_skb_len field
   and the DATA_FIN off-by-one concern.
 - Move MPTCP_SYNC_SEQ handling (test_and_clear_bit + copied_seq update)
   out of __mptcp_sync_rcv_sequence() into callers, since the function
   can be called without the socket lock held.
 - Patch 2: move MPTCP_SYNC_SEQ check in mptcp_release_cb() from
   post-loop to loop start (before backlog spooling). Add the same
   check in mptcp_move_skbs() to sync copied_seq before backlog
   processing when user holds the socket lock.
 - Patch 4: clamp max_seq to ack_seq in mptcp_data_queue_ofo() to
   prevent 64-bit after64() wrap-around when ack_seq > rcv_wnd_sent.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1793361629.git.tanggeliang@kylinos.cn/

v18:
 - Re-add patch 2 "mptcp: drop the cant_coalesce CB field".
 - Patch 3: simplify TFO sync by relying on patch 2's __mptcp_sync_rcv_sequence()
   instead of complex copied_seq checks. Use copied_seq += mptcp_iasn(msk).
 - Patch 4: move subflow.c changes to patch 2, use map_seq64 for TFO init.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1793349369.git.geliang@kernel.org/

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
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1793326853.git.tanggeliang@kylinos.cn/

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

Geliang Tang (4):
  mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
  selftests: mptcp: connect: check TFO SIOCINQ overflow
  mptcp: fix fallback dummy mapping anchor
  mptcp: defer read_sock cleanup to mptcp_worker

Paolo Abeni (4):
  mptcp: drop the mptcp_ooo_try_coalesce() helper
  mptcp: drop the cant_coalesce CB field
  mptcp: remove CB offset field
  mptcp: sync mptcp skb cb layout with tcp one

 net/mptcp/fastopen.c                          |  16 +-
 net/mptcp/protocol.c                          | 315 ++++++++++++------
 net/mptcp/protocol.h                          |  18 +-
 net/mptcp/subflow.c                           |  12 +-
 .../selftests/net/mptcp/mptcp_connect.c       |  47 +++
 5 files changed, 293 insertions(+), 115 deletions(-)

-- 
2.55.0

