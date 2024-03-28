Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFF941C62
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619414; cv=none; b=FsWObErZ3YvmlWGQLAOcX5I/sHyffekHiLJWcPzvCWCRoIOo8U1Ovo2Ff413LXx7cUKxtBgFHQ3fBeX1OtHBKLZwRLAUL2Vot8b9WADQXyVTNGsjg0mVSPXY5Q5xI2L3TYcNkQLwQhjVgzs6X0lRD8JrwzLOTFAwiaAMdQ1IRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619414; c=relaxed/simple;
	bh=7ZbQi/KtiFYfT3XS91jxJvQd9ql90XTGR8dCl+M71es=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qjjEpm6Ib5ohYqmr7aQPml0Ks0MKFXyzdAmb1kRc4POGOeZnx16v9iMU9Fwc945o8ZeOEM18L8fWE1SKn4J7R5u52DguOGTsN8MqhL04ggVw5lTPvbpJWmZXYgJpSddthnOzg70eHV0WqQNeOQaiX/n6Oe8SL5UP9LN9AWLkF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXoJDiM5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXoJDiM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3758AC433F1;
	Thu, 28 Mar 2024 09:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711619414;
	bh=7ZbQi/KtiFYfT3XS91jxJvQd9ql90XTGR8dCl+M71es=;
	h=From:To:Cc:Subject:Date:From;
	b=TXoJDiM5HqsUhxI9hhYVlfZakjtbyIPcuFVvOeFbYcdU0vTEBc+X68a5YILNNH9AZ
	 73OwyknRNaIKGKBXfSSSuooEzsHlES9pKeq2+Lfb6jfTdrTgSl4x2OC9kOgQSATCnN
	 HvF5ONnFd6MzElutq9H7MyjUr3mAaMM+1oSblmxZzsFlJKGdsIKYa3DzBKp795JUm1
	 7hRYkT7E88tOpGkbu0MvJh3ycvRdOqS/X9dBYfwGS9/bRvwGOPyN+Z438Yn9kKmqhg
	 xhRdZpQ4unXKdHSKVeKq3HaDGEM76/+iZ/li8/Lb/9T729rHTRJ9H9R6FvnqDffdop
	 kpC8kuZNYLjDw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 00/11] refactor mptcp bpf tests
Date: Thu, 28 Mar 2024 17:49:57 +0800
Message-Id: <cover.1711619108.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Refactor mptcp bpf tests using newly added macros MPTCP_BASE_TEST,
RUN_MPTCP_TEST and MPTCP_SCHED_TEST macro.

Geliang Tang (11):
  Squash to "selftests/bpf: Add bpf scheduler test" - fix
  selftests/bpf: Refactor mptcp_sock test
  selftests/bpf: Refactor mptcpify test
  selftests/bpf: Add MPTCP_BASE_TEST macro
  selftests/bpf: Add RUN_MPTCP_TEST macro
  Squash to "selftests/bpf: Add bpf scheduler test"
  Squash to "selftests/bpf: Add bpf_first test"
  Squash to "selftests/bpf: Add bpf_bkup test"
  Squash to "selftests/bpf: Add bpf_rr test"
  Squash to "selftests/bpf: Add bpf_red test"
  Squash to "selftests/bpf: Add bpf_burst test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 386 ++++++------------
 1 file changed, 120 insertions(+), 266 deletions(-)

-- 
2.40.1

