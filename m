Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C580946F
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 02:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725503237; cv=none; b=fc4pR6vlKwS3roCWdFstPUzzB03SG5vMZzloDMah3hSQA9FVVidKNf4OUpNQUrpVpMwJ1tZhNClRjqtgDxTwR76V9VlEimaIiXj49e5tihx79nHYqMO6nCr6pNb3KlGm0vf/U1grO0JWbp7LyHavQWitL1h2dJf6Yd4v7lYtRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725503237; c=relaxed/simple;
	bh=auspbMJKv1iOxydApqpzdJZ+mdfMMbCtuIEKQU2i/74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pi7znrAem7fePhNPAVWDQoCDv5lH1r+iO2AzEfa12NKAzkCY5i4cdwBjt/VGjbYCRoBzInpehSHhhpN0lZtkJVaJGOS0qmp9p5N7hoUR7b/Gw0CJZEmBwbXZpL2SWATgYtuFxE0ZFYcAt5U+Gub8Uio9Xexp3wbdmMBuVoIzUaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSUIF+62; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSUIF+62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE0FC4CEC2;
	Thu,  5 Sep 2024 02:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725503237;
	bh=auspbMJKv1iOxydApqpzdJZ+mdfMMbCtuIEKQU2i/74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FSUIF+62FXDXoVdehqBqloNiQsye7D2BC+EULZvqaXTZsMBj2QvoXdTyND/xKDBSH
	 wWh5jxfN/KlAvQZx6zDsxx/9h7aZ8UOiQxHMxI0e7lHgRrifKrVDq12jnH/gUOi86I
	 ogIaEyTpaNnG/Js0GgpHWT9MDbh/+UUOlPLqU2TbhZXY9G/PpUqi9+TTIS2js4tLfM
	 0cWA6nC8fzmvuAz076wQ/RTwlTtXMr/jnX/fXw5MSowcd3M6fBImkqXyHU4u81TQEM
	 YyUUuDO30vWGI5YgT4Ru/3tkuZR8HRQmEI2gGy+0uAnpN+OSiX2RnW1I8YVyhIcWGk
	 /lSd5PL2Mll2w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 4/4] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Thu,  5 Sep 2024 10:26:59 +0800
Message-ID: <667e97b1073cd34999964ce4c64a3b5a31256b5b.1725502822.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725502822.git.tanggeliang@kylinos.cn>
References: <cover.1725502822.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 29d3d6abc6c9..93869c873cad 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -368,12 +368,6 @@ static int endpoint_init(char *flags)
 	return -1;
 }
 
-static int _ss_search(char *src, char *dst, char *port, char *keyword)
-{
-	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
-			  NS_TEST, src, dst, port, PORT_1, keyword);
-}
-
 static void wait_for_new_subflows(int fd)
 {
 	socklen_t len;
@@ -495,9 +489,15 @@ static struct nstoken *sched_init(char *flags, char *sched)
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

