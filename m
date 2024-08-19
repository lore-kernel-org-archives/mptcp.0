Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51C1DDC9
	for <mptcp@lists.linux.dev>; Mon, 19 Aug 2024 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073327; cv=none; b=EefR347Wf/crQWcMeie77iqtf8rFHvPAiCt7/IyvZfSyY5323Xb1vk4xqmP0Jy0aoJbLnRLeGuxXXeqgHMRKalx6EO2dCBKVTDGywlLR81dyrecWqqNqx5FvNepTwR2SMHpuLHFgbUhJYHgoTchQRO4qdXKjlIVexacJ29WiSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073327; c=relaxed/simple;
	bh=FsttWvYwSPzSSUNy04zasLrpGv3vynxgrbLnfHa4HSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hRzhSMuE2ztIM05mmFB4p/dXt1ytQxvjJ5KWGnGUZyDfG7GwEDqaGrIxEnEj3L3PdQC6tvJIvxgDLe1HLTsgJWM0/rjJp72+D6M2CyRjtaIlnHVjsTUurcWTCPujJNFqHaU/Bcv9e+0duD3qYfvogdHBwTb1eS7u57G9qhBO3iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNe7h6+N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNe7h6+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF47C32782;
	Mon, 19 Aug 2024 13:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724073327;
	bh=FsttWvYwSPzSSUNy04zasLrpGv3vynxgrbLnfHa4HSc=;
	h=From:Date:Subject:To:Cc:From;
	b=KNe7h6+NavpGhErliC1I1TAeWw6A1YbxAu1snpN+zqDD5cQlpKOPPi8njNZI/l/t6
	 Utr+FAZKTCUgIsSYdGTlUTNZXCMCUsrudypW36A8K/QR0i0j8RlGTHy/VTw0IBpjkH
	 umIz1fKR45WXtZy24859TdLjv0kuy+Df/wXqpfN+gdOUNiFCttlyfAUHab0dt8RJni
	 v8TkjK2krLvOxLGMSE8Bjr9YgOm8XVWXanASbwsh+qd2DU20weDFax2MR5XR7NWwOs
	 r2PT3Giq135dP5HJlnWUjfNB5XPlsz/9HOK+FciUzKlBylhhas2zkkLq062tfeWDpS
	 wmexQqT2m3N/A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 15:15:20 +0200
Subject: [PATCH mptcp-next] selftests: mptcp: pm_nl_ctl: remove
 re-definition
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-mptcp-pm-events-v1-1-c31d472471be@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGdFw2YC/yWMQQqAIBAAvxJ7bqHCIPtKdFBbaw+ZqEgQ/j2p4
 8DMPBApMEWYmwcCZY58uQp924A5lNsJeasMQzeIbuolnj4Zj/5EyuRSRCuVtpMZpTAaauUDWb6
 /4wK/7OhOsJbyAncocf9tAAAA
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FsttWvYwSPzSSUNy04zasLrpGv3vynxgrbLnfHa4HSc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw0Vu2IRc6S+RifOUgV2eHFyURpnh12+4OKSe5
 T6Nk4QUYuiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsNFbgAKCRD2t4JPQmmg
 c+h1D/97r1JQy0T1/u5p8nWJSlnmxVVeo2YQ+Q2zTT84w/fdrCelp6yis9Rrt5EzmNP5NuAHDZD
 UGpoYW2rDKjpTBgAkieSrCjCQUzqE+TU0sN1uZxAx2HtehbuKzfg3z17TrnSPFHfRqSA8Gw7gdC
 LcdZZbrQ+Q0ApgJYX4C3OBiKQhB+ymAkZ27lBFDiDe4ik/qk+lh6aLjKkkcH7MFvzwAeLnIUEYK
 v1x1Om4gRXbioizlgoyRPc5x24PGV2cECLzoZuofucUBXAqIaTZJkonCxWiE9vTs8b8/FHefiqf
 wt4uDVDeuxTWdZ84TdhVijuCmWCdgPpFiRr0P7rG6RMe4f6JyfAabXFn/dSNk6QinN9GqhFix02
 yDvnM/Xbl5GN/BxM/W/wgUK01/YFlxmjCinJ0Sra4tSQ+uQeg3SBZmIa9POaKadFTYRDHsNMH4b
 bLcBbDNAOE6IlsQa/zPH+FwX3DBb850aio2aAZfOHI3YiMEmTwI7wrr7nU2Dt5gCexFK3KLD/1T
 Tqn/z3Jvczvx2UHkrKQE6UKpuCWkCZndHoneKIMgMaFh7q4l0Pf8beIkR71xTpTcmfdBoW4Rsvq
 cOumFhRcuKSezBKknwbzsTPYRMBZL6dM6/K9kd5eNF3U/YAaXc/OMHvK1ISZa/TJQWksDRZ+xFn
 QuHNTaFuaqEk9Tw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'MPTCP_PM_NAME' is defined in 'linux/mptcp.h', no need to re-define it.

'MPTCP_PM_EVENTS' is not defined in 'linux/mptcp.h', but
'MPTCP_PM_EV_GRP_NAME' is, with the same value. We can then use the
latter, and drop the other one.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 7ad5a59adff2..994a556f46c1 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -19,12 +19,6 @@
 
 #include "linux/mptcp.h"
 
-#ifndef MPTCP_PM_NAME
-#define MPTCP_PM_NAME		"mptcp_pm"
-#endif
-#ifndef MPTCP_PM_EVENTS
-#define MPTCP_PM_EVENTS		"mptcp_pm_events"
-#endif
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
 #endif
@@ -116,7 +110,7 @@ static int capture_events(int fd, int event_group)
 
 	if (setsockopt(fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP,
 		       &event_group, sizeof(event_group)) < 0)
-		error(1, errno, "could not join the " MPTCP_PM_EVENTS " mcast group");
+		error(1, errno, "could not join the " MPTCP_PM_EV_GRP_NAME " mcast group");
 
 	do {
 		FD_ZERO(&rfds);
@@ -288,7 +282,7 @@ static int genl_parse_getfamily(struct nlmsghdr *nlh, int *pm_family,
 					if (grp->rta_type == CTRL_ATTR_MCAST_GRP_ID)
 						*events_mcast_grp = *(__u32 *)RTA_DATA(grp);
 					else if (grp->rta_type == CTRL_ATTR_MCAST_GRP_NAME &&
-						 !strcmp(RTA_DATA(grp), MPTCP_PM_EVENTS))
+						 !strcmp(RTA_DATA(grp), MPTCP_PM_EV_GRP_NAME))
 						got_events_grp = 1;
 
 					grp = RTA_NEXT(grp, grp_len);

---
base-commit: a3cc6d5a9b3f3ccf7a368b21fb739163771cdfc7
change-id: 20240819-mptcp-pm-events-f9abf8c594cb

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

