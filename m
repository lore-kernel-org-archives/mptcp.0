Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451AF4F21D
	for <mptcp@lists.linux.dev>; Sat, 11 May 2024 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715431379; cv=none; b=FwxZ0yOnkLRCkoAwPtU9x+wjTNodsVTIvEW+6iwIjNBvaKKpk4aHQytIX1JWo738iplZ7+cETCni591P6poMQQzIDwXiunsDFi0Yb9beDzhxuf94+CvPDjXSe0pPZOkyGmXKKtdBSPg5KFJIvQYiZmKuLc2pkXPSx7u2rOBIoLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715431379; c=relaxed/simple;
	bh=RScuiwWsjrHY4NcnU6aAKi88a3HiFw7QTXVcsVi/hAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnT14ALpzYisah/wv4iTkOrQsbi5b977ML/+QQxVf4cermLC4YuXTmSfvTqbIA77EvvFNLI0CRcouoxNIUE0V+wmQy3okYIN0ADjZsMVp82boi528t26J+4oq1NBfW22BqYP97cQOLyZby1jDCqWy7Jri0z/T1hnM+VLNDUhsTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCt23WR+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCt23WR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3660C2BD10;
	Sat, 11 May 2024 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715431379;
	bh=RScuiwWsjrHY4NcnU6aAKi88a3HiFw7QTXVcsVi/hAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCt23WR+xWXqSRX7E9CtoSMitGrKRT9Qc/GXSwOgtqJyxc4eSmEmixjMBQ+QoLo9L
	 blUT/KOzbt7e0Dt7lh6e6fh7oYKQpXv5ecTiu7g1Ctut2jjXyomqHJesSzgw71lgXU
	 YvI+FKAr17gwa73jtCzNcuw3HXx0gfnzIAG5tYnQM8SF4+s9JmQYSBPy/JaDt4MABm
	 MUtGnB/LEJxsc7w3e1qk+b/PPsIzj+oPK5NnSvdXmWxvchcac7nOlAWWLqv73Y5N3q
	 bhSuPE92ShkJ4ihj7KwHaPCC4330YuN5bDOAe4Lk4O5zx1KTv2ngsuSnPWos89dpDf
	 vNpItZLylKkmA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/2] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Sat, 11 May 2024 20:42:06 +0800
Message-ID: <5d1abac25598dd7632faa0d74ce6646bc9bd4d8d.1715431177.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715431177.git.tanggeliang@kylinos.cn>
References: <cover.1715431177.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use pm_nl_ctl when 'ip mptcp' fails.
Use SYS_NOFAIL in _ss_search().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 793b4b9c2bd2..18e311a556ae 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -362,7 +362,10 @@ static int endpoint_init(char *flags)
 	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
 	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
+	if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags)) {
+		SYS(fail, "ip netns exec %s ./mptcp_pm_nl_ctl add %s flags %s",
+		    NS_TEST, ADDR_2, flags);
+	}
 
 	return 0;
 fail:
@@ -371,16 +374,8 @@ static int endpoint_init(char *flags)
 
 static int _ss_search(char *src, char *dst, char *port, char *keyword)
 {
-	char cmd[128];
-	int n;
-
-	n = snprintf(cmd, sizeof(cmd),
-		     "ip netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
-		     NS_TEST, src, dst, port, PORT_1, keyword);
-	if (n < 0 || n >= sizeof(cmd))
-		return -1;
-
-	return system(cmd);
+	return SYS_NOFAIL("ip netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
+			  NS_TEST, src, dst, port, PORT_1, keyword);
 }
 
 static int ss_search(char *src, char *keyword)
-- 
2.43.0

