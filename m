Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1009A34E75D
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169891; cv=none; b=ZGwFeC9Rbnc+mIy/XQrhylYjEv10kXQQQeOIQwLcnwRNBEZFVSEgLB39BMueBWeA3JNoei6AMwmLrM8uYxA9xpVr0YWfq8DYQCR5lrwWg55giL5F4mn6FsxST5oX70LfFIGKSsngUKfm74nG8D65gnauFWKPsHhhr6HWSVLXbwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169891; c=relaxed/simple;
	bh=w54jjT5OGNUmYDX+tGn5rJy2AAFV6mi/Dk4rS81wXVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ggf5okzYHiBLWhCKsu5eXPdhlRroTWCrooESQUASXq0rnknXgOWltm3E/zkT7vu5X5Dmf5af7Pu1SBp4VH/PPp1/8Ri51d89XeY9UloqlG+HsJb/nBhgMazAAQsA/UIagNlATJ1JpNhXVtzLb4Em3uSm/LdzrAfG+rZ10mQ+KTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix42293K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix42293K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50601C2BCC6;
	Tue, 19 May 2026 05:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169890;
	bh=w54jjT5OGNUmYDX+tGn5rJy2AAFV6mi/Dk4rS81wXVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ix42293KqKCUdNZvyqXBE8mDEfhdVrA4psFVFlTBg03oOguy8iW8tF3Jkpiox1cvX
	 xLfolqjWajjpYdtdCSLNRWpIQRNWMhtloUiCDSjA/IVPjRwgyBq2K7eejgEAJ2BLyh
	 RsAovqLfUZ7jxRQt6TE++Z493U14yIIEK4k/VLOosxD9JHWHhdWfXoyVfORX4qJ7be
	 GdIkY4jmqlEMKACM9qVNlIZkDu2R/6srSzE7Os7EIHvJKspzWcjQGTwtp41er+JabD
	 wnY0L/cY6WJB5yI580huW+46wa4r+3TZS6Jfphm9H19omWFQ77sJGQol9YRPYMJVYd
	 8UeWoNytiOBVw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 19 May 2026 15:51:22 +1000
Subject: [PATCH mptcp-next v2 13/15] mptcp: pm: make
 mptcp_pm_add_addr_send_ack static
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mptcp-add-addr6-port-ts-v2-13-3b36a51e6a86@kernel.org>
References: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
In-Reply-To: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=w54jjT5OGNUmYDX+tGn5rJy2AAFV6mi/Dk4rS81wXVQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqC/pSKaebnvTalHlBIR8gT3baJpVQ3MDmN1qfI
 N/P0U/4KouJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagv6UgAKCRD2t4JPQmmg
 c91EEADZqUgPyR+kgYfBR3DFcK8pc/hunh4rrEdonJudWZ4mLP8tAeL4A72GTfPocQ+L6XUx1Yw
 T/9y0HKJ8t/+Z2EUDmOAyl8sHxTF6ndBqP+V/iGaALnZyq3TWw6+yvlBxHw2TipyhMqERCCDf6t
 sZRvju3wjQGMdNZwrAoZq+OcJ1yZhj/wnw2dAk7fBkfeTdiZdsEdu7C+h66pqLr3bMc30fmxZ4P
 IkA0SWsOoUJpLDLBZJJ2mXUqPTMeoCusYtnTz+GnQMPV7yzKTg3oyBmkVidRM7MQtIgC+xce7G/
 0DuheyMojMtyjxFi2fp7dfgxqvB2+swK8/J+3rG0jH3VNF7JC7wFvxZPDDX/ZHFjXpf8anxEvYE
 Yd+WouMtvc5tH75RcQMRyQrwvOSBqbpM8soFXPdw0HiDKmL3eZK1cnbShVcVpu1gSHt3Z63qqwB
 xpoXYnwxhVae6rtXHLxZhttMQG6dQsH3Pcjp70/42T4c1RwLDLuMvmhCQoyqvDxRfZydP/+uM9H
 s41d2b/eyVDtV4d9RVJTYbs370syqOqH/HHA/rtLbTuysplli3CjPRcaAyg+tgt1dzRXqCCyLu1
 Co8O5FhHT7jX1YF4KAzCGncPns7duJ7vt0+tUUT33yCw+amV7izt64Eu/HTawlP9YHrUo7JmheO
 4SmPzZZy75eroDQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Only used in pm.c.

Note that the signature is added above: it is easier than moving the
code around, because this helper depends on mptcp_pm_schedule_work which
is declared below.

While at it, explicitly mark it as to be called while pm->lock is held.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c       | 4 +++-
 net/mptcp/protocol.h | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ee510071b4b4..c60d8fce64f2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -226,6 +226,7 @@ static bool subflow_in_rm_list(const struct mptcp_subflow_context *subflow,
 	return false;
 }
 
+static void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 static void
 mptcp_pm_addr_send_ack_avoid_list(struct mptcp_sock *msk,
 				  const struct mptcp_rm_list *rm_list)
@@ -744,7 +745,8 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 
-void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
+/* To be called while pm->lock is held */
+static void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
 {
 	if (!mptcp_pm_should_add_signal(msk))
 		return;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d501cd625362..a0d2d72a5401 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1117,7 +1117,6 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_send_ack(struct mptcp_sock *msk,
 		       struct mptcp_subflow_context *subflow,
 		       bool prio, bool backup);

-- 
2.53.0

