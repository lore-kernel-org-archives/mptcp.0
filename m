Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557688;
	b=1pYlKM5ku+rklS7/Z7DU3rkHvHV7j2RgP/DGcUX0SAcig7PPBvET86PwpFPtnup/09gE
	 QaC9XlamIVrvql5QPAtehVDAx2o34yfwU7QWRINbEce8cjOcc8aQAqCWAkbsBUFJD4vn+
	 nTkYz8moifc4zC0fJ4GeHo74hHLrAdeRYPEUA6jf992+bDuqAjYwYAM8sIbtTU1Tf6dxW
	 xARw2M4srnCdqQ1ykDl8HUzXIPpbVPL2dhXcYJuG1l7xN9CkBBPfo7LcNI3TxJsGxKsUv
	 O7qt7HVBKFtQY0U/P8Ch4UU1IrwLdyJtPlI2Zumvqg9fbdheFCcam86r5XLF8s9d2QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557688;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=arqzmrvd1T+g2nEXvt51rYEAE+C52HVLZgf+lMA1aSU=;
	b=ES6y20+AwaVDj2275Co7ELmCC1Il7u04zWIf9cESKqQfFjVdTqep60a29Ky19TEOBQmn
	 LAQG7xUouRQiLO4y2fQcdnKGwgdrMcN855ynGl/Czkq3plELT3oUCvBCZ3GF+dneClpfx
	 ZBZF6m8tB2ZxvfpHdwhVj3nArxqr/2fuUXx8zWWIG/dM7W/N6BJgxkZhF0pvBPeMQMlaa
	 IFmAzTwy118/ZmxHzy/mtsLSzIJEeCG6uK3vU0c53SJn9m0SeM3OVBAxPXilkAi37ShX9
	 p+KSp9fszlbv3j+kmO1aUmr8qMn3aM86F2XysYAXgKUkREo0u2AinzK+Dh58TY/RBoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EWrmSYdH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC51606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EWrmSYdH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8826F1F000D0;
	Tue, 24 Nov 2026 22:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557688;
	bh=arqzmrvd1T+g2nEXvt51rYEAE+C52HVLZgf+lMA1aSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EWrmSYdH+k68xeIkdEUQF92AhcxWXXr2TMoW3o+ghogTbpjeaR27cTUqkySwXwvq1
	 1/DHOIkD3wIZ+E/JRv+rzai8zHfGpD1TgBx/+VrMmceL8JTufuzlexwwvVFhDKFXyY
	 Y86u/+1jqqMJ3WGzaJLRw/oY25HQ9lj2RDljFzDUE4kJlrxWJ2Xi1d9NKQQnAxj+Yp
	 +4U7jnSBAPEdxgF6uIWfr/zlPwWoISMdkVwJKC6N8cGHNuWvsbQXUkKOCCaWyrjWRU
	 MEO4fTcDdIKzmu86UwTs1SrZQ5EZc4fg+xEcdgyUiQZg0VP6YjoB1mq1kDBIDg9pb0
	 uaF5At4Lyj5qQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:42 +0100
Subject: [PATCH mptcp-net v3 25/50] mptcp: send the infinite map in a
 single segment
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-25-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3564; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4w0vMAjClJ+ZgNpCHoNEhS1gzESFbtrKibc9SIZJNeE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZONmyLX48VHxj8GBKsLJ+1eXw9105W4LuJVycns935
 LTtqv06HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPpnMTwz9zkzpK4049vztiT
 s+NUp75+2qW96578clBbuvfF65JbLp8YGRp274vdzN/qoRB4Kik+7ybjWf1nr3a//lZ194ZYTI7
 EHyYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After an MP_FAIL with a single subflow, mptcp_sendmsg_frag() puts the
infinite mapping on the next skb with new data, then falls back to TCP.
This skb can be bigger than one MSS: it is sized with the size goal
computed before the fallback, from an MSS reserving the space for the
DSS option.
After the fallback, this space is no longer reserved when the MSS is
computed, but this skb still carries a DSS option, which is copied to
each of its segments: with the new MSS, they are bigger than the MTU.

The new MSS is used for the next transmissions, e.g. when only a part of
the skb can be sent at first, or for a retransmission, and it can also
be used for the first one, when more data is pushed in the same batch.
The IP layer drops such segments, as DF is set, and sends an ICMP
"Fragmentation Needed" to the local host, which doesn't change the PMTU:
the transfer stalls.

This issue was causing the "Infinite map" subtest from mptcp_join.sh to
be flaky, with the client counting these ICMPs as OutOfWindowIcmps, and
its subflow stuck with unsent data:

  copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 0)
  (...)
    TcpExtOutOfWindowIcmps          134
  (...)
  tcp FIN-WAIT-1 (...) timer:(persist,21sec,7) (...) notsent:98333 (...)
  (...)
        infi rx server       [FAIL] got 0 infinite map[s] RX expected 1

The root cause has been confirmed with a Packetdrill script, a variant
of the new dss_infinite_map_mss_server.pkt test from the MPTCP
Packetdrill tests, with an MP_FAIL received before any data, and a cwnd
of 1: without this fix, the rest of the infinite mapping, after the
first MSS, was never sent:

  IpFragFails                     2                  0.0
  (...) timer:(persist,305ms,1) (...) cwnd:2 (...) notsent:1564 (...)
  infinite_map_stall-v4.pkt:27: error handling packet: Timed out waiting for packet

To fix this issue, limit the skb carrying the infinite mapping to one
MSS, as computed before the fallback. The segments of this skb can still
be too big if the MSS decreases before it is acked, e.g. after a PMTU
drop, but this is unlikely right after an MP_FAIL, and this connection
would then stall as with a PMTU black hole.

A side effect: when the last unsent skb is bigger than one MSS, the
infinite mapping is now put on a new skb. This unsent skb is then sent
without DSS after the fallback, as it was already the case for the ones
before it, and the peer falls back before receiving the infinite
mapping.

Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue causing a flaky selftest
v3: commit msg: why an MSS decrease before the infinite mapping is
    acked is not handled (Clashiko)
---
 net/mptcp/protocol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c57bfedc86a8..39490ff40aa4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1483,6 +1483,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
 	copy = info->size_goal;
 
+	/* After the fallback, the MSS no longer includes the DSS option of the
+	 * infinite mapping: send it in a single segment.
+	 */
+	if (unlikely(mptcp_subflow_ctx(ssk)->send_infinite_map))
+		copy = info->mss_now;
+
 	skb = tcp_write_queue_tail(ssk);
 	if (skb && copy > skb->len) {
 		/* Limit the write to the size available in the

-- 
2.55.0

