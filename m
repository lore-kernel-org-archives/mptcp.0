Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324670;
	b=vGK8MnWrz8IV+wRFFluRh56KsH7pzOND4oDV6PgkdNAaqlbu/AWbzI1W69sLMprL3hQe
	 g+wHSLLnFCrFz9ZaCMVW6aMCKmeFfzOBfgO3BGi7qBeRy3yFCntWal39NQ/bUX5ZITz88
	 BfM2PK4MpSz7YACEQBD9bJT9DBo1vlscV7WI1RI1QfzRjEMiBrIvQyGdvQaEu5NmCgMjS
	 /+8R8Pi5syVOwbk90mSfL/pQgDzI41NP5qtv0Omn+zQanWovVLKrHcy2fPTk8A7DO2WwY
	 qFmLU7h2JvVZXMu5e9Dhq86mUaj5LmtaCC7bxhld3vMBwhDUYExnPGNilePd1B0nGFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324670;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OvSV2HMWa/s1IrAeK2YVLhcVAMU9pwUspa1vCLLae3c=;
	b=Nx41ezFPXXt9pMqwbOUEwyem88UhbzuTW9kMb75H1VQTZbpyxNxkZs5VT74VtFQ5pVL6
	 T0d/2mxYyZUiZqTIa2ZeF399XZhnrpZk1T/vX/LioU75pHRuIIK2haOMgtOQG7bR/falW
	 JMmgUwVjYNJCO92RiF80SetVJJEhNtqtMK6BRgtAmPkT02C9q5BHPsKcqImLGUMJeEixb
	 Qvu7kBFA4qIhVU74OdSrbOblJ4sxHuOv+GiclcyvdrM05WuvPFzSIEC/LKoqzmLgbSesp
	 F2pclGa7hXWEiltYiDHRNuaRfcA6lBICsishGjxIznAubemDz7yLpeIXOlCmNMNfOBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnoGWzlM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE64E606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnoGWzlM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DEF1F00919;
	Fri, 30 Oct 2026 01:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793324669;
	bh=OvSV2HMWa/s1IrAeK2YVLhcVAMU9pwUspa1vCLLae3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jnoGWzlM4+8dMZL+aJVuN94tAy/tfxhMaxC1bgYIXvqXeMclSOD8wl4jKD/KkHixy
	 xnPJThLuxgLzqoT0/7Hgwa12EQISJQ6HcuW7EAbsVbirE0iLJSjKkkTiHCf7H57dkn
	 qy/tFpJ6l2jK0mcF1MFdrkRfGA0ScP+LvKmg8S7OG0/A8xieA5aU2XV6zROuh6dXqy
	 cY9H3dQSo+bcT7TU1jPwlnUJLgHIP2QTHUnTun/p400hZX9CAs7jEguJE123Sk1pQ/
	 /T/5Cbep6yZGoWf0trRX4YM/yvroQuRgg7PkmVwb8dEuv1oTwUi1T6LOyZbVOokzEs
	 DcBQGukEizH1w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 5/5] selftests: mptcp: sockopt: check app_limited
Date: Fri, 30 Oct 2026 09:44:17 +0800
Message-ID: <3067cbb56400f1c1c7d372b17e82c1fd61d3e102.1793324316.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793324316.git.tanggeliang@kylinos.cn>
References: <cover.1793324316.git.tanggeliang@kylinos.cn>
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
index b8158a1198eb..f7a45b93cbe0 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -635,6 +635,11 @@ static void connect_one_server(int fd, int pipefd)
 	do_getsockopts(&s, fd, total, total);
 
 	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+
+	/* app-limited accounting requires a recent kernel */
+	if (expect_all_features())
+		assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1);
+
 	close(fd);
 }
 
-- 
2.55.0

