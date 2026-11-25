Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591391;
	b=dH32HxsH8Ews+dz9cvW0o0CAaqocusYf0fPGTcZrcmaWdWjnhotg2yVhqZS7lnzh/EX2
	 BCDOauOD7MQQ0TLJBDUcBWHKhWptTxkh09M90ye0OBx4Fcz7wVfdZURe5XtIDemIa3D5B
	 tQwiQdiaqniFPrAsapl5naqTwIu7OvcgCpA9LV/HhluDNRdMAKyJqX2d/50hfnFBYVlXJ
	 G8tLSjPLSIdgKVLBoqkt2Tk7tY7ExlAzd97y1vHIJahsq4UjVzoN5WF4m1EV45oonPT4K
	 1Fisae+jNe4wsfEaD+fbYRD3vT4WkW4dPJ6bxo0B+PdRgVKiQulc98yFF/MESDXtzng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591391;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kGbDCUUEghTXfUDed29AI32A6nM+GTG8GbtYwF0dp8w=;
	b=1zptwj9ZPinXf+pkC6sw9EoS384xcVJBewHFuOE2JQQ+riUNkyuFWPR8Uy9REu7TSODY
	 UQoh22i5vXfXVrOAPCsCILd9GuDxPPZuDvmqWN0tUVAavky1C6+Rw9X5okS7dN/b5KU96
	 d5Am9wHGEsj2681GDT4NujoHuKQH1HxKGfmvh5dgyEGoqTC64YaTG4O854MI1Z/VZptJf
	 4rFvn7H2kg0hNxUR7PuSxV2AqG2kB0iVV1CWa3gOlEIGE79AHRRHWUpZz7mtkUIuiR9Hm
	 4LB3i50WZ0knPlfzFasKh89ZmoXJRdpaV7tHPpAvxcUTEO8iZ0cIYK8Pgh4/IQFheAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfW3yO9c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244AD606A31E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfW3yO9c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EFB1F000D0
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591390;
	bh=kGbDCUUEghTXfUDed29AI32A6nM+GTG8GbtYwF0dp8w=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=XfW3yO9cLaxWk7W0c4KIXEXlb6UCy3b6Oza0jsCRuhNOlAdZnsNsiKTTenL2mZWFm
	 nrzIc8ISci5Kphg7NudUzcbhgCdRm0S1hJoj9DtZoUBVPhe+nf18hllwSaaJtC0+tF
	 bW1KAh4+HOPlZct1wmHrKsxLBE0Xp5YgavvLjYE22shiRmVgYZHkuR3ahfjYbrHdqR
	 OGGWqy2GuWjhn8lfi9gQ6fioagttlPxZB1+EEzS1aQT4DLuXVayEiNzI/9I4sHRzi8
	 LUKx75aVEPn+GXJfRgMTQaoFVNnGjL0UzSWoZU7di5H4NejJmQmQGwVzpPYNA3bG4H
	 gAbg0bkB4WU2Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 1/7] mptcp: use local variable tp in sendmsg_frag
Date: Wed, 25 Nov 2026 15:22:59 +0800
Message-ID: <d78ad0fbee64b4495d852c1676614c25330357f5.1795591278.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795591278.git.tanggeliang@kylinos.cn>
References: <cover.1795591278.git.tanggeliang@kylinos.cn>
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

In mptcp_sendmsg_frag(), tcp_sk(ssk) is called multiple times.
Introduce a local variable 'tp' to hold the tcp_sock pointer and
use it throughout the function. This improves code readability,
with no functional change.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d64e04245963..b9ae52caf47e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1447,6 +1447,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	u64 data_seq = dfrag->data_seq + info->sent;
 	int offset = dfrag->offset + info->sent;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct tcp_sock *tp = tcp_sk(ssk);
 	bool zero_window_probe = false;
 	struct mptcp_ext *mpext = NULL;
 	bool can_coalesce = false;
@@ -1483,14 +1484,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mpext = mptcp_get_ext(skb);
 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
-			tcp_mark_push(tcp_sk(ssk), skb);
+			tcp_mark_push(tp, skb);
 			goto alloc_skb;
 		}
 
 		i = skb_shinfo(skb)->nr_frags;
 		can_coalesce = skb_can_coalesce(skb, i, dfrag->page, offset);
 		if (!can_coalesce && i >= READ_ONCE(net_hotdata.sysctl_max_skb_frags)) {
-			tcp_mark_push(tcp_sk(ssk), skb);
+			tcp_mark_push(tp, skb);
 			goto alloc_skb;
 		}
 
@@ -1548,7 +1549,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	skb->truesize += copy;
 	sk_wmem_queued_add(ssk, copy);
 	sk_mem_charge(ssk, copy);
-	WRITE_ONCE(tcp_sk(ssk)->write_seq, tcp_sk(ssk)->write_seq + copy);
+	WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
 	TCP_SKB_CB(skb)->end_seq += copy;
 	tcp_skb_pcount_set(skb, 0);
 
-- 
2.55.0

