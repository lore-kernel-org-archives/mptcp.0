Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474AD143C61
	for <mptcp@lists.linux.dev>; Thu, 17 Jul 2025 01:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716240; cv=none; b=T2l53JKqwoZxgw+413N9IZgXcGCYrq1hX83p/wX0kgren7xpugByz01OGcNaYKKsOPslARZ0nexwEOOT7vvBy7/6aKpvi6KAaqZArRqRaD4TQyGAj0XNcBsMBT2n0srNsS70NRMsoe6TurpPA36LIx07T6eER+wbTrTY+jYMjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716240; c=relaxed/simple;
	bh=ORaZm1yS5bPd+jdPZPwgEd8RCEzbv3GibCaEN/DyA54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qu8MUoAcMFLtP9ifbujzVLyKp7UWxTTF68mhDXzZ2kzrwKzSG0eF51JjNTmCP1y6utNLlQYAuYysAOgxKtysSEPEe5uryqGqyNbGzoRHCWAawabWGaAzQW2Mdexn7wW8zMwodJVLRZ23qzs3LPFKo2SEOAb+p3s6Qa27peR1jtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBNG/Rua; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBNG/Rua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7F9C4CEE7;
	Thu, 17 Jul 2025 01:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752716238;
	bh=ORaZm1yS5bPd+jdPZPwgEd8RCEzbv3GibCaEN/DyA54=;
	h=From:To:Cc:Subject:Date:From;
	b=JBNG/RuaGOXf7f7Qj50m1VTAwbiotmr5KHcO4NwtZeElvlK5kh5VYwyZn4+HCLWDd
	 cktPFN2/zw2K73bo1H1B8qCMHJxtgn2YRwm0uzZBMhurkvAt+WA8j11qeR9WVB4Ft5
	 MgNLNg21wHIPcpq7aT0vo+rlKyGMVTWJmE0tty1q3OfztZCEX2Yc8W13QDR8mcOnME
	 d20IeLpjqKsL7jWRm6O1RSRuUIOJd31NJIsrQsVs6lk+4weE1xM2pm0MpJwnz3TPb+
	 N0BPPCluDeKhoei98z9Iz+iltLXfWhQ75U0fQF//A9BiByh7m0mAPOocBibzzWlpXj
	 CyGJ+xOvIb+nw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "tcp: add tcp_sock_set_maxseg"
Date: Thu, 17 Jul 2025 09:37:08 +0800
Message-ID: <a1dd4d6e5774b37769645f1b415b2e843822e2b4.1752716203.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Set the return value of tcp_sock_set_maxseg() to err.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5aafe569d4d0..c8f31be4dfa9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3896,7 +3896,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	switch (optname) {
 	case TCP_MAXSEG:
-		tcp_sock_set_maxseg(sk, val);
+		err = tcp_sock_set_maxseg(sk, val);
 		break;
 
 	case TCP_NODELAY:
-- 
2.48.1

