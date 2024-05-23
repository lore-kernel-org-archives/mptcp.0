Received: from chinatelecom.cn (smtpnm6-04.21cn.com [182.42.158.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C13413CAA3
	for <mptcp@lists.linux.dev>; Thu, 23 May 2024 08:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.158.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451595; cv=none; b=ua4dvbjPglxtr27KPhDLiICFS7rot6xNVrDdMHRni6qAr9Hx2gcYVnR1ppC76LYDlkcpFykqvZzhOUbY4Nd7GLLUbWHxpMZP1vA/JfDGet7d/tUtQe3y5FViaxWlHCuKg3Y2gIvMY9eelRJNpguCkN8iVKKrySTZhBrzJIE33No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451595; c=relaxed/simple;
	bh=nuhth45E674FydDeAsVKMEDEFYrS8BdbMYYvKEhoIx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PXzq2FM03FYiNbZg2NFrcLZT9mhZRv846lrZWZDNClJAJtecCTFg9FOX+iwWyNnV9VpONix1OBrgK92Boct7Eod315B6YBMRCdRV+xtmaguRha5ZelhC+kYsUlqZpGPgg3O5foo965sNyxV421ErO1lyMogGx6ErssgRD3ThlSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.158.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.138.117:62437.1273893622
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9 (unknown [192.168.138.117])
	by chinatelecom.cn (HERMES) with SMTP id 31B9DA053;
	Thu, 23 May 2024 15:56:42 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([36.111.140.9])
	by gateway-ssl-dep-84c6c6b769-jsnsj with ESMTP id 4482adcace2444f7834d854347c0dad2 for mptcp@lists.linux.dev;
	Thu, 23 May 2024 15:56:46 CST
X-Transaction-ID: 4482adcace2444f7834d854347c0dad2
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 36.111.140.9
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org,
	matthieu.baerts@tessares.net,
	liyonglong@chinatelecom.cn
Subject: [PATCH] mptcp: make RMADDR MIB counter clearly
Date: Thu, 23 May 2024 15:56:34 +0800
Message-Id: <1716450994-5145-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

From: YonglongLi <liyonglong@chinatelecom.cn>

it should inc RMADDR MIB counter when received RMADDR but didn't
find any subflow related,

Fixes: 7a7e52e38a40 ("mptcp: add RM_ADDR related mibs")

Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
---
 net/mptcp/pm_netlink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7f53e02..766a840 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -814,10 +814,13 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			spin_lock_bh(&msk->pm.lock);
 
 			removed = true;
-			__MPTCP_INC_STATS(sock_net(sk), rm_type);
+			if (rm_type == MPTCP_MIB_RMSUBFLOW)
+				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
 		if (rm_type == MPTCP_MIB_RMSUBFLOW)
 			__set_bit(rm_id ? rm_id : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap);
+		else if (rm_type == MPTCP_MIB_RMADDR)
+			__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		if (!removed)
 			continue;
 
-- 
1.8.3.1

