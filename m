Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309529;
	b=H4M8E9ul+gIvcjMSAc2le2E2wpjhi0m4+1C9cRCpLGQjJ6F71rex5TJ7WGsihr7vxdPX
	 lM+nhKDTLefDGFXXc6w8MoBjNR8BVUEq4ckCypPpoCcPvKQhEGb6cGzlBnNdzf/RWdfi+
	 Pf/NVCEeOG4s6bvuw7BKkGz1AO+L2j5GM65tx6gjrVn8P5ecNAwX8hkio0SX2QglD35pB
	 brAXYhbn62/mjkf5BK8OJhu5tKmALNSJV6VTZXnadKKJFrWaDVyEZZxgMRwTIngdSfhbx
	 knljON8ILjyXbyBUQ721ohk/4jTyOm2qSw+R7ipglE3Fa5lDcuUb23/k+TWBTiRlxXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309529;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+g4RFGtSy5CWrGKx9+HjfymvAu3uC40VGEsx0URqY0A=;
	b=X1/p5XqNlWZgM5XD+KaTZcku+XRPFTVTPLeL2JrtBxQnKoT4rRXP6NTI6nc57GDXSgDL
	 rYWxl2/G7C0DDbEX61A+HtMFdp6C0CGQnDZhm1y+VKUS/uB5Y7ukikc5fuYjb/sUvXfr2
	 J5tVutpheS+KnUr3PQ44/yPs8RR08sTqSPvHiFf05zN20TpKDCilrtA7o2XvgWjNUMvvB
	 XilfakN7mgtKg94JkZpPrH2NwIwEjKKmLuboCNzp3p6SXgR1+1vHrpqRU9RTEUUtlQmRT
	 jqJCMsbWoFj4AX3PpGgrZJOFQs/qD9kRGn9NydPFMzI6xtJVSsY4JgffiorTjya+aYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FW0H/CXN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175F606A323
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FW0H/CXN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE3C1F031E4;
	Thu, 29 Oct 2026 21:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309529;
	bh=+g4RFGtSy5CWrGKx9+HjfymvAu3uC40VGEsx0URqY0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FW0H/CXNxax/ktBKy8QdNaWBuVsQwJUM3ERX8JpW3DUOjoKxiaFxe70FOv6+KfsI2
	 vvppEK8EcM38aRwCYJjOiv8/qzrOYzS7jQZmZquCDskEUYCbMnnAgauHdQaSbpp2Wd
	 03BEC1BhFsSE3+q3Ec4DO4mumQK9sq48LvjH4Yz2kGwZ/HRzK/Z6E6UFEljq5kN60n
	 R3mDlGPpUWsH8YYUvonbhPFgUN7L5Jqh3JqBsf61qsMXVvy5cERn9y+o/66QIEQu/6
	 eeXjNcwpWEsLz4t5QoUFwHVD7wqhMa0fo5vMGQ+79ohpyEOvCp6T272ZHrl7PtH8xt
	 1fXWWcy/Gu0DA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Oct 2026 22:31:51 +0100
Subject: [PATCH mptcp-net v4 6/8] mptcp: pm: userspace: don't dump initial
 ID0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-mptcp-pm-userspace-id0-case-v4-6-555066fa4292@kernel.org>
References: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
In-Reply-To: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=O9fq+md9qsKr8mR0OARhWigCaB7dJ18A2xoaGRrhi2k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIe7w68UHVYd7Xp0kUtVx9c0z7L/Hrmqi0LOV4+CJVau
 SfjUpCOXUcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEVu9j+O/AW+Dh3XYu7d3l
 6Y/8k8tWX1uV9FBRUuPo1RclMspTnOYwMixefMLB/daKoNOmojdUEm8mf1Rc8uv1uw3MqXdZWo/
 0iPMCAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After the first patch of this series, the initial ID0 address is present
in the local addr list when the connection has been created. Not to
change the previous behaviour, but also to have a similar behaviour than
what is done with the in-kernel PM, the initial ID0 address is not
dumped with the rest.

If the address is removed, then re-added later with a new subflow, it
can be dumped.

Fixes: 34e74a5cf3b7 ("mptcp: implement mptcp_userspace_pm_dump_addr")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3:
 - use is_init_id0() helper, to check the port and not the flags
   (prev workaround, but doesn't work if modified later)
---
 net/mptcp/pm_userspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 0f6400bc3bf8..282d7f57c32a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -637,7 +637,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_for_each_userspace_pm_addr(msk, entry) {
-		if (test_bit(entry->addr.id, bitmap->map))
+		if (is_init_id0(entry) || test_bit(entry->addr.id, bitmap->map))
 			continue;
 
 		if (mptcp_pm_genl_fill_addr(msg, cb, entry) < 0)

-- 
2.55.0

