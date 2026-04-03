Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503FB37BE78
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775216111; cv=none; b=tu4iiXCzP1QJq2lr4yE6XpQ6+HYpu3rRminMwuVOL7ukkfQEImWJVVDyHx3fkapufC7HBtY1huQdbwuGNlUGExVZg7Guh854WmEq9kaPkIzCwAmA/takOZYkoXstGfkNjfYO5+1jCjLUU+uXzcvAadgDp0FYjT9H9T1/jSznReo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775216111; c=relaxed/simple;
	bh=YEjbBudhBe6fi99pfDoh/3Oq3yJDtnzXOxa+jP8FJEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WbfYt2orCi1K5zh2OC1Sg/Vauxp6zFOzbunMkByWjoJ60qq2jeez0z+/63VUtLK3v1gQjBdqWI34VBq5OgluOudXYI0TiKpU1ZpGuGszT7POMApNy2B5x+NAY7lDZ9huyouFIgkp7A7CDsXvXK27aKwf/q0yoXE3Fz/4apzVDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGAI9br4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGAI9br4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89EBC19423;
	Fri,  3 Apr 2026 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775216111;
	bh=YEjbBudhBe6fi99pfDoh/3Oq3yJDtnzXOxa+jP8FJEk=;
	h=From:Date:Subject:To:Cc:From;
	b=HGAI9br4GA9sgEtfmxARuNSVhuSwx5iYgWQHpD3LbozDMwBLJFdXM26uIkzjs39br
	 JPzLEhNplZMU27UU3rMIEwenhR5SISKxdaDxE0WYMqppFUic7UV7nPqmUT7+FikUaB
	 UzGWKvD3Mkgw3jg2Fd+fRUXrD5aR5vwj+X43HH0HCuTNn6qYr6AhoZk+ntulgpLDOX
	 UsKR5gol1G7+1hOrvtiBtUUF4eoH9+4BRiV/LWN0vdetPo5bomityXsvJw1lpa8Rcy
	 dvp+3o8+Q7jbBbG6CGWB1dLUZVCKln7iaJdi0ID5wGKMJysk/8hSMDHt9bkFDK2rn+
	 hHLmOS+Veimcg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 03 Apr 2026 13:34:55 +0200
Subject: [PATCH mptcp-next] Squash to "mptcp: better mptcp-level RTT
 estimator"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-mptcp-fix-better-mptcp-level-rtt-estimator-v1-1-b22152ecd69d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NwQrCMBBEf6Xs2YU0LRH8FfHQJKuutGnYrKVQ+
 u9G63FmePM2KCRMBS7NBkILF55TDe2pgfAc0oOQY81gjXWmNx1OWUPGO6/oSZXkX4y00IiiilS
 Up0FnQe+6aIM/99G1UA+zUOV+siscWKJV4XZs5e1fFPRrg33/ALoDo8maAAAA
X-Change-ID: 20260403-mptcp-fix-better-mptcp-level-rtt-estimator-b63d2cb74d61
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YEjbBudhBe6fi99pfDoh/3Oq3yJDtnzXOxa+jP8FJEk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLPL303y1Bx6bc5awuO7I7/oHKwOrHoxNSDGc/Ypr7LD
 olMX7Zhd0cpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEZlUz/LNY7PdxX5Gs4PMP
 xz9En8oLylg3307qiGvW39TWQNt5BqcZGWY3L5wh+Yo3+2Lf/r1u25vEk+fHXG87ax5Sl1Cbv2M
 mLwsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Address AI reviews:

- samples[0] is read without READ_ONCE, while the others are.

- prev_rtt_us is added but not used.

Link: https://lore.kernel.org/20260311024547.361027-1-kuba@kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 740f9d975719..98902ec4796d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -449,7 +449,7 @@ static inline void mptcp_init_rtt_est(struct mptcp_sock *msk)
 
 static inline u32 mptcp_rtt_us_est(const struct mptcp_sock *msk)
 {
-	u32 rtt_us = msk->rcv_rtt_est.samples[0];
+	u32 rtt_us = READ_ONCE(msk->rcv_rtt_est.samples[0]);
 	int i;
 
 	/* Lockless access of collected samples. */
@@ -559,7 +559,6 @@ struct mptcp_subflow_context {
 	u32	map_data_len;
 	__wsum	map_data_csum;
 	u32	map_csum_len;
-	u32	prev_rtt_us;
 	u32	prev_rtt_seq;
 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
 		request_join : 1,   /* send MP_JOIN */

---
base-commit: 7f76791a2c6b61a0e074bd908e731418ebc2ab5a
change-id: 20260403-mptcp-fix-better-mptcp-level-rtt-estimator-b63d2cb74d61

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

