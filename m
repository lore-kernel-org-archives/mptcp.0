Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065042;
	b=4bdk7dH09K416ghpbAaNoAYNCaWPdRYhQsjYvDoT67QluCKt9t+ZXIdcyK6oSnz1bmEb
	 gpncyPUzoolX1/JwaMZ9FN2NWcNMhC+WVS/EfrdNwCPhBZEAotY60rtya+DhIFU/Ud750
	 uSXbkyb4Zudc5zfIcYM8FKSbdpEmWp8zX+pAI8fAhQoaDFN+y2N4V2h3qV7rg6ykVdfUr
	 DYQyLc497XSp+UYPJgRUWsienEBGDTYzewh2nYQfYQTrd/I/vJtk+kKvTMTW9SvdMQ2h9
	 5lA6slXtHhq1nOSA2HpmmHtNX5F37peoIzWe0RdGvonVBQAFyHmMxffZn/OQJmXV8UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065042;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wEWBwoPsJp+tek9Uu4HXT6lcFheDHMYpy9Eco3d6L90=;
	b=TPgXeal3lNEQTf9exb/9lUGbKkpfhdCOuoUZJsyZ8GURAyH9bbk/IgiZDahV3xdhied7
	 weGBoVkVEYf5MGrDYAZbzq69yOaigpBzKeLTKCFPGtIYrxR4ZU/x62r1PtANNVIAISaqf
	 8pLOsdjlaiRTzy4JQ/Uu20Y89+xI9JFkQrXQ+KBJAX84SKYsNEUv7sfSBUmJfu6LZdFeB
	 qwCMKejwZPKfq5V7rrrrYetcKa3sb1G+hrbX80FuxpFq3Sm4CrCQW6M09pR67WUvGC0LO
	 efynwK9BuHPrzXl7xOwTQZKhYmqM5Hl1jm6cvSrmSJ5L5eR9WzZlIFj8YJnqUvLJFJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUZ0KWMd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD37606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUZ0KWMd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950EF1F000C7
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795065042;
	bh=wEWBwoPsJp+tek9Uu4HXT6lcFheDHMYpy9Eco3d6L90=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=PUZ0KWMd5mxVRRNwLuVJg5+0MfvuazwCP3D6BJ939SFCxUPIa/wDKrI7HK3rya4Lt
	 EosUvQ4N9abIMxVmurxENDnfYMgqzXnBLi4+d4D0yg+mPh3amHpAMqnaJFvef5LKT8
	 prL+Yj7PEMkGwlZSsOlzWEoCJVdgDptXF1zBuegkpGRLlQrqVM0m3AQvzJ02ehqodH
	 w8F2jR7SYFlDSeDOm5ddcSz0DEVfsz/kNY3bpOULKazf8OwEDCYow2HBGqitUwfPBg
	 Aq8vkiRgEPqaH8KbKK//k2zt+4EmdYuGuQddMA2L3yx6pscAwyyidoOEGlwCZPfHlF
	 IUiwB+ADrFobA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v29 1/8] mptcp: clear rcv_data_fin_seq in mptcp_disconnect
Date: Thu, 19 Nov 2026 13:10:27 +0800
Message-ID: <8ddc0c84953b684795e5059639b88594c30a3470.1795063943.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795063943.git.tanggeliang@kylinos.cn>
References: <cover.1795063943.git.tanggeliang@kylinos.cn>
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

mptcp_disconnect() resets rcv_data_fin to false but does not reset
rcv_data_fin_seq to 0. If a socket is disconnected and reused, the
stale non-zero rcv_data_fin_seq from the previous connection persists.

This can cause mptcp_pending_data_fin() to incorrectly match the old
rcv_data_fin_seq against the new connection's ack_seq, triggering a
spurious DATA_FIN processing.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 01f05b3c4322..382da2532037 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3679,6 +3679,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	WRITE_ONCE(msk->can_ack, false);
 	WRITE_ONCE(msk->fully_established, false);
 	WRITE_ONCE(msk->rcv_data_fin, false);
+	WRITE_ONCE(msk->rcv_data_fin_seq, 0);
 	WRITE_ONCE(msk->snd_data_fin_enable, false);
 	WRITE_ONCE(msk->rcv_fastclose, false);
 	WRITE_ONCE(msk->use_64bit_ack, false);
-- 
2.55.0

