Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557707;
	b=z7tP0UsXoYiF77Prs+bPb20HSMgUeoy061ur8L5zuQtL+hE1wcOM8Cq79lauhqgF51pH
	 sC8d0eoCHysvGex3yzqc5ocuhGR5HEmJVnlyZhF4IBZ/9oNj60ZpJFcfSt+xasbQulJh5
	 PNpfGA6J1BakRIyrjq07R8gfIs64wnGKJ2TUsqX+xz7z9/yRxRHS+Y79GGLkOtnGCWji+
	 sX2JSK7DfQQLlMAaQ+RNl8HIRRljcc1pH4Wei0SLYWw2mLLxiaVMd18O2jPZM+QrGidpC
	 r1SpXDU5tkGmAeEsMAAmUzJzbtRV2ejt16tjKDi4paa66tmFniPSce9EPIayLCcgIVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557707;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=BXX7V9xwAoM4rFqBies07TLWW1I87/kmyVgTL6n+Ui4=;
	b=355dIYWzFnwauCmvHMgGHvqa0wL5pusdYNiT0cY39gB1yn0adrHvEoxvtrO+B0HKE8jQ
	 ciBNgvefFO79y2BKfUSjC1N6maJBIwM/ZqcLCZOQtVq4MoPYQ0V46cek/0qLOgFf8PjAq
	 hj1QDS2DnD7hyWTPTVuol9mIDXvDWj1RwYghiZBhukj6Q+OitNiVIqeG8q+10HCwEFUYG
	 KqGRzDq/SsIY8vl0RCKDtF6dmewvYwOPXwymSz3qao35MtFJ1xlbt84BiZNr+vuHDQf3s
	 UkSw+kWk6ZIEgkQgdsbmPYsShZgNibwtlg6Syu3O1dD7tGJHCE61Ju8e7vOCF4EpYXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eycnyrpc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54CA606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eycnyrpc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC9D1F000C0;
	Tue, 24 Nov 2026 22:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557706;
	bh=BXX7V9xwAoM4rFqBies07TLWW1I87/kmyVgTL6n+Ui4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eycnyrpcpGvjrmCIYpOA2+wjkx9zzdaPbgoQ4Lzi9FDQJvpyK91RjAEH4t4KrIcJP
	 oDjfp06Dkto7znhdpZWkTsf5XyLtNgkrmdPP8zVrqv989vNmZcT5+7m1LhWvVb7YTO
	 hPXg6DIxTR8STjusTERN+opTwURPsK+SV/1gus9c9LN5naOObVkK8zw6juJct1CQK3
	 toNrDY00wwkbv1mftjgenLc2n9pplRqqweqi9QzhTbGn29HVB88ikIBOg5qXQ9AMKg
	 5LG2Ho/pIJmNGipd5aA2qa7rVUhNAlIoPVKKV4FhKHxqCme0WCFujd1nDEHM3cjMYg
	 Y+ewMxu/fMKUA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:56 +0100
Subject: [PATCH mptcp-net v3 39/50] mptcp: fix MSG_PEEK after a partly
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-39-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=akG9Mkw+666ZUDD0xRz2OG0bewBK2jkpjADxAVAdk4k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOPnnuT358+zcVtnpZm8ii30DJUQ7Dv5te+B+7Hha7
 eO+o4/vdZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEyk8x3DP9sltxwWKs13eaKa
 cC/4roj4QpOVB2bPuT5RSuCWxMF034kM/2tvbZNzUCuPkFn3zOlYNNvH+LZahZ22R79pajn2+Po
 uYwAA
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
index 8017f8775728..0ff84d9684f1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2301,6 +2301,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 			delta = copied_total - total_data_len;
 			offset += delta;
 			data_len -= delta;
+			total_data_len += delta;
 		}
 
 		count = min_t(size_t, len - copied, data_len);

-- 
2.55.0

