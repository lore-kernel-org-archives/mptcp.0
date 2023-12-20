Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3DB7495
	for <mptcp@lists.linux.dev>; Wed, 20 Dec 2023 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LJNogAIF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703038151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f59vI9JihQUjoifWsXN7BexFUg1b0NB0PJwoYGho1Fg=;
	b=LJNogAIFbp97/B7B9g89tlihqJWQe9ImkSJd12Lu4Gi8muRprb11GwhF7jC19qFeaZc9Z1
	prK81QgpGdV7hVudZXhT0HcQkKB4755FwKSTNoeaqR+oMQ2/knpdD6OEHi1BvJpS7RuM0x
	bu9IA6xFyWGpdf1AIpF69eN3GIuTI3g=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v3 0/2] fixes for CURRESTAB
Date: Wed, 20 Dec 2023 10:08:15 +0800
Message-Id: <cover.1703036129.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v3:
 - update the comment in mptcp_pm_nl_create_listen_socket.
 - update selftests

v2:
 - Address Paolo & Matt's comments for v1.

Geliang Tang (2):
  Squash to "mptcp: use mptcp_set_state"
  selftests: mptcp: diag: check CURRESTAB counters

 net/mptcp/pm_netlink.c                    |  6 ++++--
 tools/testing/selftests/net/mptcp/diag.sh | 17 ++++++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.35.3

