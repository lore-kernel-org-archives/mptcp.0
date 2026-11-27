Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809740;
	b=073RAPHTO914bTufpOBsT+Vlz2DqXGlh5STe4+WDTZuZPB3+eYVr+mRO1a8/z4/OLQ0X
	 998bs47I2QtMoJJ422Jce2g7c0BVjznwV9wxZLRzEoBLrCbuT0CLTWG9NmOqr1d7M2UVw
	 u4EV7LP206UkYEf+chIYxf8odWd2EOkbRl3kF/PGp4RBYcZxvXVkHmt6CCdyrGg8LGqFb
	 Cx6O8unEGLeSdCOf+HsJtINPOSvW7zI9rbg/4UHV4a3/gS/GzCF2lMoo/aLOkxjkBqFig
	 2T5xKdpfwU593KpjzDEN8jSuYSNxvIyNJldBd+eJ2zp00x2UQrH9KgrBnOV43RYsCQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809740;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=lPZij7tIRjyQBtLC031Og0k2bsUafJZymDbadiP56uE=;
	b=tzuUT7B6AFRV0DDmq1gfAiGHtV6zKvmtDwQ989id5kpL9jWu978e2xUHRgyg1ezh6kBN
	 iWfsqLzgd9GX6dzs776UfVWjN6/b5t63V5I/TehgJmUWbS1xBialDHbkLj2LZBq2xSQWY
	 p0vSpn3fo5UXJbjzZeAUo65wc6G1V7s24TRL2AWDmkJdl8LX27f1LFf4i76pYC01LoTyZ
	 HNuD4GUPPw9QIJay46kSt9ipvGMHmR0NILoVUna9Owoz/dl9+IitFnbtiXKlUkjDyWaHW
	 BhbNvRx1icTGvP+wXyqubIZuFoXgrDCDRlcM+8mizSfpJIaExbbUDYQ9fdWRrFWucDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2WL+lNR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2074606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2WL+lNR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AF51F00923;
	Fri, 27 Nov 2026 20:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809740;
	bh=lPZij7tIRjyQBtLC031Og0k2bsUafJZymDbadiP56uE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S2WL+lNRXIhXlYy4n5/McMYYc0ZZY46LHV7MiJc6fydpuGfhbQiB/bLjtbFTL8G1m
	 +EttwJvk/Mk3nNrWb40wD1LxCIYaH/d1EU5mWHVCkQdQpDQldKJpZvygxK13JlyjYo
	 YfuQX1dwxxspTIhWAdHyJGd5tI2rPGyZ3SVKHdBg3AxjHZX/qRvJuAcXDMOxYEFd0u
	 ME54iNbbgMpHS68tFx+gP1xwdBHJugxexDPyYJvFzHYBsAwQzMki9HjVzbKyVpEfMH
	 RT5YsB7LmKc16XDjKgeCIFEMLohRd5hkeEbB/Q4oGJl1CWVdURdZfJXijqEmNE47ra
	 g7KRRcGfVl5bQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:40 +0100
Subject: [PATCH mptcp-next mptcp-net v4 16/20] mptcp: push pending data
 after a fallback on reception
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-mptcp-cmason-fixes-v4-16-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eUCaWqilve6p4gBgluFq2NlttraZkifS6zeGEd23WAs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H271YAidcuP5meB1vHU3/ujNdsj3KRbnOv43aVtRQ
 I+ckdeXjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkECTMyHAqQ9hX10PvTHnEx
 MvK4+tQ9pV+XCN08yLVrme1u3gVGWxn++89i7ZuYqbMqMPaBlE/mhffewY4iTpofzTxtl59bev8
 6OwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When received data without DSS makes the MPTCP socket fall back to TCP,
the data not sent yet is not pushed: on fallback, this is done by
mptcp_incoming_options(), which already processed this packet before
the fallback. This data, and the FIN of an earlier shutdown, then wait
for the next packet from the peer, or for the MPTCP retransmission
timer armed before the fallback: up to one RTO.

Push it from mptcp_data_ready(), which follows these fallbacks, also
the ones after a DSS corruption. For the next packets, this push comes
after the one from mptcp_incoming_options(), which already sent what it
could.

This issue has been found by Clashiko, while reviewing "mptcp: don't
send a FIN before the pending data on fallback", and confirmed with a
new Packetdrill test: after a shutdown, with data still in the MPTCP
socket, the peer sends data without MPTCP options. Without this patch,
with an RTO of one second, the data is sent about one second later:

  dss_fallback_push_pending_server.pkt:27: error handling packet: timing error: expected outbound packet at 0.312538 sec but happened at 1.274089 sec; tolerance 0.100000 sec

With this patch, the data and the FIN are sent right after the fallback.

Note for the backports: the fallback after receiving data without DSS
comes from commit 119d51e225fe ("mptcp: fallback when MPTCP opts are
dropped after 1st data"), also in v6.12, and backported down to v5.15.

Fixes: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for mptcp-next, for an issue spotted by Clashiko in a fix
    pending in net
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 178792ebcc78..64fc04ea997c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1077,6 +1077,10 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	} else {
 		__mptcp_move_skbs_from_subflow(msk, ssk, false);
 	}
+
+	/* mptcp_incoming_options() can't push if this data caused a fallback */
+	if (__mptcp_check_fallback(msk) && sk_stream_memory_free(ssk))
+		__mptcp_check_push(sk, ssk);
 	mptcp_data_unlock(sk);
 }
 

-- 
2.55.0

