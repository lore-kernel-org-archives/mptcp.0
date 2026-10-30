Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324662;
	b=l12Y4hMk2fnD6NaPEYCn2uxKnnFG7YppJzEa9j9MkW3vX4WwyIhhhqHrIhYnjG2pwXzk
	 hILw2GZrMARAttXETNeyzYQjxUTryF9qi9ZU7F7/55CofEkc5f8dPWWpLPn/MM5Lsp83P
	 BZDGKsV+QOuDnxybJ6sGM7OPLpvDu6g2ezWCC3VpqO5mAbzaQd4ou5G5lE0TcntTGaYip
	 fn9b1/tnhld3wBHLXePTJxsyrViEMqhnhFu7iKn9cmGWe5ERZigIdh2dS/Ybxl4OAZsVN
	 blpxyXgTZwKDn3kH5Qe6uRxWVGchhSiJ/yr8PypttlxVmoasAD8Dn/b6rHC05th4jVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324662;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PEAL7gPTnkSzI5PCXwOYE+eTd3WMwkeHK1Eoshy7SwA=;
	b=go6vKKMHpK6SUQ6qKqw/UBocdTcwIz8vMlguw687HpMWizqGeza4IG0QVQrP1BHmhCXK
	 yZUcFfkdH80r3kZ0YSIwYNbBg33PHufjsVONRRlK8/PcKfTs+eqtKemZcWtaweWAec9EO
	 TFwOxnqRZIXejByJcVD4JXfLBOiJdeDOjqdazJBm7mqXCkK0cNwziB+/R8ctRaTUokn7G
	 AkVX8uFKX1sjFDTovKXyC3Qom1eUFcW//zrY1KO5XSpYhLT+ONWJRNurM54erZqRlqrR+
	 64oaCJhbpoqPKnGP7leGn3HRop7wbN8cxIz+tEa+5PyjmdttGoTrvEdUDcSh7zBNdWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a9aQZyrg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F38606A321
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 01:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a9aQZyrg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B0D1F00A16;
	Fri, 30 Oct 2026 01:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793324662;
	bh=PEAL7gPTnkSzI5PCXwOYE+eTd3WMwkeHK1Eoshy7SwA=;
	h=From:To:Cc:Subject:Date;
	b=a9aQZyrgeThSexAiqqI5C4iJAAX+mzTOSS33IfhVeHWVgN5UtUMli5axVcntYyOkK
	 6fx0KXriB0s2NE13b7dmVM2Lc6vrenUbXsD1m9Dpqxa8S2+lCmeV2EMt3I567pa1aC
	 wN/tF+rsmlRVmxXYitIh0zMMyCM9FBiTnC7czuX1ifyv8uH1d4OBwn4CHC7Jm7T29t
	 3Nr8TqHmUXxHhLvwqnD4i7jD2e+ph9fy/v4789PmdAI6B3QMBrIlhiZZMWBa4WYX0Z
	 SbSpNkRxSoSTEV1jcFi4+Tmuuivo8oz5emrRlnm/zv9LNLDgXMNfJC4PqoVaKd/vAJ
	 Ig455zTBBE9pw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/5] prepare interfaces for kTLS and sockmap support
Date: Fri, 30 Oct 2026 09:44:12 +0800
Message-ID: <cover.1793324316.git.tanggeliang@kylinos.cn>
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

v3:
 - patch 2: drop DATA_FIN subtraction in mptcp_inq(), remove the
   intermediate 'answ' variable and return (unsigned int)avail
   directly. Update commit message accordingly.

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

 net/mptcp/protocol.c                          | 72 +++++++++++++++++--
 .../selftests/net/mptcp/mptcp_sockopt.c       |  5 ++
 2 files changed, 70 insertions(+), 7 deletions(-)

-- 
2.55.0

