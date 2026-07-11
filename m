Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91376025
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783759184; cv=pass; b=Ujawv1W60bSfc1kqeqgRDUcPaGK6kZXP7VCzHhaRHYXtwhCseQQZbXEx2FRAlw0zIKrL9bXaE5oDSXVl1OIdKAux8jzMGE+DJx6IBphaVaKJT8iM59XbdD+nddrWLvioZxWFdIVK3FsIyUVmErHMQ3059uF7Ssu4z6Wxn4quDF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783759184; c=relaxed/simple;
	bh=vOVV4Nq8xLoVDzWwHZbf3pIZ5RdvC+VyrXsdFD7nIRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fTFX6Zv+fHjUnwzhcRffyH7RbC71GKUNA3TCCjW2mrsgfuVTJKjEauHUsTl8RI+JYz4znFAG5mKXwx/y1ZUw5xv6BwbK7t73sk3aqrBXJbQ1NE3cs7L87BmVwuSTaMr+DXAsl9km75YUlsmjohraOrnHx29Rn5h5Ccs6BpqVPiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=rWKhQFsA reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="rWKhQFsA"
ARC-Seal: i=1; a=rsa-sha256; t=1783759166; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jwmCZYPkanZLP6iFHMsGCGsOzt9kvqylQh9X3Mqdo+UwHLALWAeCTIJE1PRyzMF3gyijkKDRiwbr4Izeu6bq2fEzVCk8GVB66zY8icVS+IzIS2hQHxG6XL1pqoBth5/tHCjBwL5wbfAxE0X319dPTZarc2XOdJFMlVggcQvmfJc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783759166; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JgKNGzKwEPTCNFdiK2pJ4noGSKYLVL5tPQd4kCy1LUQ=; 
	b=S2u6QUlg/Np4+BIKeLHkZSTrmVg+/dWxll08X8WuSygLxe7XBeGgTxH8mJT0OMeohzYKZFFcbUBhB7crGbirI1XCFrU4SnkAWv1k/opEUnlOr2O7jnfsa+dq7OwthYQR7TyJzyu861A0xHQteeIfc3Kks6dKod7C+sAv7bDjBac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783759166;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=JgKNGzKwEPTCNFdiK2pJ4noGSKYLVL5tPQd4kCy1LUQ=;
	b=rWKhQFsA0XTtERBlF1mlQPLBcDce6C5h3MrqItuLYFnWCfMtvZwWg0+IFi7LKoRf
	OHosFJHD7CGWImPPOZMx9hYiuubjj8hl6Mbm6F5vaAhTDUjSK5F6hjGYZyQZR5qnd7b
	RgQwu7Fv5RYKg8fXKpqFNh8dq2TQUtnv+fo+G7vw=
Received: by mx.zohomail.com with SMTPS id 1783759164990138.62137875120504;
	Sat, 11 Jul 2026 01:39:24 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Sat, 11 Jul 2026 14:09:15 +0530
Subject: [PATCH mptcp-next 1/3] Squash to "mptcp: pm: init and release
 mptcp_pm_ops"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-mptcp_pm_ops_null_deref_join-v1-1-843ebd7ac0cf@mpiricsoftware.com>
References: <20260711-mptcp_pm_ops_null_deref_join-v1-0-843ebd7ac0cf@mpiricsoftware.com>
In-Reply-To: <20260711-mptcp_pm_ops_null_deref_join-v1-0-843ebd7ac0cf@mpiricsoftware.com>
To: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>, Janak Patel <janak@mpiric.us>, 
 shardulsb08@gmail.com, Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

msk->pm.ops is cleared here on the teardown path, but it is read
locklessly from the softirq MP_JOIN path: mptcp_pm_get_local_id() and
mptcp_pm_is_backup() are reached from subflow_token_join_request() on an
inbound MP_JOIN, holding only a reference to the target msk (from
mptcp_token_get_sock()) and without the socket lock. Annotate the store
with WRITE_ONCE() to pair with the READ_ONCE() on those readers.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/pm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 033f783d49902..4d8f8c999b1de 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1158,7 +1158,10 @@ static void mptcp_pm_ops_release(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_ops *pm_ops = msk->pm.ops;
 
-	msk->pm.ops = NULL;
+	/* Paired with READ_ONCE() in the lockless softirq MP_JOIN readers
+	 * mptcp_pm_is_backup() / mptcp_pm_get_local_id().
+	 */
+	WRITE_ONCE(msk->pm.ops, NULL);
 	if (pm_ops->release)
 		pm_ops->release(msk);
 

-- 
2.34.1

