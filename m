Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE03143C61
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 05:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767504599; cv=none; b=V3Bvscax+O8pF/bjybw9jBCllFZUn1IQTztN0AB0Fvl/th33Lfl986MxLOPyyEpz/6pY34W20YUG6gozbRdsNBerSN3NHX2GIETvalLxrqN0h/BaXqChJrDUAJDWRAPVOR4FL0oGznHehKg5GW6EsFs7KYcaHxLgh5/qDyG9HQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767504599; c=relaxed/simple;
	bh=dQa2mQD1k8jMXM428vmJcI3XZnE4oX5j4J4zESf4rEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7PZnExaqIPyFx8bpq5+O/t1T8bYaRpjIYYhLFdWdBEWIrnCEYmdRllCoecRGaLcwAaY21ti2QUL/CaQpgExnnjald5oKCYq1lRLDPgE6HN9nZWX9PQQc24gUau2ggDkaUGquI8rUAUkkk/B2tzKydfrULJcsFwrStrQYZqBiIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p228+bEg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p228+bEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846B0C4CEF7;
	Sun,  4 Jan 2026 05:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767504598;
	bh=dQa2mQD1k8jMXM428vmJcI3XZnE4oX5j4J4zESf4rEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p228+bEgtHwY42wohPRNIB19teqP966jUk1B2N/FWkWmYfHl2E4+8i8Gfqq8yaEgn
	 bL8qWq/p18utFfFxQVob9UqZzaAY7Gpll7pMQlJNk0zKHev11PjYhoZhrKrOkopBRh
	 E913LnDDXU/VIZ3nor2Dde8MPP1WxeKe7UNQ2FiYaxSsoVkPpHeQaxUeWVF8a+7Yzo
	 V5Xq2+qTe/LRpLh/srAdMegqYRE0C51cnTqj4qmfyx+J0Ac9Lhve2TjqQliPh1qj/u
	 9N0r7pDmQbvpRhClKZKsAvNFOuzrYKJRMqRC3gIK5OwpUO0J1S94DAHUGcJyRzlUYs
	 g6lBPzTOK7tAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/3] mptcp: allow overridden write_space to be invoked
Date: Sun,  4 Jan 2026 13:29:43 +0800
Message-ID: <2efc3455052c3a33cad0c8744b171dfc6e7a6d8a.1767504329.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767504329.git.tanggeliang@kylinos.cn>
References: <cover.1767504329.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

psock may override its own sk_write_space functions. This patch ensures
that the overridden sk_write_space can be invoked by MPTCP.

Note: This patch was initially included in the NVME MPTCP set.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cd5266099993..f5d4d7d030f2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1014,7 +1014,7 @@ static inline void mptcp_write_space(struct sock *sk)
 	/* pairs with memory barrier in mptcp_poll */
 	smp_mb();
 	if (mptcp_stream_memory_free(sk, 1))
-		sk_stream_write_space(sk);
+		INDIRECT_CALL_1(sk->sk_write_space, sk_stream_write_space, sk);
 }
 
 static inline void __mptcp_sync_sndbuf(struct sock *sk)
-- 
2.51.0

