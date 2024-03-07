Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD74C83
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709774067; cv=none; b=lNByxvquaHhmRINWQW4Y74oB0+BY7dr3D3dPtqHSsiplvc1ZOLXedDMiYXme11UravYvwomB5fD5wFXH5ir312eHlx9aMvNRxK4E9qmE4z3s7gZ/2tskkNJww03S6Ho6Cn3zc2JfvTNMhmJJDE/wG9wS4BAwkc8GqvVp/lLHf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709774067; c=relaxed/simple;
	bh=tmwQFjGUw/JRfhIdHLV/tkT1enNtx4y3g24jcrM03nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htXQVj03VQ1Ehg//RzE2rzjfmUZdtzOHGgAVBEoN/A51tzzSPWeoN4wrYLp1d3BewZKK5vw9qAACceKwrePmgdQ2K0aouSsQnCRj0yOMDuJ5jmkGE4/diPsU6FPKxa+xG+kKY3ucbUJOBSD2uZZFLmDbl8uJ8D9QRm8Qd0RjZdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTZX2v3R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTZX2v3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531BEC433C7;
	Thu,  7 Mar 2024 01:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709774066;
	bh=tmwQFjGUw/JRfhIdHLV/tkT1enNtx4y3g24jcrM03nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LTZX2v3RjWJXilz/f/4su56YD+WsyKsPjc4gl+i1YvvGXPln8+JhoyMmFBKW3KmMe
	 N9HtgRg1ksgMZPW3aWjDCaru2YxyQQq4RojO7aQ8/D2Xttdox0Q6EIVvoE+fwk3b4l
	 YzJrJE7dKqekd4GGleSKbxVJprSZfRbwtuKqyb7Ti/ul9FDBWaMLeGoJLEDhJp5mJF
	 If4ugusGUgv2qpE1vbBVUwTu2a/ygKJqIbhhY+1UbAqJu1Ih2JNNBrywCKkiAwbKNL
	 MZCbs7W55SpuZ4d2YR1j7PBnIZ9vsmTVURMN6Dq5SHjFNaf4TKptr7CH8Ft4AXyyYF
	 Use0990qcQMYw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] Squash to "selftests: mptcp: connect: use += operator to append strings"
Date: Thu,  7 Mar 2024 09:14:12 +0800
Message-Id: <06f55d6d6a1f37da444bbaae9262079d300efe0d.1709773913.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709773913.git.tanggeliang@kylinos.cn>
References: <cover.1709773913.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Append the fallback note into 'extra' string too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 8feb4eef0931..c1733c38a2de 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -451,6 +451,7 @@ do_transfer()
 	mptcp_lib_check_transfer $cin $sout "file received by server"
 	rets=$?
 
+	local extra=""
 	local stat_synrx_now_l
 	local stat_ackrx_now_l
 	local stat_cookietx_now
@@ -484,7 +485,7 @@ do_transfer()
 					  "than expected (${expect_ackrx})"
 			rets=1
 		else
-			printf "[ Note ] fallback due to TCP OoO"
+			extra+=" [ Note ] fallback due to TCP OoO"
 		fi
 	fi
 
@@ -507,8 +508,6 @@ do_transfer()
 		fi
 	fi
 
-	local extra=""
-
 	if [ $cookies -eq 2 ];then
 		if [ $stat_cookietx_last -ge $stat_cookietx_now ] ;then
 			extra+=" WARN: CookieSent: did not advance"
-- 
2.40.1

