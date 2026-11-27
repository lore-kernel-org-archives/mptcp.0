Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809734;
	b=bLawwvb1+jf5moZbMqLg8xqOoBRFxxolV0wotpwKdrcnQ+JJF9xUodg60ruwJ2gnxnK0
	 oD3T94sXqbHvaVRzWcS5DiZf982KDxgAvqSFYhiy/vwqc3EBl/76POWraoOWO4XnVc1KG
	 betHdv9tF02ZWxq/m+mYWH0DJOWhsOVYZqgzDTbFOe8z+40mpQ0wmS4LBFfh/p3jdjsyQ
	 W2zNCJR5rluuqcbBA3wD0njgrs1vqFsc9Y+PzgwCY/o3zBy6YnBT1xaSRRE03gV6J2qdt
	 XXhwKsG3RJeHrplMAcJcRKv0seRQc4e1+96P3dnh2+ukYQe/UbthSy3JEVcGMkQZ35g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809734;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=42TLcV6nJz4mG+OY5h0/UViHuvVgJMBWbVEnewhvt94=;
	b=CzVh9czu6LFZnZfXMeJxovB5G1p4uFGKgaEQESJ8f9XE/jsPPnS70nHe96L/s2BbzEGo
	 5BchwYlT6B/yWxVSPK8u0iPLwdC/kTf+sMXuaR5lYEnR+E2iVOm4JZH91nCyABPSrdHWK
	 zIaLglcpe30Nwy6oMFFRmOpFn0gR3tf2Fh+TryBMjfalNDhOLbjTSBQx4b0KGxkmGGyJj
	 k3guGiEvAroC/kEXJ9OyCbtKK2d914M6Dewlh8/9Wm9njoUaNAGNlMAYUIL9YnBmnbAw6
	 LR1Ov+5xISZ2LGh5UI0/hYDfk5A6TbvntVN7JEuvS0qzRd2E0PlInJLONXyoZQ0DP5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VukDMaGz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0119606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VukDMaGz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532751F0089F;
	Fri, 27 Nov 2026 20:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809733;
	bh=42TLcV6nJz4mG+OY5h0/UViHuvVgJMBWbVEnewhvt94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VukDMaGz1T6Yc3FereO47Kw3jjEjGnAT7cxouzE5GJvW/bUoZ0eFtsbeG5zfzNdyr
	 x+oYXhQ2FaSKId51SnSy6xZyNSMX8DdJqUpb/T1EAiqFeZnGWIuRtCcfFtsiFf3EA/
	 DuZYMrHh+Ve+hThYkubga6YAPuDqf8FudMDC8U7wup67U8AoPFRNI57P8cTHQmPro1
	 bICC9mdhTyDo+/HlM7uQ0Bhr/NN9o4al9h5BbAhhIOHnJddrlIi1IaaBdeJDtu9pYM
	 dco8aV25LAR7ZJPQEky5YcfkIkAOdrcTuCTnvOj1FzyDpwWDJz7I+3d0D34kH4bxXQ
	 CZRRuAw8QGA6Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:34 +0100
Subject: [PATCH mptcp-net v4 10/20] mptcp: order write_seq and DATA_FIN
 flag
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
Message-Id: <20261127-mptcp-cmason-fixes-v4-10-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2627; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MJSbsZVjk59nWZBAczzekjs6Ehwb4Ufl1ukfJkZ2cH0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H64TbdLaoX33Z+fS+rhVQRImZjxlP2Zxsl4Q2bhaR
 HyZSdfZjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIsEMjL8DvimxbVX3v7dhBAt
 ifO3ws8wx1sc0eaJrmmeomHanKDO8D8/5THDhs5t37tnbb/0+69ZCuOEc7dfL7oW31cmPneWpyQ
 3AA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_data_fin_enabled() can be called from the subflow TX path, e.g.
when an ACK is sent from BH, without the msk socket lock. But
__mptcp_wr_shutdown() sets write_seq and snd_data_fin_enable without
ordering them: on a weakly ordered CPU, the TX path could see the flag
with the old write_seq. After all the data had been sent, the DATA_FIN
could then be sent with the sequence number of the last byte of data,
before the right one.

Use a release/acquire pair, to read the new write_seq with the flag.

This issue has been found by an AI code review agent (Clashiko), while
reviewing "mptcp: order write_seq and DATA_FIN flag for fallback". It is
theoretical: it has not been reproduced, and it needs a shutdown racing
with a packet sent from another CPU, after all the data has been sent.
Still, it is fine to fix it like that, without real impact: the
release/acquire pair is cheap -- plain accesses on x86 -- with the
release done once at shutdown time, and the acquire when sending a
packet, as the plain accesses before.

Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: new, for an issue spotted by Clashiko

Note (Clashiko on v3): the other lockless reader is ordered by the next
commit, with its own Fixes tag.
---
 net/mptcp/protocol.c | 3 ++-
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bde512c60feb..2e3b34597380 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3688,7 +3688,8 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 
 	/* will be ignored by fallback sockets */
 	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
-	WRITE_ONCE(msk->snd_data_fin_enable, 1);
+	/* pairs with the acquire in mptcp_data_fin_enabled() */
+	smp_store_release(&msk->snd_data_fin_enable, 1);
 
 	mptcp_check_send_data_fin(sk);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7cdd0a7e8296..a9daa047203c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1028,7 +1028,8 @@ void __mptcp_error_report(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit);
 static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->snd_data_fin_enable) &&
+	/* pairs with the release in __mptcp_wr_shutdown() */
+	return smp_load_acquire(&msk->snd_data_fin_enable) &&
 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
 }
 

-- 
2.55.0

