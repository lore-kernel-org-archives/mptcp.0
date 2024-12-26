Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D414A609
	for <mptcp@lists.linux.dev>; Thu, 26 Dec 2024 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735205640; cv=none; b=hqCNyOig/1rECwIDbCf6ixci9W7cqfkwnCZOB4+jG4IUdHfsW3gMuDgTLSQ+Tm+Uj/TtRaKkS1G3kYZkTR3hcf0OReGpcm/MLzz3jPuySr1WFbDyEqEMppVevjKy3DwDiLCeTCOWWGWnNghvCXpEDxEiPyxzw52nt2h9+iRDXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735205640; c=relaxed/simple;
	bh=hLBo7v+kL/1jqIpcvkZ+neXN0ZdIwtAEysRv3Zwp8fI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5/hh3Oy1aqdWnv1THLMvihFykDQUsWucpMro1yTQLZvhsMbYzrcb4ZOrd50AbPTF+tVIE4qCQLg/9v8xNmtiZnhvE+7U8Ek5ZsMbZ/6bXOkC45XCCXxaVYbLomdwtPyBoN0QRF+kC5BpFZ3mJU4pTlM0n7mXAmfkFFe0Hs/vM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Spd57W4l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spd57W4l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18166C4CED1;
	Thu, 26 Dec 2024 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735205640;
	bh=hLBo7v+kL/1jqIpcvkZ+neXN0ZdIwtAEysRv3Zwp8fI=;
	h=From:To:Cc:Subject:Date:From;
	b=Spd57W4lFAemO4WjqXsTSCM2mAskHqoQ3hO0nng8eH3bmRz5vxo8wjSYyyWuweIpN
	 QUZZadAUfd0TQr2zZRqSG298kCix8AMHUm4d3bp9//EfQ1GWuAYUBhmdt2+QaW8sDY
	 AyG5FopjfkeMSPU3L7xSkWtslfSFD2YLFhp2hNdj7S9PhmDYZqIhd38B0QXPkeENdm
	 UOCQrGVe7NOE+7XnnxeZ5KInP2NOKZvUiBeBIj8nPzVhBPtchaF6FKTWBeR9x1azRq
	 UES5RhHpBIB4DS0sxWoVHGVLEQ+J7KTL9gGaWuDQm2YslVY/cVolb/90msl9a8Veek
	 AnPh+KepPAkFA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: kuba@kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net] mptcp: fix for setting remote ipv4mapped address
Date: Thu, 26 Dec 2024 17:33:46 +0800
Message-ID: <35436a387650236cce065f198b89bb5afb23f708.1735205514.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Commit 1c670b39cec7 ("mptcp: change local addr type of subflow_destroy")
introduced a bug in mptcp_pm_nl_subflow_destroy_doit().

ipv6_addr_set_v4mapped() should be called to set the remote ipv4 address
'addr_r.addr.s_addr' to the remote ipv6 address 'addr_r.addr6', not
'addr_l.addr.addr6', which is the local ipv6 address.

Fixes: 1c670b39cec7 ("mptcp: change local addr type of subflow_destroy")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 740a10d669f8..a3d477059b11 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -520,7 +520,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		addr_l.addr.family = AF_INET6;
 	}
 	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&addr_l.addr.addr6)) {
-		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_l.addr.addr6);
+		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_r.addr6);
 		addr_r.family = AF_INET6;
 	}
 #endif
-- 
2.45.2

