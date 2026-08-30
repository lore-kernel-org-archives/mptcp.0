Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FB139479C
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100381; cv=none; b=GENm8r2nbZH2EMc4geKKMTd1+MLygwHgv/fj5kFpdO5r3eKLDIj9J9YsFeCYDPjJCxAy6g3qBlbuKzOxXl8dMhjLGEO2Y0lg2xXWgY8KQpZdg0oLM1dXGVvTkxrpF7Qcwd7AD/NTwvZlP+0vQiKsqrpl6VAdk5W0N6wGrQw1PDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100381; c=relaxed/simple;
	bh=cWCAyWfafGwGzhNIPb2Jsy6cuEDQMTJyX6DTWa2mYkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T3msolDeg4NF/n+3pCY7Jq4Ib//WO2M8Lb6MVxEpGc6WsofIHPzBabxIvN5bLMh8PskyT1OYNY2gBLBQypa5MeXUtUmgE3eo9ewiJPPnP1h24iJDAUMHJqC/wHCUE5qeEoLN2HYFTPzSpFN91aVix2zahm4CXO+3mpDs8IBvZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jhnolb/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jhnolb/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F15B1F000E9;
	Sun, 30 Aug 2026 14:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100380;
	bh=PdegG5aKQcl5vT1PnrOJRuf27ofK1rx+nZPA1ZCeNvY=;
	h=From:To:Cc:Subject:Date;
	b=Jhnolb/qCq+VSb/eAB6K3cZQV1JA/fVrmuZU2fZOz+9tV/r3uwsQMaIZu1VbIJKXl
	 yiDbOZejoXnjCtwnfCFKwavFRi+M6HpHM7DDgnDTc4z2yZTSxFJdujOWPB4NS0ixIA
	 v/a9kprDi76tBCvZ5GIJqloImcA6ACDaoz5NZ+8GDgXWkKJpZg1L+r1ghWCAcctoIR
	 wxuBAOcv9sbdTPywOpt3PmqJs2kdlTR52/WoUQfMk7ymlED5EX+/CUeSBRwt7Wiqh0
	 cruLTeMJv9InVT9KCCq3jOyjwjOsOTwFw42aMUMq/BTJ0eOR+fim7qpT9aTG4r9lPH
	 940m+1gQkgvBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 00/10] Reduce the differences between TCP and MPTCP for TLS usage
Date: Sun, 30 Aug 2026 22:32:43 +0800
Message-ID: <cover.1788099847.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v11:
 - __mptcp_move_skb(): gate __mptcp_sync_rcv_sequence() on
   test_and_clear_bit(MPTCP_SYNC_SEQ) so the dummy mapping is only re-based
   after ack_seq = iasn.
 - a new patch to set and test SOCK_DONE.
 - use SOCK_DONE in mptcp_inq_hint() and mptcp_inq().

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

Geliang Tang (5):
  mptcp: align FIN handling with TCP via SOCK_DONE
  mptcp: implement peek_len for proto_ops
  mptcp: add sendmsg_locked to proto_ops
  mptcp: track app-limited state in mptcp_sendmsg
  selftests: mptcp: sockopt: check app_limited

Paolo Abeni (5):
  mptcp: drop the mptcp_ooo_try_coalesce() helper
  mptcp: drop the cant_coalesce CB field
  mptcp: remove CB offset field
  mptcp: sync mptcp skb cb layout with tcp one
  mptcp: defer read_sock cleanup to mptcp_worker

 include/net/tcp.h                             |   1 +
 net/ipv4/tcp.c                                |   9 +-
 net/mptcp/fastopen.c                          |  17 +-
 net/mptcp/protocol.c                          | 339 ++++++++++++------
 net/mptcp/protocol.h                          |  21 +-
 net/mptcp/subflow.c                           |  19 +
 .../selftests/net/mptcp/mptcp_sockopt.c       |   1 +
 7 files changed, 288 insertions(+), 119 deletions(-)

-- 
2.53.0

