Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397F1E4EE3
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607797; cv=none; b=VK6Uoz0PKCH7Rfl/IlYOmWLiLOg2oyNz6J58pqR2whyjsAvpgrlVqP7UkrabcNjuzyjkhlpUL1sbPwoTy+AmDiWibrpgaiVU21TXFgTxQcYg9m+wjZe5xbIYHTLujQugXp0GYLh4gVPVKUVKEfk4oYdYK+s+D+yX5qC40jl8er8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607797; c=relaxed/simple;
	bh=FOkAKENWCtHMM3qpGaJj8KkKjpHS7Y3tTHVvysiuFa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B/0TsEnDkm5pddooG/Ds6VPTFYnS6hkf+39Hg5t0oFu9ODZM5KPvGLSIUbZbCA7TO8wTBwhpzMc8QOnQaEBf8Zo5MZRl6tpDWnd7M5PHqXLLan/FGboAtEi7VTBZYGc6eCzu2DFdehoOcSAHxh+E5WzSEE69SfrmjlRwxnIhdmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh6/NKuq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh6/NKuq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB541C4AF0A;
	Fri,  2 Aug 2024 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722607797;
	bh=FOkAKENWCtHMM3qpGaJj8KkKjpHS7Y3tTHVvysiuFa8=;
	h=From:Date:Subject:To:Cc:From;
	b=Gh6/NKuqnb5x+kJH1hRRn308O/ApT/xwJAq1Y/OIZIe2quoD8cntZGN6o2u0nl9i0
	 HDEMRCZ0KCKXyB+BozLXXOOiEjDTrGvkokG6pvbUDvuKzxtQT/1onmPnl4ZnHCPJKa
	 BBY/aujgz+kehHt430pfYqhSLPi4ZDRzs5eN0x1c/1dkszozfsCCxnqH3cvBvMb65t
	 Mk50rqKSYG4enSnMRWk7TyRoEcoC9Arlg8wvIrALXlzaRqkDDzw/yI++TlWuEqa9g6
	 UYkCpzeFcCeFss5PH0wYJJ+JNS1r/alZqbYTTFvpPQtCcYJhGakrn509wRfZZvaZkw
	 fL/qw2RXTrVAw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Aug 2024 16:09:48 +0200
Subject: [PATCH mptcp-net] selftests: net: lib: kill PIDs before del netns
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-selftests-net-lib-cleanup-kill-v1-1-66220a8b6911@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKvorGYC/x2NQQ7CMAzAvjLlTKSSbYD4CtqhKylEhFI1BU2a9
 ncKRx9sr2BchA3O3QqFP2LySg32uw7C3acbo1wbAzka3MkRGmusbNUwcUWVGYOyT++MD1HFOA4
 HT30/HomhRXLhKMt/cIFnriH/PJi27Qt/DRI0ewAAAA==
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FOkAKENWCtHMM3qpGaJj8KkKjpHS7Y3tTHVvysiuFa8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmrOi0Rm0wfA/GLNtpP8ZJrPup0LqGGJ28vzeZb
 DHWBubBdOyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqzotAAKCRD2t4JPQmmg
 c9xgEAC/6z/qafvNDZB/wdmOdf05/Pla+REHBBOkS9rg5TUTXwExFBXDq8YpTjztt1cTvKyeAWm
 aEjc/m4QarVExIT4mE8A25lI/TrqWpyse0W4XUfbS+37Iiwnq2GmGl6084id8LfCyqTaSOFmM8h
 5/4KXr0QU+oXWo9VY1Z1XpEDa89gB12+0aSDf5r7GwFeqtf8cQ4+OvyWngnZAkE+bO+MKb/yhKS
 XOLzCLHNWiyb3Tl/2f0MSc597uxGOB+cAMh2EyJhlbIxtUx1AhMDiBBqqeWzzCK+bypzBaZ68EI
 /wuW45xC/pYZgISgA6GxLq08amxdjka2tBpdg2Tb7KfkPRSw+URKywAV/8wdlq/5mta9hsKUuK3
 EMMsKCIUfnpDOc3R3AObWA/mQdORNilQtFMfIcJjiUhffs/bZC8usa12JsxkUB5EHqbXksocDkp
 SlJdhhnwkU81RKZwDjCVXnO8SRPfEIjZ1BIcUynCxF5Eic7Kkzj8laVq1cHuv/OAarjZMYVoFxu
 +FTGL38h+xit4a4A+I8UzVPcKy+h0WdjV+0pnYTBkaw1b1jeaaeJI40467tgdShGFm/Uk3la75Q
 1Ddgd6LJv9KiStJ5IiNrVVQXnU8pXa9p/Wnpr/lZIl7DjWVBDUQRziRl2j1bRfRm8qD/q1+oY1Y
 t+sXtki4Tw/tn+w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When deleting netns, it is possible to still have some tasks running,
e.g. background tasks like tcpdump running in the background, not
stopped because the test has been interrupted.

Before deleting the netns, it is then safer to kill all attached PIDs,
if any. That should reduce some noises after the end of some tests, and
help with the debugging of some issues. That's why this modification is
seen as a "fix".

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index d0219032f773..8ee4489238ca 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -146,6 +146,7 @@ cleanup_ns()
 
 	for ns in "$@"; do
 		[ -z "${ns}" ] && continue
+		ip netns pids "${ns}" 2> /dev/null | xargs -r kill || true
 		ip netns delete "${ns}" &> /dev/null || true
 		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
 			echo "Warn: Failed to remove namespace $ns"

---
base-commit: 3b0e1975962a388844508be0b3e61e759837fa3e
change-id: 20240802-selftests-net-lib-cleanup-kill-f546a233572e

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

