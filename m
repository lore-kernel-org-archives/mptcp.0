Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8FC483825;
	Sat, 26 Sep 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790436667; cv=none; b=PR0UZx8fgSPDHiMcyy/V/T0ktQJYbx/3+wf/UFBfzqTFpFmb619K/VmJkLFs6HOLGw8PIP7Uwf9MFMd0gaPyhtVnSf0jYSkIpFAzafRKpBNped1eu4pc2hp57v0geFhqCwGAnVbuxvLwxt+VoCfm69mEd53283bzVzFpp2N1E58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790436667; c=relaxed/simple;
	bh=4dnmjPKMgvpPoV1XuMAF3hmIKkD1wUAnZAncgZ5bsMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jnNmd1cFEguJY1bo2NX3CBW5fPIIEUjq+Jb46wQ1Yf3j/ERsvq0bO2tlcsaXFvRRDbNm+Z36aqhf2kpUcTwbmfKlt6gFYlOur/sNuc7JQl+C3jJNkbiOXT8dhk2CcSheTR2hl7ZtZjffcYc5D54x/RyNB8sAMEKF+BYGtcQqqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQZ072wT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQZ072wT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABCC1F000FF;
	Sat, 26 Sep 2026 15:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790436656;
	bh=zkOBSfjteipAXDmKPSIjR8Lqk8DWRo/YB1D1TGRtsIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BQZ072wTx4Qe+3s/P8gS2eLDQcrZGgwdTbBNS74ZsLg0D91oQPNB/DYC3HlaiM6hk
	 J9Of0Mb9xTXqOKNEYtC8CGAbV9wPdIZN3/nOstfTtaF4+cEJDAIEu8JuBcLf1ZLL3A
	 nswKXSqeCrBTy7Iax4tzn5hOvurHUMNnHXgzMVmRbJAglM0kyNQpv4De+gcVJQxVk6
	 x98DGvD0xQ8AGE6zE/QJn4CZjRC/X/NiHhEaANeGaQGBssFiGGTEWVup0VDhhcxObC
	 763oLf7+PMft/DPn4SgwHZDmyMRSftJuDBCvdm1zOBd6KPouq6tqZ1Q7Oji6iJcd8q
	 x4+S2wnx1gwvQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 26 Sep 2026 17:30:36 +0200
Subject: [PATCH net-next 3/5] mptcp: shrink struct mptcp_options_received
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-net-next-mptcp-misc-feat-7-4-v1-3-67af4ab37406@kernel.org>
References: <20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406@kernel.org>
In-Reply-To: <20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Quanye Yang <quanyeyang@proton.me>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2777; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=v0/cB1TTY50IeKgy7oF8vfX3CvLtPvrhfv/tK3GUpoA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK2P1X9Gv50imlVtvB69g+rW3e51YfE/axw2JbZxR/Fl
 aiuum93RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETuSDD80/wR9f/4ToP88IbM
 Vy1PfKxnqXWIiE6fLctyuv7c9ktfFzAyTNmxc9qWOr3dMmUKaZzmqZyPVH5WF0ws23fiV++bpr5
 ADgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Quanye Yang <quanyeyang@proton.me>

struct mptcp_options_received is allocated on the stack while parsing
incoming MPTCP options. Several suboptions are mutually exclusive, as
enforced by mptcp_parse_option(), so their payloads can overlap.

Group fields by suboption and place the mutually exclusive payloads in
an anonymous union. Keep DSS and rm_list outside the union: they can
be combined with other suboptions. Move join_id into the MP_JOIN
group, and overlap token, thmac and hmac inside that group.

Further shrinking would require changing the parser so currently
coexisting fields (DSS mapping vs ACK, rm_list, status flags) can
overlap. That adds complexity for little gain, since the outer union is
already dominated by the MP_JOIN / ADD_ADDR members.

This reduces the structure size from 136 to 72 bytes on x86_64.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/625
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6b9bffc5992b..29b03275a59e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -145,16 +145,13 @@ static inline bool before64(__u64 seq1, __u64 seq2)
 #define after64(seq2, seq1)	before64(seq1, seq2)
 
 struct mptcp_options_received {
-	u64	sndr_key;
-	union {
-		u64	rcvr_key;
-		u64	fc_recv_key;
+	struct { /* DSS, also used by MP_CAPABLE with data */
+		u64	data_ack;
+		u64	data_seq;
+		u32	subflow_seq;
+		u16	data_len;
+		__sum16	csum;
 	};
-	u64	data_ack;
-	u64	data_seq;
-	u32	subflow_seq;
-	u16	data_len;
-	__sum16	csum;
 	struct_group(status,
 		u16 suboptions;
 		u16 use_map:1,
@@ -170,15 +167,29 @@ struct mptcp_options_received {
 		    deny_join_id0:1,
 		    __unused:2;
 	);
-	u8	join_id;
-	u32	token;
-	u32	nonce;
-	u64	thmac;
-	u8	hmac[MPTCPOPT_HMAC_LEN];
-	struct mptcp_addr_info addr;
 	struct mptcp_rm_list rm_list;
-	u64	ahmac;
-	u64	fail_seq;
+	/* Options below are mutually exclusive, see mptcp_parse_option() */
+	union {
+		struct { /* MP_CAPABLE */
+			u64	sndr_key;
+			u64	rcvr_key;
+		};
+		struct { /* MP_JOIN */
+			u32	nonce;
+			u8	join_id;
+			union {
+				u32	token;			 /* SYN */
+				u64	thmac;			 /* SYN + ACK */
+				u8	hmac[MPTCPOPT_HMAC_LEN]; /* ACK */
+			};
+		};
+		struct { /* ADD_ADDR */
+			struct mptcp_addr_info addr;
+			u64	ahmac;
+		};
+		u64	fail_seq;	/* MP_FAIL */
+		u64	fc_recv_key;	/* MP_FASTCLOSE */
+	};
 };
 
 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)

-- 
2.55.0

