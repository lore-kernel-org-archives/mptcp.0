Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8A10E3
	for <mptcp@lists.linux.dev>; Thu, 16 May 2024 01:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822790; cv=none; b=jOy9NIjho66WhTfZ6mVldVmN2BHRWv6ccp5dB3KI4w0J/s+Jv1mesWAHIwiOMHuXza/nKzRxAnXeo769WUFepg2kRrlsg2qz82e1HWA3KVq6zMlpRxajSd0Rz7wnL3RtIGSze8W4T310NQ3qdwmguxhFb5/d6j72qITxFDOff9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822790; c=relaxed/simple;
	bh=XDDN2Ayb9LBIzE7Gsbex2RBDsfP7vJLCt++bv7OxyZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ive1jUfhKqV/v9s1q5mSZsMCtEQrLSUtaooM1wVJoZmxFbtc1tLNviO6gB821pwnl5hPoqmR+jsA7V6FdSBxazl5rdHBcuYjNMJZDLElJHfrpQMQpDG0XGWyMjb4s1GIwB0Rgu6VKwjb7lV8HDRGdai2TbfeiPOlTV2X3ChxWUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/xWMvRb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/xWMvRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F716C116B1;
	Thu, 16 May 2024 01:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715822789;
	bh=XDDN2Ayb9LBIzE7Gsbex2RBDsfP7vJLCt++bv7OxyZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/xWMvRb+lMEV02FipcpU30slvzjzhXptt8MCKWnrA3vu4+j45XkuS+XUF5+5UeOp
	 AT9KQO8U0sTZ3LXBxOzGaX0B87wuLNM/t7dLSCiRni1+ObwtRZmj9p4wTHlpwfzC9a
	 4211zfeCY1P1wOcWFnKI9ze/dFiVIaqNU9PjUzlgI3JzLqUa6K7+MtSxc16miyJ1un
	 yZn1xtEyaCK519o7k8VCR1yDRUtw94sJ48yYztePZnTGLUTBvgPnsGOHdYVkJhrKal
	 7bh7SRWzBh1B7mb19FgmDtUkGMsEwtVGzFMSmp8ldvmAssyetdZZJVcCv0pzD9kMCi
	 urhDIYeeubIqw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/2] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Thu, 16 May 2024 09:26:18 +0800
Message-ID: <b45c687b744220f0e3dd7b70ec48f48c29ba58a2.1715822527.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715822527.git.tanggeliang@kylinos.cn>
References: <cover.1715822527.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

create_netns() is updated in "bpf-next add netns helpers" series,
sched_init() needs to be updated too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a4863328d2c7..1b2ffc5211ea 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -439,7 +439,7 @@ static struct nstoken *sched_init(char *flags, char *sched)
 {
 	struct nstoken *nstoken;
 
-	nstoken = create_netns();
+	nstoken = create_netns(NS_TEST);
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		return NULL;
 
-- 
2.43.0

