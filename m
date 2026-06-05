Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39E37AA7A
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622667; cv=none; b=caju2ew2hmXIHFHO4DtzV9oTTDes6Q5zUnRCae6m7kwejjaCi4NIkTIIMd877aNzIHT9sez5dLbyjcQ8ASS6PuKrZVVkk2TV5Y0QSXuvhnieJsRigEfa1z16eOgVHRwJAh51f7OXQiarzAuEEvPZW0dHBQpxwAw6XDu4Y2j8T1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622667; c=relaxed/simple;
	bh=3gl0K9I5PyXXoykIdu26iq4G+91su8cvRW6scifbKT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhoVcbRuoG4Iuir3QGXd3muiEB41dkERqW7F9v30o0vWjMuA/sKm5xxLxJgCsLgg/Tn2Eo7EMsWGiL6b811q06vJowf0L8HD1ltYBo3TfsUZ5/Yc2rPk+VjgnEI3KxttXtSxiAmiL+w8G/fV62pXz3N1r3pkgracyDP22neYDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtlTDz3X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtlTDz3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B1D1F00899;
	Fri,  5 Jun 2026 01:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622662;
	bh=i1r228t++8Jx2HzWD9Lh3NCKCbWjqFm66UQqWx4jVMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dtlTDz3XDs5WB9aZXhhg28bIQVmj/9JuisiAN9dvDqr4MIJ/Sa2x4gRYiz/zztfmr
	 XafZMAJcBkdxoQa8SpZOQu+gXYwswPPLBumFS3WrQWQaEIHFr7WiKoSwxwerI8cHlL
	 B66vz4ZNOHOhW3g/8tOoVzBVZ8/c2t0bURn4cj8eA66wL+di0lCoQFikBvO8ySBO2o
	 CYA2FPt0mActQg18JzoJ6DvKSep8s2achw96f5jCa2k4Kx8puRIEmGnBV823nBX8Uv
	 gTA9vjQ99IxWnQi9zHW//4a4PETimb8to2cWPDmV3mCd0K+2Q8vy6rCa6Zs8M5fkkD
	 /W7lNMRuMpUaw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	yangang@kylinos.cn,
	qiang.zhang@linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v24 11/18] selftests: mptcp: connect: use espintcp for ulp test
Date: Fri,  5 Jun 2026 09:22:51 +0800
Message-ID: <f0ef787c57d5917b8baf1bf6a6896de8dea28152.1780621326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780621326.git.tanggeliang@kylinos.cn>
References: <cover.1780621326.git.tanggeliang@kylinos.cn>
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

