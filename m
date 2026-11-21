Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254185;
	b=kzD6OHDyb+q3ROyJwynT+iNib9mYt1c7vL5EedQERyBYBpEAeHTXzPptena6Q8PvcSan
	 B3ZDilczW+bJd1L38PezkWMctAro4z4LqNA2ij84/NAWZwJKlIBLpWdl0p07KS5GiyOOj
	 djDr2n0Wn9nJZGXC6fDFWPFE8QlaDNaOow3c/HUYkufdQS6krPxXk8W7EzvAUJOtLdDHy
	 W77Ui3WxJ9+1N2MY1oFuN2MIpWvI/qfkzAy7bETsWoKSq71U71/vHvTkrnJfOGiNNqKsR
	 W989pmAXZ3iV4MbVTq2nAR0so0USovnrvtHQn9IqY9XbgU2aFbMqI65HYGiBdxy1RSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254185;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ICaS5+YxPgQV8dwy5z8oXcjW+VDvA+reJ8VlzvMMR0g=;
	b=Qf1xSW7ESvy1KfFBTEu8UT8T55SvHDnJn7tjt8R5kmjoFcvIZYNX70+iHOBGyj3uXU2/
	 scboD65PCR38/0cR4cmDcETp94y094sS4TACvFgU9bpKJqWoVk2Uan+uBUnLVq4gNBq+E
	 +R+KPGaZ0pGi5xie2pnr22+G5wSRoZl6T+cNUXai8nnphhebfzlSvBdb3JGasCOmXl9sW
	 OSXaGjgJ5cLiS5iUzq07ccF09RmMoeKhqFmxb4TU5xQwTqcMaxa5OlaVLSRYrRyBq8SJt
	 PwIN7N4vbIE5hcGLwsBFEo/ZIctfXydmae7Y7hcuqxJQZQ5yziXvBABqOu6PxAZcZgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LghaA8Z/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B56606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LghaA8Z/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F38F1F000C0;
	Sat, 21 Nov 2026 09:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254185;
	bh=ICaS5+YxPgQV8dwy5z8oXcjW+VDvA+reJ8VlzvMMR0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LghaA8Z/1BU1yBIz8ysD/Lc+Fe4oMboKoFtwOB4zqhUXMc6gH18pvEVQLuIyL0rhB
	 DwVaaKUwBpPTjnOtfZ+ZroTTHOsA352VkxSCyBZpVCNCknEyYbCILOgLfv1Kwkd51D
	 nH852oahUPc2omA/vpZMwrE03Gid1GGszxXfXFR0AtInlcUYVL/EOX4qNgpsj4BYv3
	 zikEdGrrmrvvZYoDAWs9FlREPFvxQK2yEG5lz5WkB/HblO+h39NGzFv/gCXfpk1JDB
	 2tZW9PBWGFIdnYppxoqZZhwrlhq2JgrAF6Ged/Bo3ZHcBQrAbHDPK4sHorIoeGX8TQ
	 Iv8DnQXwh2OBg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:51 +0100
Subject: [PATCH mptcp-net v2 53/62] mptcp: fix MSG_PEEK after a partly
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-53-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DnNuMfA8Exbbkwg7ajpZlzt9BDKt/Wl7UevOR8rW70M=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0wtYO9mfPX37jc/vgG2bBeveX8rqbFm5N4+5rBQT/
 bH6z1urjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkwRTIyHHHZ9s64j7V/ttqu
 3Ve//LO/EPnGTbFae+Xiyc8WvDgdN5Hhf9osp/br1zM0ts77xbrv0oxpq55usef/Mcntx/b2RX3
 Jr9kA
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
index c16daa461290..992e1832398f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2299,6 +2299,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 			delta = copied_total - total_data_len;
 			offset += delta;
 			data_len -= delta;
+			total_data_len += delta;
 		}
 
 		count = min_t(size_t, len - copied, data_len);

-- 
2.55.0

