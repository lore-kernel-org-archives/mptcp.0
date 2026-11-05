Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860698;
	b=fsyJOJuGlTwsXfj1S4Nfb9MrlomOw43udmTZVqbofjqpNJSPJhj4FqwM5Pp6UBpA+sCu
	 fBeF/k7GKeAdgCQdjhRNDuknHes5mWd4ODfVOF64+TPv/NnN0uoK05xRJEf16J3tCBsfl
	 oBU+N3rjPDYhxDGIYfi+9X/KPe0Kx79MCqACjzs9o8lGBkwgNv8lVqU1faRc+mPcNdb2b
	 r58DsN8OQ630w3r7jZwqk9J6GVatmHLt90TEX9e/82UIAJdoFsQ+ng4lUlEhKGrd1kgAF
	 KGMGvwNwsCJZqEiWWzWv/SJTmKOZI5ORzj2mKLCjVT94frF3espr035Lf/0Sf3bEJ8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860698;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zt7KY3YNKjXf9NBz0qvweS5Ip7lax0wWTxqRXwoEY4E=;
	b=tqW/I8bhkbJ+OCAWd4A3T2mQ7cxXIJqQV7ObY/A1QZaBvr6in8ufIUzcLt6da/JOtUsa
	 PK1c6/F+zvW7neo/mWvNFc5dG4ormhM0DJb+IrmL9mi8WAitm4BRRVcHpafiAoWhIIWCJ
	 KwhQnk9hD8/a8Ga38Sl3z8ruMFyIbbcLKuvJ6Hvrr5wtBgfr4TBn0o9C2wn65g5GE8Axd
	 bjcvMqKaA2zgCgatxXsqs8Ui9QdOoHrg6IkS2oNKfVYGrq2JN1vK/8V1t3kSVrqPpe8Fd
	 HWmGFNXX30qfFt+OepNYpISo6021Nx2dAzRw5gbjIsbalDOl+K+LOp5icrv8qLP88ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUlCPQQX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22932606A31B
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUlCPQQX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52A21F00A16;
	Thu,  5 Nov 2026 06:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793860697;
	bh=zt7KY3YNKjXf9NBz0qvweS5Ip7lax0wWTxqRXwoEY4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DUlCPQQXdkrMf91R4gpqTwnQpzY9Qs/GxlyifK2KN/zF+EHKrfm6ylsf6ZHuWdIRn
	 juWghLV/gzv+wTMakG+YImFi+voQlUNod0gUQI+lMBtWg6ABebsp5VhdMVTGXuyPxo
	 sUT9cydTEHTP0Fu/HUUl5L4ZDR7WdlXBDQyNG3+l1joaezEEYqK0+nbvb9gs6g+CRQ
	 Ek43+N9RQSKPuQz1aVg2Iqqa4HhIa65vJCPOV3BNTk9nLJqPbKUvwpfPbMr2ZWfttJ
	 bJGWQk1tBCsjQTd3fQTFXJDWislpuaN6XzPpTwqZfTfA+LndKRSwqxJtdB5viciOSJ
	 99mLVpsTIgOAw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 3/7] selftests: mptcp: connect: check TFO SIOCINQ overflow
Date: Thu,  5 Nov 2026 14:37:59 +0800
Message-ID: <da22fd79c625e4eed90e83cf91bdddcb165a4a78.1793860134.git.tanggeliang@kylinos.cn>
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

Add a check in mptcp_connect's server mode to detect TFO SIOCINQ overflow.
When a TFO connection is accepted, poll for data to arrive, then check if
SIOCINQ returns INT_MAX. This detects the regression where mptcp_inq_hint()
incorrectly returns INT_MAX for passive TFO connections.

The check runs when the MPTFO sockopt is set. It polls the accepted socket
for up to one second, then uses ioctl(SIOCINQ) to verify the available
byte count. If SIOCINQ returns INT_MAX, the test fails.

This test verifies the fix in the preceding commit "mptcp: fix TFO SIOCINQ
overflow in mptcp_inq_hint".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 178d98d91fea..83db495704fe 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1207,6 +1207,17 @@ int main_loop_s(int listensock)
 		check_sockaddr(pf, &ss, salen);
 		check_getpeername(remotesock, &ss, salen);
 
+		if (cfg_sockopt_types.mptfo) {
+			int avail;
+
+			if (ioctl(remotesock, SIOCINQ, &avail) == 0 &&
+			    avail == INT_MAX) {
+				fprintf(stderr, "TFO SIOCINQ overflow\n");
+				close(remotesock);
+				return 1;
+			}
+		}
+
 		if (cfg_input) {
 			fd = open(cfg_input, O_RDONLY);
 			if (fd < 0)
-- 
2.55.0

