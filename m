Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64E2BE621
	for <mptcp@lists.linux.dev>; Fri, 21 Aug 2026 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295910; cv=none; b=oXZ6YeF1IxKl+3TfUWd4REoGrvSuoKjvsh4WShF6Qn1lNcJulEGFoNhzb8hQaaikxj29DmW2pqMMPFAS8UVx4NVtZvE+0aCLb2Tp7t1hLjaaCPh6o909Qhy7ufIr0UCJ7M84I3LM2H42fKnvOu8Zb1y9k0CZtupgIoajBr7ANi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295910; c=relaxed/simple;
	bh=99Lu5YyBEzv5W2r/DkAq9GInGPz0ZqQnSW778cwURts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E0XD/+GzgM30qrDYzdnSzEACt6mEDL52lyy9HwYe/YCXEhBoXojrZrHB7uW3lY0tlxPZHV+y478N8oQp32soiBC53TOkaCBIOnk9qT4CM4Eo+hHg3rqdPsBxM4rQGP31OI0jBCYuvksbv6PHWrPY5/SYzmnqX1UF6GWpwp0KZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2HaNhcV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2HaNhcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C784A1F000E9;
	Fri, 21 Aug 2026 07:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787295906;
	bh=Rmox5QBVFJh0Va/ogxitGw6/8ydf8pGpuUkpicas1OA=;
	h=From:To:Cc:Subject:Date;
	b=Y2HaNhcVA34hsqu87MaDrJubSwCLK6rDgOu0l+SSjqx26l3v6A++o4Jo38tk0u2D3
	 y+u0b/x1AiMU2vCc70JjJwvznKXLbEkjPtI+fhsWNgN3UJ0pZaYOQ9R87Imez5q3D9
	 Ke0QHF+Oaf/vTIBG5a8RoOkrFXlVTlNjngyS3090e/GweL/nZbjUfv4Txg3KmHR1sK
	 udniGzPI4JB1HWyjlPBcjIcd9hD1GpiURQMRx2Gpmeh1kuajFvTQQIDi9jq0EZn4c1
	 l0IvfQCJYbONOLG04lzWxDhEdTTdTgseMLxz7QDt9tA7IUvZoYHpiiaHWd+NMwvMPf
	 dZRYPZWQfrGSg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/7] Reduce the differences between TCP and MPTCP for TLS usage
Date: Fri, 21 Aug 2026 15:04:21 +0800
Message-ID: <cover.1787295147.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (2):
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
 net/mptcp/protocol.c                          | 263 +++++++++++-------
 net/mptcp/protocol.h                          |  21 +-
 net/mptcp/subflow.c                           |  10 +
 .../selftests/net/mptcp/mptcp_sockopt.c       |   1 +
 7 files changed, 209 insertions(+), 113 deletions(-)

-- 
2.53.0

