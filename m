Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C1B26AFA
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807528; cv=none; b=LcrksgbRh3EgaWF4Z5kSMzgbC0cSzJL5uSfKN64URPzF+u5tJhOxkCIcxGzaJ+ruf1xwvkzV0JiTdQj+bGmNFOXhVSljDt72cN5QlOYfhyyflIe9stw7RD4Km+ipqVmqJL7xdqxLf9FA28RHLTOHoexh+ULhBHxaDDvlpgRyRHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807528; c=relaxed/simple;
	bh=JXMQEe3zsXqCqykV0TiMzHSF/bLvNSHAVqPzoUmJcJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Atn/L1jsQ8voVJF/WiCV6oxGof4+BRzB7dBsj4mi/eldMtvuF2+b0Bv7nrrgH7qxtbozblKPri7qWbckVaqZ4C3JxsORXXQlqM6ZjHhn2ohsKS2uErHWDnjJ4AZ7u/7cf/nUH1t3VEAiTKBhZaB9QesFaju3phrjgK+SGbtKYEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axIWYFu8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axIWYFu8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCBDC32781;
	Mon, 27 May 2024 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716807528;
	bh=JXMQEe3zsXqCqykV0TiMzHSF/bLvNSHAVqPzoUmJcJI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=axIWYFu89dJ9o/zIIiFtUfuBfKb96i5+DPobvHXtN7ex5t+AfKFsA3v9I7yJOTygv
	 sA1sictYT/gJMNXYasxg7gU5bUYJEQvA6sfS2FtQbheeip0uPIU6YKWmt18TGBq2JP
	 xQJTaEFO9JCfCZV9jOMUIPsAMA5GGkOO2yFVBOjjRTonJ0M+CW5/SQaZNdzNBijeLs
	 HIgOmrBIUnJmoXPXAe0+sFskkOClTf2G/Lm7jNEki/CGreg6JK/ukiqNhklMgghZ+t
	 Z+Oh8f9czU1/nUrQp55sQ+D95YxPoSbL7FW5mlWCRe4Of6hHSveiG/Km5winehuCt0
	 B4se4sFQGoKEg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 May 2024 12:58:31 +0200
Subject: [PATCH mptcp-next v6 4/9] selftests: net: lib: ignore possible
 error
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-selftests-net-lib-fixes-v6-4-72411ff2460e@kernel.org>
References: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
In-Reply-To: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JXMQEe3zsXqCqykV0TiMzHSF/bLvNSHAVqPzoUmJcJI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVGdiVwh2eHZmoQGEd+JOxMjPRkzDsVTnEns7B
 V1yfypm7BWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlRnYgAKCRD2t4JPQmmg
 cyVBEAC6g1CjkMr/nAQ+DLtUcSmRVujg/uyjwkDuhVZappJtmbSn88xT8cUfaqsy5MOzJeMAwXr
 FIgysnvGSLNaVBLbE42e1oebRgpj86xX0PfVh76rNRnjeNwLGRTnDCMYNqT++Y7Ly2q4yrQeA/J
 jUnvnJVV7L+VUFi255eXdA9lioncLhOsaz6w/AWR+loGtMiDPb+M6+Wlly6dbLBln63NmBbUCR4
 aYQf4xBVD/oYhQgvMX4wRHp9Q539j027Tbur+ctcOTz7yfpDtehzItUmRAdZGKb8dcN7RtlL340
 6O1s5sF96JaR55OLHJ81UiiQvhB7SDN/yHFJeUicX7rKE0KISf+g9VJboK/HnBPdqzT1EVXIP0Q
 VdfBEYc3KxD9CWBRh8mlLgaQMWL959f05k4H/M5ZFKgeU8u3svkay+wHtyb94WZ3SvYwEdahSzt
 1kVaJZxYsvDs9iSJcIrYuSeyq1mgZMIHxjqIjRaylQvG4WdrFm99vfkNoYjG1F0ksw+45Lhxv/x
 4LmVeICcRdcrISA335ERd9NBnC4j57o3UB3oUmL5GxBtC+yIiVGJeZOpyJZpnvmT8sCiFx8slkk
 4YyV4BhqX2K+zq9Inp08m/lmVETKn8xDGAesLMIsWH1QGf4xTNLRjEs3LPyskdfYRuSlrybL3Jc
 nrVy4C2zGiHCLbg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No need to disable errexit temporary, simply ignore the possible error.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 9155c914c064..b2572aff6286 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -128,25 +128,17 @@ slowwait_for_counter()
 cleanup_ns()
 {
 	local ns=""
-	local errexit=0
 	local ret=0
 
-	# disable errexit temporary
-	if [[ $- =~ "e" ]]; then
-		errexit=1
-		set +e
-	fi
-
 	for ns in "$@"; do
 		[ -z "${ns}" ] && continue
-		ip netns delete "${ns}" &> /dev/null
+		ip netns delete "${ns}" &> /dev/null || true
 		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
 			echo "Warn: Failed to remove namespace $ns"
 			ret=1
 		fi
 	done
 
-	[ $errexit -eq 1 ] && set -e
 	return $ret
 }
 

-- 
2.43.0

