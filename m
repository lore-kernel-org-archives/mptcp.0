Received: from mta0.migadu.com (out-83.mta0.migadu.com [91.218.175.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C988F35E1AA
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138482; cv=none; b=pG5rDekYclsgrqHfx72a6bDkRKKlBinb8oQZr4Ehu1BjiqQ+ZZL0RnD8dNSdmtH1qk24SCb5uGa7H2gxthcp3xuk6WtMLCD6HZ86m5p39xsxiBdPy54MFb6NQxAX8DirNff9Ljl5OZcRRXoQxHrDmjSGKcR9nHvLFhrfohfWifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138482; c=relaxed/simple;
	bh=kB83V3yUg+2bzKdwztGH6E3ejAm0BGhWJR0s0PhxUm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pl4uUKXtiQq8ZNEX9Eau0KiI+U4AFPGb/jwGD8FMz45wthJdySO30MqeXLLivCFl9/GgzcCh1MCYm9SiJKQJly6jwmzLAaqJEgSdoh/2Mc2j8K+YMroay4qR5xBc+d5imjQoaa//dAHTnCS/MvpOLHsLn/mNx62w6lNXUc7iY48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yjc2/0oM; arc=none smtp.client-ip=91.218.175.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yjc2/0oM"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=kB83V3yUg+2bzKdwztGH6E3ejAm0BGhWJR0s0PhxUm0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787138478; v=1; x=1787743278;
 b=Yjc2/0oMSKReS/cj+rkKuiEkZnrKUNwLkDSO4SC1WwY/pD5+MK/nImeQsld7wGgHQ/aIhKkd
 MkcxBocOWcULGV7gEd7nv+WK986IPGd9YoFc4fiR4xry9D1r1hwQWxa8TFROdNZkVdTiYJcXOgQ
 fyBQZss0lLD/Gz1ryHWm/x0w=
X-Envelope-To: mptcp@lists.linux.dev
Received: from localhost.localdomain (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 6e86423111f4f84c;
	Wed, 19 Aug 2026 11:21:18 +0000
X-Migadu-Flow: FLOW_OUT
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH mptcp-next RFC v5 3/3] mptcp: reject new subflows after fallback
Date: Wed, 19 Aug 2026 19:21:12 +0800
Message-Id: <20260819112112.1985121-4-chenguang.zhao@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819112112.1985121-1-chenguang.zhao@linux.dev>
References: <20260819112112.1985121-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Check FALLBACK_DONE in mptcp_can_accept_new_subflow() so that
MP_JOIN is rejected after the connection has fallen back to TCP.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index af81ad5e699d..c35f3bfda535 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -61,6 +61,7 @@ static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 static bool mptcp_can_accept_new_subflow(const struct mptcp_sock *msk)
 {
 	return mptcp_is_fully_established((void *)msk) &&
+		!__mptcp_check_fallback(msk) &&
 		((mptcp_pm_is_userspace(msk) &&
 		  mptcp_userspace_pm_active(msk)) ||
 		 READ_ONCE(msk->pm.accept_subflow));
-- 
2.25.1

