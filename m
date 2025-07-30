Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8FA1F1921
	for <mptcp@lists.linux.dev>; Wed, 30 Jul 2025 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860178; cv=none; b=QVed+zORpXU4qMNMbsT/BaOZloy1USwK/A1eTiz+PQ0YCFe3TT5sN/wRBlICJYAaqwJIWEuVCtJhF6ver3vmmsw2HzKt/iHMiMYoeLM1xCgG5lqtS1u6LX1qirVpGF1gh+mri6BVUadBrRgLRPN4J3ywQom1KBBV8GST8URyC5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860178; c=relaxed/simple;
	bh=PmcsxIY5a/dKhXruzyjeYFFPsApejN+hDtVijE/DWIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIzLdNBUDDBL/JPywi8tv+etpRjiXLaRyNXi2QvWj0Z1BSUAKLXOzPlorAMOBwd/C5Red1N47MXwBGM7f52pn06yrpeHuQZJuikQCs4x+m/b3BzAAkkhBbNI+8W5KrFRJnBZy2z7joZWvY72thd+I4EfwydD5rHcYIL6YmsPl6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHOb6D1P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHOb6D1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A056BC4CEE7;
	Wed, 30 Jul 2025 07:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753860177;
	bh=PmcsxIY5a/dKhXruzyjeYFFPsApejN+hDtVijE/DWIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHOb6D1P+0+01AvSVRq12otUE+OIQPUZdMx9038poxriL3wydGzDja//VwFItl1zk
	 GLqJ5+1URlavLduNKjbFY+VQSKgO8Gaeg+afCza0odCagLov7Rdmz7bTRlpCurs1R0
	 Wc4JOZ3wB/rBtWbSkqCOzfQKvrIxlcl1D1UwlJtSThx+oOiCMQ4dZFjEEgvF4jY9XZ
	 5uVQHvkDElm3l99riwtMAAC3aMLSpHtsQeNUbxEnrXgWlfYrCHrCZrb+Pq6kqdJY+K
	 rmq11fW3ZwZpXUrxWvvHipBZjfEXVU4CSgatDL2VYqCExocuTqoLupSYCFNjCkzkJI
	 f8TFRreGHhoXg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/3] mptcp: setsockopt support for TCP_MD5SIG
Date: Wed, 30 Jul 2025 15:22:44 +0800
Message-ID: <7f2aaa80eef99f64ff6d7a48ce0a6bf06d1cacab.1753859907.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1753859907.git.tanggeliang@kylinos.cn>
References: <cover.1753859907.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This adds setsockopt support for TCP_MD5SIG and TCP_MD5SIG_EXT options.
The implementation:
- Allows setting these options (getsockopt remains unsupported)
- Applies them only to the first subflow
- Maintains MD5 compatibility limitations with MPTCP

Note that TCP_MD5SIG and TCP_MD5SIG_EXT are unsupported for TCP too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b264185b810d..5b3e54f7d803 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -567,10 +567,12 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_FASTOPEN_CONNECT:
 		case TCP_FASTOPEN_KEY:
 		case TCP_FASTOPEN_NO_COOKIE:
+		case TCP_MD5SIG:
+		case TCP_MD5SIG_EXT:
 			return true;
 		}
 
-		/* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported, MD5 is not compatible with MPTCP */
+		/* MD5 is not compatible with MPTCP */
 
 		/* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAIR_OPTIONS,
 		 * TCP_REPAIR_WINDOW are not supported, better avoid this mess
@@ -834,6 +836,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_FASTOPEN_CONNECT:
 	case TCP_FASTOPEN_KEY:
 	case TCP_FASTOPEN_NO_COOKIE:
+	case TCP_MD5SIG:
+	case TCP_MD5SIG_EXT:
 		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	}
-- 
2.48.1

