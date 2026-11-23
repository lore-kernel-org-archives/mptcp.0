Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421999;
	b=b2j031MrN7PoqhGBdY14occZNXgw45WdYyTfHmjHCbBh06CTFiHBTgIgPHrOlTFnKKBl
	 ELUtqaCzaQxZZQ+551rtLjzvFFoKNDaru6lSMj3SheoF+S2A8DZLonxgkVU/NCAwbEEe4
	 kUN06ctaxjG/J/PWKPMA+pHPt5aZI85WLnaR11D3osgCwESZB63sxwAVpZ/EI/4XZbJmH
	 IZ7A/qSZVFD8mEKcDFb8o+3mqxbRXv9/s3Nd0MO+4dvO/TVu3zIOS3XxfSoap/bbkZfaK
	 nyGdGXwkHM+71IbNzqhuh2SIdYeDXAMu8i1+n64TjbKiHvbpDVKj7+3BzpdNHyPj32Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421999;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8myUauXGsW1McjOq5/f58u/fkN4+mQS9Pt78QWf1s04=;
	b=nD2FB5XcW0xxjoXKqXlozdpz/YSB3BeTuqjU66tPTl9eWaXEXKtIu5myc/PJpmH/ai56
	 G6kju4wze6mIeI2gFjt/hiZoBPsl1EweOBqh5t5KvlnWwM2YNssUeU7UcPbEesn9Pd/mO
	 LDilgQd5bgm454bcW3RhQIGviybn8fxfHBxDQK1XjT01TqFT95ztVr82iLb7oKYYwDpz5
	 jAhH/SX8hxY5B+nGh5dTEFLZDWHs5JoOZQBUIa501xBBICU0ALcQ7FAu0LNpN1q2XHmV2
	 29NFTDp92unROhZhk0wGi2uMYOeFmAiUIHQF9PniqOep3V7dbQGee5BljG8L5NjQycw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEcM924k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB78606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEcM924k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B341F000D1
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795421998;
	bh=8myUauXGsW1McjOq5/f58u/fkN4+mQS9Pt78QWf1s04=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=IEcM924ke6CT2hM6k8dfyeuhJAaSAhR/CZg/kMMUNEpk2Ba4qQ6xzf1+x+yuV40I6
	 MY3dCCmmpsowMM+LysceWgkV+u955pT8qIRYsMxVpIrM+FFwJOp5xWJd49xmCAzEkc
	 +EZtNk+1GgxZZMhfoj30vfvDVLDawLX6NshMBlpBgKuig7Qel15nGgmcL3+9govGLJ
	 BxYLxArNiiwPupS3eTPwBmBopRocn/aLSVL1AW9GbgDcuF7cMoOeVhHaduO5L6sDfW
	 FehfFM5WbZXODOObllCIOvIFzb/8GdmXh8vAJkYqEcfpwcjAwNG+lQ3aGVHDAPJtwF
	 ToSdFbJNhezqw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 2/7] mptcp: use local variable tp in sendmsg_frag
Date: Mon, 23 Nov 2026 16:19:45 +0800
Message-ID: <ef8555540d1f14932280a8f9b0259a953969ebe1.1795421388.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795421388.git.tanggeliang@kylinos.cn>
References: <cover.1795421388.git.tanggeliang@kylinos.cn>
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
use it throughout the function. This avoids repeated dereferencing
and improves code readability, with no functional change.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index be23768b6d05..2102adaad4a9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1443,6 +1443,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	u64 data_seq = dfrag->data_seq + info->sent;
 	int offset = dfrag->offset + info->sent;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct tcp_sock *tp = tcp_sk(ssk);
 	bool zero_window_probe = false;
 	struct mptcp_ext *mpext = NULL;
 	bool can_coalesce = false;
@@ -1478,14 +1479,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
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
 
@@ -1539,7 +1540,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	skb->truesize += copy;
 	sk_wmem_queued_add(ssk, copy);
 	sk_mem_charge(ssk, copy);
-	WRITE_ONCE(tcp_sk(ssk)->write_seq, tcp_sk(ssk)->write_seq + copy);
+	WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
 	TCP_SKB_CB(skb)->end_seq += copy;
 	tcp_skb_pcount_set(skb, 0);
 
-- 
2.55.0

