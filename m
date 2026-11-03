Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676621;
	b=yJTiemyL/1WKfcfwzau/dQS58OkHFLrQPMDGTalXwyb4ykik2IT/DwD/NDm4UFx6OKLX
	 n0w8qvabxYessXsiBQhdU8lfJvnIXE1a6ZKw4h9XOOQ3Kd2BqUFNkyxfLI0foCwe9Q9Cb
	 0L5wLY5XonpRFPiSgWcpQBcFzKQX0CrHTt+21N+NA2QirEAutuWx8pcmwCvWNf5buzZpH
	 xntjnLTUOfxobD4VLkQJdAwp23xdMZYpLuIdFHDbxmlS52VqFfq95ROMfoFbIM6fybVRR
	 RTrwB8ffPZcYqbc0Nkd//+d4RFA3ucZHa/2bSu7JNFzWAwAgkEkaw95xv7kXp/Ngelw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676621;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iK8V1MlfHjnYSbtBsbUWnDX6RDncjbsXaHlKcgDLSuo=;
	b=qSntceGnryAFuJn6jx4hCnDqJygWM3JhKF0099Y/RkSU5Fs8AlKJv6RN1ePkh7Cqx7z7
	 umtW8fKzaphmRXKAEuiuWBVHk2O0ojkaa/mWvgqiwn8+88dm+mxUhgpbH3U4oFJ4pJy/O
	 u1CiVTYO2/oR88pzG93icOrl7dp18uQOZT4fpNzflgfigXhoiRCNXruTnDK3TMauR1exG
	 0E+0zAp8tk1iT0IuWpwiWEq/PBTcHjsUucXDYH/bti3oZHdOLWHtId4CSGNOviHHXnK0o
	 hwg0ikn6Idwxyld1FdLYRlLo4NigdsikXGGrJlbEfGkIOau5TkdkM7kw0saQLLRAivQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpnN8WE3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF2F606A32E
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpnN8WE3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C721F000C1;
	Tue,  3 Nov 2026 03:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793676620;
	bh=iK8V1MlfHjnYSbtBsbUWnDX6RDncjbsXaHlKcgDLSuo=;
	h=From:To:Cc:Subject:Date;
	b=kpnN8WE3Px3s9NwG8xC6UCsWV76D5nANlOhQsypqIlZtIStInEatpG7K2lmF760wO
	 5f9irtF4pDN0SEI6qWsilfKhLCKuMbTGGA5fUXCvnNj3Y4r6yVmCls//lAjncSMNLZ
	 1fLjqDU32CUkOaf8/5bnvUTvHp/P4AknbRlRsCMbPNFJlgTvUUJJUsN9tTmSFqdEbh
	 XnXZPsnCwkEQeMu27pu57BOUhDfgtZUv0095rTzPr7lAkblbPOTarQQn/oes+gl6Kc
	 5v3nJmCfbiqNiWTMbMVmWLqgwy1AHUbZFHV4UqxPSe3fgWB2Oy1L67CN9AuXBfVJha
	 KezJnYI+9yxBQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/7] prepare interfaces for kTLS and sockmap support
Date: Tue,  3 Nov 2026 11:29:49 +0800
Message-ID: <cover.1793676064.git.tanggeliang@kylinos.cn>
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
  mptcp: use mptcp_data_avail in mptcp_inq_hint
  selftests: mptcp: connect: check TFO SIOCINQ overflow
  mptcp: implement peek_len for proto_ops
  mptcp: add sendmsg_locked to proto_ops
  mptcp: track app-limited state in mptcp_sendmsg
  selftests: mptcp: sockopt: check app_limited

 net/mptcp/protocol.c                          | 92 +++++++++++++++----
 .../selftests/net/mptcp/mptcp_connect.c       | 15 +++
 .../selftests/net/mptcp/mptcp_sockopt.c       |  5 +
 3 files changed, 93 insertions(+), 19 deletions(-)

-- 
2.55.0

