Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B352352021
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938958; cv=none; b=a+Q299MBs/yt6jf+tA419QiP+n3gqaGel+k2ahMzEQHSZRyti/jTqOCgZ02UBplh+9tquJe/i2PHCSy50F6imAk2RRTOprsIw1g3OWNExpPNJBs8Rzp0Hq91hKz9YQXASGEDAen8A4vCudHut/97iRNU6YGQ8DTZFsg5c5o3h1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938958; c=relaxed/simple;
	bh=v07TgdD2tPEsgU5cO4PRB7JmE/MRcvIgFi440Q4GVWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cUhPIRzd9cBYuRLNu7kxiHwuNCWYMpTGSr4/M+X1X/zu6AJo1LyJ+C4JgV59yFJE8e0jk55dnFjrBcOYvdO57MXEu1R4BKKbrOEyb8uAVQX/DyA1pGIhv+Dz2ZvGmKLdtvgr2xOzr9GSx39i7KkVf6Us7Z9BroScMBiZn1oy7hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm/9SGz1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm/9SGz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675511F00A3A;
	Wed,  5 Aug 2026 14:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785938951;
	bh=FYCHPeiCmFvOBqYXj0o/vhLzJSwQL1uZtcZSrlaqes8=;
	h=From:Date:Subject:To:Cc;
	b=Mm/9SGz1TbWeLXwV0iw6PiZ2aZiDHQ06NV7SEa+Y7JMx8cAjlP5AjAaYceOZYwI1N
	 +HpJfS5snsh8L3up6wuzWO4Gm9fF4DSudv5qgwZx/wJS88S39XsU2HgDvdNYEZByct
	 iZBeVymYnCra+MqOBKAEBk3Ehi/qrEG/y6vBK4K889vyTH6NBU9sIdeXeEz9ZFRnqI
	 H3lWx99eIJetljTLt0+1G8x2CBMNgE8XaUgBC97VCFwjrebZPS4bJPHELzEKr6MymM
	 skO1RH9R6LGwo1HRALeddRUY2AjucGlw+fTv+kNf2UxJsugUbCBvktz5Uaj/poGK4I
	 tazXBpVfxHYcg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Aug 2026 15:20:19 +0200
Subject: [PATCH mptcp-net] mptcp: pm: reset retrans_time when ADD_ADDR
 entry is reused
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-mptcp-pm-reset-retrans_time-v1-1-19efbe17046d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2UCdU6u/MkTWLmqE1pJEEcb+f
 dW9XDhczplASZgUzs0EQh9WfuUK200D8THkOyGPlaF17cF5t8dULBYsCYWUrK7JkPVqnAi9P3V
 +54IL4xFqoQjd+Puv97CKmQwu66Xv8KRovzrM8wJMLDI5igAAAA==
X-Change-ID: 20260805-mptcp-pm-reset-retrans_time-8894830b0bd7
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=v07TgdD2tPEsgU5cO4PRB7JmE/MRcvIgFi440Q4GVWA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKKXdiCaycv+ZJ95++0Fe73F8RxtDH9Eb/zQHxNtynfr
 IO3K+pbO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbS+5KRYe4BlldaLhfruIwY
 NyruN0wsbPJosGByPHnjRPd9fYFzMgz/Y8LSmvVV903e/23d3BcqEo3PalzXJ0qoLV9xSfHB0wk
 KTAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When an ADD_ADDR entry is reused, the timer is re-armed, because the
goal is to re-announce an ADD_ADDR, and eventually retransmit it if
needed.

In this case, the retransmission counter should be reset as well, so the
re-announced address gets its retransmissions back instead of relying on
what was left before, and possibly not being able to retransmit it.

Fixes: 304ab97f4c7c ("mptcp: allow ADD_ADDR reissuance by userspace PMs")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664%40kernel.org?part=4
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5e499ec1c50a..e46abbda7d27 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -462,10 +462,10 @@ bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 
 	add_entry->addr = *addr;
 	add_entry->sock = msk;
-	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->timer, mptcp_pm_add_addr_timer, 0);
 reset_timer:
+	add_entry->retrans_times = 0;
 	add_entry->timer_done = false;
 	timeout = mptcp_adjust_add_addr_timeout(msk);
 	if (timeout)

---
base-commit: 0715f5ba093a581def25b88da61c987b1719bc6d
change-id: 20260805-mptcp-pm-reset-retrans_time-8894830b0bd7

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

