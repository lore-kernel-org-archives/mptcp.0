Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7954D8B7
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318047; cv=none; b=BuOi3Raf258j/gpMI2LdScS6XfGtn0qdJm9sP53KMo+ErpuRoMZJkwRgoimkQSyj0lVf59fACqfc/9SFsovr2jzuRyoA9xrEJZ70K3xK/rAGUHg72+YBhA+jdWI6XZS8Wd4DUbzZ7dCupsUKqsBxBvfIgd6oJsge6nZf/JbN2t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318047; c=relaxed/simple;
	bh=el4qRlSZNNEra5/72bcgxC16DUkc+vjJu9h9eGeb9RA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jJp7JDGqfhPtyJqovk/WH1PDLPx4IMFXFpczw3p9WeAuYS4KpdVoR3JWofRBUsvZHBRW8J/jJOtJZ4ynMtqcgre928hTFk3WHwhErQQEOGblRFM2VEONazrlrCLKNWgv8D6FoxMZAkuYcMsd8K44T7Q47g2b2nJ22BPduoSLYhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/5jKuzV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/5jKuzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915C8C4AF09;
	Thu, 18 Jul 2024 15:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721318047;
	bh=el4qRlSZNNEra5/72bcgxC16DUkc+vjJu9h9eGeb9RA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s/5jKuzVlw1tepxtZxKXHyn9KlAdTKCQ25nzFZ8Bwl1jorycNYMctE5RDH2O5fns2
	 2wuGjOQW2EnUHd7V9IoFBA61jSwivUgv5fBEt06NC+sNFfKTkIFBNUxQlG1mWzNz1Y
	 fi8owYU6yRoel80nJloeOzsL3u0Key3cGSmdnakbWdGJRSRnyU7eA51gb/p0uyieMW
	 7atWQ3fmdWvcwKRLzqhQs09kgBX2fwf6EKEn15P+bcmTMnjep2KenoXoaXSmjUsSpH
	 MXGzCY1E8rY6qFbO7wFmz5KrTRmgsX6RCytGOLL83Mc3K5pnp99NRh5NZoZ9IpgYn4
	 9bM0vSMaVZ7Wg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jul 2024 17:54:00 +0200
Subject: [PATCH mptcp-net v3 3/9] mptcp: pm: only set request_bkup flag
 when sending MP_PRIO
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-mptcp-backup-mpj-v3-3-1f6cd9b89ee4@kernel.org>
References: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
In-Reply-To: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=el4qRlSZNNEra5/72bcgxC16DUkc+vjJu9h9eGeb9RA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmTqb7uX/aOctNxO7LKqqhq5lDaF99T3g8SWgF
 fr0fzosfruJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpk6mwAKCRD2t4JPQmmg
 c9L7D/9eG6ioEdmEYEdRnq+6ei2riU7hdeXQ1o1qIiLtrsunnq5M8p5r5y7YAXTlC5Sf5BXrzoL
 I+qoxrtX5o75yieHU0kf3sfmMfzxKk4aL5DUBwT4HPVIoPzOGGnC0CLkNmoN6NuQK/J880uPidH
 3cHw5GfI+VTMjl0VK5kyMHVXwouWmhYB8iZVnlU7V/KSB23u/QqBpMlGGahMVFt32vwEuYTsp20
 QfwWJS71L5Qyfw7iEBdCw/GV1Dkid0vXQrWlEgQcl3tM86ghF0gRDrGb7BfeO4/H3mCuEqLKGx5
 Xb0uYQOTvP9SAio35JsJSFv60W2NcwkmcRjadSo7sXN7DG30zVrU3KBP1tRMTJUzeMIaDMH+CaU
 k2209XPVWaeZ2lmhc3r+jc5RkKbVGLH5rwDSOF4e/qScr42eTXrwixmMhH80k9i6F0UlkuqzBHv
 N0a/SmfpPomnhrofCRkEiLjYz1CwUgluYMKRljPt0A2goKjbUJZ9GF8uCYqjiYE2Np4VSS0LF7c
 FmxsFLYRlTgf8DlT5dSpG6PXNcW8513O0fy0TKbuzT2MdH1kA3DTkdcX1OX2au5fRqyysNErnw4
 1kabDOAE01xZz/d6v+F9TAUZ3zVZ8W4jK9IKiW4/QLjVQbvHaDR+0Wuw65v+qNWQq39P5Q0r+oy
 qUXec0au9+/JpuA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'backup' flag from mptcp_subflow_context structure is supposed to be
set only when the other peer flagged a subflow as backup, not the
opposite.

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f65831de5c1a..7635fac91539 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -471,7 +471,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 	slow = lock_sock_fast(ssk);
 	if (prio) {
 		subflow->send_mp_prio = 1;
-		subflow->backup = backup;
 		subflow->request_bkup = backup;
 	}
 

-- 
2.45.2

