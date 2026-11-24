Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557671;
	b=NUvfmexg1cvQeo8eiBU/KC3FMezffKAKRjebC/qGROt9vxzd8FiFpitGPOm/akSAftyk
	 3cEUEPN2floeaB30weK6uFqjM96COdQATVF7B8L11l/m7jt4LUXpISGegsWM8u4dh+CIC
	 9UYKjaiYhxyJP10tryx4oMLtUCrkVodx+FX0vQshaMqPMF5PpefCG4TIW2eZGImqO0Jdv
	 /BW9SUq7VyqX6HWtwWjFdpr7dIl2CgRfVty1ujG1caq9kh33kBu+rnhZJWxn5iJ+IQPyu
	 yLwhKWFIj1wHpvPhv0w9xDrOP9OCxXofbckHLOPxlnP2PED4wrSTQjzcWjDMxBbHbOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557671;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rPxPQclKiW2EVNCZiqrq34x2rST1mhnPEAYFIGQVMYc=;
	b=Yfbbg+d7i5XxrSqZMTd+XTtb4HWTsR4DYBGxIbcjj/wnDrVDjdbW+iMhDRrLV3e7iYkp
	 VHswhYKSX4eQCDOaGSYR4UVBKYPZb6hlGa68xrHVlYKqwl3GRgIdddD1kb1uSGcGH2WCN
	 M44eUG9i7+pXwk5t3h4z16Ki4Eu/9+NewFQ0fCcNdLqD18RQ/onFPa31k4f7OJppKpAzS
	 UDigVJW3O/M5Nkr45GNW5fD1KOtVHwsER+TB2iWKuOQOxnugK1gVCNfSoGUJE8XcvWnle
	 jzZ3VhZzVLoHUIU8NhwJl5zsqfrudEUk/93O2Rk1VeHabflicvyLSmYKiwKsOZihGng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFIA3ck0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9766B606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jFIA3ck0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CFE1F000D3;
	Tue, 24 Nov 2026 22:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557671;
	bh=rPxPQclKiW2EVNCZiqrq34x2rST1mhnPEAYFIGQVMYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jFIA3ck0wLbClF9WL1UPm1W7OELN+OsZOrjVSz1ab6naSB5f03Ok4QvXgAgApTmF6
	 OUHUSSHnQLL0eXA3iI8dOpJcY7tPaUv67qtseA+iejzy3UCUDjv5/qFzZtcn0f1wJy
	 h0ROxyRPvZbnWsiESYz6shlhDdHu1FzQFy62fE786Ifh3R/6bO/UUU4n5W51b0zsz5
	 NgMnfuH5PAIWbCUM0/hv98m/hgLZMs5DpKTvPh5ZV77J4UPgIcVk5yQQXLSBTqfiHo
	 ZFzuWKX/6KMWSOaOu4FCVygBX3CA7qEWfnma8K4Rt/gicQIQvaNfrh66UQKVi146/2
	 2uuGskujWJJGw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:28 +0100
Subject: [PATCH mptcp-net v3 11/50] mptcp: no sf left: process pending
 MP_FASTCLOSE
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-11-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2933; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=C0khbWlxGL96vW0fnBJpjSLxRBsgg0OWgwwimB7nmpM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOP5WFK95ULbn7mZGnrubap6xzp7smH//vt57/pv1B
 uXvrpwX6ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhI6AdGhp41dy3exBYcjLhw
 q8suzkss6Yt67b3J/pdzjldcPmRyxIXhn+qK1+e2zGIRipfhOhL5//Dxr/UBzj+un5C3cth/217
 zHzsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the last subflow is closed while the MPTCP socket is no longer in
the ESTABLISHED state, e.g. in CLOSE_WAIT after a DATA_FIN, the MPTCP
socket moves to TCP_CLOSE. But this subflow could have been closed by a
reset carrying an MP_FASTCLOSE, not processed yet: if this reset is
received while the worker is running, after mptcp_check_fastclose(), and
before __mptcp_close_subflow(). At the next run of the worker, the MPTCP
socket being closed, the MP_FASTCLOSE is ignored, and no error is
reported.

This issue has been observed with the "fastclose test" subtest from
mptcp_join.sh: after the DATA_FIN from the client, then its
MP_FASTCLOSE, the server, still having data to send, was killed after
the timeout:

  [FAIL] client exit code 0, server 143

Since commit "mptcp: wake up blocked senders when no sf left", this
subtest no longer fails: SEND_SHUTDOWN is set in this case, and the
server gets EPIPE when writing, which is expected there. But the reset
is still not reported. This has been confirmed with a debug patch
keeping the worker busy until the subflow is closed, and Packetdrill
scripts sending an MP_FASTCLOSE in this window: in CLOSE_WAIT, SO_ERROR
was 0 instead of EPIPE, and poll() did not report EPOLLERR; in
FIN_WAIT2, read() returned ENOTCONN instead of ECONNRESET:

  fastclose_close_wait_race_err.pkt:26: runtime error in getsockopt call: Bad getsockopt optval: expected: 32 actual: 0
  fastclose_fin_wait2_race_read.pkt:28: runtime error in read call: Expected errno 104 (Connection reset by peer) but got 107 (Transport endpoint is not connected)

To fix this, process a pending MP_FASTCLOSE before the close, if the
socket is still in use.

Fixes: 27e5ccc2d5a5 ("mptcp: fix dangling connection hang-up")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue causing a flaky selftest
v3: msg: the subtest no longer fails since patch 7, and the remaining
    issue, checked with Packetdrill (Clashiko)
---
 net/mptcp/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5d916c6b43f4..bcdad00d3573 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2705,6 +2705,8 @@ static void mptcp_cleanup_ssk_backlog(struct sock *sk, struct sock *ssk)
 	mptcp_data_unlock(sk);
 }
 
+static void mptcp_check_fastclose(struct mptcp_sock *msk);
+
 /* subflow sockets can be either outgoing (connect) or incoming
  * (accept).
  *
@@ -2817,6 +2819,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			mptcp_schedule_work(sk);
 		} else if (sk->sk_state != TCP_ESTABLISHED ||
 			   msk->in_accept_queue) {
+			/* After the close, an MP_FASTCLOSE would be ignored */
+			mptcp_check_fastclose(msk);
+
 			mptcp_set_state(sk, TCP_CLOSE);
 			WRITE_ONCE(sk->sk_shutdown,
 				   sk->sk_shutdown | SEND_SHUTDOWN);

-- 
2.55.0

