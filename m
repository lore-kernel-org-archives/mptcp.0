Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F9343D8A
	for <mptcp@lists.linux.dev>; Sat, 20 Jun 2026 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781945106; cv=pass; b=VkVi+wyNf1jZY1IrvPMwyCBm7qy1Sv0Kug0o6y+Cp38eEQmTJscraKBCLEg5t2E197QtChCchG/BJukWzZgDe3cVk1DYUPfANElf2TV08RKkCKvgoOD4sIeSClzU81L6QecKlsNrJt6AxXr1sH2+8KrbOih//w3DAJXMrbNX+LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781945106; c=relaxed/simple;
	bh=ZNb+3vGfZ6nyBPVf2ARWC4lTmY9yoZJtY7YkaSzkZ48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ngkp1CVT1rso7D8w6ObPEO2XXgFIExItL9OUaekY10f/jUZwFrQtKA7fk9jVznY89sOvi+W4mSk0jA2Kwl20IVKXyaZRfTeirbHbxAhZ1iNUg4c4iE8fnC22Orh1irgHnGwn+meZCFmZz1pxTKtVLEWgo9wJjDBYQ6jUFS511Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=Sz3Czvqo reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="Sz3Czvqo"
ARC-Seal: i=1; a=rsa-sha256; t=1781945094; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=N6IP8SwWk6D8klLXxHQExEvsla6rodaHlRk6W7cVP3OVTI+7RpUnqSinT/o5abP2BP79yTWRugKfLjbVOjwaKYjU2j3F2Yb50ZoO7JeP1QKZDpGtIDmHF11ncCHuAXjdIqxlB+x9oxSO0pT4Gl/clndu3L9B6NLQLF+9YyjTHLk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781945094; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ikWAGXYnRQnkD7J6hQqYYlG0369LGpcgxufVMTQKSdM=; 
	b=lZxx7hHvCHP4Osvp8oklTUQLEJd1i2WrhDJM3TB5B44G6NAmJbmEF/npfCwGp0PrYUcHGBgIdgwLtuU8/akUPcduNs6WRlltSNnAP1Z/xv2RHF+juu/0cQXrgUZH7xYxQJW2qVDaOxKOYVwvdAxq4COt5kifse/uFsf1+mX/rfs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781945094;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ikWAGXYnRQnkD7J6hQqYYlG0369LGpcgxufVMTQKSdM=;
	b=Sz3Czvqo/OGRa3zB01mgz1Yi//ea51WSykV1Y7EVEXCH2cYdpOTNfecERkvgnCSD
	SwuBSKW+bANlOAPPdxrZKTffgcIgURvEwIu47C6D1HZb/zC1z28tzpUIAMX/XuLed7U
	sZOtTlbEQL9Q+1jlHUQuVx3lqwpd/c0fetqm/EF8=
Received: by mx.zohomail.com with SMTPS id 17819450931459.06970663451932;
	Sat, 20 Jun 2026 01:44:53 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	pabeni@redhat.com,
	kalpan.jani@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next 1/2] Squash to "mptcp: pm: init and release mptcp_pm_ops"
Date: Sat, 20 Jun 2026 14:14:23 +0530
Message-Id: <20260620084424.3072634-2-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260620084424.3072634-1-shardul.b@mpiricsoftware.com>
References: <20260620084424.3072634-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The userspace local address list is freed from the userspace path
manager .release callback (via mptcp_pm_ops_release()), i.e. only when
the socket currently uses the userspace PM. A socket that used the
userspace PM can be reused via mptcp_disconnect() and re-selected to a
different path manager; an entry appended late would then not be freed by
the next teardown running a non-userspace PM, and leaks.

Free msk->pm.userspace_pm_local_addr_list unconditionally in
mptcp_pm_destroy() and drop the now-redundant userspace .release. The
list is initialised in the generic mptcp_pm_data_init(), so freeing it
from the generic teardown is consistent; it is empty for a kernel-PM
socket, so this is a no-op there.

Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/pm.c           | 6 ++++++
 net/mptcp/pm_userspace.c | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9dc7b41fb5626..8e6d066a868d7 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1170,6 +1170,12 @@ void mptcp_pm_destroy(struct mptcp_sock *msk)
 {
 	mptcp_pm_free_announced_list(msk);
 	mptcp_pm_ops_release(msk);
+	/* Free the userspace local address list unconditionally: the socket
+	 * can be reused (mptcp_disconnect()) and re-selected to a different
+	 * path manager, so entries queued under the userspace PM must be
+	 * reclaimed regardless of the PM in effect at teardown.
+	 */
+	mptcp_userspace_pm_free_local_addr_list(msk);
 }
 
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ad6ba658e5a58..96fdaf12f6ddd 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -689,15 +689,9 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	return ret;
 }
 
-static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
-{
-	mptcp_userspace_pm_free_local_addr_list(msk);
-}
-
 static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_local_id		= mptcp_pm_userspace_get_local_id,
 	.get_priority		= mptcp_pm_userspace_get_priority,
-	.release		= mptcp_pm_userspace_release,
 	.name			= "userspace",
 	.owner			= THIS_MODULE,
 };
-- 
2.34.1

