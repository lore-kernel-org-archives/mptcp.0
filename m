Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901723806AA
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089533; cv=none; b=OAc2VSw4YZeIrryk/V73LNnEWafuy67whPWnvfe5Eg1XkRYEkgouEN54Dqvmkrx58T/nONaxCoSwLPhz/WCysVE5cb3zFfUSvHEfDm6nMF943EHu0avH1Gx/Dt96UCmpIKZex/HNzZi51yOjxCVSggJlNUKS21KrYxG1rnXXxkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089533; c=relaxed/simple;
	bh=jdnbny3FpAqqGhKUlbs7dLOaF4eEPi0aNGYalBCs4Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M7BjdDphs1jWUU1xN0GRqSxR17JKz+bFZ5nyQ9Prfk3jZjX8QYJF/NnNfo484RfKJKFB+8p7vpjy3LjUA9WgLIgpxzSLkDCIhLtbfH4Wxum+WXbxKCS1B/VincKwgIhaGDvpEsD4oIkWf3DQV57Qyy1bYohPRaKANJaF2TH4+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ6+lvCP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ6+lvCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBBBC2BCAF;
	Mon, 13 Apr 2026 14:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089533;
	bh=jdnbny3FpAqqGhKUlbs7dLOaF4eEPi0aNGYalBCs4Ts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QJ6+lvCPQw7iya2/UgY/2qutRUYqJGQfM5edEYh/qAY88LuGDh70XmY6HPgGSIdEz
	 /eAp7LB2GFTXkVAfedzolMyX7fJCk2oOQ+SWesL8D4XhD1IhMS9+dce2bkEsstqzWy
	 FFv3T+6HbiK/Js32kHGPqeI2Hcrxp5pp5SEQxuAUZ8UtL1YfdD1xbT9S4+q7rsb6Tw
	 Baw4V1bbnk93pRSMui/KnRo0OoLILJUBuahb/95D4moHyucOR0ujawSqpi1adLRYIc
	 YZ+FIuwU9XjBrHd6BF29tauWsmcnUa4xu/22PsJW1pcc51xL0dLMFWiNh3t3m6n1Zj
	 bl16mhx88ADzQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:11:55 +0200
Subject: [PATCH mptcp-net v3 09/19] mptcp: pm: prio: skip closed subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-9-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jdnbny3FpAqqGhKUlbs7dLOaF4eEPi0aNGYalBCs4Ts=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/Fxn3VXV++7qxII9ifIqZjaJE38x6piGz1x4+vaZz
 2FeBpWqHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABN5PIWRYeqZpikGb7vWiT6R
 lYjmP9zbGx3x3S576sJXj1YETPlU0cHIcImHcbGqhszUN2xdKzU2bMo0+Z7Vq7+/en/m6S2sFfa
 zuQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When sending an MP_PRIO, closed subflows needs to be skipped.

This fixes the case where the initial subflow got closed, re-opened
later, then an MP_PRIO is needed for the same local address.

Note that explicit MP_PRIO cannot be sent during the 3WHS, so it is fine
to use __mptcp_subflow_active().

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index b3c4a6c75c27..17f6ccc22941 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -284,6 +284,9 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_addr_info local, remote;
 
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
 		mptcp_local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;

-- 
2.53.0

