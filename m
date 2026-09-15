Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195184B2718
	for <mptcp@lists.linux.dev>; Tue, 15 Sep 2026 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474608; cv=pass; b=vA8vSdghmbPSY+g8f4TyaE4pC43zpLhQNP4VdyKAsxtBbUllnxmrKZONA2dXrECNXvZ4RAfwd7+71jSdl9BCC+mE2kKrAifpmPxEV4RGpVOm4uNql9bFVnxsXXGcfIMUmeB5Zi3M86LeNdzlbMkhFy2Jozd/DsH3GC0I3pssSmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474608; c=relaxed/simple;
	bh=vOBPlcKbW1yxr1mL9fYzl2S+nMjvrKcyf6Aqr7sC6Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYrjooKuwJ3ZQHeWoEIyZ3n0NG3xa8GL6ZCaW/8LvWIwLcRaDhXW6l9j1lMogXOp30fZGTygLBRZZnzjLDq/iGzuxXfYqEGOndgi2YgwQiUqlR5GLxXk5DPCFUQ72sMEicY8rlqSXbpzF8mqwvU6ystC4KmCqGu3U7ZwXqLK2BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=akshit@mpiricsoftware.com header.b=ftPiJDOD reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=akshit@mpiricsoftware.com header.b="ftPiJDOD"
ARC-Seal: i=1; a=rsa-sha256; t=1789474602; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jDgpOvT0vvLX8ApG/xdPpRbgPsKn/txh1m6JFIyWwSmL1TwSG/4z8Mz//z+Jx2BZYWmbIFxnzPDZsMyC+5WakSwr/l5q0ztQpFYGtUUM23JuxF3mC9hFlBtwLOjdhG0X+uqANftvi0UqWJEmDrAzFuVCiAlL41vPvdqMEGfFFvI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789474602; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1xYLuZl+I2o+d72bQWN6/QXXf1zaUEJBzU9V5A6zjm8=; 
	b=Ogo9baduUZ8bWfjhcU/icNsUhjdZom+KHCCoPUlMfsg/DNTS5iRE4HqgYEF/gv/+7KF2XPClMNRi/GOOvqEiFASosD1pcUnaU8OBIM86MAqrRbHBbTD6qIA4XRwm3sVmuvG1w/uITWlUiKEVMHA3ejNuRRd0tvEM4+t0dqYUxsQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=akshit@mpiricsoftware.com;
	dmarc=pass header.from=<akshit@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789474602;
	s=mpiric; d=mpiricsoftware.com; i=akshit@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1xYLuZl+I2o+d72bQWN6/QXXf1zaUEJBzU9V5A6zjm8=;
	b=ftPiJDODtHb0U6V9iiMs8bnc41NHQt4L1page2u+U9r4qSS0IldzH7JfOTOzYiRN
	xGyL5zVga5PjSDuuX2Q+XkoBf1e1D9+5BmPH13pqn+IOupw+9/i98DcGhJb4wN6Jbhz
	3HlbkZ6zI4hr3/9fjmhXcL7mkXjG30Togl4+bFQQ=
Received: by smtp.zohomail.com with SMTPS id 1789474596830265.6690777209882;
	Tue, 15 Sep 2026 05:16:36 -0700 (PDT)
From: Akshit Patadiya <akshit@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	pabeni@redhat.com,
	shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	kalpan.jani@mpiricsoftware.com
Subject: Re: [PATCH mptcp-next] mptcp: fix add_addr_accepted accounting on subflow close
Date: Tue, 15 Sep 2026 17:46:22 +0530
Message-ID: <20260915121622.1151132-1-akshit@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813123754.4095492-1-akshit@mpiricsoftware.com>
References: 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi all,

Gentle ping on this patch. When you have a chance, could you please
take a look and let me know if there are any further changes needed?

On Thu, Aug 13, 2026 at 05:19:09PM +0530, sashiko-bot@kernel.org wrote:
> [High] Concurrent updates to msk->pm.rm_list_rx can cause RM_ADDR IDs
> to be silently skipped, resulting in leaked subflows.
>
> If a remote peer sends multiple RM_ADDR options in rapid succession,
> softirq context can call mptcp_pm_rm_addr_received(), which
> unconditionally overwrites pm->rm_list_rx while scheduling work

Looked into this, it's real. Traced it down:

mptcp_pm_rm_addr_recv() passes &msk->pm.rm_list_rx straight into
mptcp_pm_rm_addr_or_subflow() (pm.c:830), and that loop re-reads
rm_list->nr / rm_list->ids[i] on every iteration. It also drops
pm.lock mid-loop around mptcp_subflow_shutdown()/mptcp_close_ssk()
since those can't be called under a spinlock.

Worse, mptcp_pm_worker() clears the MPTCP_PM_RM_ADDR_RECEIVED bit
before calling mptcp_pm_rm_addr_recv():

	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
		mptcp_pm_rm_addr_recv(msk);
	}

so if a second RM_ADDR shows up while the first is still being
processed, mptcp_pm_schedule_work() sees the bit already clear,
treats it as new work, and mptcp_pm_rm_addr_received() overwrites
rm_list_rx right under the loop during one of its unlock windows
instead of getting coalesced. End result is the outer loop's i /
rm_list->nr can go stale mid-flight and some IDs from the original
batch just never get processed.

This is pre-existing, not something this patch touches (different
struct, different lock concern than the id_accepted_bitmap stuff
here), so I'm not folding a fix into this one. Will open a separate
issue/patch for it, can take it myself if nobody's already on it.

For #498 itself, this patch should close it as-is. It also looks
related to #496 per that issue's note - let me know if you want me
to check whether this covers that one too, or if it's a
prerequisite.

Tested against mptcp_join.sh for the close-before-RM_ADDR case,
fullmesh reuse of the same remote id, and duplicate RM_ADDR - all
passing.

Thanks and regards,
Akshit Patadiya 
