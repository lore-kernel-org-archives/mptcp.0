Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254172;
	b=EwBw8obdOqQtnxd8jMczZrAWEWP9SeqAkAYiz+EieKJixRTtxuzHSco9NgrjA36MOQRb
	 8CP55dQwY6FxfcmEZhmADtNYI14ubAas1jpUcrqs4cyr7rtZuz6v9tAhN2yZiA35DeHjh
	 c5Hzj+W+bqRd99wX7FxHrAI3wvuQeegxIJuPqJLidUP0PQzAxA5uUuKrxgLHRGEqLjlkN
	 77Z/nGCrnYrxdXLF4jBDLc1+ETbHfgLuTzmSAGfhl6ZDtIETUQzuZv6EHzLfznf2/zIup
	 McvSSUxJwGXtHMlglQI6FGhJfq3PZ070tPrwRUPwT8gUTlAsdSBsdL0HgKmFXBkhuFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254172;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IMWIfMLbTgOU68PETiIOO4Z0jSGD0f3GiD0SqFWMpb8=;
	b=AYP8mRDrwA20AAzw4Gv/+2BQGql0YJcWWzIKEFFbdeV2gUp4a2wjF/TN6tGiMh+XP14U
	 cEJ+dcGW/hrpsGoEbRYSHmAsGrzOrC1vFVZUvxh5t30ZDTT5vbZcJMtfOd0rcLYMesMaf
	 Q+UAbOGaphyYxrCX0PyHVWiUt5zhCEx0MdfUH8+DyryBi9PyPt/UKb/qcmEDbgzBOqHEF
	 yXBnEJARXwUONUAadjkU0yhDKWYq8Qt0SfRkkLLgdjFrIL/RF7oBIqZIY5ZzsbT26wlHU
	 yGP11PY1CpnZUr751W0Gy3oYVw+2kLLIEK1eKKwfWFkO3RNAsN80c7wf2kmJZDcuPdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyzl2GWS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED3606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyzl2GWS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C181F000C4;
	Sat, 21 Nov 2026 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254172;
	bh=IMWIfMLbTgOU68PETiIOO4Z0jSGD0f3GiD0SqFWMpb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gyzl2GWSnEpgFzpG/ABBb5HJaJG/yanE/o4YJY6J0lg+7keiRUK7jzpZ5cFVsYWIU
	 CpnoP3u6DsBUFUsUzZDcC2z/eEqL4Ykmc83BLAaYohWlJ75LhKM0EzznOFbZ3jRmNC
	 0MrX/DZQerY3hhrZ3tguj6KN82XWOwo8rduzZlben4aprUrLmKieIYUNTl1mNtwZmp
	 FBl1GL/416spBO0crHu7lM2QnxssfKo7aiykVnyV3az6UG4Q4kot0T1wLemgKB2a5W
	 b/z9KQvTeUeXll8vK54O9gWVLoADua4y3pvAJvjSqjm2diINOFux+2Wn8WnjAMBEm9
	 hMZXOuYGgpEkA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:36 +0100
Subject: [PATCH mptcp-net v2 38/62] mptcp: send the infinite map in a
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-38-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3236; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rzBxndB8ksKv8c8dj3HUIdQOHI4xG2yif+Eg2PP5mLU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ01MYbidG7t1x1d37n3kvn8VXX/Frl6cYt2xnmCkfe
 eiG1YTDHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhvCxSkAE5lzjuGvwOVvVn4MQvlvzx7d
 Y7Rw07ZPx6L3nIsy+Gb4VvZaTJz5VUaG474TJbK8eZqL96iHP8rMd0z60vkm9tDf+TIsdbvd3zg
 wAwA=
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
MSS, as computed before the fallback.

A side effect: when the last unsent skb is bigger than one MSS, the
infinite mapping is now put on a new skb. This unsent skb is then sent
without DSS after the fallback, as it was already the case for the ones
before it, and the peer falls back before receiving the infinite
mapping.

Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue causing a flaky selftest
---
 net/mptcp/protocol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d16269d27b1d..e2fb81f52df2 100644
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

