Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795397239;
	b=gXn8Rp1U+wpd17qh4Zq6Euvhr3F6vYOmaykpLg7jzwcxRJ8bQdpmJ5X9AkIJIVbo+Ip0
	 A1O0SDY72BTKqrzWuoGLOIHh4RMM/Kk84YRSG/HeVWOXjoRjmkOW92Lq4+4IlvZkxey4/
	 6ERH0Eed2IKExKxHN3tCwkTFoRgfI6DKtwprccj/dGztgc/PbPze9+PxEDpYozuhKZWDg
	 jJcx2qeEjJLXsf5ht4yNpHPs/sE8CDH9MdxoHga5vX4Ja/ddZtbCZGsywjBHhJZP80Ek0
	 +gPRanhdD3++P+hlNNtSKdGrtsL7Jja0SCVBNwURYmMJfa1DKQrhsEK/HlT8ju8tpVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795397239;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Da/pLBaGlrSmp2X5BKsBvROFSfhRJgjd7VBFwZOmVV4=;
	b=GJAYkogoR9hS3nI3U2RFsCWQzFhr1iesxRUmBCvepaOoazp2CI/LmRN5NzsFTQnerES5
	 gnl2nQDPpWrcuEGUbtR3dJdq9wtIUPH0G2ELgUen+zN12vaT9ompX1w0jlzKZIsptgPF9
	 c8Wqfn8hf+nfDiWj12oSKBFb1Hgy9aR2YBQkK9pYPxV/RuNtjjhnFIP/CL+IFhdK72ZXI
	 J6WyhJV2HbLO4WpialXqJGSxdDUY7VWqRV9Jz0mUNsAKjc/vV3PkFWQHEwJ+K69Teho3a
	 OB5R/NLmpMEyh3LrJSvP6orkSdpwa1PYdQ+9IwM6iR22aYcEvCzP8E//3TswznG61nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d/NyNyrR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8122606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d/NyNyrR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FC71F000C0
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 01:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795397238;
	bh=Da/pLBaGlrSmp2X5BKsBvROFSfhRJgjd7VBFwZOmVV4=;
	h=From:To:Subject:Date;
	b=d/NyNyrRk/BhadHwccmKYYRs6TpmW/UH6TC7lC/0HWgW4hD0NTE06cJ0weISdKk7A
	 uo+6Nwp/YZ86N/nL2U6jMYbke757yE7pEzVxO5R7TusIKLs//oPzHgR8sdBjZv6Iqx
	 IEtGc/iVzETcN07DBmQY2iPSeO2o1fn8We1+hB9xEWjV3xYbJNu9AhoOFq13ZfnOe1
	 S8lvl1/tG5V0ca7tyvsnGx4+3P8o31+818KGIO+N7WwEjtwlIjygokqy3e1o7EbtST
	 McbplfeUCOwjz1EQ+AaaWk9eE1Gstwa96BJhRYZbAnD+4XW5UL0pXqjTz03/ngwKuS
	 OyddFJ+evihNw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 0/4] mptcp: fixes for SIOCINQ
Date: Mon, 23 Nov 2026 09:27:10 +0800
Message-ID: <cover.1795396910.git.tanggeliang@kylinos.cn>
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
 - patch 3: fix Sashiko AI review comment
   avoid comparing ack_seq with unset rcv_data_fin_seq (0)
   check TCP_CLOSE/RCV_SHUTDOWN directly, only call mptcp_data_fin() when
   rcv_data_fin is true, exclude MP_FASTCLOSE from +1

v2:
 - patch 3: drop mptcp_data_fin_seq(), reuse mptcp_data_fin()
   - u64 return couldn't distinguish "no DATA_FIN" from "DATA_FIN at seq 0"
   - mptcp_inq_hint() checks rcv_data_fin/TCP_CLOSE/RCV_SHUTDOWN first

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
  mptcp: handle ack_seq advancing past rcv_data_fin_seq
  mptcp: add missing memory barriers for rcv_data_fin_seq
  mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
  mptcp: add mptcp_inq() for SIOCINQ

 net/mptcp/options.c  |  1 +
 net/mptcp/protocol.c | 63 ++++++++++++++++++++++++++++----------------
 2 files changed, 42 insertions(+), 22 deletions(-)

-- 
2.55.0

