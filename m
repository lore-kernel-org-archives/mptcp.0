Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860694;
	b=mkJkoTuw/Cu/OEQSXZyD6sDJDdfEknVtbr8rxxfQOh2zWVgD8OP2J/a/xACGJsgdOx7F
	 aH2Toa/QYn+tEayecrAMfNnYkMRr8OeIMue3JTQ0sGRmokoljlMANX156+DiQ8fmcVAvh
	 fXoj1QWtiFSwLh3PtvyHqERCL5Y2pAFF7XWoQXcuDmvc45r+V9jyaZl3Xf1/rRtaAiLQq
	 pzpBzLy/jGDYXomvJ3exOsCdKmkxmVrerBXolVm4Pgl2TZUCDplTVO1kmBr5H/6jhg7ze
	 h0hZLcrFNX6zezUZmI2lHMmgmEDfL2EdVp+URtwye77X0MsZdUDovCT/ZFSLU3uouoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860694;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Q/38GBNQH6SgPd1KHNxzGKXc23TeQs+LSC5Xh+wIdkc=;
	b=sYRvVl3zqyMohySzeCwAtLhmC5RfnVywSTFORWpi7u3QJ2DyVXZvbb79UBHu4NGmTfA0
	 P/XOzugZd3FEh5Nc9VFvzpIs0mK2isNk4ls/JBjrlCXxP6Gq/wJWxj6EUQB20tLHIojas
	 ZM5B0DaIwA+bN//KAjPJM+cXhx2tbP+2i5sp21LdRYDpxUYAkz6mLcULC2g6srdQpyB4Y
	 zoeZ78UcB52uAyzL70rd7lSrz33UHplPFHANjqPIKNs/LP3aWXtVdV99myMOlD0lqwnus
	 2T7cvo2CqBa7qAuB/+KfZELO4JMiNwPZCo4nWp5KjXlo/m0O/u8vzQAPvGb9CKFiSCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtAtY+wf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC9D606A31B
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 06:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtAtY+wf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDDF1F000C1;
	Thu,  5 Nov 2026 06:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793860693;
	bh=Q/38GBNQH6SgPd1KHNxzGKXc23TeQs+LSC5Xh+wIdkc=;
	h=From:To:Cc:Subject:Date;
	b=DtAtY+wflrNT85jg1HmS4s7syD3adMe7VHWqZUMY/1hp/nGe9WdJtu8qGIZyx1Xgz
	 Y6OU2JFM+hqe+JEeBTNe2Ch25JmSLk+ORc0fes/xTYHzUbTDNuX8tDTxP+7BMfcKER
	 fwYskmPJVl9GeZrGaooyxlEhRwXQv9rDFPkQHvTMNeCvcAqOSoKy0JC8BtMbIZ2EmU
	 hA6pJd25P9BX78bGDzDPKwuL4s9+SRtn4Sqk26op2G/7DZ7tFVlRGDEiXqKErzZYX5
	 GxLNRCqYgCsv8WE4IyZkhVvua00peeTOY4U88WBqJKJD6XevZOfzHim/jBt8IuPzdq
	 ABKrlPO6TlaOA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 0/7] prepare interfaces for kTLS and sockmap support
Date: Thu,  5 Nov 2026 14:37:56 +0800
Message-ID: <cover.1793860134.git.tanggeliang@kylinos.cn>
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

v6:
 - patch 2: add Fixes tag, and use '-net' prefix.
 - patch 3: remove poll() call, check SIOCINQ directly after accept().
 - patch 6: add READ_ONCE() for msk->flags and msk->cb_flags reads in
   mptcp_rate_check_app_limited() to annotate intentionally racy accesses.
 - update commit logs.

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

 net/mptcp/protocol.c                          | 96 +++++++++++++++----
 .../selftests/net/mptcp/mptcp_connect.c       | 11 +++
 .../selftests/net/mptcp/mptcp_sockopt.c       |  5 +
 3 files changed, 93 insertions(+), 19 deletions(-)

-- 
2.55.0

