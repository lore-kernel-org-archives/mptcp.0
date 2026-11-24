Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557669;
	b=30FKgzl1bw6KhmDBV3CkpWRFSY6sftLPspjClcUoZlAy2R2nPyvL5VBcy+DbqCNxbqzl
	 GeaxIHNaSwEKxyGVl0rgaUU9+Uk71V1Da7LBLQ/WhDCzCwLZYD2Frl5HWLPbe1zzEfb+J
	 GTxGC1WeSY88hJ7w/Q3C5V2y+zVvkrkzGYZsAMki5oBWQCGHtjCWN5JBdpBFacV9NapVd
	 SEdrFIu1gKghuu7sqLrdR1AaEo+sffkNhr+4uwnpUbBhdOGZPkR3xiiKnQMZV1/qo45TS
	 EAfUGkHbh9oYM3SeHerrRIV1QbaLpsoQn5QK3gCXHdPyCD4rfcXL9pF9FCF5utjUZ0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557669;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5MXjjCYi0kU2V79M8/mlLVoULyEwG5FsbNe6gY2BWAI=;
	b=T1YLeID1aCozUhohsDYe/qmA769Gei/K3Io9iO5fggwFYvdBiKkGHqYrLwVMbYqUY3t4
	 dHgd2qhM3rIYwOFj/dxavUDjMO/xbau/SOKddM82lZOIv0r/IBFAAc1PS7n+xUU+LkrZA
	 br0y5HNJm6eJ3p5ro1emLP7zUQWVvi/6JC//5jl23stjyNH6b0VJ1i++IB0AvOwk9IyZq
	 8WZmYi1egiVgqjADP1KPEfEcv1AymQLD0090SCiJTzlvs+EfYdJRkrHyKYu+uE61PmnLE
	 kMe1iY1UyCMja4MGptc7icXYhif/FCOcaoKa0fzaY5yiZYhp5oBvM0zp9AahG+CE2jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hD86A4Wn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA6606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hD86A4Wn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6D81F000ED;
	Tue, 24 Nov 2026 22:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557669;
	bh=5MXjjCYi0kU2V79M8/mlLVoULyEwG5FsbNe6gY2BWAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hD86A4WnnYNl071ZUPOZ0BgTE68kOICvWY1S2/DQpMNt6+0AlbYq/MIKePZsHhADv
	 L3HPLKvHJLXCLCSP0D+Jr9tSIQ7tUOJXKWdaaGYxQfd9fDnqkUarWdGn3HiUYfCkTj
	 0HM6B0R/FsKwgW8g3O8XJ8AWfK7o3euVdRTPA00akEqL+jsDMRr/f3xk3W52DTFlJq
	 CfdBj24jvhIFCb1BR7RVbNZjcnD6NaP0zqJdCx0iB1sd9o7DXLc0YitGVyiyeUYQP4
	 SB/GSsoRKdsu8uHWoHy+a8ex9dNrKWP5EktUPSjwLalCLYDU0NRcwA+dyBCQlmv1jg
	 2qbJzQ7Y8PjNA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:27 +0100
Subject: [PATCH mptcp-net v3 10/50] mptcp: process a DATA_FIN received with
 old data
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-10-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3770; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=a9g9eGPIvFmUAgiGS0NsexER9+XsB2NR6/Rw/c7K7J8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOP68sHt5gZMh95n9XzfFOzL1XhfmTpuQ5XjllvMb8
 cy583dO6yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIgQcM/9TfrGF+UzWNc+Uf
 hjbzmn/Ja7XnnP8bP/91ANtl8SWeztmMDHOPuTRF8Iaqt1gc+c4kUHPCLeVTaUt6fczX+HPajom
 7GQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A DATA_FIN received in a DSS option with a data mapping, or without data
in the middle of a mapping, is recorded by get_mapping_status(), but its
processing was left to the code moving the mapped data to the MPTCP
socket. If this data is old, e.g. the last data retransmitted at the
MPTCP level with the DATA_FIN, it is discarded at the subflow level, and
never moved to the MPTCP socket: the DATA_FIN is then not processed,
while ack_seq has already reached it. Later retransmissions of this
DATA_FIN are ignored too, as it has already been recorded: the peer
might then never get a DATA_ACK for it, and the reader the end of file.

This issue was causing a subtest from mptcp_connect_mmap.sh to fail,
after a spurious MPTCP-level retransmission from the client
(MPTCPRetrans on the client, DuplicateData on the server). The server
had received all the data, its ack_seq being at the DSN of the
DATA_FIN, which was retransmitted 9 times by the client, still in
FIN-WAIT-1:

  26 ns2 MPTCP -> ns4 (dead:beef:3::1:10023) MPTCP     timeout
  (...)
  mptcp ESTAB (...) rcv_nxt:17234557033099169620 (...)
  (...)
  mptcp FIN-WAIT-1 (...) write_seq:17234557033099169621 snd_una:17234557033099169620 (...) retransmits:9 (...)
  (...)
  (duration 61384ms) [FAIL] client exit code 143, server 143

The root cause has been confirmed with new Packetdrill tests: data is
received, then the same data again at the MPTCP level, with the DATA_FIN
in the same DSS option, or in a DSS option without data, in the middle
of this mapping. Without this patch, the DATA_FIN was never acked:

  dss_fin_after_old_data_server.pkt:23: error handling packet: Timed out waiting for packet
  dss_fin_mid_old_mapping_server.pkt:22: error handling packet: Timed out waiting for packet

To fix this, schedule the worker when this DATA_FIN is recorded, as it
is already done for a DATA_FIN without data outside a mapping:
mptcp_check_data_fin() then processes it if ack_seq has already reached
it. If not, it is still processed once the data before it is moved to
the MPTCP socket.

Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue causing a flaky selftest
---
 net/mptcp/subflow.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 054ee992904e..67a749643ad7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1242,6 +1242,10 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 			bool updated = mptcp_update_rcv_data_fin(msk, mpext->data_seq,
 								 mpext->dsn64);
 			pr_debug("DATA_FIN with no payload seq=%llu\n", mpext->data_seq);
+			/* The current mapping can be old, and then not moved */
+			if (updated)
+				mptcp_schedule_work((struct sock *)msk);
+
 			if (subflow->map_valid) {
 				/* A DATA_FIN might arrive in a DSS
 				 * option before the previous mapping
@@ -1252,9 +1256,6 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 				return MAPPING_OK;
 			}
 
-			if (updated)
-				mptcp_schedule_work((struct sock *)msk);
-
 			return MAPPING_DATA_FIN;
 		}
 
@@ -1266,7 +1267,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		if (!mpext->dsn64)
 			data_fin_seq &= GENMASK_ULL(31, 0);
 
-		mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64);
+		/* The mapped data can be old, and then not moved to the msk */
+		if (mptcp_update_rcv_data_fin(msk, data_fin_seq, mpext->dsn64))
+			mptcp_schedule_work((struct sock *)msk);
 		pr_debug("DATA_FIN with mapping seq=%llu dsn64=%d\n",
 			 data_fin_seq, mpext->dsn64);
 

-- 
2.55.0

