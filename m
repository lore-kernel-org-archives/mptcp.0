Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186877D07A
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062384; cv=none; b=Qgq3NbY7siJXnyPlp+UisscX/peYxz/wtI6jN5lkd2khKlZFZ+c4MRS6i5ksa6IyiUgkgyFaVrAxB1vyfF9NeQ5EE0EhaZja/HNiz+qirh3N2HxWY9G3D4s4qZ6OHYpmCol2TQTZ1ppkHFbuChEm2DqGtX12q1xPdmQL4eB8Qic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062384; c=relaxed/simple;
	bh=eQvFELl8pxzqwfz9JzYRFSReTAP5VwvWRBeuVM2da/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l9OcxdsY69a4mLhH4fnaKROHu9J0BR+HnP6+irdfNOiSUd8MGZU8xzEC8uCCS1febgOr54Yh/7rBQYpcdk9mvtiiv1Ir8sWPSLjB8Z+FtAb4uTxmQ+hV/pffRGHrJgYVLzM7vL+Yyj0jmmJsjFwaVIVVGVvP75zPUJyOrvr8izA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iM+fnTMp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iM+fnTMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B210CC433C7;
	Tue,  2 Apr 2024 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712062383;
	bh=eQvFELl8pxzqwfz9JzYRFSReTAP5VwvWRBeuVM2da/A=;
	h=From:To:Cc:Subject:Date:From;
	b=iM+fnTMpho6cs5Gdc5PN8sLV4ldavldFlUpeuA+0b2FW/iMo4jHPjzvrUBFKUnNmr
	 ViZeOP/Tn3eoc/Z/3IO7epfaJSIDiQqrNtze25wyqzIRQ9W26wSL6UKwKEH25rOApg
	 5vtE9jFgC95G2JAv7Pf7yMS64TXRi6tB6ctw5p956dwCtg2aUk6WU2s+wLkwvpDQwc
	 TWVh+fpe7yN5OOm/VC/KDO3OmEbjysCtOyr+A5jWjKW5P+M/TO57xbKZBG2hNj2Xlq
	 74eCNHIFD+4eqGczWcHjd4n4s46SUwk87GNOkVOnsooYH8IDKAxhkTdcfTTY4QM3Fm
	 Qx5X1tdDy0Vyg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/2] display "last time" actions info
Date: Tue,  2 Apr 2024 20:52:53 +0800
Message-Id: <cover.1712062199.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - merge the squash-to patch
 - rename cnt1/2/3 as Matt suggested. (thanks)

v4:
 - address Mat's comments for v3 (thanks).
 - merge patch 1 and patch 2 into one.

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

Geliang Tang (2):
  mptcp: add last time fields in mptcp_info
  selftests: mptcp: test last time mptcp_info

 include/uapi/linux/mptcp.h                |  4 ++
 net/mptcp/options.c                       |  1 +
 net/mptcp/protocol.c                      |  7 ++++
 net/mptcp/protocol.h                      |  3 ++
 net/mptcp/sockopt.c                       |  4 ++
 tools/testing/selftests/net/mptcp/diag.sh | 51 +++++++++++++++++++++++
 6 files changed, 70 insertions(+)

-- 
2.40.1

