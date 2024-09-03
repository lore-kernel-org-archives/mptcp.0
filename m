Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852BC205E15
	for <mptcp@lists.linux.dev>; Tue,  3 Sep 2024 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350714; cv=none; b=A+rmdW3PAN6YuwR+TZovziip8SJ3AjE7cVhAVhrKPe10t91uCdUyvaSF3ZkwpZqZ6x4s4XBrZxKC9S8Tyz8/aNMWKY8ea+/cIKnWUdG45rg/qsUB7EnunHwy5u+W3Cb/TUvYLgvpeswVvw2x3PXb+ZWR/x6RGqJYfjIfvuMSg9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350714; c=relaxed/simple;
	bh=oX7Z8PFHcoibNtviiQrL8NrQS08lqeHBu56Z79Hddbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zsu12kszFKM5AyHSq5LfrRPjRSvtbHGYirk9VBwy3ca5sDBejOJcmOVqy8+BUcQcROScS03ovqbw5PYGOpr1i9UqHi7X4ZN3BXL20ftaJy5mTe1RduW1YyL2B0CpzHMiHp/SmDN/WKwBsqNVokbL8vHlnEljrIMRHELhwqoZH38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rumrqf+g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rumrqf+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD32C4CEC8;
	Tue,  3 Sep 2024 08:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725350714;
	bh=oX7Z8PFHcoibNtviiQrL8NrQS08lqeHBu56Z79Hddbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rumrqf+gVqnWvVakZPFGW/ORecFWN/A2usPgCg6zFv0JO7ikeLCiX/PJ9Rq+ljrFB
	 HZo6isF6caXXk2Wma5W1jvPFMklYl4kHUxNHsqAOKQdQJcUpjN6sSv7qTT6ybTqywW
	 L0mzv66eK7i5X6UFZHswTTprXU+854wBhfsXSLbjsu2tphhXEjouaG/AKKOBuC/4HA
	 ODjmWl7oFQ3IbBB3L9z/A5PSqrdQ+ql2ZrCeP7fbofvlHjIOGDTVGyO44/Fbr4zpkF
	 CnZYpkgkIezgUfq39CrLicORT91taHk5nP5q31X+PH51VV5LsmUw35y4PrgGb79Bs8
	 8l2PuaHs9WRfg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 4/4] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Tue,  3 Sep 2024 16:05:00 +0800
Message-ID: <ca639ae9c654aa60428bfd0961476c6c8f8eddce.1725350462.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725350462.git.tanggeliang@kylinos.cn>
References: <cover.1725350462.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now ss_search() are only used by bpf_sched tests. It will be dropped
in next step.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 6085aaf61b27..8f22416e00fb 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -487,9 +487,15 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	return NULL;
 }
 
+static int ss_search(char *src, char *dst, char *port, char *keyword)
+{
+	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
+			  NS_TEST, src, dst, port, PORT_1, keyword);
+}
+
 static int has_bytes_sent(char *dst)
 {
-	return _ss_search(ADDR_1, dst, "sport", "bytes_sent:");
+	return ss_search(ADDR_1, dst, "sport", "bytes_sent:");
 }
 
 static void send_data_and_verify(char *sched, bool addr1, bool addr2)
-- 
2.43.0

