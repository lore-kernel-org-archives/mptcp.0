Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896441835F
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092129; cv=none; b=GWm1ArSfyD1SBv6C1XKCKGhu66dEZ7WDBV6PAcxJapLmkqt8+4xXpbX/JxtSNcLnnHf461bpqeuPzOh+9DUEwdWxINJ7V3laFN0fIeUons/0T5jYhBWqkqBQnqmRcoZBFJUwm9ctE6qkYx/TAVc7L4zEMN6Q0M/WnEynRSbTnAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092129; c=relaxed/simple;
	bh=TfS1HZredEFp4AK/plqRsUtvZlkrUGAe36gdGMcN4RU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EdDgc9IV4PuoAXHRSXbqzyAdF+rYRAxoDC21YGQ5K4IXbb4xq/hK1HmThcp6RORFO1BcVSRZGAV0Ll0KJAeE/FUO4rY/C/VrI0TOGCxzosroYfB+G3y1bhr//tDqEeZRRGGlptPRptGFr2i98pEyInxvR4lFdy55w4FFL+NF5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gphiS1E9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gphiS1E9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E1F1F00A3D;
	Fri,  7 Aug 2026 08:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092125;
	bh=qCu1uTbhaNhE5xnOrza1p3d/8b/aUWZ/RPDL9++KkQ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gphiS1E9dklkVNXlrlsY2lGUuEYKjrPZwEfhQ1PSTE1i3ru2WktR5hrBm5m1aFVBJ
	 S1egooqvgYnfGOwXtlD5uOdQ7WKCiH26Cxm73AJnmovKwgjSWlqw2OViNMGikp4jGa
	 jKaMvqmcNlI13w5OWBsKnvd0GyNWw8bRJqxKL0mwo8vOud+b4bM79ndb362Nx1cgNG
	 G1iX2N181eHtLkNFeU23ZG3DmKxsbq7i6lpoKttXGvfamBtA7Pa1wbsDZsuHoDDHPe
	 IC5uheja9bIawq6qBwOL39FOgLJ3HcF+lpP2HZffi7jObye9RB2eL7I/Jsnx3uYFtV
	 b8KHDiUiLxuPg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Aug 2026 10:41:53 +0200
Subject: [PATCH mptcp-net v3 6/8] mptcp: pm: userspace: don't dump initial
 ID0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mptcp-pm-userspace-id0-case-v3-6-de9088549924@kernel.org>
References: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
In-Reply-To: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TfS1HZredEFp4AK/plqRsUtvZlkrUGAe36gdGMcN4RU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKZ4V+U9sYlz555q7ZSow1zI8UJZwOtlnsLypfeIW7f
 iJ/mP3fjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIm8ecLwT/nR5QKRXduqGmSn
 CYZ9WXrEdu/9KQfXfduqkfBs6pu/cxYyMhyP3XbA4C1LqPKDQut5gR5HfPLWXLrZ/dGI6XblzPs
 tzbwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After the first patch of this series, the initial ID0 address is present
in the local addr list when the connection has been created. Not to
change the previous behaviour, but also to have a similar behaviour than
what is done with the in-kernel PM, the initial ID0 address is not
dumped with the rest.

If the address is removed, then re-added later with a new subflow, it
can be dumped.

Fixes: 34e74a5cf3b7 ("mptcp: implement mptcp_userspace_pm_dump_addr")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3:
 - use is_init_id0() helper, to check the port and not the flags
   (prev workaround, but doesn't work if modified later)
---
 net/mptcp/pm_userspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 87f044735c59..284d021c6e5e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -633,7 +633,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_for_each_userspace_pm_addr(msk, entry) {
-		if (test_bit(entry->addr.id, bitmap->map))
+		if (is_init_id0(entry) || test_bit(entry->addr.id, bitmap->map))
 			continue;
 
 		if (mptcp_pm_genl_fill_addr(msg, cb, entry) < 0)

-- 
2.53.0

