Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1D3D3CF0
	for <mptcp@lists.linux.dev>; Thu,  4 Jun 2026 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557560; cv=pass; b=U48kl30xcOo9A+JCc1Y/xZTroYodS6bsGIDCpDc/3pncP4Q9diA4djhqSS2UXgoKDvfGPxYUX4NoZ8C5SJybhfSHsdePPlIy931OGvEfRN7LzJ4MMg2n4jW8Xald/QQ+hrjdtDKSHXK3uxjlEvuyGssArkXlLyIbE96wYhND8zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557560; c=relaxed/simple;
	bh=BzFqMcR4sIrWQt29095yShjGvgq7kd7j1nv9gIta0r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5hy6jyp+MBlIBmVPWy/aEZFl9RBUQ2Hfe3/kyS0IENo2+m/rnsldx9hldPiHcb2Q2+J4HKAEOf2ZmH5VRWX7RFI7OMDCbLIVDn/RqsBGJbfSft6nPpYyl0MknWMHpUwpIrOdNu35ee096zFBuJakaNAvBdVKqJwrspStgXqGEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=WnaMp7Wa reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="WnaMp7Wa"
ARC-Seal: i=1; a=rsa-sha256; t=1780557556; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ibJqU2d9jOEZ4DUbsiEfeAjnoS/oREXjD6k4LYbJ4Pn65CIvldSeD4DX9dFBK3inxWUvIG7ob2HmlruSEiAPkYbAD73PSx0R2APmTkSUU+AEyhqzhF/7l54d9DSOgHhy7lIWLUUvyEGOTOnxACb7KXXRaaVvlU6dQSkw48aGDTg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780557556; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8dGMn5B1QbXpyGA4uqemmPVzWr+9m+yWmDOOFcJu6W4=; 
	b=Qjw7AZhzoglwZD2edAKpR9oy6WElUdqQcuYjKK2lc1Bx3g70HyiMWawBTvnuRbeDZf7+BcsmpsLHgZbG0gY2ByB7VbBRjcH6uhz11jo0EdXGQ+6Vp4R4O7u9OavMCD81rSDlkJVl6qtz+hmuYn8dNiLeBMfXSS4a0scp5RLvY6U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780557556;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8dGMn5B1QbXpyGA4uqemmPVzWr+9m+yWmDOOFcJu6W4=;
	b=WnaMp7Wabs2fjyGYQxUUfMMQ+fAkvhtHpCkKlNfuxPvO+xwNstZTprlt0ehZQfUF
	XFE/3ULcMVExBAFGZuGx9CwUHlyoTR1GtSvio/pC4ME9Rp0FOwsTFyO1l5XeMS7rw+H
	N0qQt9XVmMi1o2CqVaeglcTDWizUpYjf6tb/R8iE=
Received: by mx.zohomail.com with SMTPS id 1780557554331723.580473249301;
	Thu, 4 Jun 2026 00:19:14 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: xiasonglee@gmail.com
Cc: lixiasong1@huawei.com,
	mptcp@lists.linux.dev,
	matttbe@kernel.org,
	janak@mpiric.us,
	shardul.b@mpiricsoftware.com
Subject: Re: [PATCH mptcp-net] mptcp: prevent add_addr timer rearm during teardown
Date: Thu,  4 Jun 2026 12:49:09 +0530
Message-ID: <20260604071909.3260023-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526103647.732350-1-xiasong.lee@gmail.com>
References: <20260526103647.732350-1-xiasong.lee@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Li,
 
Great work on this patch series! Your approach of creating sk_shutdown_timer_sync()
helper is the right pattern.
 
I noticed one additional issue: in mptcp_pm_free_anno_list(), the timer_done check
is unsynchronized:
 
    if (!entry->timer_done)  // Data race: no lock protecting this read
        sk_stop_timer_sync(sk, &entry->add_timer);
 
This is a classic data race. Your patch keeps it as-is, but I think we should
also fix it by removing this check entirely and always calling timer_shutdown_sync().
 
Would you be open to adding this improvement to your patch? The benefit:
- Eliminates the data race
- Simplifies the code (unconditional shutdown)
- timer_shutdown_sync() is idempotent anyway
 
I'd be happy to:
1. Test the updated patch
2. Help refine the implementation
3. Co-author if you'd like
 
What do you think?
 
Cheers,
Kalpan Jani
kalpan.jani@mpiricsoftware.com
