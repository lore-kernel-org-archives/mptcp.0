Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A93CF7D
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703228; cv=none; b=VEB6tKEMsRTPB5D8nc8Z51bvl9tGj3gUtHOjH/LRkoxEcPRs2hAZ7PC9b2A9UtkzKx/1tAwutfV4JcdN8AZC2nm/+niFbnxpjOMyCdE/puilAa6yUN3sXgeJIzgspOiLY/kjq/+0ChQyx5B1kZEhE+g5pRMG6O0hdnE13mpWAbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703228; c=relaxed/simple;
	bh=BIL1jNa6HF3MqwdKiC1OShZvX6ItxLm2xzUEQwVvDJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MU3YtowW+y2uPsAF3ZPQJybAoam1DF9Z3Gl7R+Ir4P2LwFz64uWDlREeRsts6EBGyN8cGplZPlh/3b3B9tBExmuGyf/0eJGKyEJHqVKu4v+xycarkY0zE5YlzF8pmrKG8pRI/PMIsGAmXKuvIDuE+quAWX8C2QFV1CmwmObk/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfPdNhMr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfPdNhMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8E9C43390;
	Fri, 29 Mar 2024 09:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703228;
	bh=BIL1jNa6HF3MqwdKiC1OShZvX6ItxLm2xzUEQwVvDJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=XfPdNhMryoUB5obL42LFkT+/Ih75FLggqRS9ZNKQONhpjAxVAFQLwM3I42ppOGUK4
	 OelZxAhuQ/20+SVMdxKiWbqxacimJoawu7XcnURwoP+GlYFrW09L6ISvOoWQ+RqDHj
	 tHCQLpso2tuEg1GT0DZgL5v7/ePpyxjKnHRQY/b6IcmZulpU4Y7HToTArxOPlj2+dK
	 Pa69nAgXc2cGgu+vY99CPttk1HZ9/JuYxGAHwsDXIv0YHr0hIIRFSAvGC3Cbg1UXj0
	 cZTtjL6nRaKHuLBo9/RaujmzRRro7xsJSNkhlbqRM4UxvvPm66DzOw0mfl2StVb7i5
	 JuAXjDGhKsoPw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/3] display "last time" actions info
Date: Fri, 29 Mar 2024 17:06:58 +0800
Message-Id: <cover.1711702915.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - address Mat's comments for v1 (thanks)
 - set msk->last_data_sent only if err > 0
 - set last_data_recv in __mptcp_move_skbs_from_subflow
 - add three reserved bytes after mptcpi_subflows_total
 - move selftests from mptcp_join.sh to diag.sh and check that the
timestamps move forward.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/446

Geliang Tang (3):
  mptcp: add last time fields in mptcp_sock
  mptcp: add last time fields in mptcp_info
  selftests: mptcp: add last time actions tests

 include/uapi/linux/mptcp.h                |  4 ++++
 net/mptcp/options.c                       |  1 +
 net/mptcp/protocol.c                      |  7 +++++++
 net/mptcp/protocol.h                      |  3 +++
 net/mptcp/sockopt.c                       |  5 +++++
 tools/testing/selftests/net/mptcp/diag.sh | 24 +++++++++++++++++++++++
 6 files changed, 44 insertions(+)

-- 
2.40.1

