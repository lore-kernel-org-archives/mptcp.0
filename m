Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391F3AC19
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496611; cv=none; b=MF3GT0ELSckp9OkPjnC7kPum7Zj57NfEVma/ix5D5FhlCcrorXRut0sBdyE+ietM1uMmrgdvW4KFNUROqxDzERGocbseLIQJUgL+OMX91HFJIR33tgTMtuDxRA5aLn6+j3hMTlJyQY1FD4niXM7CsdojA8UlnVgztFMZM5Fq6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496611; c=relaxed/simple;
	bh=xNmdofUPy6hXtd8eZ4BLpNIcRAIKYYss+sNcC32lKc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ar1iS1r+aGYXVRtfuRtMHIE8CyUDHiAs05/LFRB3Fri+SMjCigucKjsxI0WtWYFX5oe3nPIdHEj+8n/assZqz7iRn0XYojHzP0/iK1dy1G/sP6ZcSryEen0XmvGqpH7GdxBQwfCgF0c5y+SppfGKKMqgO2rvfGsMTJe1m5DAprM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sut1FHGR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sut1FHGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB29C433F1;
	Wed, 21 Feb 2024 06:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708496610;
	bh=xNmdofUPy6hXtd8eZ4BLpNIcRAIKYYss+sNcC32lKc0=;
	h=From:To:Cc:Subject:Date:From;
	b=Sut1FHGRJf4DtTsj9oEETQqfkidkKJOlJS0+LmsSp6w8h67X9oV/VUjs7rVcHL79T
	 bY3z5J+oJG4hvNeb8GlKCsPbi6VtFNlSrTBjTZRcWbxn7U7/vhxeVqMieq3fP6fzUp
	 5xP31y1TexM4FndaZtmTqdW6Q0r1ncfDrb+/wOM8z4kEnKzYpHu26ncvgTG0LNMI4/
	 hocFyEPADVRa6rnIlNwq/9fp5pVOzNGkoKx2yLOfgpZ3MVZggXcoLuhqOnpb6or3hv
	 QDQ7C1SqLlJBoL0QlJD0IekDHDceENpoE7V7LhWFd39ALtk4zMeKJYmqc0DBZQYBu6
	 XnEu9Y5KJvAcg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/3] add helpers and vars in mptcp_lib.sh, part 2
Date: Wed, 21 Feb 2024 14:23:21 +0800
Message-Id: <cover.1708496523.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Depends on:
 - dump for userspace pm, v14

Geliang Tang (3):
  selftests: mptcp: connect: add local variable rndh
  selftests: mptcp: add mptcp_lib_ns_* helpers
  selftests: mptcp: add mptcp_lib_evts_* helpers

 tools/testing/selftests/net/mptcp/diag.sh     |  9 +--
 .../selftests/net/mptcp/mptcp_connect.sh      | 29 +++----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 31 ++------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 79 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 16 ++--
 .../testing/selftests/net/mptcp/pm_netlink.sh |  9 +--
 .../selftests/net/mptcp/simult_flows.sh       | 16 ++--
 .../selftests/net/mptcp/userspace_pm.sh       | 42 +++-------
 8 files changed, 123 insertions(+), 108 deletions(-)

-- 
2.40.1

