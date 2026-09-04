Received: from mta1.migadu.com (out-140.mta1.migadu.com [95.215.58.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565043B42F2
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507217; cv=none; b=cZHfSWh52LIlMjrJxgL8d7+7V3yQYsECdEIQ4NNjaCVHLFPJtbxGPwGiTHHlcoTX4tw27IStlsDez9//hV8wLxSM9v3R3qaAbhmeeyx/QZjCAVyL+swI2xxzGh4gpo4FzyKaVRTEhjGWS1a1FuJme9VlhyQXD/KzjpUAKGsxDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507217; c=relaxed/simple;
	bh=uqZS/vI+dGF+QJXloOkY0UqwwvW2/THSXcJob7V1dO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7ozUGX246Z1VcBOErI1jB2kFc4ESVrpOsHrjOOSbO7Wrn6h0A0QevxFkIUMJ4BrahIFHNjwPGAcmz/Ywnz9FqwBbwy6NvIo4V3UtMxTzHhh45QmGcOYNKdIqNT1ciuDP0T/UXmDqyov0iYV/fcpijcx3PmhvePhl3lOr+8v8/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qTpntxhT; arc=none smtp.client-ip=95.215.58.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qTpntxhT"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=uqZS/vI+dGF+QJXloOkY0UqwwvW2/THSXcJob7V1dO0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788507212; v=1; x=1789112012;
 b=qTpntxhTFlmcekI76vU+23pZDI+z2XxgxdJt+MeLODkkCeoEzNhUi+3svJupZjJ4AVr7MMIG
 zza9uFoemXa9uTjJuiWaGJVfVjPGkFDh36zLdq0kcEWAdVlT5rvFcUJwSghR8SDouOG+sbFm9cU
 kFK+MWPZ8GWquVdAV3H2N9SI=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 9e3e72e5590e5224;
	Fri, 04 Sep 2026 07:33:32 +0000
X-Mizu-Trace-ID: 9e3e72e5590e5224
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH mptcp-next 2/2] mptcp: pm: take pm->lock in mptcp_pm_data_reset()
Date: Fri,  4 Sep 2026 15:33:11 +0800
Message-ID: <20260904073311.1285024-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904073311.1285024-1-cui.tao@linux.dev>
References: <20260904073311.1285024-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

mptcp_pm_data_reset() clears the PM state with a plain memset while
the RX path can access the same fields in BH context under pm->lock:
on a disconnecting socket, mptcp_pm_allow_new_subflow() and friends
can run concurrently with the reset and see partially cleared data.

Take pm->lock around the reset. All the callers hold the socket lock
at most, so there is no lock inversion.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 net/mptcp/pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8b68868255c50..e224aa6f63dd9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1179,6 +1179,10 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
 	struct mptcp_pm_data *pm = &msk->pm;
 
+	/* the whole PM data is protected by pm->lock, the reset can
+	 * race with the RX path on a disconnecting socket
+	 */
+	spin_lock_bh(&pm->lock);
 	memset(&pm->reset, 0, sizeof(pm->reset));
 	pm->rm_list_tx.nr = 0;
 	pm->rm_list_rx.nr = 0;
@@ -1201,6 +1205,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 
 		bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	}
+	spin_unlock_bh(&pm->lock);
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
-- 
2.43.0

