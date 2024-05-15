Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5423EA7B
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715769520; cv=none; b=T57uVbicKqxWaWR27v+StKrdVdmGUz9zSxt+iLeJm9GToNrxga20phgtOrwbSMFTG+DqrmOl3Kp78rVI1lQ5uIE4M0Iqphnf+PrO+cB/Dl+91Pvn5f34IGiW36CoHihN63GrxgrG5AxTHmGf7HM2nEylfSMYHZaVTZ3G/SJd8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715769520; c=relaxed/simple;
	bh=R5O5q7tUwAI3mtCcrC7G9EaU08Qh+Q+5AiMIMkJM8Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILAE+FJwv4gdw+wpCL1FsNIO6o2m/FpgPKJrd8gveP/ZAIgRWVW7Ex5ruxjUaPZDPlKJQyhsdhF9TR/g5ysgojhL2SO55T2/nqMNIngmqRx7rZh+T3a3bj6K3PefllvwPGuhY5uTLE1rEZP8gzTVA2VeFJIsCWEUa93hT7ifhxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhux+mAD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhux+mAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94496C116B1;
	Wed, 15 May 2024 10:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715769520;
	bh=R5O5q7tUwAI3mtCcrC7G9EaU08Qh+Q+5AiMIMkJM8Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhux+mAD/iJQf7lj9OE6bgTZmOvq6TQdY7lGCSOyGDIjzBvfWJQZn4C9bf7mNQbgl
	 CJWpViXZSgZYdEH19xH/DE+QqThF1XG79tCXY6uKqIwXFTYUSuSfIUkBT5k9BMgK9u
	 BxIWD5Dl7j7Zd2+miH3q27+g4S6TImkyhM2lSv6/v7KUaoFsWu5TYAX86MfenFxId/
	 J2Wn80PpK+OFQCS+/PmES3zAHi3BhCABRA7EKXU9Cmjt7cbtUs0CKifYnNkw2wXOpO
	 z1fj6OYVwlDPfc8JihYPmJjMEHzupPBzRhe09lmc9/J+WlLSA2WWFu7Sydm3p39QZX
	 pn4Bkovu8/Pww==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 2/2] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Wed, 15 May 2024 18:38:31 +0800
Message-ID: <b3cb0c6384a920dee9066f7affbe9df4174781dc.1715769419.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715769419.git.tanggeliang@kylinos.cn>
References: <cover.1715769419.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use pm_nl_ctl instead of 'ip mptcp'.
Use SYS_NOFAIL in _ss_search() and drop 'ss -M'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 793b4b9c2bd2..4472aa404da0 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -362,7 +362,10 @@ static int endpoint_init(char *flags)
 	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
 	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
+	/* It would be better to use  "ip -net %s mptcp endpoint add %s %s",
+	 * but the BPF CI is using an old version of IPRoute (5.5.0).
+	 */
+	SYS(fail, "ip netns exec %s ./mptcp_pm_nl_ctl add %s flags %s", NS_TEST, ADDR_2, flags);
 
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
+	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
+			  NS_TEST, src, dst, port, PORT_1, keyword);
 }
 
 static int ss_search(char *src, char *keyword)
-- 
2.43.0

