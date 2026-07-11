Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4F76025
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783759205; cv=pass; b=OFKtxX54PPiE+o9R+xyhqTwNTV4B95GhreKdsxS5/wXITZaYHGcPGvJ+yyqai5shoSYhoNBgZA1PSaO4gpYpe0Ot/Wf7mNOdaL/lpcemlfkC0T5EuwCFkL2CzPMuGwA94qWhu/gEd6Y7vub70Nbl1oL3v+a2ZwDuOuiS7DRDopg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783759205; c=relaxed/simple;
	bh=HNKSA7c1i5wbb8TQbTZqG7h7kVtQ0XTLf98DNlOUu6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KmrNgGIj81FWUIF5dKJgR0s2tAKIaL30krVaTYXmTVeRqtJT0v9LTXQmRPGBm3yLgncJigI1vYDYjOHXhN6CUycWunlfZ80Gcq5kEQvFAg/FxOhnVJDPxjtqu/fHfrKxnqoOpkR6Cjl0hYhkUl1n3zdRImuo3iO8956QMFiTJPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=E8Fkb9GV reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="E8Fkb9GV"
ARC-Seal: i=1; a=rsa-sha256; t=1783759174; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gRaPB1Xx23LXJJssTy6puNERMJPU6DxpHBhE5Wm4QDUyBqSkdR5CJ0s5RN/0qXNucrK/8uRBJiuNGFXrGtl1QtjVIb8qK4sSaBwytof5fnC9aijAtCwmgSYZXNXuUnMIFmbfY8gYoTd6UvC8h6kfHXEyCCyGbyooUzPaO7kl7Qs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783759174; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wKPo4d3mhxkkvOVzujMQBOsPO10/UeKpMRPM/iuL05I=; 
	b=n+TDtYCadqnbRb61TPpUdomXmCMBDeGD+lf8SsREDjDhK+ncOStjVADmYwRPu1F6X6NpHxrKItmojoBc66oY5Yi/5dcpfYfbMiWTPe4vDNrn8m2lXTfSJbldXqBKxndFUSho2MKrIiNc/bFPg2R/h42aPlvCNN4Y4IhVhc+rhwY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783759174;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=wKPo4d3mhxkkvOVzujMQBOsPO10/UeKpMRPM/iuL05I=;
	b=E8Fkb9GVBadXR4OXNDOC7MITn050rh3vEMBA89OaIDNtLL0BiDS9tBfvG81u5XOt
	h+lue4m8rbqjWLZptMJzQGdLSNkqKGnNz57U/sk8gvJEnuxZHLvfz7nhfviN/fE6ezi
	nikBOrJKLwbquWuHuJByCvQ77qlZbjDGqTsiqqwQ=
Received: by mx.zohomail.com with SMTPS id 1783759172771190.37490046917708;
	Sat, 11 Jul 2026 01:39:32 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Sat, 11 Jul 2026 14:09:17 +0530
Subject: [PATCH mptcp-next 3/3] Squash to "mptcp: pm: add get_priority()
 interface"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-mptcp_pm_ops_null_deref_join-v1-3-843ebd7ac0cf@mpiricsoftware.com>
References: <20260711-mptcp_pm_ops_null_deref_join-v1-0-843ebd7ac0cf@mpiricsoftware.com>
In-Reply-To: <20260711-mptcp_pm_ops_null_deref_join-v1-0-843ebd7ac0cf@mpiricsoftware.com>
To: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>, Janak Patel <janak@mpiric.us>, 
 shardulsb08@gmail.com, Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

mptcp_pm_is_backup() now dereferences msk->pm.ops, but like
mptcp_pm_get_local_id() it is reached from subflow_token_join_request()
on an inbound MP_JOIN, in softirq and holding only a reference to the
target msk, without the socket lock. A concurrent close()/disconnect()
clearing pm.ops via mptcp_pm_ops_release() between the token lookup and
the dereference triggers a NULL pointer dereference of ->get_priority.

Read pm.ops once with READ_ONCE() and return false if it is NULL, the
safe default for the backup hint (the join is already rejected by
mptcp_pm_get_local_id() if it observed the same NULL).

Found by an MPTCP protocol-flow harness extending BRF (arXiv:2305.08782),
which drives inbound MP_JOINs against a connection under teardown.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/pm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4fcd9d30b3df2..12cb2f7b5af92 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1058,10 +1058,20 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 {
 	struct mptcp_addr_info skc_local;
+	struct mptcp_pm_ops *pm_ops;
+
+	/* Paired with WRITE_ONCE() in mptcp_pm_ops_release(). An inbound
+	 * MP_JOIN reaches this via subflow_token_join_request() on a msk
+	 * obtained from mptcp_token_get_sock(), i.e. holding only a refcount
+	 * and no socket lock, so a concurrent teardown may NULL pm.ops.
+	 */
+	pm_ops = READ_ONCE(msk->pm.ops);
+	if (!pm_ops)
+		return false;
 
 	mptcp_local_address((struct sock_common *)skc, &skc_local);
 
-	return msk->pm.ops->get_priority(msk, &skc_local);
+	return pm_ops->get_priority(msk, &skc_local);
 }
 
 static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)

-- 
2.34.1

