Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731A179B5
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069355; cv=none; b=b/aEXa0nYt67b33ge2CqF1dsabGxdKPXbOUnPfbFGVqOg9QpCkXUzbJIFH4OWLIMZ65ZnmCc9jjQoiZ3oVfIbm5y3WEGiYUS+pGkoOWjBq4LzyMKzE3vkra/8+5ZK00tukZY1AjVOgANeiZkG66Ui8fLsT0M5I3yoD1bNOvxyso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069355; c=relaxed/simple;
	bh=JRMj/SLzyGIOFS6blXMUY3ImOv8wI4WGrPWCLtVXACs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGWljDueGZTCKoFUEjMqzzFumxNirQw0Xbc0JMGWA9SY04jfyzujoW6GcFSsMG0RYbiCcs90M0IVJSOzuBA16QlWpxyQ21YnDuCe2MhNhCHMw1BJFf0j7kcIOJSVo50AJ7okIQ2zQTG/dJ31cShb2aA+fs6H/kEu8ngCG6z17fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHxTBWUZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHxTBWUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE07CC433F1;
	Fri, 16 Feb 2024 07:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708069354;
	bh=JRMj/SLzyGIOFS6blXMUY3ImOv8wI4WGrPWCLtVXACs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tHxTBWUZ1408cexenHhGN1J5flR/yy3/EbNdvU4QBjk3Zg1h2/kyElEhuhTgFlA9x
	 YUw/Z73LumrogjpM5n5nwZ3S+3DRp/So8mL5Nv47VDmNtgeeEKWs7FfMmVrkGatomG
	 ooG5XHhb+vyp0IKPPdQMBvR7yHcC0h3+hWrpfuKwha9jZHzBeVFH88G+4lGPz2SNLM
	 gWREKYQkvTNYHiMn3KYo1F3DUm5CweZ3yLzjiEpEmqBzJd7rXj/AtWTDeCRv7eEuVP
	 RRYR8rV0uutbiaADGEAImFnFJC7MN6sSK4fKNs1GIhX9WY1lepuPOIfDOMarKgTqom
	 SRDUarx07Z4vg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 06/14] selftests: mptcp: add userspace pm subflow flag
Date: Fri, 16 Feb 2024 15:42:08 +0800
Message-Id: <3a0a77fbc321a19623844b3b63ad8ce3d641dacd.1708069036.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708069036.git.tanggeliang@kylinos.cn>
References: <cover.1708069036.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds the address flag MPTCP_PM_ADDR_FLAG_SUBFLOW in csf() in
pm_nl_ctl.c when subflow is created by a userspace PM.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 49369c4a5f26..e97856323ec3 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -453,6 +453,7 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
 		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
 		  1024];
+	u_int32_t flags = MPTCP_PM_ADDR_FLAG_SUBFLOW;
 	const char *params[5];
 	struct nlmsghdr *nh;
 	struct rtattr *addr;
@@ -558,6 +559,13 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 			off += NLMSG_ALIGN(rta->rta_len);
 		}
 
+		/* addr flags */
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ADDR_ATTR_FLAGS;
+		rta->rta_len = RTA_LENGTH(4);
+		memcpy(RTA_DATA(rta), &flags, 4);
+		off += NLMSG_ALIGN(rta->rta_len);
+
 		addr->rta_len = off - addr_start;
 	}
 
-- 
2.40.1

