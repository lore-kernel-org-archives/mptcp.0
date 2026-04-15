Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6252EA171
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247097; cv=none; b=KnJV7hAc7/O2ECdWJ1Ztq5MCaTsBGrzMDXiDO6UdcNuQZr6A7lzRhJmfnsyrM7ZOBiyuTc2OPJMF3xsOTgLDTttfgd72vj8ilaRVSdc0vFURW6RfTqNasoUtd5kKxajhdeHZ7pZrhTO8ct6uwY8HJTSyt6+g2jGythVnurBvnLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247097; c=relaxed/simple;
	bh=awkPvRqvIliDOSYlLhGGuN/RUqHCdebo60QpsHNoDSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NVQq6bzOOVkiLwb6VpJ+9flEjt4s0iunTAIbbekdbfdpu+yHpw6tTI/qkkrWbDigAeeOVLJz8Faw7fiY1NM+b+nMPbM+NHD1WeplQqJbfYflgtCjkCeBOLmOSdf2NF9Q0szW3DtxtdgME3GO2iJQDZnorIKWDAEd73lS7A9TFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRv8rEba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRv8rEba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0FFC19424;
	Wed, 15 Apr 2026 09:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247097;
	bh=awkPvRqvIliDOSYlLhGGuN/RUqHCdebo60QpsHNoDSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KRv8rEbaIcWNTAqN0Klq67MfcbQp7LJbsq664UOP2SHG34vqB9445P4WxuH8RPM9y
	 VMlhNiDJUO8YC3rPgCHRDev1YKiddmv7P0Hj/R3UL6IL67YstCAeV+z+h7pyWxetFl
	 qg5A28HiSDveUENOubTpr1PP0WACbAPAahwQ7z5lQDhvKDTj9Sb9rtooWWmu1mhsl3
	 F9xEiJogQTjtEwpu8JaHACP2MpMm1PUtwyoNn3WIcqiTLYHbEHXNjKEvwuvz+EuNC6
	 xd0LcbxRDQ9QeGPaFR8UMXshNu+fyJrppJk4WIfdziSJvL9cBzDcDyVyUze1QPNHtC
	 cJHg9b5fb0vjw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:56:57 +0200
Subject: [PATCH mptcp-net v5 09/20] mptcp: pm: prio: skip closed subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-9-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=awkPvRqvIliDOSYlLhGGuN/RUqHCdebo60QpsHNoDSU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ2qarev0dqu6W/lAqGr3tshTJZ+MIqPv837azPTJ6
 JjWhg0HOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZyeC8jQ/PtZzy95v4qLfN/
 v/ohlbth2qHJCZNl5v7Qzehqf8SblMbwP6Eg+bTk3GlX3+75v3LPHAdGt4ViR1dVGx/2E9//2Ge
 vOTcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When sending an MP_PRIO, closed subflows need to be skipped.

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
index 25cfc5b7cb98..0bbb6054f0b1 100644
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

