Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDBE42A794
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172937; cv=none; b=C4iLBDOnz9govvaLd0DjxnXDouitCPHB4hzByG0bvPMgQ5BqLlKJjsFBcLr5qQKiNWG4MXXJPVmB31N/sgZ4gI6B8OkaTRK/19hJDTNlWQlnQslqZn9gDHxfsJ2IBf7CuQTENkgf3HZTMDOMg5ApP23Xwg+RpVYkkFv8QE72ibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172937; c=relaxed/simple;
	bh=yP1BRNA6woQo0BMxYA3BzemPE5NDI2dk/Rk8Rvh/5YI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ru6ntxsj2XtbnHpswaMp2DBjcMqN80erLj8hzOYeqzhwtm+MmgmTKj2Rth9O0qIAdfBV2oH7jMWouP2XDKjnS1ruTyzjHXa7mxaP8uPANTrkjUQxWQYtByIGke0ddlTIVEe4ncPAoSTLBCbDv8nUXP5rsxVDqUJ3ic5LIYSmVJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC6xG4kq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC6xG4kq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4841F00A3D;
	Mon, 27 Jul 2026 17:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785172933;
	bh=KsEfpexFrZyJ/BampPNQ0ApRejnp0RM4eQ6JM2jOhPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AC6xG4kqterJ7MBVxQ5PEc8DH8oOyB/38RxIcSKEMImtqnLoYwdQXSrd3AwMaVkma
	 HSAxUCU5VSOrBeO5vD8dlgK5iaDeGMfupRugfxUs92C/uw3+ozWHqi63J9KAvk6ZYx
	 Na5d6ms1TisB+aFoUz3wJj6fm1ugZUo89pO4aOPnvqGVkkJ3uRnUcvGeDG1YqHwnN2
	 VVmKevk+iATsd7HIYgLtR5dK13wyKy9ZUy42v/22tMxUJr4h6dsAVSZXC1bHgLvJ1+
	 lr5KjdGlmHMmzz7S9ybSjcB7a2wgKRl6Cy22e+aQbZ+GGUb9yoB3DqrFZPSqaH+Ol5
	 kdLzM670t3zVg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 Jul 2026 19:21:53 +0200
Subject: [PATCH mptcp-net 4/6] mptcp: pm: userspace: don't dump initial ID0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mptcp-pm-userspace-id0-case-v1-4-9877f02a9bae@kernel.org>
References: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
In-Reply-To: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yP1BRNA6woQo0BMxYA3BzemPE5NDI2dk/Rk8Rvh/5YI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLSJ+/xc4qz0S4043kolWv+XCI070edwKlFfZc9OAQmv
 WpvcE/pKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmIiAOyPDi9vFUXNOK977/3bv
 bgO/hA8Jn9xM2nndrs65VmnrLd2eyPC/nNmm/sv/RdKr465NrD6mf9mu25zN9nhrxpqgxNTbt29
 xAwA=
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
 net/mptcp/pm_userspace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9c7fab6a59bf..c4d5161eefa7 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -609,7 +609,9 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_for_each_userspace_pm_addr(msk, entry) {
-		if (test_bit(entry->addr.id, bitmap->map))
+		/* Ignore default ID0 & already sent */
+		if ((entry->addr.id == 0 && entry->flags == 0) ||
+		    test_bit(entry->addr.id, bitmap->map))
 			continue;
 
 		if (mptcp_pm_genl_fill_addr(msg, cb, entry) < 0)

-- 
2.53.0

