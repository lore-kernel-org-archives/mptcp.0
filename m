Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25594C6C
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709774063; cv=none; b=cKxrkIKIkvFzCL25U42cumOPtQkgeE/QXYcAiGbiEf51U4knTAcu/2a3CBr0BcrT8CpMQbuktw2m8cEy9u6EIdK69zDSu4+HxAX+Pwq0V1bt7mOjh7ZRwCTvuTMZC9d9rhZj0V2yggIaOUOA+VFSPeHFXjd5FI6KHW/oLLiJeZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709774063; c=relaxed/simple;
	bh=NCznuH8x8+6xpH9ZhzUlTPubFKDVsyw6/Jyf67I6wMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MGnMEmQNlnOgLazcjJLA1CtdK8pwm4//GzMWTATSen4LAw1oF7FrAZv1ey6IoyZEc6v7goa3Qzx/MnPWobv+XN2yn19OouZBpW1Y5EeRNpzUaAUN/GoUnv2HR/Q2qVs9MlYt+AZxBcdvWCvG9tvK+aeHdc7zIRPloGLCN1//HNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3aEAPEs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3aEAPEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960B7C433C7;
	Thu,  7 Mar 2024 01:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709774062;
	bh=NCznuH8x8+6xpH9ZhzUlTPubFKDVsyw6/Jyf67I6wMo=;
	h=From:To:Cc:Subject:Date:From;
	b=e3aEAPEsa+s+ED06JUxVuNEnCFnFLwIt/crKTtqit4ojaC5GvxOqQcISWNxjZ9FKb
	 LCpCm9fQA+OEi3esRvPcaSO/3euBx93kR14ulNhzpTAh6nzERv6MPjoqbn3oTnlwwZ
	 FSA3Nek1ZweTzWquGJj/2ChIYoAsHiEbY7P4rKjm6bcniuif3q7C2puTwH+0LgE4PR
	 ipQHXx+kSqVdS574jIPc6oXAZlezNPOp7CKQhCupv+lbIHpuRjon7qqeO75rzVCFO5
	 I553hJeQGAeuHxHUmvhPSJ/T1h/Fr5xhDWZbAcTvaHebdaEDQ3uYVE3KtZiLnwY8BW
	 dDGzZYJUmn3ng==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] squash-to patches for "add helpers in mptcp_lib.sh"
Date: Thu,  7 Mar 2024 09:14:10 +0800
Message-Id: <cover.1709773913.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Two squash-to patches for "add helpers and vars in mptcp_lib.sh, part 3".

Geliang Tang (2):
  Squash to "selftests: mptcp: connect: add dedicated port counter"
  Squash to "selftests: mptcp: connect: use += operator to append
    strings"

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.40.1

