Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E23FB060
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151777; cv=none; b=SdBiKwqrLbUeIeLnFvWirNatXkjOrtsFw+17vTK+QH2gzhbESbxxDmXUwK4q7pSx7+WiUW7oALqtD2b1OY0rBTyVwPU7mrebPwLyAZvJeIGGdbrrctXmaRJIWfhCskUkmAg1I74JgiVDAobqASSgpIzYgZFqmSqI/bTpgXN0tWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151777; c=relaxed/simple;
	bh=RTTGGIVMOXb6kjQLTo22tGGmDc9ua5D5GHbetiWmYj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWSFXIDSbff4uU5NMR2Gh8z+u6MczI8tTWxwuV01ViEduLWP8kXwdVDPdjKAUhxVw5RZVhnmZnsACmf38LeFYQoeOpurSezGI3gbC0l1oHO4xvj/x667CkPs+eXKmX1rPQC0Sotzv3sUEz5fyH+g7NuYU7J0LThxDTgtmWf3QIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym1DY7bO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym1DY7bO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4EE1F000E9;
	Mon, 27 Jul 2026 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785151776;
	bh=VeWMagpV0WWt8O+DF9GzQlSEq729HDRENvfU3d3Nxrg=;
	h=From:To:Cc:Subject:Date;
	b=Ym1DY7bO2lCFDgfG9xX1i8Y5R1x41X35XU/njdcAzsBkeLBNwq8ssv3rWrVi+qBZy
	 J8ProJg0fgNT/9HWbI0EZTpECFmgaHskCap5uHn3HDWYuPMxYVf5kiB3plop5hNBGg
	 XV23ItCCxb6/j+44bvWwGZlZKTirrOWg1OOs0sKfXtVe5RbgH2DBckJfmKwk3wbnka
	 N9skC69EvKkIY65crEUAcreLzMQpS1AqAY+gvkkuo1PiWnT/zrzK10Ig5fhaG2MLro
	 W20r8AsxsRXtqW7sEZ3DJfHp+QGpFMx1+l3qwj716JPpTV2+P+jASMz1VhcymQSi6g
	 WtsMDOhvuymZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/6] Reduce the differences between TCP and MPTCP for TLS usage
Date: Mon, 27 Jul 2026 19:29:15 +0800
Message-ID: <cover.1785150300.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
  mptcp: trim the duplicated skb head at receive enqueue
  mptcp: defer sk_data_ready to the worker

Paolo Abeni (4):
  mptcp: drop the mptcp_ooo_try_coalesce() helper
  mptcp: drop the cant_coalesce CB field
  mptcp: remove CB offset field
  mptcp: sync mptcp skb cb layout with tcp one

 net/mptcp/fastopen.c |  17 ++-
 net/mptcp/protocol.c | 323 ++++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h |  20 ++-
 net/mptcp/subflow.c  |  10 ++
 4 files changed, 250 insertions(+), 120 deletions(-)

-- 
2.53.0

