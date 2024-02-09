Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7DF53398
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499750; cv=none; b=MzW92yNUWy8Q4sa8a04+8yIQjMly0MdndDqFimLrfzubM7IuetwaMDWfRYePOH3YwN5Fs/bdgey0D/YkSK08XduUgAKd9ELgUNSC6nMh+JFgosDxLN0wFTY2/tQqZYLDrCL0O04+NX+jT30ruCVp8kTN7lxA0wnn4BW3WtEZO04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499750; c=relaxed/simple;
	bh=hvG/nPNAxX7rVhtHd425COQSVnzV+hvk6AfbCjxEcxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OViYcDCWv4CZP8WhaqgyOurqX1SFEmLNTIh0x7TmFR6HB+GNvASG2+Fmg1+KPtdGy1NrSB/Xg5rPrc5+kWEjAD4IVWsqFwe0kJhH+8iQ6Gh0mLWp4e2ivxNpZ/BqVVNA6vKs2RIEOqQdnx3C5LaFhEqzeTbER0M0NKxMbwuljSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTNtxsHg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTNtxsHg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832E6C433C7;
	Fri,  9 Feb 2024 17:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707499750;
	bh=hvG/nPNAxX7rVhtHd425COQSVnzV+hvk6AfbCjxEcxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fTNtxsHgsLiKXWpwharFjX2zFq7AKZi/1JvkWPsx+Gb+38XSBgfFVswCm1EPE4TSe
	 Xv8tDIOpiAXnKlbpY/VwzT8V+lI/7mQog5iMIZGX5uV9VyKL3z2Aofc8Cf/MUSYK4v
	 icl0BZSSLI802DhK6rucE+9tYrAnXbjB9qggqvHmA/ULanImDJ6K++aNI7pzFkdiUG
	 qKP+CFcbd75GfwQlRCCymNxTr1d030d213SLG5Zld0hHW5879V1LZ5yVNJrt/G9wiS
	 EP+8LWILP6SydgTgwASIwk7qp+cUQE6iTH6yj7UDY5w+2gNgNngYUGFdAeoENhAPST
	 1yMyFBFkC6wOQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Feb 2024 18:28:40 +0100
Subject: [PATCH mptcp-net 2/5] selftests: mptcp: userspace_pm: unique
 subtest names
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-selftests-mptcp-uniq-title-v1-2-e4fb3a3b5f66@kernel.org>
References: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
In-Reply-To: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hvG/nPNAxX7rVhtHd425COQSVnzV+hvk6AfbCjxEcxY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlxmDjFd7RA6XQHgJMwhhHbaaq+U6mF87Z6VH07
 MCLi6z5Zu2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcZg4wAKCRD2t4JPQmmg
 c8S1EAChWzpm7tYv3eKy/8MEm3mGp2rYzhnH9wYT/ApNEIvbvODRPhkN8+6NpyxI7kX83Uo9R2d
 q434fXocb06WwbCUs6nFB184SoFhE0z6MP9UvWiDvRam9UKrEbYPzjFGoYhYB9HiXD+EPJ8yx6w
 Txz/1wz9mOh7kgnxP6EYCGMiYAfwTuR+AlIcVToh1qOWPURTHfuXWBXg+N1Zr7pdp4SEz5y4b8p
 LgpVZnXHy1uaSpBKoP83yPqCfkdlYLbjWrpuc29iSNENrK1l4tJqKS8pRIjAtKUjqo8OSW0RYPp
 CLFJLml4H0Ag2s5vVZCxdIGDtzQG/f71EdpgAkJ05OGf9GW6mET5gG01QAoAtbMBHTS2Np+R8ha
 KPghVfuJU6fERyyiciE7jCahxExxBZfM+GUBWNhEoWT7faxvq1nx1pyPd7R8o8h+HFlF69lFJ1F
 Q/7RFGmlmmHEsTrKITyYfK5VJsU8SunLQvMjnl2X7Z3LNNfbbh47gX96vG2bl8CK247od2IY1aC
 ufk5Tg1BLBabiC2hdQtDf5x+uaYGpxoABMlnaRifhPsEGxiIdQFXR/gm6V/QqgP0WQNQyBjoqKz
 ESEtFNFA5huzbN/wngF08GuC1uOasftZWFgJv+zaDcN62UadDSg3lQsBTbSYKWtYVgUxPoK5jOt
 oxxgofTiUfv775A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is important to have a unique (sub)test name in TAP, because some CI
environments drop tests with duplicated names.

Some subtests from the userspace_pm selftest had the same names. That's
because different subflows are created (and deleted) between the same
pair of IP addresses.

Simply adding the destination port in the name is then enough to have
different names, because the destination port is always different.

Note that adding such info takes a bit more space, so we need to
increase a bit the width to print the name, simply to keep all the
'[ OK ]' aligned as before.

Fixes: f589234e1af0 ("selftests: mptcp: userspace_pm: format subtests results in TAP")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6167837f48e1..1b94a75604fe 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -75,7 +75,7 @@ print_test()
 {
 	test_name="${1}"
 
-	_printf "%-63s" "${test_name}"
+	_printf "%-68s" "${test_name}"
 }
 
 print_results()
@@ -542,7 +542,7 @@ verify_subflow_events()
 	local remid
 	local info
 
-	info="${e_saddr} (${e_from}) => ${e_daddr} (${e_to})"
+	info="${e_saddr} (${e_from}) => ${e_daddr}:${e_dport} (${e_to})"
 
 	if [ "$e_type" = "$SUB_ESTABLISHED" ]
 	then

-- 
2.43.0

