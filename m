Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809727;
	b=k47omt2Mt3tTCh0ORVRTxjsYBy35R9Q1rulJV4RJlopQRZB+E6USWlAuxxh7uzUQ6bFI
	 5KtFtSWNg2psN3BDeY9KwPYiZUFQtxN53wyrsemNJBAoJE5aTThB4IKycj0bewuGAkMfc
	 MMGccc7j48Q+BaIbPBrWaKxRNPNHbbN9zMkechN6U6xQLTKrexUXDuc6sF4m2enLIuS/j
	 jtvOp5Y/DWOrmiYTCdFKLa10uGpcHDPe0KABrbz3rRRzNRkOgixl58Rk4EIZnBlM5J/98
	 iTTy3Mbzb70k+92oqjmQ0h3joViiLj5NC4bVEko1/x8JaSWrhmRQid6NGHzqiX82GnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809727;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9jUL1S2MGi4IgKaABXDJkDVJf6TYRkClhoC97/SPV4E=;
	b=BXkNK47jVpcVfBhqJR7KwkaotJASswrS91iIc3QfN149v3AY9qkuXCRQ/ioyXjIbWYm2
	 jzwDzD79lLOgcMJpPJOm/9TDd3tgpjiHTmn3LT8LcN7m/Ets+afV2YNRT8ysPf7npODKe
	 iyuJxkDmeNLjCmMgkV9+8V+e1DLguePkk1KfQLu/z+VsI9mjkemC9xNImdhDrlFpHmvr2
	 bipGm1X7nw5yC6Wr05PbakZHwTzQXCOENJr6oX8kasUCyOShLiVNX55kB1qPZdKMosqY7
	 fqk6jROxaGUBfBUkFoZp4GrV0Am7FhE/Dh4bXnyMSBWBg4cdG2eHpqyeSGDKmr+x+Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6Z5FGAF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A526606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6Z5FGAF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399471F00893;
	Fri, 27 Nov 2026 20:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809726;
	bh=9jUL1S2MGi4IgKaABXDJkDVJf6TYRkClhoC97/SPV4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=i6Z5FGAFZBzvHgDEAItmX0FEn+1ZFNF0e6FWIs16NUZGbgyyKgdSLWP+19LQS8NO3
	 NcDbVro9COvTq316N1fYqAlmpQBgK/KY1GeEgVPa1YhjS2ukojHYHlOhYqsflztgT+
	 zJY3Sixhtb7wwxdUQxphPbK+D/y4V4MgAOUOaPXO+1v2C/wJKDbvS/QBsTgXJ2s6dH
	 dKwn5fxFfLiwBscFjUrqHCMEOCmtRXJPQTZSKIuzTNPO0bLAUOql3BIbtVFNd0qLAp
	 wi9aNo2FZrlGFWtlyWtp691YCr2WW5WmjtGqcIMRI+2omYscZuBBqJibpPgHXdj9Wl
	 6KsEUSLB7L8lw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:28 +0100
Subject: [PATCH mptcp-net v4 04/20] mptcp: fix MSG_PEEK after a partly
 peeked skb
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
Message-Id: <20261127-mptcp-cmason-fixes-v4-4-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uAwL1EVExW9q7Lf+Fr6bu4b8Oj8ZKmd1HcfRqxX59ak=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H678Kb3V6M2nEHb72CUJcj2vFj415TY/yLhxZRhL1
 W62qJx5HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABP58Jfhf2Y0l3uddvnLRSzx
 OVNkP4YwvUx/+eXTu7VLNF8unbPkix7DXyF/FbsA9s7ZvKuN44P4+Lf8+sKZf3K9dc+6SO21ohZ
 3GAE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When recvmsg() with MSG_PEEK needs another pass, e.g. after having moved
the data from the backlog, the data already peeked is skipped. If this
data ends in the middle of an skb, e.g. the last one peeked, extended
since then by coalescing, the following skbs were skipped too, entirely
or partly, because the length of the data skipped in the first skb was
not counted: the peeked data was then corrupted.

This issue was likely causing a subtest from mptcp_connect_sendfile.sh
to fail, e.g. on NIPA, with a debug kernel. In the "saveWithPeek" mode,
the client saves the data peeked before reading it: the received file
had the same size, but not the same content.

  # 46 ns1 MPTCP -> ns1 (10.0.1.1:10043      ) TCP       (duration   264ms) [FAIL] file received by client does not match (in, out):

The root cause has been confirmed with a debug patch holding the MPTCP
socket lock for 200ms after the first MSG_PEEK pass in recvmsg(): 1000
bytes are peeked, then 1000 bytes are received and coalesced with them,
and 60000 more bytes in other skbs. Without this patch, only 60000 bytes
were peeked instead of 62000, and they were different from the data read
after:

  peek repro: peeked 60000 bytes, DIFFERENT data

To fix this, count the data skipped in the first skb, so that the next
ones are not skipped.

Fixes: 8e04ce45a8db ("mptcp: fix MSG_PEEK stream corruption")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue causing a flaky selftest
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b9c6e5a615c8..f600e9cdc500 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2295,6 +2295,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 			delta = copied_total - total_data_len;
 			offset += delta;
 			data_len -= delta;
+			total_data_len += delta;
 		}
 
 		count = min_t(size_t, len - copied, data_len);

-- 
2.55.0

