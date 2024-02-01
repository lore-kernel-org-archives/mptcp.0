Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD88B3C478
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764761; cv=none; b=O/ACwYLBsk3Xd2iE/Kuvw1M2a6CIMqSOEE5SfweGXxT5zVpMDYoK1OQdL6OB7zSrfgX4ETUAYQewL3rg+zTf0gro6OJmjs/CkdxDDdTH0svNo4MAKKs9nbkqoBAf6mnLuoueZ5UCj8PdSIUYm47lrOREkdUlKAwbsWGm2yswvkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764761; c=relaxed/simple;
	bh=JRMj/SLzyGIOFS6blXMUY3ImOv8wI4WGrPWCLtVXACs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YyMu80Cc7mcwO34qN2kNoed53AwV10waUPog/kbmmoSl/H/9JhMaXMtpbniYS9HYYFS9ibriahqnVrhYm9pXpwITPRPYP3oVtzFiXqe0oRy3+3Gu4e2yjpOWVu8higTNueK+nU5PaBO7hJbyE13vPcqixUAdXaizOv0h3JzXH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d96AFAQF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d96AFAQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF97C433F1;
	Thu,  1 Feb 2024 05:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764760;
	bh=JRMj/SLzyGIOFS6blXMUY3ImOv8wI4WGrPWCLtVXACs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d96AFAQFAGKENL9VJTcG3XvSSNZUMuj7Sny4dPSo6dkv9ldRKcg4eSOaahd/pjjml
	 /0fTrmQudneznJGRdzkHWjDmHrgPVsecsrMJjoTQTy1qvbWZAXkm3F2j+VwLLXNyh2
	 POcdIXBJlAlV51Xym31k6bqmbqK+UO6ICvADeXhbEY1+Wxhu5eDFUagcWCxqaOovje
	 4w+msvnjde3zuoLIVEsHQFyiUG/to3XLe+rFpkbi3M8PyCN0APt6Q0RSqdAL2DepRe
	 lSAHTxApBelyfOyFqd+YOP78VzV4cm0dkHxZJtJhzl9RnfIJgJZ//tkU6lQ5oDz7Jz
	 D1Q7eB8w13Utw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 06/15] selftests: mptcp: add userspace pm subflow flag
Date: Thu,  1 Feb 2024 13:18:56 +0800
Message-Id: <f4dc409dfbe40fa6958dbebe4f907253a5334041.1706764519.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706764519.git.tanggeliang@kylinos.cn>
References: <cover.1706764519.git.tanggeliang@kylinos.cn>
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

