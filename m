Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4AA257424
	for <mptcp@lists.linux.dev>; Tue, 25 Mar 2025 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900907; cv=none; b=sOR2iA4+fgsvSD9ebCtg84WF0WviA3U1wx3HGorG5zOMAGRm2q43aPOY3A1qM3/o1Lv8/E5ynd1VYqFSkX/TvPBRBMFgWGdU9C0EQVDJX1Sx3oQV/7kVasD3HyMJj8yaL+ExF7zq2T+use6Ki8nJig9Yrhy9Etm1Cl9CaIfCnLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900907; c=relaxed/simple;
	bh=Fp3OuqKIGI87B+2qLAxVYAj1U/8NXpcexesT2kFFqoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wm+i7EPiA3T9x84gj77GS1bhpuZyUQWqZCxFnT/tcbsRP6nxsLTe0vII/w0gHjCNNacsUBMAIpmHo+FYHv4CCm9TPuvRnFBNjvubTsW83Ts4ywCgcBNuXUuljEvSGjQ+akKr2+JqXDfluFtC0kSPInJ769MR8sfLHv+JE2TFRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tg7vjrNQ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tg7vjrNQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742900904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cQwFKVuOUJVkhVIojgcrzkha3ElxfIW69cI+JU/dNp4=;
	b=Tg7vjrNQRJ6lXbi19BR8wkML3vpzTtgbaltdrGjQi7/ovYGEf+urVTbTtwe+L13zmxmk+n
	Zatr/MZ7LHa8epIRed9+nfLrFVAcbmhwF6rblxhnPmTVTN9WD1xzZmuuaPa5w2RrLLqHOf
	nKWFZ9HCZX4YiGWycUodp95zp0abBmo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] mptcp: pm: Fix undefined behavior in mptcp_remove_anno_list_by_saddr()
Date: Tue, 25 Mar 2025 12:06:39 +0100
Message-ID: <20250325110639.49399-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit e4c28e3d5c090 ("mptcp: pm: move generic PM helpers to pm.c")
removed a necessary if-check, leading to undefined behavior because
the freed pointer is subsequently returned from the function.

Reintroduce the if-check to fix this and add a local return variable to
prevent further checkpatch warnings, which originally led to the removal
of the if-check.

Fixes: e4c28e3d5c090 ("mptcp: pm: move generic PM helpers to pm.c")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/mptcp/pm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 18b19dbccbba..5a6d5e4897dd 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -151,10 +151,15 @@ bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
+	bool ret = false;
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
-	kfree(entry);
-	return entry;
+	if (entry) {
+		ret = true;
+		kfree(entry);
+	}
+
+	return ret;
 }
 
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
