Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9583CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391893; cv=none; b=QXR32MMMuA9KlX08CxGbL/vGgvA1Os/JCHmp4oD51lGVZsqBOzpiG+9xh8adFnigDbkRUFoPNGW2gWfVqtlJtR1/77SF001I62JTCq0ParcSwmIXiXYnc5AsorDIGr8wqEVXXmT1gZS4k0BE6gp+3nJrClk3tZj40vPxciKzpuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391893; c=relaxed/simple;
	bh=4X7QSjPZQ9mzFn+OP2ehOB27WgZnhWY1j3aQBdeEXgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VqmfVKLmtE+NKlYum2Ajujosw5ja0IFPJ6ZgTzmV2hsxXJVPChe3r5Y9aXxKh5kuVDZzR/I9t3tNBUt40w8A7XxiACOQpwIyxM7an/b5TH4SwDTqVO3QzEt3FHT9c129YSNH0JNYELXOKrQ/NbImE75GNlpyTRVf1/d3+jXcg18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKmk1Q6n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKmk1Q6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E97AC4AF0D;
	Fri, 19 Jul 2024 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391893;
	bh=4X7QSjPZQ9mzFn+OP2ehOB27WgZnhWY1j3aQBdeEXgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CKmk1Q6nR87tgFDNn02c8NZn38OHuxB+k82qH+lKyJLphay/sQRU4wXIGnmWkLIdy
	 XuEgd5o19QXUj7ytlaTdeyAbbrPmDgrGk7Loff5CQj0Z5FChxapsWivPzcbPF4ZCOF
	 uau6rGpSQnSp8SwOc7+RHqGQXE4osa3JbY/U5mv6JNofXaDkWAH/Ik3BVGzxPoQIN9
	 PoyjeACDNizk9Oq9Ots5kZoCTvJjpluPSsJTI8NQafdpfDdQHkuduxYXEPsy+sTY+x
	 UGNLogLPSOKRlboN2qA6VUQdEcjw6kBEiBOATC/dOuOwIltEJB036A7UfN2cSlMJPs
	 4VuQUxjRwHCdA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:28 +0200
Subject: [PATCH mptcp-net v3 17/20] mptcp: pm: check add_addr_accept_max
 before accepting new ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-17-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4X7QSjPZQ9mzFn+OP2ehOB27WgZnhWY1j3aQBdeEXgc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlsASl/Qr+hjWrUht/q/sEqDGTlWXENwQBJti
 eCcwuF3OHWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppbAAAKCRD2t4JPQmmg
 cwtDEADdL8IuCxWfM+cOGZCmblFvxM/vT3Z6eK932IMMtwgFp1NTDrVtThGvyC4Ii/3NMMxv2ln
 spZPOMN+Q5Dxpn066pMripe8fEg8Xn+TFc6smbNDla0BREsWz5BW1WZ3POXdbB6VZ7mWD0bjFBD
 gISC2t8+Z9GyWe8IpmyVYeWB0sdN/b7n600THaZ8O4dETF8qqmIHORYlfmoT9dL+htuSdJAXc2U
 wZbVa//DiuSw4ALreLEaWw0aLms2K4BLYyFQczS5IEe4m1g+sFiyLhVafp9KhgOQV2IuePx/wwe
 OsVZdesrorMNPlZd6FXQBpSDFeDQIa2WqMnN5tEqfFTDdx+BC53CTpaG9sXvrLnsAEiSCmbCxTc
 xJU9R/oNJkiYEpjUlIfqc2ZiMWQgOzGnJSq2QNVIi0FKvMDkfm18AyaWHVBXr22CNourq9x2Y1G
 dULh4ISjdAhsoqrm5PCCDzsLYmRlmXPv7qINu0sqSzB8GFit+aTUd2fqYORGFql9RH1QNSS4uBl
 OPlNvQLn5wdjuICB66BgtSm1lt+OKYXJfBDiKeRuhS1O99IgsDULq/W3vH0EkO8oZNIDhKi3I5Y
 BX0P2l1oqJNG+IAbF9avBQiLgu0KKP+wSDD1Mm0t/nIG/9apuAoXL3CMVs2GhO0AWOnPoF4eeeH
 WonZZQ4tIWiewnQ==
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
index d040cf8af412..b6086e9c7fc8 100644
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

