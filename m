Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E518629E
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038224; cv=none; b=rctM2wQ3XiI/4N2/iJhMHi7fIi0fc3kiYapCfiOz0ArngudNzrWRDDhQCdHrH2u66Ftcp/uFScDCPG/fCHvnQ7Tz04hwuMDWx1TfFaQiIlgkcvUE2CzoTB0QdhPujkO1yZJ4EU6yfbG9lbEqbOoMWk7lB9rqJyqQNR8SlHutcQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038224; c=relaxed/simple;
	bh=L3MZt5Jtty3KaeLdgFEkH4d1+wvGLCJaiHMqUpEzJJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kh4KbX027+ao2/jDfc44lwcyfi6MNQcHDtSvWIRYPZdEPK/v/CHxjW7YWc3k71W6vBKMcKSRxT+U5ySrqS/1ZD87TbxTfHkligfA+OQAO7ONcAyk+G0bJP1hR0XSuMfNn+0bmMQYLaP9PR6mKEzE3YEoJFtRyROTXnb3lNy7LeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJi/vs7j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJi/vs7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D61C4AF0A;
	Mon, 15 Jul 2024 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038224;
	bh=L3MZt5Jtty3KaeLdgFEkH4d1+wvGLCJaiHMqUpEzJJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qJi/vs7jomnmmCGWtbe3VEov9hP/+zWi18IWLgNWemaYYeIu+gv85p8OZFaLvJGqQ
	 R2cUaD7QSUoUAuYgZTKliGoY0APEPbnduQKqz6ZyEKzYYNnrjZGkD6uIR8B7HszVit
	 TrobjdtF+J2r9Yrs5m5eV9PmoWeKtYkh3lRl/vctNc526qecJkynS3nukCkuYxUOwE
	 Fjuj22mnWPMIU4+6sFgeS6df5/ur0rpVJ6JfJ0Ik8CUVz0QSth+hMvE/dHN8aEwgEM
	 kshiiv6WQ5b4oiAq27ffIYdbcCE1FIMvz1V3uMXFU6eWCJtanjJK/ryoIElXFBgYYq
	 aHpffOgq2ld2w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:55 +0200
Subject: [PATCH mptcp-net v2 17/17] mptcp: pm: check add_addr_accept_max
 before accepting new ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-17-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=L3MZt5Jtty3KaeLdgFEkH4d1+wvGLCJaiHMqUpEzJJE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV35HI611pYLR4FBId8jfpK1VY+RJbuXffxN
 SPP2nbOwOeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 c5yyD/oC0sLhCzczR5g82J7B06EE45chAZ72hM/9poogTdRy6h1m5/Du7Dpe/iholnn+IjLN4vM
 6ZmOYxNCmYtiylIXcX/16JbbuN41aEF1IZBp8LVQ3uWNntXzyI7DOCBM13rNAZ/GLRVz/Nz/hN5
 RxYoHi8WNhiDEkSFi0fxfveq+9Uw1C8p21AjLAVXKLW+oUwq+dsgCw5mU7mOE+nJGIXJkWhlDeV
 lKoIx1L/gNhyR/+tgOWCBspBX7RaIh3hEbwyZ9iN6lS5ICUKSF1GNwjVF4I9tQ1BIO9hwrzAJ6o
 nn/sH6tLl6bnPXdsKyecWmfq4mzV55SflVKOB1p19e+Q+jE3nk08RsKaC+4fJmwYtJpHR787jDO
 2YtyoXZLzyRSYCt6+hnPd+o38E5Y1hiMdXCpQ2iOXwMHT+K1tazyRPo+Q4YNAhcX9AyAvq+YPKp
 o77Bj7R+rRLLaBNOFLlNFtDpAw1m7SlyvwWCkqus06WXTHAVYOd2lEUZw8UkP+YPhXpdFkblFFm
 qBi+b7hR63CRJ+H1Y9eiJqmrIJwNd63tr83C5bnhbtgng3aSlt2g8K5YQjTM5WjUUJ2RzHkc3C+
 4SX4qOdSduEdHJ/iLqRL1pwpFzjccV5Ji99GIQlXw3rnJXz/ctswJx9T16Xsdzu3OHjegW7g1z7
 zZIDRDNGbZb+Npw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The limits might have changed in between, it is best to check them
before accepting new ADD_ADDR.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d69d51309419..57d967fde843 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -849,8 +849,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			/* Note: if the subflow has been closed before, this
 			 * add_addr_accepted counter will not be decremented.
 			 */
-			msk->pm.add_addr_accepted--;
-			WRITE_ONCE(msk->pm.accept_addr, true);
+			if (--msk->pm.add_addr_accepted < mptcp_pm_get_add_addr_accept_max(msk))
+				WRITE_ONCE(msk->pm.accept_addr, true);
 		}
 	}
 }

-- 
2.45.2

