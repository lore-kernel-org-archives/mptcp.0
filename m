Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014452F532F
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366199; cv=none; b=DQkkLLYsreIWFFOsjkSvXIeuyNobSiVB/EZH/kQuSHAVBM6WEvwXVb9BdYtb2lS6oMJW5VUCkU9GMgF12JE54607OspGpOhcVMhaupSin7GeAHkUxk6Y/bLtoWf1FbsdG7Qe3jOpuiI/qIT3OLnb/4rxiDAf7XovYt+pTM2doXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366199; c=relaxed/simple;
	bh=LQS6YIivyys9LFu5gqANdXMKolQ/xn5G+bxq7MVZnVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oc2cKxdvA+WgZWyz4teH7YRFoC9y1/mMts819RTw9jN2AE8bUYmQZFMo3bwIpPdiL/abSa22ia78YZT+oYuQHCDl8h79Upq/c0gOUwEULCK1+6TSmR8T5yd0NuqlcUgikoNhywF1fAco4frH93IfL/Ce5FCF05qVUuOydO1xKJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+HUpVj5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+HUpVj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFF9C116C6;
	Fri, 13 Mar 2026 01:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773366198;
	bh=LQS6YIivyys9LFu5gqANdXMKolQ/xn5G+bxq7MVZnVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+HUpVj5uQ5CJJVxcsYWYBa2f6yZtZqFU0hO7T8l5i+VkgxGMAgpnRPdoa8KsoD9N
	 /qvy+YkIHO36vYccq4fKjf4jRKEoIN7TrAj1ck4Agms0uo6tfOuzsUOi/mWIJe/ym8
	 Io5C2vc+nqU3GbpQUmxgQtzIBNRgN3VewbL4/G+HoKSz1FUVgTOsnIEal1sX1D3Ydh
	 4zi2KXY08Ks9AJwmgHCuZwZEjsE19DZcF+hfRDXc6TMJYKh3UGqVvkR08mqKQrzOZP
	 RkWSkWE+d+12sHhzU5s3rxYS/kvIqHuEqfyJwVqfQJY6HjAsAOvV16RIFdI53maTtw
	 n6ppYGHU9cpog==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v9 03/10] tls: add MPTCP SKB offset check in strp queue walk
Date: Fri, 13 Mar 2026 09:42:45 +0800
Message-ID: <acf171d4e4d0712bc2ad91d9a9d2d933f43a472c.1773365606.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773365606.git.tanggeliang@kylinos.cn>
References: <cover.1773365606.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

In MPTCP scenarios, subflow SKBs may have non-zero offsets due to
out-of-order packet handling or partial data delivery. When walking
the TLS strp queue to verify sequence numbers and decryption status,
we must also validate each SKB's offset using get_skb_off() to ensure
the queue state is consistent. This check is specific to MPTCP; TCP
does not require offset validation as its SKBs always start at offset 0.

If any SKB reports an invalid offset, return false to indicate the
queue is not in a consistent state and trigger a resynchronization.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/tls/tls_strp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index ef1a8659ee18..4cf0dfbd7fb4 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -454,6 +454,8 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 		len -= skb->len;
 		skb = skb->next;
 
+		if (ctx->ops->get_skb_off(skb))
+			return false;
 		if (ctx->ops->get_skb_seq(skb) != seq)
 			return false;
 		if (skb_cmp_decrypted(first, skb))
-- 
2.53.0

