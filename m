Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBD313B780
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807526; cv=none; b=tgnvVBlA08Kj92eRoUcBbQ5V+szBwv2Ybvtw7kuZLKCBqm8hWCEnQrZYOHrTMSqT7dg0b9hs9Q0vsekmDrigVookxgpra6GqFOzhXq2TKI6aNjLfAgx5AmJS+4ZRTqwKkmHzTMBt+RgUqThO1MvZvWB++7+zsOYEfmFDnVxnt9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807526; c=relaxed/simple;
	bh=isSgg6Nbw4paOmQkxswWWXT5wo3Wu8UKlwr7DvZsRVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ESQDWIMiHsSDqc+eB9pmsyTziuLThVxkEkIumjbXslFTjySrzYZiTKFByreL3JsPCJBfIie1W1FNRkqkUYgDEJIKbb+4rMmusafdqJPRcwhk+p5X2hoy/il4R///d0yvDG3UN63LSOWSgHr462ym85dH5vwOgTjn/79Ej8foq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVqj4jNS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVqj4jNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910E1C32781;
	Mon, 27 May 2024 10:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716807526;
	bh=isSgg6Nbw4paOmQkxswWWXT5wo3Wu8UKlwr7DvZsRVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fVqj4jNSv9fesv/RsY6HnFOrDqTSI7/Rg2ferGTrmnePupSv5mrX3qbxz9sgIpTdj
	 eVXh52c8OdLciHBmQiP8lxwut2FdUAB/c3SNhSCsLdylY1j8bErhJcyVzQtFsHqIhW
	 q+C0r6B9+deyaH61btC3D8kVAUxqZa6w9bY0O2ewEXvT+uLlPp+28F0YsF+4ZK4CP2
	 mgUuFdNy12vGu4I9o+b5eg/3eExQTUturzFK9lBW+lQ9cTWeQWBTYiimisXxwuzimn
	 eiAn0nubeQYJLSRu1RRoUB7G+kQbs/Jp+q2x4jfRA35buv+5UbxDtb1mL232XiKcc6
	 H6Y39U5iYUHWQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 May 2024 12:58:29 +0200
Subject: [PATCH mptcp-next v6 2/9] selftests: net: lib: support errexit
 with busywait
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-selftests-net-lib-fixes-v6-2-72411ff2460e@kernel.org>
References: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
In-Reply-To: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=isSgg6Nbw4paOmQkxswWWXT5wo3Wu8UKlwr7DvZsRVE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVGdipIAFNcWBXmnhlR00kBFXp6pd7YkjjjErK
 kp3X0BqgWWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlRnYgAKCRD2t4JPQmmg
 c8ucEACWqN40Q3AhX27SZeblBIowVwcS7y6eAWrO/ENxAc/VtTOwTdx0RV0XxLqPG5/F0dnUDHw
 jJ3icm+Qw5Sp7OBxHlCzdhHE1ajSQNRf2fE7ILdDbs4foKlgrOxIma87hgbeNs08CEVQ3S9mgp7
 lT7yDWjvLQuAv28fKdo0PWgbl1hQ6cm7921BJnRKsZFx2agIIdRLg1LGpWWEQjc2hO8C8DosdkS
 FsvbK8FVFS38+09qDrcPVyH4fkcz8Hl6alcyeBozoFpJjFbDO9D6ICVN9x/GEc9JFAnPA0Q0Lq3
 FYwwZZ03sZHWIFx+K+Jop5LSbDFXoxxezbfmsn5diFPW5ULEotbZyr8LLAPstijamkcqaJI67gu
 K24Gv62Ebj8gD+bD/4tw2JLQthzbjQqce/bN+c70vwLxYWhm7eNKwtCKT2PGoK2EuCSMS7VVrxY
 dsBTueLND1Qo6m3bxUXw4/bsTtFW6pZqYZGoKyp+09Ocv21ziyEc4iujwOJ9TS5CCzy3YT7iYrl
 3rMc0ofoMExbuQ5TYbwqLj4AmB73QAugtF3PelXfLUCc5Lf4nZZvnjbCz7kCf61z1l03UaFA16Z
 f6nGDJbZO8AH9Ui45AI5iirsG85S3yO6Pk8vVWNT87KsJKR9G96R4ifpk31qxdbe7umDzUftuPx
 uiGqmdtRn0NvaxA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If errexit is enabled ('set -e'), loopy_wait -- or busywait and others
using it -- will stop after the first failure.

Note that if the returned status of loopy_wait is checked, and even if
errexit is enabled, Bash will not stop at the first error.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index be80f7b1f9d7..2fbc01003b0f 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -68,9 +68,7 @@ loopy_wait()
 	while true
 	do
 		local out
-		out=$("$@")
-		local ret=$?
-		if ((!ret)); then
+		if out=$("$@"); then
 			echo -n "$out"
 			return 0
 		fi

-- 
2.43.0

