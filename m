Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB7C42642D
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505017; cv=none; b=neIFnEBbwUsENfC6tI8HRb8OTVY81/VYrWCzF36r+DqpDAGirNYPPzsKGLFMhvNAmeZNDWwOyDNv1Hgp3rBh7ljb3rntL3BiLDvSUF7EDJvnhH5NSgLEmMAffhz8KTlvqOOzYP2I2pwXUh6LFJHKdvNoXmjorLvJ8VPgpCFTFhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505017; c=relaxed/simple;
	bh=Q8LI2wLClKWgMdcNNGOaC0V0Mu1v6FgmHKgz2+Jc7GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LiazsgAmp+pgseKgiE2Qojr2s9AUR6AsdiS91FuHF6mWE9Je8jLYSqoJh5wqpoBwSd1eY5QPVoyhK6/Bj3SsHbRt9i0AbI7z6ai3fZW+EvJnyth572Rf7KZwP1UGFC2UlrFiIYnxnet2mLXX5FgEZaDhqPfxE3OplXDriKWGF7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVohs6oa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVohs6oa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B3F1F00A3E;
	Fri, 31 Jul 2026 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505010;
	bh=BQce/aYFDIi/uehmDusbV6BuB7vBsnRhRNQdFsfExog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EVohs6oaLALIzoNi6DzGZq7JUflBiEOwXjZ4t0bECYpZbKZ7W+QdOJ6bXFitGxpO7
	 pY6APxHM0iaPNv4IFJoormunMjBxcZnW9GGzCNEfFu1jhymWPXsIbRNVP+rWzD2hjF
	 NUufsuVa3Pz04GWvdJ5mophsaB5grL8Tq8ewvYdS36J+IEuKaD2dtCyPzVjm36NzvH
	 OUK6UEXh839fX6shW8ut09yDunl/PqXHgmVsnIiHSiud3GzMcaB259Y1sNiuJ/srJN
	 7FQo/2RPu1ayVyTbDA+oLQBuHEoj4eSqhj5hyy+a6mBBOvtY/Beisb4x/bcwZDwHvQ
	 /pjAaQUsjcMhw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 31 Jul 2026 15:35:37 +0200
Subject: [PATCH mptcp-net 3/4] mptcp: options: reset DSS fields in case of
 unexpected size
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-mptcp-squash-fix-7-2rc6-v1-3-cfe460beb666@kernel.org>
References: <20260731-mptcp-squash-fix-7-2rc6-v1-0-cfe460beb666@kernel.org>
In-Reply-To: <20260731-mptcp-squash-fix-7-2rc6-v1-0-cfe460beb666@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Q8LI2wLClKWgMdcNNGOaC0V0Mu1v6FgmHKgz2+Jc7GU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJylrxjY7lZuPeA2+VpfYxVgtNvxLY8lpMLjbta7PL9h
 UR0pgJfRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETUjjP84XkkHvCkh2X2nVmL
 3npxPNSQdV3rOj3SIGb1wvN6ktLLAhkZdqmmns4zF/IsLVL0EytZY/ZMYXV50o/SGItwTWfRuCI
 OAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A remote peer could send a malformed DSS with a wrong size, followed by
another DSS or MPC + Data. In this case, the first suboption will be
ignored, but leaving some fields written, which could lead to
inconsistency or access uninitialized data.

Explicitly reset the fields that could have been modified in case of
unexpected size.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d%40kernel.org?part=1
Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5611de38f4d9..dd75fef7f046 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -209,8 +209,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		 * RFC 8684 Section 3.3.0 checks later in subflow_data_ready
 		 */
 		if (opsize != expected_opsize &&
-		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
+		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
+			mp_opt->dsn64 = 0;
+			mp_opt->use_map = 0;
+			mp_opt->ack64 = 0;
+			mp_opt->use_ack = 0;
+			mp_opt->data_fin = 0;
 			break;
+		}
 
 		mp_opt->suboptions |= OPTION_MPTCP_DSS;
 		if (mp_opt->use_ack) {

-- 
2.53.0

