Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6764876025
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783759195; cv=pass; b=D9rUkXOnF0IzIWgycAv5Rdge6VMqrMYtURm+2P+NQ3mXaR9ucuZDdDy/NqshlF/XGYdvExqLtGNZXUIA0EWGXqohPIp3HH+WCJ7Fk9ccMXR3AiL/5jsLwJKpsMQAuYO81uYSHAc+s+FfGzFDL+ew3dDeeTmA4pMS1B33qhAcCEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783759195; c=relaxed/simple;
	bh=+7d61WKk/hsGU05gdYD7Vvctnh7ia+gBc//kClt5XnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vy+YU9wbHF/FdJo9RucmqFVhTxvcHny47gnEFINuf8ucVHi+GmD2gm2lN47d8LkQhyES/znmR8q+C+3msu/DhF2Bb89XR8fitpKCbF3bv59VN2XWXbZelz8rGJ4pNRbyQCq2t2VDztg0fSHM9QzbJpPA/nsapH6XHJHihTvaLqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=ObXpjdgu reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="ObXpjdgu"
ARC-Seal: i=1; a=rsa-sha256; t=1783759170; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cVjyzHdYLAAT/RFKzGBDFBFrO37CK7POwi2Q1hWhnKXWvfXebjEQiCGI2bA/k8RI42/nCU6gAX7R4NpRRfkclOPyg59cc31ZKkukHeK2QS5ef/9fykg9hxQtQr2Ru6JuCHA97JP3bjpTVYLiD+Bf3UoTowiTlyayUH0otJqvebQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783759170; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X6cnuxp5eMD9k4nHWN906RkVLSWAlJ49/k3hgCqEKU4=; 
	b=DhTZ9JYlGFo+dcyCSdAeO/ssQPc4zchW1OT9i3GgahWXM6j3jW8QzKBxAIn7a+kFSI1R5S7oMrNMDLuM+Pw4lUqDvezCN5072Q1JJgBWjvfNdnpvNZ0K8HpS054PzKMPPAI0XRqnj5DguGexzjBJ1dbhok4u388ryg9nmfB6+ww=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783759170;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=X6cnuxp5eMD9k4nHWN906RkVLSWAlJ49/k3hgCqEKU4=;
	b=ObXpjdguiiDK0iY+V6q/ZaDbbnNcZDyxFucKbfv8lkgjwI3/1VJAH/etauPLH80G
	2CumUumecVoucU4CPPd3EiQl3WCR3wjHN+3bkwu1DF/0VqdW2ZOZ29WXxdl/+VcnO5F
	FNr8cp/7ZfWp4TRZQ710fwn4giXV/bfQXTTotA/g=
Received: by mx.zohomail.com with SMTPS id 1783759168991218.31095441719276;
	Sat, 11 Jul 2026 01:39:28 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Sat, 11 Jul 2026 14:09:16 +0530
Subject: [PATCH mptcp-next 2/3] Squash to "mptcp: pm: add get_local_id()
 interface"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-mptcp_pm_ops_null_deref_join-v1-2-843ebd7ac0cf@mpiricsoftware.com>
References: <20260711-mptcp_pm_ops_null_deref_join-v1-0-843ebd7ac0cf@mpiricsoftware.com>
In-Reply-To: <20260711-mptcp_pm_ops_null_deref_join-v1-0-843ebd7ac0cf@mpiricsoftware.com>
To: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>, Janak Patel <janak@mpiric.us>, 
 shardulsb08@gmail.com, Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

mptcp_pm_get_local_id() now dereferences msk->pm.ops, but it is reached
from subflow_token_join_request() on an inbound MP_JOIN, in softirq and
holding only a reference to the target msk (from mptcp_token_get_sock()),
without the socket lock. A concurrent close()/disconnect() can clear
pm.ops via mptcp_pm_ops_release() in between.

Read pm.ops once with READ_ONCE() and return an error if it is NULL; the
join is then rejected, which is the expected outcome on a closing
connection.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/pm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4d8f8c999b1de..4fcd9d30b3df2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1029,6 +1029,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
 	struct mptcp_pm_addr_entry skc_local = { 0 };
 	struct mptcp_addr_info msk_local;
+	struct mptcp_pm_ops *pm_ops;
 
 	if (WARN_ON_ONCE(!msk))
 		return -1;
@@ -1044,7 +1045,14 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	skc_local.addr.id = 0;
 	skc_local.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 
-	return msk->pm.ops->get_local_id(msk, &skc_local);
+	/* See mptcp_pm_is_backup(): reached locklessly from the softirq
+	 * MP_JOIN path, racing a concurrent mptcp_pm_ops_release().
+	 */
+	pm_ops = READ_ONCE(msk->pm.ops);
+	if (!pm_ops)
+		return -1;
+
+	return pm_ops->get_local_id(msk, &skc_local);
 }
 
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)

-- 
2.34.1

