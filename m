Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367E1946C
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910860; cv=none; b=P7Q06P4yJ6hPIuAl5TD6AEKdF/fZ2kdesj6Qp/GR1HjkhT8O26MfI+sFBySdOqyb3pIHy2eDaKVvAW9w5QcYfUYlqnifgyRN3wwbLL9Jvch/tMkqM3nRxIV5DJbfIwMrIWXKj0HpmthfJxNDSglZH9IO4jl0CGMMuH0xL2glYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910860; c=relaxed/simple;
	bh=JRMj/SLzyGIOFS6blXMUY3ImOv8wI4WGrPWCLtVXACs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iXRNyI/U8VyUM150dK0WkxTvt+PGGvaVvJPixbmT2H1w5yH7VuRVAkTGR16o254zPpbn5zSVlZeTdbPRbT+qobadO9batZNEXCheTd5nEEuDpkXR79eoBLWAlUOzgE6o+45uSRr3+Y2g3gdb3IDW2mxuQiXrulSLpA492A8x8xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIkctLT3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIkctLT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74ADBC433C7;
	Wed, 14 Feb 2024 11:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910859;
	bh=JRMj/SLzyGIOFS6blXMUY3ImOv8wI4WGrPWCLtVXACs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIkctLT3EtgvLJEivIkEIGzn9vF4ei5hBMH7PZy1fheZ0ojgVbvU8BGu4g8UMRjlX
	 hdxRKlArTFBH/aOpJRkCY3AJfS8ueJz4TSsQzD023qzEOiujXB6eCscybCQVid8zUr
	 CywtP92dfgUSFgYhc/1iiz0rcQ7zZ6RzLCNNGYyq8b/ie4FJKUzjmdp9cGOuNO+kG1
	 qkfUh0t0rRjDh2saHGxApYzJKBIUFDGVoE0veN5yMbsDDbBR6vg9dPZYWS6Tm7W6ev
	 sRlfpam1pYh//LHzeGQ4NSRNjLKjVnv7oRvj8RzseyPdibS56+zk15nR5v+lF2fcPl
	 LDeuJMixjLonw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 06/15] selftests: mptcp: add userspace pm subflow flag
Date: Wed, 14 Feb 2024 19:39:57 +0800
Message-Id: <d3ced6db067a843436793503005c9403571842be.1707910454.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707910454.git.tanggeliang@kylinos.cn>
References: <cover.1707910454.git.tanggeliang@kylinos.cn>
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

