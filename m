Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1121773D
	for <mptcp@lists.linux.dev>; Thu, 23 Jul 2026 03:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784777043; cv=none; b=siXUQumnveAk8fBdET7HM3tL3iakCUezGhL0LpDw1aflUfQi/ig3og+si+cBS0CJp1EpwsiPJAcQdIrhGVuJdZqOahIsq2fv1LW2oJSQNknoFETMinV0VvjwQaPy3fs7MiXceHKLwriwhqNy8cFe9KXVPLFO62tyH/dps4Jz3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784777043; c=relaxed/simple;
	bh=scbWTGfxfh3VGb0/0KvJBbsyDH7t3SNPKWqjFthAHq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhwPIbBzXufOVbFqyg7o96GNKwyHhSG3ejTzgVVy5tg9YRjr0MqJjPmjo79MogIbgE5puseslinQm/lDkuqv+U2VxjnNZTBw1Kvf1vDaepA2oKCw60vvviYi0v5v0zFUMHnBuewtxvfvqO39K8hw/KMRVTIE32jtIcgyCyCmSt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ogoIXI73; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ogoIXI73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=IbD1RDHQe6lCAcpt0iLgLtyTwux8x/D3ZrB4wVldLHs=;
	b=ogoIXI73y3GZyl9HSL+EWx73K3XUb1liKQ1lKM/iiLDULHQ777pDh9CoF+Ew17
	yKaMzXHBj0RdVCmXkN5ykUoFSCMwBweXvN6jfSw5L1gJ4fblA+D87M8WYNRVaiqc
	nrUfaAT+DaXN+kYrIKYTpdoLLxf8Qt1qxj8Jy1iDndrY4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCnrxktiWFqBwaILA--.33598S2;
	Thu, 23 Jul 2026 11:23:26 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: matttbe@kernel.org
Cc: gang.yan@linux.dev,
	l1138897701@163.com,
	luoqing@kylinos.cn,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v4] mptcp: pm: fix data race in add_addr timer callback
Date: Thu, 23 Jul 2026 11:23:24 +0800
Message-Id: <20260723032324.189675-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <da4b96a3-c7ba-4444-bc41-96760e5ee08d@kernel.org>
References: <da4b96a3-c7ba-4444-bc41-96760e5ee08d@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnrxktiWFqBwaILA--.33598S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1UXw15ZFWxXr18uF1Utrb_yoW5Kry3pF
	4rW3Z8GF1kGr47Jr1xAF4kWFy0gFZ5JrW5GrWjgwsIyws8XFyUXFyfG3yYqa47WFsYv3W0
	vrWjvas8Zw4DuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pirOzxUUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC3Q9gpGphiS8+zQAA3I

From: Qing Luo <luoqing@kylinos.cn>

The timer callback reads entry->retrans_times outside pm.lock to decide
whether to call mptcp_pm_subflow_established(). Since
mptcp_pm_announced_del_timer() can concurrently set retrans_times =
ADD_ADDR_RETRANS_MAX under pm.lock, a race condition exists.

Use a local 'retransmit' flag set inside pm.lock to capture whether
retransmission is still possible. This ensures that
mptcp_pm_subflow_established() is only called when the retransmission
naturally exhausts.

Fixes: 348d5c1dec60 ("mptcp: move to next addr when timeout")
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
---
 net/mptcp/pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6afd39aea110..c71dcf887683 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -380,6 +380,7 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
+	bool retransmit;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -412,14 +413,15 @@ static void mptcp_pm_add_addr_timer(struct timer_list *timer)
 		entry->retrans_times++;
 	}
 
-	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
+	retransmit = entry->retrans_times < ADD_ADDR_RETRANS_MAX;
+	if (retransmit)
 		timeout <<= entry->retrans_times;
 	else
 		timeout = 0;
 
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
+	if (!retransmit)
 		mptcp_pm_subflow_established(msk);
 
 out:
-- 
2.25.1
Hi,

Thank you for your review and suggestions. I'm very sorry for not replying to your question in time and causing you inconvenience. It's because some issues are difficult to explain, so I merely followed your suggestion to analyze and submit the code.

> Don't forget to reply to each question from previous reviews 😉
>
> How did you find the bug? Do you have a reproducer or is it by analysing
> the code?
>
> Were you assisted by a tool/LLM? If yes, please add the Assisted-by tag.
I discovered this potential issue while studying the new MPTCP path manager code. Through code analysis, I noticed that entry->retrans_times could be accessed both inside and outside the pm.lock, which appeared to create a race condition with mptcp_pm_announced_del_timer().

Unfortunately, I don’t have a reproducer for this issue at the moment, as it’s difficult to construct a test scenario that reliably triggers this specific race condition. I submitted the patch based on code analysis to prevent potential issues.

I used AI tools to help verify and analyze the code logic during my investigation. However, I’m not entirely certain about the extent to which I should acknowledge this assistance, so I didn’t add an Assisted-by tag in the current version. If you think it’s necessary, I’d be happy to add it.

> For legal reasons, you are supposed to put your full name. Having only
> one "word" for your full name, without capital letters looks wrong, no?
I apologize for the confusion. “Luoqing” is actually my full name in Chinese convention - “Luo” (罗) is my family name and “Qing” (庆) is my given name. In Chinese, we don’t typically capitalize individual characters or add spaces between them. However, I understand the concern about the formatting, and I’ve updated the Signed-off-by to “Qing Luo luoqing@kylinos.cn” to follow the Western name order convention, which I hope is more appropriate.

Best regards,
luoqing

