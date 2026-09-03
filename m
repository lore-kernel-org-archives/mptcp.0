Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B9E4457D2
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424526; cv=none; b=XolI47FfkpC4FteSACCb4dPCaYH3bZ7lMHYzezO6pg1XvRthWs/vffBlG/jbyaloUsQl6XM/dKTiPyWTisxR8mQtYe5jUxVlgPms724o/lEJFVswjraT3PAmriOyFzW3HI8ElswR/SIenkKWWhTupikgEn/yPzwXTDKrUWIXvJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424526; c=relaxed/simple;
	bh=/MjYt2ta9mFvbu69n1CKfGpTEP3/Cm6uJX62W/imdDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b7a3FAPay3rtWYkPpsN5D6Q5D1GkTTOqz6Aa2R3XYkiKekKo0Z5/hjFOQda9rbEI5/O0TlT0McePrzkRS9avtucMgF82qiTmzPpUyrOGg78AySclHxT25uzK2/n6myIoHf4qoIv/1dtTibR4MwEifkzZxp/IVeH7wBIIKjLxVd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtE9skPi; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtE9skPi"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-482fc3327fdso1357792f8f.2
        for <mptcp@lists.linux.dev>; Thu, 03 Sep 2026 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788424522; x=1789029322; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=66m0kEzVw0wUaLA90qEFlh+4kl2dF1iPNWHMpLLgPYk=;
        b=VtE9skPiKpaSuS60Hj4SoWZOXiyEYLdOD6TVvhFVMoHm+c1+UUHGNV/18XKxwnVPXi
         QHJ45KI+2CRe7TV4hQhW/kVXQDYsnabRsBb9MN8rHBML1Kr/SmG1/8M8hyqpsaIFoVoP
         TnnfPgFmAyMns/UgzG+Aze14HHVkaSbufv6L+GXVaD/JQ41KZkrJqQutPVB7OJpyBYyh
         3pC9shOAGo/DG8Po1JrMr21KH9cZb4POtgo8opYqib73VXWV2RA6inq078RLd/WZhSl6
         XS22EDxuCNNPQTQBx/rSR0deWueWh/cLviGwwWzSr3kqAyNeMaCqoy53CVCT/E2p5idh
         Qzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788424522; x=1789029322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=66m0kEzVw0wUaLA90qEFlh+4kl2dF1iPNWHMpLLgPYk=;
        b=KCkKDMzumxcQyLmYVq6IdKljPH9E+Dp8tzQpW7Io4fsjgHNDXWf6ChMv1lkDaed5pD
         16v11m1TqTYxTugriZ2CySMhzEd4TMbETSsB+9F30vi/JHnWHMVV+qp9+qwyL2jPvk5Q
         Yr9BdkZhFwRwh7Dbst8EREWluZ5H3BIuBSw8JeseH5h3vDmsPzY1FCohVl2jHB8sNvlN
         yfFEq35hphxqtBj+GzhSpIO+Sw3pE6Bk9/n3uw4frSZU5L8cSdIqny06KFtRqUaMXJrA
         MTt/Il/8lhIBMHPT+oEuYr7V8j2IuQfPb3ud9+JOEmaCQxtGG4zt+Gf0CC9fBZcRWNb4
         +f3Q==
X-Forwarded-Encrypted: i=1; AKwUvBy/oZztUT1JgwhEMaWkczK/LlXyL2uIRBAXA3QL3QlmP3sYi7hUSF6wm66FeyHv897Pa0FUvg==@lists.linux.dev
X-Gm-Message-State: AFuF++k7Pi1lf4QNuq3uZOtLVvOL2fl44hqtY4wJZS9s4Uxv/k10Z+Ct
	feYP1hR5p5EQrHfGarjipZhML1SZTEOtNk/y9OFar35zgoHKUhHfwPzO5jnPgQ4K
X-Gm-Gg: AYBFou27og3HtH/A5hJ5QP5a3VwqECsMQ5iLUKAd7nzPaInknM4lWN7WP4zIfi842Xq
	wAiWP8Wvzi1Rm8lqeGBQVOqjkVaPeTU6bx68u5RUR1ewaYXftWFz8FABVgBWsxGdmEP3NpVs90i
	zzaMFylWAePpXB6RN2Mg4XiEPGmchGQDQhapdM8ThRccL6GWVKrOFQDZqV6pQ7FUJ4rDl0l0nki
	UpT2HN56ZSjs4EXagVkOn+f01ykIw7bomSEMKEbcwdL4xirIXrKS7YF9HrBVbE3hcUmv+uRNvGn
	2IjZ7bR6wtCM2Ui0MPZ3pYTBSueeKcZiWzJ203bfydQSXm1O1EbpFeWRgN6aTsPW0vwisdBizCG
	1HIRlmhkwSWnZcFSujM8o/T9uOZOBnIP2IosDNdT4w5yJLUhAlC0S/TO1vWUtIY6L6AO0Yk+rWX
	vNBwbQPNDvcfQNo++T95op0X80c7qotssbDEj/nyB85Og5JQcOhPPuCwCcS+1Xcjtno5JqGdrmR
	41YIrss+mwE60QmpwZPSxp8il4GGLnEP5ZWM9Xbaai+VVezzcBXl8OFAcBDUVBXBxtrttwqJe6+
	P3Qj/PmUD9QAVLlUyLSpItadjPqXqD6lk1Eani5BgghnUZ+TpD9/7ql2fDfXdZJSa5Gv2sOgMwA
	ZQRAs
X-Received: by 2002:a7b:ca42:0:b0:49b:92df:87be with SMTP id 5b1f17b1804b1-49ce55fbdbemr129735745e9.4.1788424521705;
        Thu, 03 Sep 2026 01:35:21 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm228357425e9.0.2026.09.03.01.35.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 01:35:21 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y 1/2] mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
Date: Thu,  3 Sep 2026 10:35:11 +0200
Message-Id: <20260903083512.99864-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260903083512.99864-1-kmehltretter@gmail.com>
References: <20260903083512.99864-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

[ Upstream commit 9634cb35af17019baec21ca648516ce376fa10e6 ]

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer().
It should then be released in all cases at the end.

Some (unlikely) checks were returning directly instead of calling
sock_put() to decrease the refcount. Jump to a new 'exit' label to call
__sock_put() (which will become sock_put() in the next commit) to fix
this potential leak.

While at it, drop the '!msk' check which cannot happen because it is
never reset, and explicitly mark the remaining one as "unlikely".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-4-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Karl Mehltretter: applied to pm_netlink.c; retained v5.10's ID 0 guard
  and routed it through the common refcount drop. ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 net/mptcp/pm_netlink.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d4d56f0af3e0a..aee3a8dd9287a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -217,14 +217,11 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto exit;
 
 	if (!entry->addr.id)
-		return;
+		goto exit;
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
@@ -253,6 +250,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 out:
 	bh_unlock_sock(sk);
+exit:
 	__sock_put(sk);
 }
 
-- 
2.53.0

