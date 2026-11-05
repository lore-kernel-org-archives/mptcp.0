Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871847;
	b=sKS2b5l0iVxILShl/jQlmwpA3Tp33fjjPlMgBTEYJEghhXJyetctmU31T0EUuiUyiHaq
	 MK33g/mV/XETJ1Sz0lGTjfbKZvdxUzCQvunT1Z8HC6m6+fpjaOCBfxlZ83Qslmj7VC7ay
	 +vz26aFBD5AkQQbsapV3mHegafQlLn1cBw7YoRCr/wyMP2sAtTyVFQUvQMBCWjaywWteR
	 ZltBoMiOA4C0ECttInW8aqTrNORAUFIXL9EVgt/NVyb5+NdNnYN815H2HiUw7sxGSMVGz
	 iiJ3s0wt9Ys3rQAPyOkjiEQvbaCuKPD13Qd20MdoAG53ml2/0+vciwJhWqtlnRshjyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871847;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1767Fc0/9AZ61m0K4rmel1tN0XakvcKvc3l3Muz6b6c=;
	b=Nhtw4b3wGZfyYc/rGR6hDR8iiqeelJDhM/TQ6DnmRa6Ttcc0AULtshZAaJ9+kWruJwA5
	 VZ5DZF66asqb5DvuLKj3e43pJHDvZO6CkUjTPJQ8lc/u8L9DThSEbKlLZ68xqxZC0PkvB
	 eQg+A/1buHbHN70/MZihn6qTqPgM5t2nopFENSUEselzVlmag0AtFrEIrqc5fYt19GZh7
	 T1nCXrupub8K8tlTaOk9Lmh6y6bbYqALLGl+KLB3sgbRAlvFYldbRSVhmFYClsuL8u2Fj
	 H3qRPfU8N4v0biKxJK8cXcu3fsdjD/zApeW/nRDhLQ9FSsHoxZzrFZMNq68m7IEqUJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRgq0NPB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29B606A332
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRgq0NPB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900FC1F00A02;
	Thu,  5 Nov 2026 09:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871846;
	bh=1767Fc0/9AZ61m0K4rmel1tN0XakvcKvc3l3Muz6b6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IRgq0NPBv2bQ9QVAt9BdMN4RGDlv4Df5/3zf2+AvWYy3taH3dvBcgqxfVNREJVwqY
	 Cd+XbkC9fa0O702sRR67pEayb0sBSZ5KAgZyi64W88jU5MSLL2ucJvh/nXpF8XsoJm
	 3cgbxIRH9tsYmXWEeaCzJ9mnqHvDm+JFbvmqnns06M496Aoz+GUXa9fGTXQWbD2MIJ
	 +B2usNq12VLNB1uU92KUDAGiEjTBvoncappR+h17+f65T1hHvrRPW5GAYWaSXPE2k+
	 MxaSLaK4MM6msffWGHSlILues4ssYOLEddKm6eIoo2Z0ykRBD6KadY32R3yY6lWrcJ
	 Mkbbqawf61PGA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net v21 3/9] mptcp: fix TFO map_seq sign extension in fastopen
Date: Thu,  5 Nov 2026 17:43:46 +0800
Message-ID: <46b31cc96bd3ed1cd5afd2c3e0e7a5f1581d16a5.1793870710.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793870710.git.tanggeliang@kylinos.cn>
References: <cover.1793870710.git.tanggeliang@kylinos.cn>
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

In mptcp_fastopen_subflow_synack_set_params(), the TFO skb's map_seq is
set to -skb->len to represent data before the IASN.

Since skb->len is u32, the negation -skb->len is computed in u32
arithmetic, producing a large positive value (e.g., -1420 becomes
4294965876). When assigned to map_seq (u64), this value is zero-extended
rather than sign-extended.

This causes mptcp_inq_hint() to return INT_MAX before the MPC 3rd ACK
arrives. On a passive TFO msk, msk->ack_seq is still 0 until the 3rd
ACK. Without the cast to u64, the computation 0ULL - (u32)(-len)
underflows and clamps to INT_MAX. This incorrect value is returned to
user space through SIOCINQ/FIONREAD in mptcp_ioctl(), the TCP_CM_INQ
cmsg in mptcp_recvmsg(), and also affects receive buffer auto-tuning in
mptcp_rcv_space_adjust().

Fix by casting to u64 before negation: -(u64)skb->len. This ensures
proper 64-bit two's complement representation, so the hint correctly
returns skb->len before the 3rd ACK.

Fixes: 36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/fastopen.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index f717750906ff..914d52960dc6 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -44,8 +44,10 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	subflow->ssn_offset += skb->len;
 	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
 
-	/* Only the sequence delta is relevant */
-	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
+	/* The TFO segment data sits before the IASN; before receiving
+	 * the remote key, IASN is assumed being 0.
+	 */
+	MPTCP_SKB_CB(skb)->map_seq = -(u64)skb->len;
 	MPTCP_SKB_CB(skb)->end_seq = 0;
 	MPTCP_SKB_CB(skb)->offset = 0;
 	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
-- 
2.55.0

