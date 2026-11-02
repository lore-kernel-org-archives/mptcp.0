Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793588344;
	b=id3H2k23FGijwO2QoEQOyvUdU+BdLprtTe4KShgGACeLQlGdELktJUQBBP85ABoDE1tD
	 F6kl+BIjlcqeIHDJ+7HYv4dp3ELpWJQ6hRHT1K65mCY3Phe0q6bL/IciXT0QafNAqxTdO
	 3t2wCpV+CJ0KVB+q/4WMoqcvefV/K9e7UdOcg6uLtPXxRSSr379+YwjYdYFo9obfjpnoW
	 J9hPchJRlTpqblll7ZcSzIZp4Eyb00AqUrjiAqlN2jw1CHgCtWhqf3rdf/1MOdt+php//
	 DkaV20lha36Z4o46Uw/syo3g8VJSXRm6Fk6C9PWRm/3EfvZbbtByIcm7vWjZUn1v5yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793588344;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jOD8nhp5mxZ3H/++COyRosvjHUww0SYlul4ovzk0/2o=;
	b=W9GOmf2GWZgPtO/+ijM7hKuJ/OKFBvI7ro5cEGrNd8e/tAjJ8JU2W9R0zgEVsw/twnqC
	 vjLb4cywgZsybLIC58KkNDiyHJhpMxQGNIyeUYemXGd51bJz+EZgBFjYzdQoJVT3btSFg
	 LrXtVApwqc4fF79b613/rsJzzW6FKVanaIcvfu0xVBkZ3oBrFulB4bkJJnyLqux8u3GPj
	 3MiH25FOrdr3aB8+Fw53mjYr1/wYVQ708P7ylvpdBV6eA20LXErw6G60oyfTP8Ssu7UWG
	 VyDF2eATdaOAQea004H6Z4De8DO1Qz71ulF/p6NyysSKi44nEgqi5bdXqDqjuRdgDhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQp9AweQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F635606A324
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQp9AweQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0620E1F000C1;
	Mon,  2 Nov 2026 02:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793588344;
	bh=jOD8nhp5mxZ3H/++COyRosvjHUww0SYlul4ovzk0/2o=;
	h=From:To:Cc:Subject:Date;
	b=CQp9AweQDkxhunsoPT7lrRMRHf+P48OgkEv3sygtnCdttl6gXOAkSQpRoDBO2MnUK
	 5mjMMz2j1VEC+NuAQG+cF7sxff4CKFV09vgTTQc+fk+0LRCk3bQvH0a4PhE00TTk60
	 TJ3WaiOQeuLQEwh9nn5nVbbZpOgJGa6yeFTVCJB0tLqCtIZu3l37IYiOwpWspBdfSy
	 +k5wxp6TN5i3+lzOK3qvnhFFIO3TZgpx/EnDZCOaakmlw9UwBGwLgtcIRMgorr9yKn
	 zv9Ng+Ws/KN6Trl6emjJxluRlIIohhogJ04a1rP5TdLf6BLiEUX+4IvsXu8uUmkJzB
	 iWnv2G7cMdJcQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/5] prepare interfaces for kTLS and sockmap support
Date: Mon,  2 Nov 2026 10:58:53 +0800
Message-ID: <cover.1793588257.git.tanggeliang@kylinos.cn>
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

v4:
 - patch 2: fix mptcp_inq_hint() to return 0 instead of INT_MAX on
   passive TFO overflow (ack_seq - map_seq >= INT_MAX).
 - patch 4: add mptcp_rtx_head(sk) to the early-return check in
   mptcp_rate_check_app_limited() so pending retransmissions also
   prevent false app-limited marking.
 - patch 5: update comment message.

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

Geliang Tang (4):
  mptcp: implement peek_len for proto_ops
  mptcp: add sendmsg_locked to proto_ops
  mptcp: track app-limited state in mptcp_sendmsg
  selftests: mptcp: sockopt: check app_limited

 net/mptcp/protocol.c                          | 75 +++++++++++++++++--
 .../selftests/net/mptcp/mptcp_sockopt.c       |  5 ++
 2 files changed, 72 insertions(+), 8 deletions(-)

-- 
2.55.0

