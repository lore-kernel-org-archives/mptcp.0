Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000189;
	b=JgYn4F/X0C4akWfjz2IN6GDNjOD3uXws2COPcyi1Shp3y6TMNsMy1DfH53zxiSq4+osB
	 3sQ9oSfoBeOVlP+WANQN7kSIoO6OGhNNrs1HvHKUDkRBr/chmC3j3Llm9p3ondBJZazgK
	 cyMB/qoX2cjHSF4Vb+Rmq+P100t1rlDOMlPmroz0FRm2YNFjJ0VSSRy9/8xNsA+qF2jfx
	 smJ8S6Vao1+ZBjQoIxB8RZTJT19oSbP4qYrVylCWHKBuWWuGNDwiuXPPBzAwfcNcPE0Pt
	 oG6D9+3nFvL8ZYzeHJKZ/3lxvsJxNQySWfmz7W3oIsY783tgO5hEswnjB8UYRxbJarQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000189;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G42RRxZ71vSQMaE3e+aTKH+ZUVLeSO+uj7VL5sTlD8o=;
	b=JmCJjstCc8mjY6TtufR9RuMPDZr3F+dnCmbFPPKUCetlkrtPETQc99AvIGvbtITPYifg
	 vGcSgCsTLd+vcR31qNixmhL2xQXRFdU8eo0dpTaj03DE/tJ7HN2nockSkgwZRBHSauaxW
	 3VUVf8nGd/sLPfpbgKQg9Ic+XXBWm1mU9unR+8LJNHcxOw9SDQ1PYukrrYLqjg/2Zmh1o
	 kSWemVdfw+oLicj3CjndH0BH4YgRPgYtWx2aZ5j84xdyWEdyswSrc2Ucb4lhfwZdeA/N+
	 opOImguG4YuOJhFXTj6HFraLqeCGpyTWe9JAXqF38UoeDOa3caYMIh2lArz2A1C45Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0VJk6kM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D5606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0VJk6kM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6795A1F01829;
	Mon, 26 Oct 2026 07:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793000188;
	bh=G42RRxZ71vSQMaE3e+aTKH+ZUVLeSO+uj7VL5sTlD8o=;
	h=From:To:Cc:Subject:Date;
	b=J0VJk6kMCMIsYJHXTdGt+pvI/U/Wh3u66SgBV7/jVSCB0DPI+YJHi7omFHNHX/Hj9
	 36NSxv4+2MQXo/LTJbayqM+xiDVkpUw4kzT1VlIByXFW6E2AK/thUTws3rGMNaaxdx
	 jx1yEGO+2yj9lePeAiiwaDaIwrKJ44CSTUeaXI87AS2j9oP1wFzbKi8kOkKkTsdhi+
	 BNRNwhrtAFYMDJ8f3O6DUm09MYkxOu9k43UUkIL1nvlzlLBu9XMTQewG5xlfi7ICpK
	 ulE+5b2mDXhoyo2ykItbPRbzowWXSIU3/44Xm2gx/v9EsKkNzcgvi7pxH/fWDeLF3V
	 LQYoTH+IU/dKA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/6] prepare interfaces for kTLS and sockmap support
Date: Mon, 26 Oct 2026 15:36:16 +0800
Message-ID: <cover.1792999988.git.tanggeliang@kylinos.cn>
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

Geliang Tang (5):
  mptcp: prevent dummy DATA_FIN on RST in fallback mode
  mptcp: implement peek_len for proto_ops
  mptcp: add sendmsg_locked to proto_ops
  mptcp: track app-limited state in mptcp_sendmsg
  selftests: mptcp: sockopt: check app_limited

 net/mptcp/protocol.c                          | 86 +++++++++++++++++--
 net/mptcp/subflow.c                           |  3 +
 .../selftests/net/mptcp/mptcp_sockopt.c       |  5 ++
 3 files changed, 86 insertions(+), 8 deletions(-)

-- 
2.55.0

