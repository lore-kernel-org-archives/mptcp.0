Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE5D823DA
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329879; cv=none; b=PjYfSYd7tluo/udZFoQ3kpwtgTij705S1D6gEqtu30uFxanbMU1N6xN7BQEH1HI3rpm5uV3mU7JhSO50YyX1b2QYlaDH69cnhtgZCk2Z3ilHWaaRTfPjM7JhGJtbyxnBBXx1YRJMwsI9KCUrfQI0FCCuoMo2SChC7lb8wXKl8/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329879; c=relaxed/simple;
	bh=SgZOTWzuw1wrJ5HpXCZkxUS0s5IbIT6m9evcld+aQXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cyrAbdLY4juQGR3P5pLpqvYywWEkpuXxhTGvHBlyUJrUUzS02DmRmmMCxqN/EXDJ6LrQOnZ6tp0pbcCegVqTztJMLsc1Ie3WObCZ/NmW9y0QuTvodBG3u/NNXK5c/7SYKBJGMd9M0OSDo7mU2kAoyyIJ21mM5JG+pJEW/V7eIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njdR3401; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njdR3401"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71842C433C7;
	Wed,  7 Feb 2024 18:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707329879;
	bh=SgZOTWzuw1wrJ5HpXCZkxUS0s5IbIT6m9evcld+aQXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=njdR34012C18Y5DdcSGQfG/B79or++LdZRos3rFKJz/3PX5jBiKW+YXpDOEIOItd7
	 c6m5h5HON7NG9mlbnbalPlNThbUdk/IWwEEim8Jyfz63BfObPihvyo8k1kXVMbtaVp
	 TEgSZPZcSR/mZGbLRNI14wxtpo1c5zCXLJeEpOaWw5C4M1D+kY8+6Wo2JRNNwMkSRB
	 Yvbndmv5yHeK8xoHbl3YcbeC49wpT+0zen/4MUvi825t4/6PqgMd67hsWOLdwWOksh
	 xEe5QqIyC26Ab+A3eDDZHi4pQDg/jeuEl93n/JN/EDqFPRyZ/qndyoaIdOYKWcHOHi
	 DsReptVTEDm2g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 07 Feb 2024 19:17:50 +0100
Subject: [PATCH mptcp-next 2/3] selftests: mptcp: pm nl: avoid error msg on
 older kernels
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-selftests-mptcp-fix-5-15-v1-2-005b0cdb135a@kernel.org>
References: <20240207-selftests-mptcp-fix-5-15-v1-0-005b0cdb135a@kernel.org>
In-Reply-To: <20240207-selftests-mptcp-fix-5-15-v1-0-005b0cdb135a@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=SgZOTWzuw1wrJ5HpXCZkxUS0s5IbIT6m9evcld+aQXQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlw8lUkHWt3nYhlFwJqdkFICjV5aB1k3vkknsCN
 fl9pf41VpCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcPJVAAKCRD2t4JPQmmg
 c9YGEADJgLCkNwIfSn+xGE/5Hyr+WgWe44u6rEv6N3nJLMM98EIgHDC989j/csHuVmqzyWH0V3m
 tKM+N0oG3b7nwlb1f4aKgsqO1ZYnBIFdxprgiilPyteCQP+DaYsmA/DqV0svWqpN6TRywCUDE8P
 cR4zoEksAmz5kUTFBMSJocuA4Coho6FKDiuv5333bdNGr3y8cgOzw7jjSZ8Bl5kISf9wNyuW7ts
 JobNhNMSvD8oCqNOQoEEOMPVhRvmEgagUjKB2uSIMIQXe1pLp9X8EVGUgq7ZRR66eoJCXzzNwUB
 9aObeZRnvK1XGh6r7dNijIH9i3PuA0NPz9pIUzIeBgHIzcJ8E+Uxu/iFGXWOOXLO3woaN2yD+Ha
 rcb029CeNlsr+j71sJWWMDdo6aa4Le5XG/eGPCpUKf5oZZNUxu6F703a+ev55S0JByii5Ft8bNO
 Q1FdDhVP0M5OJSVGYJJA07n/6O1ubPpmwKiaz27qb69JmN6cfXgsn23zoLYpXNidhamYsz2pXPq
 Xwm239pCX2jYmmWu1eKBnT7i0H+wCeQP0WpLkzOV/wV7ARB+SKcTul0Tfm3Qad2dSd/GPXwzOzE
 c9JcQHXHF0q9yntoRsz02YkqbwHmctj71fK/pu57/LoqQX7B/DbkiWNr6e05Js5RlxM9qcQYU2y
 +u2g3f5LYi8Bf6g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since the 'Fixes' commit mentioned below, and if the kernel being tested
doesn't support the 'fullmesh' flag, this error will be printed:

  netlink error -22 (Invalid argument)
  ./pm_nl_ctl: bailing out due to netlink error[s]

But that can be normal if the kernel doesn't support the feature, no
need to print this worrying error message while everything else looks
OK. So we can mute stderr. Failures will still be detected if any.

Fixes: 1dc88d241f92 ("selftests: mptcp: pm_nl_ctl: always look for errors")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 79e83a2c95de..71899a3ffa7a 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -183,7 +183,7 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow 10.0.1.1" "          (nobackup)"
 
 # fullmesh support has been added later
-ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh
+ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh 2>/dev/null
 if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
    mptcp_lib_expect_all_features; then
 	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \

-- 
2.43.0

