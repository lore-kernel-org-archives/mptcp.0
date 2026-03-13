Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926973093CB
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 01:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366211; cv=none; b=O5rlou012/Z5Fn5nhcmq5sug2ubfW3GYNqOpvsGVa+yhpbbx1A0jjZvt4vvteD49Z1YuFnDDkO0VfoglXAQZJxoPP6S6Aim+t4YpzT1jWCdICYyolJHrGuzpdxwxo2cFcLNRKnwQr7J7Umcp58QjKGa+36gLvgEFrXcAhaE5oTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366211; c=relaxed/simple;
	bh=vHXNBO8jXZDa1sFTamr2m/WIvPLuUs0l79eTwuIhZiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0Ad4ypxKSWORz1VOrgLwL/9SIwSt+hadaQonT9+Sll+DnR5F6PTteFpTYOsC1N/REOYXy5tA6S1NRYlkSVBid/t6b82rt1Jr9RvKUwYn8z3LozyW0dlIMnE7UjYB7LPhRspMhfeBC6G382Wn1DNxUBqO9rc8d0Gdlbk7p9S1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiY0RpTg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiY0RpTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE34C4CEF7;
	Fri, 13 Mar 2026 01:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773366211;
	bh=vHXNBO8jXZDa1sFTamr2m/WIvPLuUs0l79eTwuIhZiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PiY0RpTg6rSOXyfyojWYxl8OkI1ukfn7vjHO/ZECvK/LL66ys2fMkiXHEHN+kjqrW
	 VlzY6bG6OC1yPNQ8+de/uIia8fz48j+NAtfQ7xWAXqXWKlwh+Ctl4RZ8TS1erfHJ85
	 OrcPBrb13SDOE/JmebIAJ0bp5Y4K3MxX19z06LsqQOUA/IEVZvg/Ux73EO5hkaxq24
	 YbUYz1qvy/agWGMOW466I2492vGiAHIacp0AcE13Rzn0TUYvm7xmii5xVVk1M/RMQz
	 XwsV/zV4cCup0iVYGNcADx+EkzaA6L/xa8tkhzO8pX7O35PiTLw/OY3PK4ILqGcK+G
	 +e1jJuxd+bpAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Dust Li <dust.li@linux.alibaba.com>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v9 09/10] selftests: mptcp: connect: set smc instead of tls
Date: Fri, 13 Mar 2026 09:42:51 +0800
Message-ID: <d146e42dfe374cf28164726f6afd4b0b0ee12b6e.1773365606.git.tanggeliang@kylinos.cn>
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

From: Geliang Tang <tanggeliang@kylinos.cn>

With KTLS being implemented, "tls" should no longer be used in
sock_test_tcpulp(), it breaks mptcp_connect.sh tests. Another ULP
name, "smc", is set instead in this patch.

Cc: Dust Li <dust.li@linux.alibaba.com>
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
index cbe573c4ab3a..64c8a4bfe749 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -289,7 +289,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 		if (ret == 0)
 			X("setsockopt");
 	} else if (proto == IPPROTO_MPTCP) {
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "smc");
 		if (ret != -1)
 			X("setsockopt");
 	}
-- 
2.53.0

