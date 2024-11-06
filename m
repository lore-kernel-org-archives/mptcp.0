Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50284653
	for <mptcp@lists.linux.dev>; Wed,  6 Nov 2024 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730877076; cv=none; b=Id2jZTKHUWV1tI+wFyrfjgPH9hHeTHe9dHBUM2RD+NWOOBpg2aeGwRDkjiWybyHQaP4wZIkVZfowYwaTozGYsGWdaiu3U99qQzj9XyFPH3Sgf3yKlju0z2CK2IW8whpHHvLg7kA1+y54Sb5ecfMq+sJ4ig/iF40vG4dUEkro86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730877076; c=relaxed/simple;
	bh=bic8U/7EprTF5tO0m+FTNPsSXiyFSKnhDFBIh5HETFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R1yRPlCEux3k5f3KPufUbeV2rtJzllVWp3PmyEIDb3URAzxIfOeMvpNSiq+KxDFBxYV95QghAoN1I4oL6whQHzuc5f038/Tjk1xhj8tXrpEVdMFH/T45cb+04FBVzEFOYW2iF8D/I3csnkl+VqbB2l3D+whZJ5XF3Zh792C2at0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aZ3sg9R/; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aZ3sg9R/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uivsu
	ld9fyepD+tXzzr88CQjezyhiA9keWMJ873haXQ=; b=aZ3sg9R/2RdxrofC5jyiH
	T8XyXyc5USvUzpCDHg5OVBzQVfTYefszgwO8M1kChpNn2FxDMPm0I5BPC6pXCti0
	++p/Ksb4ZXk3obtHf65qhk9mTNmQ+Meb7RhzWnFkyMLKc4aGLtfIkgEKg73Gcwxo
	p9+0JPD+nwljVpssUSm4/A=
Received: from localhost.localdomain (unknown [14.153.182.146])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnT8duFitnbBgcCw--.18643S2;
	Wed, 06 Nov 2024 15:10:39 +0800 (CST)
From: MoYuanhao <moyuanhao3676@163.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	MoYuanhao <moyuanhao3676@163.com>
Subject: [PATCH] mptcp: remove the redundant assignment of 'new_ctx->tcp_sock' in subflow_ulp_clone()
Date: Wed,  6 Nov 2024 15:10:35 +0800
Message-Id: <20241106071035.2591-1-moyuanhao3676@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnT8duFitnbBgcCw--.18643S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw13Aw45tFWUKry7KFy8Xwb_yoW3Zwc_Xw
	s7KrWxX3yYvrZF9F4UZw4ft395Ga9rJ3ykZr95tFZ7t3WFqa4kAr18Kryruryfua17u3y7
	Ca15Aa40kr1j9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjnNVtUUUUU==
X-CM-SenderInfo: 5pr13t5qkd0jqwxwqiywtou0bp/1tbioAGPfmcrDATNlAAAsN

The variable has already been assigned in the subflow_create_ctx(),
So we don't need to reassign this variable in the subflow_ulp_clone().

Signed-off-by: MoYuanhao <moyuanhao3676@163.com>
---
 net/mptcp/subflow.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 07352b15f145..fd021cf8286e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2049,7 +2049,6 @@ static void subflow_ulp_clone(const struct request_sock *req,
 	new_ctx->tcp_state_change = old_ctx->tcp_state_change;
 	new_ctx->tcp_error_report = old_ctx->tcp_error_report;
 	new_ctx->rel_write_seq = 1;
-	new_ctx->tcp_sock = newsk;
 
 	if (subflow_req->mp_capable) {
 		/* see comments in subflow_syn_recv_sock(), MPTCP connection
-- 
2.25.1

