Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840B1755C
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987108; cv=none; b=iuKAAJRtcuDPLiEOhmHL5y0sYDeMbEQgj6/torEiDkinMu/uQMdluTE/HCeQ89ep2n6xCXfXtcc7wXVvLEFyKzcGPMmU2fg8A5PBfPL/PznFt8tTFNDnXK6sf8tEZl0YN+QHrMhPl2F3G57ebBwnS0kxqa1geoCupAxvgfl5O9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987108; c=relaxed/simple;
	bh=5seDjS2bflJzZeew/zsozQHHXMQJsN+C1Uc9wVfmK1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P8dwCDLcHqCdHf4sv4xSB3XrHYimrfWahsFf9ADMCcDL6EcKY6ca23hsG+6IzBuGety3yn0fXoPtBVaTDz0GBa0quDX62kL/zaBn9SK2TD8RDOez4o838YViOfuHL87YkvjWAXayR5AM7dokBNyGXlc3SC1EbQSMv6lnHiof/GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBx8zpmg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBx8zpmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B891C4CEC3;
	Tue, 10 Sep 2024 16:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725987107;
	bh=5seDjS2bflJzZeew/zsozQHHXMQJsN+C1Uc9wVfmK1Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XBx8zpmgUMi9j2f7HLYeGCzLTUFe7pqPjqGOZ8VFCrHQBSsTdwZv0oAa6uxUdR467
	 qwyUijUPgcsicoRQJ635NR6EGo+emS0jyNcZXWM89tU7ltgVd5p2JQqLwZJvaYNkNV
	 8e8jYL37PdCh6fZVqVaHYmcdxaKermXUt0v2wE/7LIWvbekxTZmiu/Qv59VZ9uIjGJ
	 5+zdG13HvqwXDQ455HDtuGmigOmlTnmX6GpdhWF/EAg7QcfVCGrfsTCOZ+k2+BWiqd
	 HJsdzDwLf/PwC0y7WebI9A35MlWParOetl3jRiltf4sQBWZbgCTOf+2xreU52p3dcb
	 i2IQna10knn5A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 10 Sep 2024 18:51:40 +0200
Subject: [PATCH mptcp-net 1/3] selftests: mptcp: join: restrict fullmesh
 endp on 1st sf
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-selftests-mptcp-fix-install-v1-1-ed1fdb92aa02@kernel.org>
References: <20240910-selftests-mptcp-fix-install-v1-0-ed1fdb92aa02@kernel.org>
In-Reply-To: <20240910-selftests-mptcp-fix-install-v1-0-ed1fdb92aa02@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5seDjS2bflJzZeew/zsozQHHXMQJsN+C1Uc9wVfmK1Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4HkhQFGh9favMGDvaAOHtkzWrdkCgDSy385sd
 gr5rdOs3zyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuB5IQAKCRD2t4JPQmmg
 cx8eEADLc+QO70eJmmQehYoCcsGqWve0z3GrGOjZQs7jNIG3JlxJSc5IKjLa+Oy8fqmoBzzmjLk
 mev7I3C0OHNDjrEWSDiznCYSHAZPOsgljI10/6K0g7eQn9Vy1Niwoe6mzy1Ievhvik8U4fJE53g
 B3T47AIEZiIqDh6AAE5ItTI3o9jTQfH8v0EjmHCD4fxOQCiS8ocMg95jVNV4nJtfzdQm7NOnS6O
 U1x2f/3PBIJoR3wYl6RMpFeeX9T2vqvnxUk6POzxrpoEq9Tyjk/jIKC4uaN3OSwQwJ/BAY0B41j
 tSiJuN1c/rf8H7+kQXvjIN7bWrwRH67Y+VDj4nZGssLjNtIjGEmGY81m01NUBT3U91iHWb5DtUc
 hFNDOY8KSIqO1CD/h0rNH811RP6sHSEu16YKKjfjAUFjyrRE4SDHrq/gLOKUldU6KZgLpohSIRc
 pcgrAZLHB8YhgPNapMOATFPphqWyzJbTxpVaSdLGLXxtlPwuJXDHoqYxjjFYGAAt7Ur2HAW1hn3
 LbKsTftTf//wWsZPeTgHe1LotnmNA2iwdAUpRZllKk5pHzlrk/1aaZFCf6dU1/x2v9iS7JLaHeL
 n47yzTO3cUB4z23rnIZFaSonFNOYOciOMaUvmZvfOxXvIpIQjqmHJgshjiVGlvNjsKrPMQtxX+3
 RpHbHgOim65m88A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A new endpoint using the IP of the initial subflow has been recently
added to increase the code coverage. But it breaks the test when using
old kernels not having commit 86e39e04482b ("mptcp: keep track of local
endpoint still available for each msk"), e.g. on v5.15.

Similar to commit d4c81bbb8600 ("selftests: mptcp: join: support local
endpoint being tracked or not"), it is possible to add the new endpoint
conditionally, by checking if "mptcp_pm_subflow_check_next" is present
in kallsyms: this is not directly linked to the commit introducing this
symbol but for the parent one which is linked anyway. So we can know in
advance what will be the expected behaviour, and add the new endpoint
only when it makes sense to do so.

Fixes: 4878f9f8421f ("selftests: mptcp: join: validate fullmesh endp on 1st sf")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3564cd06643c..e8d0a01b4144 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3130,7 +3130,9 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
+		if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
+			pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
+		fi
 		fullmesh=1 speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3

-- 
2.45.2

