Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5A374D1
	for <mptcp@lists.linux.dev>; Fri, 30 Aug 2024 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000947; cv=none; b=aQ0/qfCG/MA7qRyue9UNrWy4EYpaWBCoY3VysbwTrDETJuaS1khSAMeCPzUps0m59e4WFoNQkwPOwZGpc4GfFoWC3Ax5LdHLZLJClrjFGwuCSzN/V3a/sg+bvKwRkPWkSo12sUfhocwdlR7pgrJ6wwPvvnQXrwnKV+a39ROnkIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000947; c=relaxed/simple;
	bh=oX7Z8PFHcoibNtviiQrL8NrQS08lqeHBu56Z79Hddbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCVsThN5+sj2UHYunxEDg1/FZvKAytQlkjHvC8qwHZjhqh1slWxOdit1aV/4WugCi6LputACnVFhoSYuY00/+yOTvjXKJELxGSqy1jWCzzV7w/MHRkiVrxANRs0EW6saSCxKt9Q+JVp+X9HJDWPveWRQoFD6GP4QRglalw0SQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1/aMsbn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1/aMsbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4B3C4CEC4;
	Fri, 30 Aug 2024 06:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725000946;
	bh=oX7Z8PFHcoibNtviiQrL8NrQS08lqeHBu56Z79Hddbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1/aMsbnG7jBNdcTNaVM58ESNkvdMDG6krJK1uuklJ5+fT7YxQH32d+WvgCvIdJz/
	 heNo0bSZG2NROL588A3C0vsHyczJb24YBo5E+kvEaokom1ghy2SKs9g3kuXwodJQuy
	 aSVQJpAJYNq9Q0v6oZSmGujs+aEhdm96nMpCq7vu4+N+yMtzbYvuPtlemad4ZyOZv5
	 cHeWxTyFNZVSRxJnl0VZLRj7h21bAT8vSqWvKbCJWmGkpZbZOpz48k2zMsNAhvl3g8
	 baKlNYlpy0aRvhQgKvfQLblw6vCUv99sFzUtirVws2VUPuAiPjosg4seaagBEcDAUw
	 6QaoICbvRQD7Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 4/4] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Fri, 30 Aug 2024 14:55:33 +0800
Message-ID: <d47be7ef1326ac388b2e1605a8d2511adbf2996a.1725000687.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725000687.git.tanggeliang@kylinos.cn>
References: <cover.1725000687.git.tanggeliang@kylinos.cn>
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

