Received: from mta1.migadu.com (out-139.mta1.migadu.com [95.215.58.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3D381AE4
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138467; cv=none; b=VyhCU0FEkrQ6mn/vKvwvl7mUHqveMiYFavYINmvxK48X/ZWqk4iwS+K4dmvkAz5nz8A7C8IC+QUcA1msq/bhBEcicYfyS4s3BMi04KrX0ECGlahjbOlQ+7midB1fYxHCO6vdVt5N7apcc0oV34puyEfjyuamjbL42l4n+1nlbM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138467; c=relaxed/simple;
	bh=K9SYtSYrcUUzhStkIn9dcSaf8Rrq6ewmhBK2ChNSrnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pZcXynK7wLz92oq742a7oNnOsJ08B8zcr8c4A0ExAIxp7rJ46EOJm8G2lA0cTAV399wHadbEMqHctuGWmjKOEcmGYb/tBLEPWKFNdl3bDGCHaNmV+K8CE5QN2eJTrVuE2DfI5uf5fXlqrorfRZeLU/WNMZPc9FBVYPs8dH29oMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qyk9a658; arc=none smtp.client-ip=95.215.58.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qyk9a658"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=K9SYtSYrcUUzhStkIn9dcSaf8Rrq6ewmhBK2ChNSrnM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787138461; v=1; x=1787743261;
 b=Qyk9a658o8nmdUb1Xn7ezym8LTW5Pi4QlIdV8B16bEwKLLl89MZb22sQin6Pyinmi9m6n3GA
 Logma+0RODO8X2MW0hoiz8xikVyMi4uTdzSPxu6i1CbSuppvC2oBS0TuniaBPAvms+4lNufzdWS
 XbMvDtPrYiZmiqZ3afXoccrA=
X-Envelope-To: mptcp@lists.linux.dev
Received: from localhost.localdomain (223.70.159.239)
	by smtp.migadu.com with ESMTPS id ff202aea241f8031;
	Wed, 19 Aug 2026 11:21:01 +0000
X-Migadu-Flow: FLOW_OUT
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: mptcp@lists.linux.dev
Cc: chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH mptcp-next RFC v5 0/3] mptcp: fallback to TCP on MP_FAIL with a single subflow
Date: Wed, 19 Aug 2026 19:21:09 +0800
Message-Id: <20260819112112.1985121-1-chenguang.zhao@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Patch1:
 Add MPFailFallback MIB counter

Patch2:
 Move the FALLBACK_DONE flag setting to right after MP_FAIL is received.

Patch3:
 Add a __mptcp_check_fallback() check inside mptcp_can_accept_new_subflow()
 to reject MP_JOIN requests earlier.

I have tested with the script from the linked URL, and the kernel is now
able to reject MP_JOIN requests early.
 https://github.com/chrisocean716-star/packetdrill/blob/fed57fab92c407eb433acdb8c8ce72bd8e3e2f37/gtests/net/mptcp/mp_join/mp_join_server_after_fallback.pkt

Chenguang Zhao (3):
  mptcp: add MPFailFallback MIB counter
  mptcp: fallback immediately on MP_FAIL reception
  mptcp: reject new subflows after fallback

 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/pm.c       | 5 +++++
 net/mptcp/protocol.c | 8 +-------
 net/mptcp/subflow.c  | 1 +
 5 files changed, 9 insertions(+), 7 deletions(-)

v4:
 https://lore.kernel.org/all/20260818091417.2200986-1-chenguang.zhao@linux.dev/

v3:
 https://lore.kernel.org/all/20260812054653.43799-1-chenguang.zhao@linux.dev/

v2:
 https://lore.kernel.org/all/20260715061830.1057851-1-chenguang.zhao@linux.dev/

v1:
 https://lore.kernel.org/all/20260713064134.914507-1-chenguang.zhao@linux.dev/
-- 
2.25.1

