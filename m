Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474C270EC3
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 05:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513626; cv=none; b=O6YluZ/eBYbVocxMocyHeRddn2/IkkL1OuNEDy7jDftvBIERXnLIt+MOTV2FzSedTjdRlM0JE9GqbFLD5Jb4GQsjdFCEdKWdZp4rKsrss3p7IkubVaO7JJJjBnqkfalMNUusGW51Edmf2Iizc/DOwjw9wnmptnfJ1+pXIcUO7Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513626; c=relaxed/simple;
	bh=dIhgbkCqwjxZKtXoit7clY5HiAf6j+c6rWANY41t/rI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CH09iKQjJn+wzMYpDoiQz96RtXADJF16IE+I5qsoc9z0ZCH7FOp/E9QuMI8fGHP9NwSfxsLV3/9Qoi5oHFYoyFSiCYMCeJpnGGnWcwkG8oc70ot5BGxziL3yVa6O2+vWaMmdWUaHa7TbW/JzjthWfFww8/UEcWO29zsVKpLpnzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vCaQvBhf; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vCaQvBhf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786513622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R73H97QJvE85QkRD5NEL3Z68SGfj043Kvqvg6LMUDOo=;
	b=vCaQvBhfUoSCC1QRol/fPHFINmoFhoMbmpmj8YL7NHd4fEPnpaCqGHahXQuHZV9/TywHHA
	ST3xW+liyNrAXWI3rpfcyOZQvu1BwKohcXKVyDhn7Ma1ATz0EAnylNQyh4yib/i863oEO9
	ZF54mlwZjZHK9TF8lhNIRvJEwQ+cJHU=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH export v3 2/4] mptcp: reject joins after fallback in mptcp_is_fully_established
Date: Wed, 12 Aug 2026 13:46:51 +0800
Message-Id: <20260812054653.43799-3-chenguang.zhao@linux.dev>
In-Reply-To: <20260812054653.43799-1-chenguang.zhao@linux.dev>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

After fallback, treat the connection as not fully established so later
MP_JOIN attempts are rejected.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/mptcp/protocol.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7e168e450fb0..bf2483a7ed92 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -957,8 +957,11 @@ static inline void mptcp_start_tout_timer(struct sock *sk)
 
 static inline bool mptcp_is_fully_established(struct sock *sk)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
-	       READ_ONCE(mptcp_sk(sk)->fully_established);
+	       READ_ONCE(msk->fully_established) &&
+	       !test_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
 static inline u64 mptcp_stamp(void)
-- 
2.25.1

