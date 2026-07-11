Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD90123392E
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783759174; cv=pass; b=gM5oYS/APvH4Giow6FlAdX1PynjUFtO0W4HPGYmZLjCC0WWz4HGsvcktxtEhk83OCVhvJvdjFys2h3+vVaRaTnyA9LbSeP3A9Br9NHW/F9EDSfoAhIrA6U1XLLZOEkOUsE1gS08bIgftwgsvlL5qX8Ts7KhFLi4rNajDI+MsBdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783759174; c=relaxed/simple;
	bh=DkdQenwevlcseMkHN0/iAxXm5NhrnQAnE2s64ZD3FsA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hRqyi91uISx54RrcoVPVZOFxMFZnsZ52aUN98SZ0PFKjohm2nGst58ypnY1HNVFKc6MWlq+6fslQZ9S1zbeHbgbxPrSaQ6Ph5nX4J6Lq1hBA1BzUCYGSv+HQSM3qyRbdRL1gs80dw2chs5vghA59Q9WvDjjK+46NUE6wANDI0jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=f239HMRS reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="f239HMRS"
ARC-Seal: i=1; a=rsa-sha256; t=1783759164; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lbqDvasYGdx6nDrsuBr1yprAi/H875DqoVh6KYNJToIn0ol7oa6+YSHdI46QHCseHyuA0FOo7OcRdSwBG6D7vFVd1DNJ6oIWXWBkpUI5QuMUUVzMt7FftoR8LdTdLodODPFj6WHObPOrJ6XBY4myyer72nKVqv2tOAGMeqtRqwQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783759164; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mbYEgtcTD6a6JbXJOPlvBXucS309KrzDOgIFCvfdYfo=; 
	b=f4N2M8LeZEoRxl4mTGa+Zvu0zb7hgrjizSisBHYnjCYBFRq7unHyzfvD/72Q6o6BHMkXxzANFK8HfxK5CDauXYXvAN/Xj4MiLl+83sR0vRNzE8kjri35w0Dv6gcyNrLXqYGbSrl34yDwlC9XRVitT+uJbI3Er8gYHZZM35tA1kc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783759164;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=mbYEgtcTD6a6JbXJOPlvBXucS309KrzDOgIFCvfdYfo=;
	b=f239HMRS6/PHVVHjDjSSknLgJHmN30nFSbQ774R0mPKZk88Rx1xpvVfcNuvbiWmf
	V8eG924+U6TtuI81bzmJXdvAliHgukTP2lOn5rPwFyggIbhcfaVH5TedamHOcsFcU4k
	FVcikDStpgTZLhdV/bIfD4UeexAfh7JXjaecurpM=
Received: by mx.zohomail.com with SMTPS id 1783759161149415.6654243530869;
	Sat, 11 Jul 2026 01:39:21 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH mptcp-next 0/3] mptcp: pm: guard the lockless MP_JOIN path
 against a NULL pm.ops
Date: Sat, 11 Jul 2026 14:09:14 +0530
Message-Id: <20260711-mptcp_pm_ops_null_deref_join-v1-0-843ebd7ac0cf@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADIBUmoC/yWMQQqDMBAAvyJ7bsCkrZV+pZRF49quaBKysQji3
 432OAwzKwhFJoFnsUKkHwt7l0FfCrDfxn1IcZcZTGmq8qG1mkKyAcOEPgi6eRyxo0g9Dp6dakx
 f072qr6a9QV6EbHg59y84S+VoSfD+O5nbgWw6/rBtO3ZfU6qMAAAA
X-Change-ID: 20260711-mptcp_pm_ops_null_deref_join-a2f8e56832b4
To: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>, Janak Patel <janak@mpiric.us>, 
 shardulsb08@gmail.com, Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

The pluggable path-manager series converts mptcp_pm_get_local_id() and
mptcp_pm_is_backup() to dereference msk->pm.ops. Both are reached from
subflow_token_join_request() on an inbound MP_JOIN, in softirq and holding
only a reference to the target msk (from mptcp_token_get_sock()), without the
socket lock. A concurrent close()/disconnect() can clear pm.ops via
mptcp_pm_ops_release() in between, so the join path dereferences a NULL
pm.ops (a KASAN null-ptr-deref of ->get_priority in softirq).

Found by an MPTCP protocol-flow harness extending BRF (arXiv:2305.08782),
which drives inbound MP_JOINs against a connection under teardown.

Guard both readers with READ_ONCE() and bail out when pm.ops is NULL, paired
with WRITE_ONCE() in mptcp_pm_ops_release(). The affected commits are still in
the export tree, so this is three squash-to fixups, one per introducing commit.

Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
Shardul Bankar (3):
      Squash to "mptcp: pm: init and release mptcp_pm_ops"
      Squash to "mptcp: pm: add get_local_id() interface"
      Squash to "mptcp: pm: add get_priority() interface"

 net/mptcp/pm.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)
---
base-commit: e6ce9ffe5d02034a38e8bca7b78a7f58aff8caae
change-id: 20260711-mptcp_pm_ops_null_deref_join-a2f8e56832b4

Best regards,
--  
Shardul Bankar <shardul.b@mpiricsoftware.com>

