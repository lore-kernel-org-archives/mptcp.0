Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB9C8F40
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558345; cv=none; b=gcd6IZ5nPMk7QzW9dBSbvnyuqx18YzcZ832/XDCgWq90WrLAxwTywQj4ekmOSfxT68QxZ24NzN15xpjyAx5iOJbusmL5atgVkFYp/7Pwx0P0WbCrmeX1tNnRICn8Wf+sPP0nRVCiBdUXz2KOy6dYHyRKyJV7epKxoxs0P63/vGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558345; c=relaxed/simple;
	bh=JRMj/SLzyGIOFS6blXMUY3ImOv8wI4WGrPWCLtVXACs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=uPj5rPpfJIv2+fr3P8ysHrUjzylYbmOGSYqzYcAqfM9/i+Zm4lF3vEK4fBq990uayC7NKRYcDANGf6XDPKZ6nyQ0DAsRo61qlpr7iGPGZCkCkTIiPTM6vmT5snSZXgmyLNTxoxSW0ke7t3xwey87xt6+YcwtfNIJBrPLZuem+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/Oit81k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/Oit81k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008FCC433A6;
	Thu, 18 Jan 2024 06:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558343;
	bh=JRMj/SLzyGIOFS6blXMUY3ImOv8wI4WGrPWCLtVXACs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/Oit81kCyyB910C1hYkuMJKemJJsk4+xfO4KE7pi7VJ1PEQ7lReBgA3pH+Wpwl26
	 a5RAOiu2yI9Na6UR1dK7yY5MYPlUK4VjKShwl2FclBA8pFT7CReRQ8rUwNgXgds0yW
	 q2cbB4vbVGvFOMLBOWJAYwGoblogBRCaTh7k6sqA1DqWO1E9u8T+PXcwnGt4CY5kn4
	 +9m+Ehz3rVZ3cctXALsAt8hZqRPuNzN8rDh3r4aiuAY7RlQAzm3VIRzJIyBU0SN9k4
	 CS7ckUdPayD+jMTz/1j3xdd16zASyUEXPyU6HvwsGva7F8+3eP34leG5sqWNMQpCS0
	 1LlWrnuv4W1LQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 11/23] selftests: mptcp: add userspace pm subflow flag
Date: Thu, 18 Jan 2024 14:11:51 +0800
Message-Id: <4330616e91c0ae496a82619423ae00448b905a0b.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
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

