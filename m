Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557716;
	b=5KQZycZ2uIOWhi5Me+Ieq+fN3HPaJeDM7jFJNEFvU4FzUoYWukjkoksavjWD+qyPBmNS
	 alKcPSlVYNcG/WjQTv/aWBOU+1IYFm/qJttYzzvp9ZL9GOOPDtBzMddwxdrPFEPPFmMI0
	 fyrsJFe5EJlVhqb7y791zrjuAaNI+vcgyBG1zTdWj7z7kQgqfU6ckfI0YQsJkoGuyw371
	 u2xcmT6s9QUCiu14J4+iow30ndjKp6t0w5YJcvJ3qm1kdEuKpBnG+bq/yd59Lt/7ZFIZn
	 JtW0+vzCm+E0WpHU2jEHhTDeRdlosYM40W2M0ZzRXKMsrvZ3/9nf8eZ6BUHY8wsvy4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557716;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=y8i/oyaV74z/cMVr8AWAB0C86+EUiNTMHskUP6Bgd2U=;
	b=P1gRjqVNf7YZ6tWdukDVpGFpGfMFfpELB04NJ/4YsIBm61Jsp56beVZQaBo3XFlnpg/G
	 3D4SqwGrXB1Lbr7c3RN0Rl2dRKw1vkGR47VE3GX2DOO4huSnYi9EveQBD9gVR0M/sSHbY
	 dnBEcfB0zkv7tZ+wA1w7wRIoTe/QwEBy5IPM5aRoOPMQhdn/Xk935QMqMHxR1Z5Ap4fWF
	 5gwRBCLsovHJN1PQSBYPaLAYojMbLneSdvyK87le/0H2Or9uOXdMT//QB4JlSKSUChkmh
	 NVTcNwPOxQkNrXc/lG47kByMQj11A9OQYT7HT29uUCi1e7y6utPFe8piwloGVKJhI2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFEByJlG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2154606A321
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFEByJlG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F271F000EB;
	Tue, 24 Nov 2026 22:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557716;
	bh=y8i/oyaV74z/cMVr8AWAB0C86+EUiNTMHskUP6Bgd2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iFEByJlG+Q6hEblSEbsshfbgHVRR4Bn8jUNtI/mde4+xD14Wnzfta3uL7LOZ5AO0V
	 Ucm74Q4wnx2kc/6AcJti9h+rT4++KHEAv9SjJFMMNz44ZkS4z7BftsAfifQ4c0lZf/
	 N/UOjy5+lQo7wHufVe0DfVYGvAdzJVQ3Cf7u3x2g+sO+UTZUrzHi9bWHZ8RBO/Y66v
	 Z832QW2i/q94OEbiCEz+vy0kIAlIB/5tKzFLG8a8Co/WPxQFZPsn2Ya0RSzGlRAjO2
	 XZ59cSTwrjOxtbRtfoLPk7T6TzM063ZfJ+y+oNa4EShOhD9MuG/XaUq8k6HpB3sbxC
	 69/fIX55rAN+w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 23:00:04 +0100
Subject: [PATCH mptcp-next mptcp-net v3 47/50] mptcp: push pending data
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-47-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VoEFd52P0f/Wl7Nsl318cKlCYYppJi0VzYbUjZ9145o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOEU2LV7tseqd2vy/AtrP3hvyHr2hlW1YveK5ifU60
 +q9OhKhHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPZ/Zzhf/RLp7AsibzjegIr
 ImwPmE5ZsEdcqL7hg59M9/9ZX69OSmJk6HI6VmVQ/UZ62dQVRx4b7U2ee8v1nBfHnflZDpcDlDY
 KcgAA
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
index a3c2d8f93bd7..016b16b3cc92 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1083,6 +1083,10 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
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

