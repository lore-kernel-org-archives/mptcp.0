Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B5A38551B
	for <mptcp@lists.linux.dev>; Thu, 19 Mar 2026 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914956; cv=none; b=JxcD4nuiOfftDgFzvKD36Vh7i3SLFhjIJtL3a/sApe7mU7885sMURLiPUUbDbAH8SqV6cAdh+naMJfV3rrtdA8vTx4vHvSvuJKBb1nGHZemFR/GU2JxQr+Ebo47v2xBtWcfdDpazs0qC/4IjzjZv0TprgOfI9jIw8IcgQ9Vi+rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914956; c=relaxed/simple;
	bh=/LebqvnknnL06basaKBFF0yShgEpaL6raWlnbLgcSj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWknMqSUbD1++HXm7lqnHp4IyrjwDI+KYjz1AtXjppf26wPOQ2pRBLeygZ6r72lgvhRVeluneFjZAVMwSOvIYwq/7ToO50DGEpUgUeDJzZzwgfb+1+kbA9mtTib2ue7N7vuH05vOq9bzfVp3aCvQxVzDyZsccb8GlFOpZvRa9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQZvenFc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQZvenFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E677C19424;
	Thu, 19 Mar 2026 10:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773914955;
	bh=/LebqvnknnL06basaKBFF0yShgEpaL6raWlnbLgcSj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQZvenFcDuvRgPWba21NEEcXAvVlEhHwUATrmKItUmMjTGfqHQ2OvbioW5X63EAs7
	 bDIERp49mNxff02L9biC9+YzAZ+3l/gUj7V5viuRJl4yXZdBmB5WTHPKfrjCCSUSot
	 lQzh8qLRKF75up0fjZ0e3AQXnW6ZOYiR9kk5tu5BaKeTLI9wTUmjzyLLeAUz1BDUzf
	 IWqv7YqOB6+5k7WSKxvwnMi1NaibvQEpcv7/inOHIg/3Ty/H8D6/HmAsPUioBuS+1Z
	 kWMmr+WBESdMrl7g28jNzxXWZhhTxKuyQjwBH2DOmg4Twf1xxH7E3yA6q+mmEhfSyP
	 jGYm9lgV8yRmA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v11 10/15] selftests: mptcp: connect: use espintcp for ULP test
Date: Thu, 19 Mar 2026 18:08:43 +0800
Message-ID: <84a5532ce60d1ddbc9204f3a36d1d21ed1e70f7b.1773911536.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773911536.git.tanggeliang@kylinos.cn>
References: <cover.1773911536.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

With KTLS being implemented, "tls" should no longer be used in
sock_test_tcpulp(), it breaks mptcp_connect.sh tests. Another ULP
name, "espintcp", is set instead in this patch.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config          | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 59051ee2a986..18bd29ac5b24 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,4 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+CONFIG_TLS=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index cbe573c4ab3a..0d4a944c4269 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -289,7 +289,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 		if (ret == 0)
 			X("setsockopt");
 	} else if (proto == IPPROTO_MPTCP) {
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "espintcp");
 		if (ret != -1)
 			X("setsockopt");
 	}
-- 
2.53.0

