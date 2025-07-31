Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B632BE059;
	Thu, 31 Jul 2025 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961064; cv=none; b=kcSBiTYD3RQkcblq6tZTA05JZpV3dV9b18oR+L5uNu5mgmVYmisJICwSyuAWBHJPBYT+i2kCUO2JsjTLpLZG+ECaUtttjKGkwBPrPXsXlLlLLX3NhOsQEGGM+FOL0PSRg1uJ5mrXv01n9vx7DitMuJROsx+DZqozIoAp3pgZXMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961064; c=relaxed/simple;
	bh=W4Qda+mvWHWz1R0Gx8QU3A4Dcqty5W8B6mYAXLBraP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWwaLMlqAConqiBULFVayAgUj4Yk6sCGSEGpzvs8BROpoZxUGrxWrmDWewRCh549/CR4BV4ViCeYznh91wKEdQ7lkKdbwm/fU5WoJcqvhDfRxU7yRfzjbocc9HOZJITv8WuaLHdPcHcFsRxHvGIYcd8pqhqtSV+pR1lPyC3eEdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clJO9CtD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clJO9CtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3011C4CEEF;
	Thu, 31 Jul 2025 11:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753961064;
	bh=W4Qda+mvWHWz1R0Gx8QU3A4Dcqty5W8B6mYAXLBraP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=clJO9CtDo4m+ezGVawoUJp7OcRNwVzyZrsIoI8P9XrxEVQ82Eb4opfG+8xT+sMHSw
	 Z5eqpG+73pWxQUDunbU679K0YAJ1snh8AkMwFTOPdHl+E3bWaowT4W57r5jmn1zUw7
	 r8sN19qjTAbAjHjH9IH5yL4xCM+wu7tDcux2t+l6tGBSIdZyoz8uYOUhzvPE7XSMtE
	 bhZokE7fOUGbgqmZHCHZGcIbjpDkRZTzgDbNy3Nc9kQs3NEr2kIzO2WVsdcCUUxpP1
	 plQSN18xdshdPK8Dt3a3b2C6VyUbBynnmYMpN9co/FQjxKxb5zAj6I7dfUbQ1T5Edx
	 aQdJ8B5yHoaeA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	sashal@kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.15.y 4/6] selftests: mptcp: Initialize variables to quiet gcc 12 warnings
Date: Thu, 31 Jul 2025 13:23:58 +0200
Message-ID: <20250731112353.2638719-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250731112353.2638719-8-matttbe@kernel.org>
References: <20250731112353.2638719-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=matttbe@kernel.org; h=from:subject; bh=uA3dGsq1KQVY/0mRDNfeGEq/tEmcX9yXO+wq962/Iic=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK6g4Ilbl4pt62vyubVZF8VcGrjE4tJTeY7L5w2mfgvN mHGQ86+jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIksamVk+B6jK3gy3bPj2JGg PWf+bs6913bti4xmzcvZqW9rzrest2X4X8habp1QqMlRs+jgo/BJ+mY70wRstiuuelUpIXTh2eN d/AA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Mat Martineau <mathew.j.martineau@linux.intel.com>

commit fd37c2ecb21f7aee04ccca5f561469f07d00063c upstream.

In a few MPTCP selftest tools, gcc 12 complains that the 'sock' variable
might be used uninitialized. This is a false positive because the only
code path that could lead to uninitialized access is where getaddrinfo()
fails, but the local xgetaddrinfo() wrapper exits if such a failure
occurs.

Initialize the 'sock' variable anyway to allow the tools to build with
gcc 12.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ mptcp_inq.c and mptcp_sockopt.c are not in this version. The fix can
  still be applied in mptcp_connect.c without conflicts. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 95e81d557b08..599befcc1c4d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -188,7 +188,7 @@ static void set_mark(int fd, uint32_t mark)
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
 {
-	int sock;
+	int sock = -1;
 	struct addrinfo hints = {
 		.ai_protocol = IPPROTO_TCP,
 		.ai_socktype = SOCK_STREAM,
-- 
2.50.0

