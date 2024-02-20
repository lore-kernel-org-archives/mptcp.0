Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EB760264
	for <mptcp@lists.linux.dev>; Tue, 20 Feb 2024 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423122; cv=none; b=M+iI2yqcjPoAl4xs4/ljGvjWO7sa0yFmSoNZybceKRjTTMnFHUGqIEm7If8BK39H9LFXNeGIKv3H2zT8xJQekueSz5JUCnsBXOfpx1URpO3UbjlvJcV20X2W257EmiHZ1ZQuz0XoUmnmPqjq0cAwdzQhH3gb+y0tgv5BxsKXSqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423122; c=relaxed/simple;
	bh=JRMj/SLzyGIOFS6blXMUY3ImOv8wI4WGrPWCLtVXACs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qv68YhuO1UdvLVFrxLNU0O467XXLPSyFT1BDkLwis4g66rbQ9e5KKJVvFS9OLrjWwr0SHuuLag2EZ1ZxLIAw9GXDG23EgnU4mlJrW2QHhABvrbp0Rh4j5ehCKkMpEfXRm+3OONaYXqZeBLzs9uKwp7sU7XjN/6SyYMjxjrzP2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNvd8kzY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNvd8kzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C76C433C7;
	Tue, 20 Feb 2024 09:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423121;
	bh=JRMj/SLzyGIOFS6blXMUY3ImOv8wI4WGrPWCLtVXACs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNvd8kzYoiDvebWUWzY0v72pCFmZyGA8UBxbG3jn3pQqT7TZSjllOqokIGkLQXj6x
	 wA9kzMcsN/Iecbs8M8LEYdSfCvV7hl59TQ2YpwJe3QeABrZDsiIu35TkkVPXVd2/hb
	 V0Pd4rObK1Na7klPsz6/apUiXV7gfiFA6k5DPxm5mfyizIgcplBd0ZkQOiinRF+6Fd
	 6NXbMSQQ0MWCuT0VmRBhpteQFjRaytPpUs4JXVANITMlh7PHwteluog1imXYJFB367
	 YeR15E0iyuKmWDUeLD+BinJj+54OC8zuKfl0if7Vsrwv0cUQAzvff7UElRcuXOUb13
	 3SW5B5P6+ioig==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v14 06/14] selftests: mptcp: add userspace pm subflow flag
Date: Tue, 20 Feb 2024 17:58:20 +0800
Message-Id: <4fc159a116a6a9c8c951c05b939aae82d9a76e89.1708422758.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708422758.git.tanggeliang@kylinos.cn>
References: <cover.1708422758.git.tanggeliang@kylinos.cn>
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

