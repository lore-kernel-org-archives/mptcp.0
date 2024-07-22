Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAE2171640
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676972; cv=none; b=EAbxxS+Jf1rzNjRAtk/pa1Zn9ceE7UQLLEpf26ftpQLes3ltf2yEO17jl4VkdlNzwdUKtPqJmImj12e8P/sra+gTeKLWwLhcsT5NovypsGw0hOv8ZqwRuC01OsLGzyTnajqUGgV0Iklonhj3OPcMsAbBr09nN0weV7I1jA2ks5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676972; c=relaxed/simple;
	bh=4X7QSjPZQ9mzFn+OP2ehOB27WgZnhWY1j3aQBdeEXgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hvWNWgSzyTjTul39WPg9c/pQI8VPGicd72/PGLtYdG+bJ2HYjlgQCappVcrN09qvHgy7EUWGHJ2WyQC0VZmFwd7L7nq0fr8XsXmmrNCXn0wIBS0TEtTOtKC66Ly8H6yBLP9Qu3mKzC5irNBrYcrPQ0Ch1dJbt4njXIX45lcKW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gz0OA4zS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz0OA4zS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64491C4AF0B;
	Mon, 22 Jul 2024 19:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676972;
	bh=4X7QSjPZQ9mzFn+OP2ehOB27WgZnhWY1j3aQBdeEXgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gz0OA4zSoi/QarYmBrbHvFW4jvxJpdPI743TZqXGHwbEVrM/CLXEW55hKXm5QznPS
	 DQTjliTvQdJ8xLZQ6nyISWypGkNyplYcsyV2cfqqtkT+XmSwwITkWHZEHWFMqol/LO
	 0WYTwm0gKRVELOFhBpFRn0Lzo/JBhaHHCOlNihRGim7/rNYR6y0ukiORIKoVYVwmg8
	 z6H+wSsk8kmRvMUbNi2KAfJwH0A+a1wQLgBye/lRyl3JRVouPXtRfp9Rdund4B2nKW
	 63ULvf/aMUDmXlgrT3VZemYkqbLukmgOlxdQLyqyt5cHISPVCW5UjlCBT+o0Y10WWq
	 rXf6OmGnpzzmw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:55 +0200
Subject: [PATCH mptcp-net v4 17/23] mptcp: pm: check add_addr_accept_max
 before accepting new ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-17-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4X7QSjPZQ9mzFn+OP2ehOB27WgZnhWY1j3aQBdeEXgc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSXmf9nDGT3MUShfaxuiRyAZ/B5ikf6VZ000
 m6tIuY9YLGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lwAKCRD2t4JPQmmg
 c36UEACDdktxWq6nNZ0cu8k/uVqQmAcObPxUt3P3rAidnoCP6BRspviOWBq82BgGhaXR3pK3KWt
 HAytSJ6lWJRwyAgwOg8uCW67vOQfpmdE1PzJPWr6Dut/V6bdCVoYTjyPoaBny/TOgzGd8Ie8XT/
 xVLF7hH7hkDkqMJUhzeobHhA0bvMVQuo9UqkgG571LJWDIZ0t+U/9Q2UMavdgHMtAzAn1Doi6Ys
 hoaJzgNcdkKGMrtOdt5TaN7L/IQSkDrL8umW5ASVTarnMMsKNastMwc6CctBjjlLnWN2idYPjc5
 NcYCQ2u+ij0zATIuPpBRFteR1IyolQ+jc+Y4bkYuioBS91APzo5fYo59sAtT+VzpjmztN67TdxX
 Ru/cOXD7cs+qoXCrG018ID8u1iVdU4WkC0edcY0nuqfcO8x6T2Y9qs0/iceY4X3eS6Qk+Uf6Z82
 6BjNtu19h4viJE6by2/4qHAk0+Cc2LclHTPLIumstolPMyo+Urb4uJE8/hk4CQMnpsMWUpLQ7Q5
 2tLEL9IEdtEInXiCev3SGNZY+qa7yyXxqmAFkivWANGUuSKp6rj2f0uVwZBxo+5WGf4tPuObdLz
 fsBXezjJxWlDaXy0Rjr7oPMn+Ttg4PJ9RUB96O1LUZmk/T8dbG25JPJqKFu6652QUvzHf1GepjI
 VsU56Uy056YP5UQ==
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

