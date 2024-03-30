Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261321C0DFC
	for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711784778; cv=none; b=qgThQEKd0hr0LXvIkrDpgq8bSjxxY8hXrYlTRv+aYzCbTLmo9MkG0JjWgsq+IbyAtBHeWhO1rIu9eu3o1Z8objwZLuhvGmB9FLN9qh1caMf493N7LU+AoCxsc3cg7tsPneqWT0BoKJyDc5WG1YQfG1Hd/uFPT/RZywiN78Hj8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711784778; c=relaxed/simple;
	bh=6OBrgezxKGVurMeQPOQUhtRxV0Ab8DpH7z8xTUPi1a4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RVMOxIhpmE/TrtTgvyBFu+uvHRDqGdNHJvhpHsRLOaFfHOEpoz9UMqWaCkY9Do79R2HrToei+A2gh783MDVD6+Nk31rpyPNctmKs+QzTCgjzFZcpl0j+NSWil3dtl3QP9pxVFMxCuoas54hy1xAgv6+v9nMj00TD+Ah1hU0IQFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/pWdJNn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/pWdJNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A00C433C7;
	Sat, 30 Mar 2024 07:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711784777;
	bh=6OBrgezxKGVurMeQPOQUhtRxV0Ab8DpH7z8xTUPi1a4=;
	h=From:To:Cc:Subject:Date:From;
	b=N/pWdJNnThvx0wMz/4mt+evewwV/OWcBG6ESyIAbyBMUXSojGW8lcViFwa4+VDGCb
	 SKDWToyA1B895o9tctPRZM0Ko9B9ZEafQdBHv9m/346F0d33vrTlCw9NW107/bjnw2
	 pNixh+OrKwLq3ldl1RPjCzvAzzq3nBhAQemw7NxHSBu7p7WPDOxUysWJqrIBSGYelD
	 O4o7ZAcVUmBUF00zHT202sjvGBieGNyTUGes7LfflydnOLVkraFXXZGLsbSIQv/gGa
	 jiR3eKhnqBB5WydTwdYZPL3j0dwIJvp/7R1zZz56pW2gvdO+/VgAAqawd65Au/uYxM
	 FgI2k+n2gqb9A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/3] display "last time" actions info
Date: Sat, 30 Mar 2024 15:46:07 +0800
Message-Id: <cover.1711784619.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - address Matt's comments for patch 3 (thanks)
 - add "dport", "sleep", and mptcp_lib_expect_all_features.

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
 net/mptcp/protocol.c                      |  7 ++++++
 net/mptcp/protocol.h                      |  3 +++
 net/mptcp/sockopt.c                       |  5 ++++
 tools/testing/selftests/net/mptcp/diag.sh | 29 +++++++++++++++++++++++
 6 files changed, 49 insertions(+)

-- 
2.40.1

