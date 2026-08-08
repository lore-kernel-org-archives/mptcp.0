Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA1E165F1A
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786158556; cv=none; b=HIxNURut6kzwirrKoukSzA3WqD4w/+Ptp+TzoV5YPpYMEwAkDhlL9T5Yr9/njgFsfrl7ogXwRu36ff9Ml6HjccM2h4Wby+wXonPoIRLkR3N+WOjgxgFhLYNRDQ8GdV4zIehEtCh9pA5SdBRRgmdjB/FM9Nb6LqJ18RRCF7JBEBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786158556; c=relaxed/simple;
	bh=LgGTKGqkJIawoRw/9zmtmg5mbgXWRykqHGe8o3ryUNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sDN+kC/WlD8O8QP+mMw0zgLLNi0zIA53loBn52M1kM/R86WIojn20pRdvQL9P3G4cwuJUes9mx21gpJWOwk1b6gA4+ziylKV5N7xM6FtQNmV81SnEHEanXdt6Atmx1nFJG9VuxoMomjxMyzWWCHtbMAwfYpmzfslKZsCH0o6qHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuFHnXco; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuFHnXco"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B663A1F000E9;
	Sat,  8 Aug 2026 03:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786158554;
	bh=ZenXRKzFzVS59dGUAgHXjlk6C0PDbd//tVOYdeaFk10=;
	h=From:To:Cc:Subject:Date;
	b=MuFHnXco8mJziRyBXzUpJyfKy49Z4l/UeuqJzVasKM1GYoNCxY30+5maeh8TjylIL
	 pBN1aRy3uC0Ew6KqbIPhA1BoioOwo8mA8oiKC2iA+xnXWbqwqeX3AC835VN+FZDbyG
	 xkGGXvTsHdu5LfLMm6C00uYi1Ub6Bu3RMcro8ni5Du2Wi9922NoRxW058k5sadRmdv
	 HlCkP6SQtOAiv1Sf2hB+VS+jG0qDbtf+lqQHsWHEDN3KlZctT0bkZUPVHT817gljLP
	 0UvstO7VcwlpCb/S3vergO+di8h9cK7wmCstb4vWVKOSecdFzwEdaYh1x0XT5sr7Gk
	 3l7mHiGCTgeIA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/7] Reduce the differences between TCP and MPTCP for TLS usage
Date: Sat,  8 Aug 2026 11:08:41 +0800
Message-ID: <cover.1786158416.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
 net/mptcp/protocol.c                          | 260 +++++++++++-------
 net/mptcp/protocol.h                          |  21 +-
 net/mptcp/subflow.c                           |  10 +
 .../selftests/net/mptcp/mptcp_sockopt.c       |   1 +
 7 files changed, 208 insertions(+), 111 deletions(-)

-- 
2.53.0

