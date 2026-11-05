Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860703;
	b=i/wApzoTRAn6ex1VyciIkFShzAO6D817vLaL7sChT9pxy57aYzWofYnM4LFP/MqztukS
	 eQWVvuvdRt+Xi7dKz8ohnzQyRJNBG8npjHdehnNOGpTbFTNPDSdSLRnChN6XYHVN/cnsc
	 qrWod4QnRPtIEEwJd2pX6NyTE3Mp9ZdskZazUo7JxlIMgBGnQXT9l/LonjUBW4okuSzPl
	 6vzbnBBSLHhDUfukm0N4BSls87XXnPaZzjdON5QTElB0+rLcJs2jdgcVe4E9v+rgva9Ca
	 PkEOySGBjWAqQobm0nKX4bG7q0Qt9TlIIwNToTbUzHpfiwgwHtLm/AzjXiqotAjxzrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860703;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7+j85nzl2zC+6eFpOE4tO71tHI7dTH1G+8o1HEDJfMA=;
	b=o3oLnfjbvKZZHXbRrCzxw3ejxlrUj8Zz0AIJJJ70N3phKP0VLckn8v7TaRxIhkXRHgkO
	 JCKgBRN9nyutOjSV1hQuZKYdtLyDbjCp34aUyeGITEyt9C/uSkxh2/MnoJHLQ2TlzNyTX
	 zkn5QJaWu5OM6DUZ8/QVlm3gXf3MSS/M95v9cZT3+6ZOCbEhoxm8HCcx0yXhvdBCO6XBu
	 6n8BPtvG9K737mMacAsrfFFXOveNtD+GW7DXam9P70OoYeJVIP6ZuWq900YeMZvor9wOt
	 5MDcWkSKwg/Cpy6MA6IBagFTI8Kna98uInddoz4Dr+XbX/g2tKQwwOSa5LUX1eelpNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTE7Rge5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507D3606A31B
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTE7Rge5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3081F1F00A16;
	Thu,  5 Nov 2026 06:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793860703;
	bh=7+j85nzl2zC+6eFpOE4tO71tHI7dTH1G+8o1HEDJfMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HTE7Rge5tTaoNWBMhtNlAX/ZOLYLxml21RlwrlsBsmm5Qo+Vlj5QQ7zcugE2lrgd6
	 xBtukf4UmK3om/eX7I47rIC95qUCcM5j1cN1epv1/7UlTG89/ytS/exX7guVT8hWdv
	 VZ/rOs2QBQBF1RHWX0DF25e4h1Hh3xft8zz1ZlBXp1TXGWz/3LDGCIPLdN91UJXluN
	 42AQLSF8JZeVC8oTHwh4EIRNyzVcEnDuHmsMuYpxWyqBCifuwxj2dSwglF+x2VJKAJ
	 VwEy/najvxTrxruU/1lV03972dv1qqX11VdDqML6kiorK0tZ47syT/wrrEpJf+wSql
	 n6nZmeF+4zZlA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 7/7] selftests: mptcp: sockopt: check app_limited
Date: Thu,  5 Nov 2026 14:38:03 +0800
Message-ID: <30807971ab2ce40b1c8d9a73e96e7472e1329910.1793860134.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793860134.git.tanggeliang@kylinos.cn>
References: <cover.1793860134.git.tanggeliang@kylinos.cn>
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

After a small data exchange, assert tcpi_delivery_rate_app_limited == 1.

rate_app_limited starts at 1 (tcp_init_sock) and is cleared only by
non-app-limited rate samples. The preceding commit makes
mptcp_rate_check_app_limited() set tp->app_limited on subflows when
MPTCP has no pending data, marking outgoing skbs as app-limited so rate
samples don't clear rate_app_limited.

This guards against regressions in subflow app-limited accounting.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b8158a1198eb..9517c530ba21 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -635,6 +635,11 @@ static void connect_one_server(int fd, int pipefd)
 	do_getsockopts(&s, fd, total, total);
 
 	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+
+	/* app-limited accounting only checked under EXPECT_ALL_FEATURES */
+	if (expect_all_features())
+		assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1);
+
 	close(fd);
 }
 
-- 
2.55.0

