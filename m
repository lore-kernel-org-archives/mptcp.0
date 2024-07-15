Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0FA186E42
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038204; cv=none; b=utJjm54j2gHaZVeITROcrKKYTyMh0282ta665lCawDiJeGO0v9tmjQu0Ic5ExN5yJ5JN2L5rBv9K6PfWizB5R4uwj5KCKdSMXcfn/vVNTl2fSX+2nwC/HPCB29b4encZACn9kUvpBNqMj5psLEXQRKtsBQMfR4rPzF+Xiw6Hgo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038204; c=relaxed/simple;
	bh=VTCYuWArzYhunK5hbwYMqWdj9fMJvYLpw+Ge9TGDPd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sm/qZQRooQRB0ZQ6A0QjQevS7vkCxvNQyyua24jMhNWvqR3jY5tyWNL3/5AFZo0fb0EgPPJZ1UMaJY98YzG7dFfSkUh0ewE/0q1Senrjd97Rf+I45G+ppCfMYE3nOS8RS7qPaICooagifUiAIc2txnJnkWkSSgE/owrn+zefLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edbuf2m/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edbuf2m/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0688C4AF0B;
	Mon, 15 Jul 2024 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038203;
	bh=VTCYuWArzYhunK5hbwYMqWdj9fMJvYLpw+Ge9TGDPd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=edbuf2m/OoYURfGsUzUVhdRFdGrLCS+K2yvYYuwMYHnoLZnPqROQvPa/59JOkM4R3
	 jv9tO9jmTlaqFYZWOF5a+/XDKLgVNCr/l1ZlR4V5N7ZDDTHegHDfl3sDQA3kSyEfR9
	 vJQWuZXj9uVbcesf9HPA7/nYO9b/CFxyi+5N3pU1Y0w2a64iWGCprBHXLHNQuWDReT
	 ljiBxv0LKcNyBjhFp5xopExBUsApaSJ3TchTrvLjB3Zh9flpicofEoTqUOt2Gg4PcR
	 O8SKqorHPi9UbY1akSm8nS7eTyf3QO6ZyeGZAfPSmRxdfxGcMnzEVpyp50FaWg8I0I
	 QP8ibwkUZl4xg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:40 +0200
Subject: [PATCH mptcp-net v2 02/17] mptcp: pm: deny endp with signal +
 subflow + port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-2-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VTCYuWArzYhunK5hbwYMqWdj9fMJvYLpw+Ge9TGDPd8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV3X/lqoq34yh7dzQznWfplPDvSxR7d49UZ6
 KAFFQGovyCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 c79iEADP2y/RVSepo5pZYnVJ9yWUukd1XuLG6wNJuZXgJ+jFld5zpYaJx5CZ6joV9fGh8xNwbq7
 Y1tUnC3kRnZqSYHwjDyZZ9kF+hJ3Xd/ttnLMJP6H57b2y2WSzgsj2w4rUdKiB2rdd7CSSnSMEpQ
 PtMQOir1eh8TtSmEROQQPFONFlHufn/MQr/mG43JLsnnCS2Nn46VEw38rYXMFG25f9S/tAsNmMQ
 oURbCw7Y1IPBX9nxwXqq9FW7BqcDCAlGIWHdKuKAUeh/xkr4AtioqzbVSiDZZftdKe2Cyp2U9Fw
 A/Sk0fP0rY5KKO3Gnc1vRe0vOmFMHze4msYsDyE3VKntZp5DDjMR1/ij1r9h1QKiYEo2IQpfZkB
 diPW6t0my+QhHomwcz0RK5BKXEm06awan6eS0NTLUnI8P4+SDQ9NJUxSTpQqqhsQUlaitFQp5o4
 acaeZ3DFvl/aACsh8s23JYlBj2+mIw1bkU+Ukzlp4uQ/KtZxbJpm+3tUkP3l4lDp2maO9zFIYP9
 kqxOFTnrdDdqZJR7omJTXCKiC0iuKW+zHmFEvmIzVEcYWtJyCQ8w369Hcad8Xx7BiwO228bSruY
 N69V+ZUuaD6oex9PWHKPlbassuznyC9xYEvO+enMVhQuWVSpIdDkY0g3XbL9n7HqfV23ZgC435t
 3r2n1pa2f6rTafA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As mentioned in the 'Fixes' commit, the port flag is only supported by
the 'signal' flag, and not by the 'subflow' one. Then if both the
'signal' and 'subflow' flags are set, the problem is the same: the
feature cannot work with the 'subflow' flag.

Technically, if both the 'signal' and 'subflow' flags are set, it will
be possible to create the listening socket, but not to establish a
subflow using this source port. So better to explicitly deny it, not to
create some confusions because the expected behaviour is not possible.

Fixes: 09f12c3ab7a5 ("mptcp: allow to use port and non-signal in set_flags")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f65831de5c1a..c44b0ae51cdf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1311,8 +1311,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	if (addr.addr.port && !(addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "flags must have signal when using port");
+	if (addr.addr.port && !address_use_port(&addr)) {
+		GENL_SET_ERR_MSG(info, "flags must have signal and not subflow when using port");
 		return -EINVAL;
 	}
 

-- 
2.45.2

