Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795864111;
	b=ZNXr6IIyqtqK6MBhMz/TFSYbaq0o+5G5+T6W+e7XkmRvkwaj8If8bA8AOhP1q7q3/G1a
	 cvI0taMyh8W0cuDiNvunujy9H8/c3qaXLXfOrG0h7SGc1SLHbxwHH3TqqnCM3iYzgROgT
	 DxM6p9QXUkvQ7AsZtHb5QUpZEfxhtWWeGDqnBEEVCRrHk+BZb1ZwTChbdD+tVQu3Nv6mM
	 fmQk/A7BSg27WUH4aXdNISzRkvtsY/fIR3wlw+mFP9kLAafZHIE2vJ+Unje4PBG+gOOK7
	 NOago6ZuKRd1/V7afLaUdWQUvtBoZZkF6i2FjjEULwP5mBzrzIoo2xKrFYKyppOhOZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795864111;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+oOd0XpXY1VXoiyUnjStDGp6fHK+MxpnjKyz8n8u3R8=;
	b=MrexuqMLYj0fJ0T3qco/eE//1apURg5By/uRzudBOP8kQ8SR8W09ZvI21NHnGnX0O32T
	 m926/si+V6aovUa2oIPytJMC/r2qaPANJhHYy+JhzucnLDESqF8Sc4zgta3+QuzY/sYox
	 /1q4e2t9SGqQFxYdy0tRmx+Gzj7psxWjgYZ3fLeKJrQgq1MJmoGLs8u7xH368UsSFKSsO
	 cm+u3+zsWhbD5Ig28T5A8ZoNFEIV3gmfDMHxNKfngtt+qfXX384ZhxLYFMQ3PQ7s93+uB
	 BqpIc5vtnea4GMrBHp4NEvsTjbWJP7LuH29kaBongJ7xzmjQTIZ/UOERKDFev1jkURw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jaBK1pm+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B467606A321
	for <mptcp@lists.linux.dev>; Sat, 28 Nov 2026 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jaBK1pm+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4981F00898;
	Sat, 28 Nov 2026 11:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795864111;
	bh=+oOd0XpXY1VXoiyUnjStDGp6fHK+MxpnjKyz8n8u3R8=;
	h=From:To:Cc:Subject:Date;
	b=jaBK1pm+T/PSLSh0dj7wjglFv/Fco1uVdT6iWLD/jX/oyxQ/Yj2cHl21JC3MN2ZO0
	 HT5El6216vVID1e6emmGBpzNyyyyu2/h/kHAdR4SFTAFUWNqNojBCtqglZZt86qQxZ
	 BG9KOnjwk0Sr0k/TWCqpeiPOq1Lj1tqlfbB/0Azx3J5tMgksShLgFktoF5ONe2U13t
	 yI5QIMsw8H75Q07SUVWJy4Dp+FbWThj+F7SdBsXZRHtKvFby4as3t5VECkzOlcVeW1
	 4lycCmNxGivT44oEzn8vIiLlghs50aZv2AMQKJ7UrLC23FlH82qBEGQCUx6GjkHU3R
	 FxpP4U6WITfJQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v4 0/4] mptcp: fixes for SIOCINQ
Date: Sat, 28 Nov 2026 19:08:02 +0800
Message-ID: <cover.1795863454.git.tanggeliang@kylinos.cn>
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
 - drop patch 1 "handle ack_seq advancing past rcv_data_fin_seq": revert
   '!before64()' back to '==' in mptcp_pending_data_fin(), the OFO queue
   edge case is not a real issue
 - add patch 2 "use SOCK_DONE in mptcp_inq_hint": replace the
   TCP_CLOSE/RCV_SHUTDOWN check with sock_flag(sk, SOCK_DONE), aligning
   with tcp_inq_hint()
 - patch 3: use sock_flag(sk, SOCK_DONE) to add FIN byte instead of
   checking TCP_CLOSE/RCV_SHUTDOWN and rcv_fastclose, simplifying the
   condition.

v3:
 - patch 3: fix Sashiko AI review comment
   avoid comparing ack_seq with unset rcv_data_fin_seq (0)
   check TCP_CLOSE/RCV_SHUTDOWN directly, only call mptcp_data_fin() when
   rcv_data_fin is true, exclude MP_FASTCLOSE from +1
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1795396910.git.tanggeliang@kylinos.cn/

v2:
 - patch 3: drop mptcp_data_fin_seq(), reuse mptcp_data_fin()
   - u64 return couldn't distinguish "no DATA_FIN" from "DATA_FIN at seq 0"
   - mptcp_inq_hint() checks rcv_data_fin/TCP_CLOSE/RCV_SHUTDOWN first
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1795348666.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1795318567.git.tanggeliang@kylinos.cn/

The goal of this series is to make MPTCP's SIOCINQ fully consistent with
TCP's: both report the number of readable data bytes, excluding the FIN
byte.

Patch 1 fixes mptcp_pending_data_fin() to use >= instead of == so that
DATA_FIN is processed when ack_seq advances past rcv_data_fin_seq due to
OFO queue processing.

Patch 2 adds missing smp_wmb/smp_rmb barriers for rcv_data_fin_seq on
weakly-ordered architectures.

Patch 3 fixes mptcp_inq_hint() INT_MAX overflow on passive TFO by using
mptcp_data_avail() instead of ack_seq minus map_seq, and reuses
mptcp_data_fin() to guard the FIN byte (+1).

Patch 4 adds mptcp_inq() that excludes the FIN byte, matching TCP's
tcp_inq() behavior, and switches SIOCINQ to it.

Geliang Tang (4):
  mptcp: add missing memory barriers for rcv_data_fin_seq
  mptcp: use SOCK_DONE in mptcp_inq_hint
  mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
  mptcp: add mptcp_inq() for SIOCINQ

 net/mptcp/options.c  |  1 +
 net/mptcp/protocol.c | 62 ++++++++++++++++++++++++++++----------------
 2 files changed, 41 insertions(+), 22 deletions(-)

-- 
2.55.0

