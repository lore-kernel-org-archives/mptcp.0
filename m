Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66530E0F5
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367607; cv=none; b=EEYfFJbRhqftNGbzYFwHXJ4crrUV64QFwN2KAro28Bbujxka+651J0JODwDIfPs9W+qABsIk8Yj+yaGxf20h7A6dzJ4HCRrSzwpig25TXi0VgZDS5mYIqfeIu0XaaT7f9USeOBVzofHIurtpNbaqFRwbsxd8Mk6LqLC0d3/7iRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367607; c=relaxed/simple;
	bh=3gl0K9I5PyXXoykIdu26iq4G+91su8cvRW6scifbKT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt7V/cFE1isLC3GIxtd0NmhcVGVKqU6M5Zva8H8BJ6EpvbEEQUH/IHTfvNOP2MWAfhAo8SLtLjHc28WxjKD7/YKXfkhlu3I7YB1kDP7RogEsndZeOpWY3Rj8JXWjYVQ1jc96ZXaDSVPB7gOSXTojVLgZ3boMHmcHohg1C8mpwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLcGdTXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLcGdTXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4233E1F00898;
	Tue,  2 Jun 2026 02:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367606;
	bh=i1r228t++8Jx2HzWD9Lh3NCKCbWjqFm66UQqWx4jVMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jLcGdTXbNJGSPx5PwiFZFYCcVW9X2N7bwPu/I4Lokl7yzDUBsRniwS3yLGGqRTGMj
	 uOAid+690G+l6I9soUjwtA6Q/XEE1b9T9JUoT4jGSsOQfNXYh2aUFF8E0JO93ZUS3X
	 q157fKn4IszpFs1oL/bGll4ZeMj8uDdUIvWHLTeUS5NT32iLvAOkETdNOfA74wRxjY
	 QYY3Ir66T97cDBjAqNE0vmUI1xidFIpdS8Jb2kZR5jpC2WOkTWySTPaCQMuAiM1sh+
	 bFqxS00dqBPXio43Dxju7O3P49phMnuXoMSQX0fm7LAcU6gES33G9zPtMsw2ttGr5S
	 IYmQGy7iS72kg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v23 09/16] selftests: mptcp: connect: use espintcp for ulp test
Date: Tue,  2 Jun 2026 10:32:50 +0800
Message-ID: <9e1f02433c4164fac011b86eb2339322ea41ef9d.1780362942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780362942.git.tanggeliang@kylinos.cn>
References: <cover.1780362942.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/config          | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 59051ee2a986..f48bd5183fb3 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,7 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+CONFIG_INET_ESP=y
+CONFIG_INET_ESPINTCP=y
+CONFIG_INET6_ESP=y
+CONFIG_INET6_ESPINTCP=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index cbe573c4ab3a..299a7a02d6f5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -285,11 +285,11 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 	if (buflen > 0) {
 		if (strcmp(buf, "mptcp") != 0)
 			xerror("unexpected ULP '%s' for proto %d at line %u", buf, proto, line);
-		ret = do_ulp_so(sock, "tls");
+		ret = do_ulp_so(sock, "espintcp");
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

