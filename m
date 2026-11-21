Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254158;
	b=NFDnZ0Itj6v21C7Orns0KRcvoibH1HXFtO62MvQXOqFOKLT0bxrG9suLScskljEmUmFK
	 A3ZGHnuvpcYqVAYGHhGYwJ2jTss9FQvZKsK8Jp1363sdukIipStllWiylZ+XHlHwD5JZu
	 tMQW43xUse1hHyG+eOkRImv3L33Gznye3iAKCB+c2FomZtaukxFk2AoYj73oXItCCERjP
	 L8wWVxDLWhiLG33ArGWvjMQhXYlOBjLIJ8y9bMhR1A/pmU4syVBy6XasrgqPQ4FRqYQ/k
	 OanLj73Ow2ZT5LdFybEXpxeJ2iM1xfmtFnnFvpGhG6ekrreSDPUB2L8SC4SIqkjMVsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254158;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MEbdcjjomg+4qLAt8AwpYGHvRdsNwybXR8Tvw5hhFE8=;
	b=fC5YGSs0GfjDWcKLKD1FII4MZvBhnX9hUmbmXQ/ntuTJlukuNw8GS69hUR+tdVE48r6v
	 xUvrEeP+dTvVj95hdlQ6/EoizvpUklYf54OdXgg0b7nN4AFReBZQQ33DRjcavn9ISHzIf
	 qsvE8TNY88GzDh1dODgoqD3zOxXPZFzhYkCRnCWZ08KTzh3jgoxb+N8/dm0kBougBDDiG
	 F1nW5cOXdtkbaMUGJy6fgZYyUsO7xWk1sEPBl4hxHQpTkv44zVcTKnh6kV4V3Ke8FHHHt
	 oTjpAyrhpVKbnVyuntrurz2HKjSec/ViXUlHHfzaA3n0lv0N8re1BnrO3Nt6qKeG6Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JlGiV0Gb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B0C606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JlGiV0Gb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8B11F000C4;
	Sat, 21 Nov 2026 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254157;
	bh=MEbdcjjomg+4qLAt8AwpYGHvRdsNwybXR8Tvw5hhFE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JlGiV0GbGpwE044T6y1Ow+urVraP3a5eDOcAayLT0whW6XxkQyoL61v4wz+vicfck
	 OB5UojSxyOZuxrcAGmivb+fjB0+zLXldbe2m+3Ku3vEfMxdVhbzlbYseQLec5P875k
	 yqh2MIj0SNP3REQQU2KAIkuo3RzQjFWX+iv2iouxpkv9USGGcthOcoGEJrXYTaSoqo
	 PktcZfd7RO66MaFNocPHjpbqgrilZk2sRkiA1isxw6t3cwR/nS9AXgWiLHtjCsmIYP
	 9MdmsM950TlGq1FPTTgnc/Ia0YjYWIydaNKH72nqIu3gWIq5xFXaq0jLcMTzXZLTJ2
	 l/nnZUUPufjQQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:19 +0100
Subject: [PATCH mptcp-net v2 21/62] mptcp: process a DATA_FIN received with
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-21-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3770; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3A0z8CZt7qLjWDKGRv8CZTfNrzHK5eXN5+4lCLQd8tQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0yMmr6yLOHD12zw2mziFzI7WU3cCtm5d1K+otKV5/
 udHDDLOHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMpWs/wT/Pruj3tX9y31i0p
 WW0a86Tky5dwaZf+TfkqEuJdW04vu8TIcGqjQXzrgSjl942ZcxYKivbuWKuyS9px/bEEK5/r8W7
 WrAA=
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
index 20d506235074..0c97a5ce2d0c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1218,6 +1218,10 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
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
@@ -1228,9 +1232,6 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 				return MAPPING_OK;
 			}
 
-			if (updated)
-				mptcp_schedule_work((struct sock *)msk);
-
 			return MAPPING_DATA_FIN;
 		}
 
@@ -1242,7 +1243,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
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

