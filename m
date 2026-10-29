Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259509;
	b=IoA/oloQDmyJsRgqmNwBXVCz1jKcebRaO2KnaboInk3TesZ1jGo1KYsNW3cJiOui7t96
	 2o0CRPWI0koZ0pV07zdhYk58w/1fBBjOtefoycQ6l0HTDQJc2ZxenKk84KUpZUQ9DdwxB
	 oJCqlLw00tE5h23ZaFITbR7UdZnYkt3W2RHGQ0XoSLDU7bk8Q7ceML+uIIDt3TKmwkl+e
	 Aha/OTMNNCWXFQkYjQ3yQe2n0mvfiwbFqsK5LqE9ZxeeScnnXcFAeY9JncN3j3P5OunTN
	 Qr3tOw3xfVUWJt4xd62wVYLOiB/doxj/VuZK8b6CubYt2wURSBGZXcf1KW10sInnaBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259509;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9wIT/7Df+fOfQKhKSazCFg0NEmPagMOioGRb95Q4ySc=;
	b=EUlIwlJ1nITJQPbSmyitieGq28sLr3RaetHzEqz4+Z5VyOM7q87fB97QqqusdDsIk5Rz
	 qXhHHLgD6WRNHGCUq69MyFgWjTvcMZsiQtNMbuAu6X2dIGgayEpeOjFeD2MQ1q45dp5ka
	 8GV6JyM1Xdq31Ry5k2ZpT39P2mR/69aE27FlyrI39tjNrhlvtn5303ms7rqjJT/w/juUI
	 OJKXydfNmTCs8A04OpoKD5x33gWWNCh300Ao+avZbRC6irphIhaErtACB5wCy7JmskeOY
	 vG0pFvbe9olOo6/P5JMMRax/JA+5rfK6H+gyibYwGida1cbPUol4xs/qZWNhMy4pflQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BUHxshZm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD9606A321
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BUHxshZm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98711F031E0;
	Thu, 29 Oct 2026 07:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793259508;
	bh=9wIT/7Df+fOfQKhKSazCFg0NEmPagMOioGRb95Q4ySc=;
	h=From:To:Cc:Subject:Date;
	b=BUHxshZmTLpeAuqcUNpZacRKNhDUG0zUaz18BzZCbORbJwjAxIEZlbT8Zo7qnVbtJ
	 GYGfPnZiq1aHqmAiPp8A28tiOu/cAvINM/3ARvS5uX4L9Qf3S+Dpv8kRA/i/pVviD4
	 2NdaoQofs0oJ+h42Z7Ro/PJl4MBfDCJ2/HQYa0Sn9vdmnJqueGEnLoJMa/UE30r6bH
	 VQ/tDBv/gaTXpFeENWc2XoPqqkHWx+ZCfSM1xkf/CEflSkwyyNTtesBh3gmUYYQ7k1
	 rx4sX1upeUMsHMYDen/eqBC0lyPX7GhIZ2ls0Ra6wEDvT/LWpnSakoE2lVM2Q17Cus
	 d5jth/g+bj4tw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/5] prepare interfaces for kTLS and sockmap support
Date: Thu, 29 Oct 2026 15:38:12 +0800
Message-ID: <cover.1793258749.git.tanggeliang@kylinos.cn>
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

v2:
 - drop the patch "prevent dummy DATA_FIN on RST in fallback mode".
 - keep mptcp_inq_hint in mptcp_ioctl unchanged.
 - use mptcp_data_avail in mptcp_inq.
 - add msk_owned_by_me check in mptcp_sendmsg_locked.

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

 net/mptcp/protocol.c                          | 79 +++++++++++++++++--
 .../selftests/net/mptcp/mptcp_sockopt.c       |  5 ++
 2 files changed, 77 insertions(+), 7 deletions(-)

-- 
2.55.0

