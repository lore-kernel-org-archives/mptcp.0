Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053879;
	b=j+7YxgUChdJZkJoARsUOARbLuMbrym8aozypW9mfKmvVrPQZZYnvyqM/CLqa/fL06vY+
	 orl0CDVJfTZQzO+oc3qMYQ/akRmVboV1FC7A0jdF8g4y6/jnT2jDXJQGAcRnzq/Slwgea
	 EyN8zU6HeDjpWR48P+0CD+5ut1kokUoYqLrwUTcLAe/uKu6GGQ5F1+Shshlk2gpGRcUJo
	 QkkDrGvShk6A4MQafdv2w8U1lSrMiyPU+gl4cj0R/hHk0RZJDUNg4fVqZN+C4mpEtve+4
	 MW8lD86zc3gSSBLnHLh34H4ddM80wdwSRynhluAU3cEFL+VKlxxH/JMedGCyopolahw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053879;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KY/eHjpuJC9gkRrMN0LzUWCt09sRj8c+0f80CRXtIyE=;
	b=PxvFn1J2WPqtWWSvpVMw1nEUgnzY6UJwL/Jg1JSWaTUp682mKyS/G2kgGOzTHJ0AGPHP
	 WLsdwEiScQgw/FBVsSbSZSriXbPvYrz7JFrCiZ7eVWRzbRftSv5xiQ0QYFMXiNC5S2EUe
	 ue//vY8TSzHPMnDbYNBgO9+OZ8mL973aGee5D8PwRzZThtJss6+Yj8Ytqo3PjJvLmx86L
	 PemDmcs4eUOmFVvHFpB5VzXnJbHhve6KXV6GhZcEZiCWcyac0MVzNiWMF7IBlosI+YrEh
	 shabk00xoSkcGS8u9AcPNtgP7HSGw/0tKu/pehGayVyQ8WKSOg/tov7qlqNpup9ZsDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzbYRAMy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27362606A326
	for <mptcp@lists.linux.dev>; Sat,  7 Nov 2026 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzbYRAMy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D741F0089F;
	Sat,  7 Nov 2026 12:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794053879;
	bh=KY/eHjpuJC9gkRrMN0LzUWCt09sRj8c+0f80CRXtIyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jzbYRAMyQ/OH1lPJ7HC0Q3ons/8qhbaBR+oczpzKVrVACVrBS9Gwo86Kzy0kP/4vp
	 cODAhUZxGZdVMc1Z+npmRpKfCY+EFubTTShI4pv2KDrFDVyY8Nfrr5Ny11rVJh9tQD
	 q0lRqFs5KP+4avU9KWG7SMCqCS9/0sYHPLpf9cVd3QeQqid1ofVIcWDpS990/6PUR7
	 QrFLnTWLL7uVY4HDqTLFrd9mLHoGI8Cryk4yozOM8/NBcQiK1NRTSObKB0o+8PDXyQ
	 Qet5s/Zkr+7ujdUMS3XOfzbs/Y/yizAiWgs8DTEFFkbp8spGAgOpsMjHytPqjGgKs+
	 TdPSgLtuFz73w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 6/7] selftests: mptcp: sockopt: check app_limited
Date: Sat,  7 Nov 2026 20:17:19 +0800
Message-ID: <4fbeb67aaf0dd8e75876c82d3781bd72cfe435c4.1794053683.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794053683.git.tanggeliang@kylinos.cn>
References: <cover.1794053683.git.tanggeliang@kylinos.cn>
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

After a small data exchange, assert tcpi_delivery_rate_app_limited == 1
when expect_all_features() is enabled.

rate_app_limited starts at 1 (tcp_init_sock) and is cleared only by
non-app-limited rate samples. The preceding commit makes
mptcp_rate_check_app_limited() set tp->app_limited on subflows when
MPTCP has no pending data, marking outgoing skbs as app-limited so rate
samples don't clear rate_app_limited.

This guards against regressions where subflows are never marked
app-limited. The test covers the empty-queue path only; the early return
in mptcp_rate_check_app_limited() (when MPTCP has pending data or
retransmissions) is not exercised by this test.

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

