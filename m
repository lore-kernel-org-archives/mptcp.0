Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA201FD4
	for <mptcp@lists.linux.dev>; Sat, 20 Jun 2026 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781945096; cv=pass; b=DFHUpVcGZbneopWZUwdXULtF2dcjqBw0QgoJ0JWT/NyTiDNQqxcGSDWs3MEfC5gbgnuM8Br0GsZPUqnQdjPdD1bYJLrsuX2sUpMOU8jY2woTpVT1ypkVLiFkWvmllpvoTB+qRMTcZOLgOkk4QV2AA+e4JztS6zMDZnQMuZDhdpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781945096; c=relaxed/simple;
	bh=RlZe4NcNypaezTl1zjoXqgLEWnnK/WyqF8nmCzoJqSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFZ+57GaUeLlEW9CLACPira6XtXhMmteGin4PbNN/JJY8T9HqKpV7VeTDf02AQo0HrjwYFjOOA4u0GNcYas6dt9Dpu6nf30WYlQIkqIeOSPDqacGsaaI7EwnsVQtjxb6E2ABYLKOu7cBew7MlkdGA84Nh9Ph3zIrWX/7vHDyuIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=kewkXiVT reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="kewkXiVT"
ARC-Seal: i=1; a=rsa-sha256; t=1781945089; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R4k1h0prExxpZ561JCVZHY33Stk3Qz6YfkkYPaPdD6mLZggiQaD+PTDX0mjC+tqqcMLlhCfyJD/7zI8XsAlRcFhHfhx47I3JkeL6GOtVYHZmdXUTAUUUBxPQO3x6j1916gqQqxrF9vSAS+lLdndqZUs0rnjOzlfiX+UaQsQAQ7k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781945089; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GnS3AG4scfFutrkBxWSCGu80+IvAa7nw5ZgT6JaGF88=; 
	b=O56z209ArcOxYWXqwrkyPCOEiX+Ebr6RkmLot7IraXIli8KryYt/1MQByjI/fKyh446E6GEERciKzcH9w8n6Pys9vovfVFca+TCk4ylFHfABv+HGiS3IGbVJJ/mg+C0kpN5vbjVRp/z0KGUZ9SJKuGLYKSrluhpnl9+DnGtQty8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781945089;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=GnS3AG4scfFutrkBxWSCGu80+IvAa7nw5ZgT6JaGF88=;
	b=kewkXiVTcwd2+LIzbxODTzupnVZC2RxgvlBC2NrziF1WUQUJgsE0Z+dfDk5xGe22
	nunpcs2DbWPKePeQMvvkYOgp0N6z9mEUjUWZcowaUDCYC4VINAr59QS7scnxZLzmxL2
	zpGq5+PJyoEy5X8eUIBXVxqKPcEeJ3p1R7yjTytM=
Received: by mx.zohomail.com with SMTPS id 1781945088085155.4695709881928;
	Sat, 20 Jun 2026 01:44:48 -0700 (PDT)
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
Subject: [PATCH mptcp-next 0/2] mptcp: pm: net-next port of the alloc-during-teardown leak fix
Date: Sat, 20 Jun 2026 14:14:22 +0530
Message-Id: <20260620084424.3072634-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This is the net-next counterpart of the net fix "mptcp: pm: fix memory
leak from alloc-during-teardown race" (v3):
https://lore.kernel.org/all/20260611003613.3184956-1-shardul.b@mpiricsoftware.com/

v3 remains the canonical fix for net; it applies as-is on export-net. It
does not apply on export, because the userspace local address list free
moved into the userspace path manager .release callback in "mptcp: pm:
init and release mptcp_pm_ops". This series ports the fix to net-next:

  1/2 squashes the unconditional free into that refactor commit (covering
      the disconnect/reuse path).
  2/2 is the MPTCP_PM_DESTROYING fence (the alloc-during-teardown race),
      rebased onto the renamed mptcp_pm_announced_alloc() /
      mptcp_pm_destroy().

The net fix was validated with an MPTCP protocol-flow harness (BRF) over
multi-hour runs with zero kmemleak reports (reported on the v3 thread).
This port is structurally equivalent and is sent so the CI can exercise
it on net-next.

Shardul Bankar (2):
  Squash to "mptcp: pm: init and release mptcp_pm_ops"
  mptcp: pm: fix memory leak from alloc-during-teardown race

 net/mptcp/pm.c           | 13 +++++++++++++
 net/mptcp/pm_userspace.c | 10 ++++------
 net/mptcp/protocol.h     |  8 ++++++--
 3 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.34.1

