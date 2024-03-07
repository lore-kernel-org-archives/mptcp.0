Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29C12B141
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815737; cv=none; b=Xxn8fsXETodGnB1qt8qieFJTIgyZMsScaE37RQ1OkkhXrWb0AcekfVeNMGr17+fLKfqSfLpWLkGn5VRHyzdVUv3/n4v8OZJIx+BC6nQ5drhY6a9dza3+5V1kejxFl+73o/MH0OrXGFTGp0lrm7Qod5uoBsYPvdQ0aBqPAcq4xCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815737; c=relaxed/simple;
	bh=o7f8kVP8UcHMpZ3vcmBXWUyG2V4HLc8mOSZgNGTrlrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XrKiGeIDQXm2oTPZsmsngTdHHTv7rI8E1ZsxoHmNePxBlNUf7VK/jkcF3GLYj4XXylOg1mtSr8FLhjkuDj7JauRaf6TVEug3Z7NOORAJDkKPYx4fSmy0azm0Tm/oPBr/VnMpSfLUd6ptoNYGaPJZ91OH3MiKoPpZtt8VtoKp1jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHfAfmI/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHfAfmI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22ECCC433C7;
	Thu,  7 Mar 2024 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709815736;
	bh=o7f8kVP8UcHMpZ3vcmBXWUyG2V4HLc8mOSZgNGTrlrQ=;
	h=From:To:Cc:Subject:Date:From;
	b=hHfAfmI/lShPs1x6ufBJ+Klh34O4nb/h9zIxWszSNXwlP/nS5ace0VFgZfuEniiQ6
	 +IjKfc+5odMgEM/fivm+ZWQKdZFfs12XyqS73bii5CNmqmaxUjeslIHRA3mYemKM9c
	 V4pJHeBDHET1VhWzOsiXYZqjaAx/bjZW2/d1WfmMtUtfvyISrmOi6Bvnq2jFsq9FmT
	 Hivr/gOW+OADNbVSLPMBuIQYVxjc/IhC40gbe8x9fXl8kDo6QFQdcID/8XKVehoS/Z
	 0nJvkX4ZSDPDAxCdu76wrHpGVtqm68sGwP8iypga1YU592ns4kSp3lbQh8DrKbbcp+
	 vhcsHHKLQvhNQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/5] add helpers and vars in mptcp_lib.sh, part 4
Date: Thu,  7 Mar 2024 20:48:39 +0800
Message-Id: <cover.1709815545.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP events related patches and two cleanups.

Geliang Tang (5):
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL
  selftests: mptcp: join: use += operator to append strings

 .../selftests/net/mptcp/mptcp_connect.sh      | 18 ++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 93 +++++++------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 74 +++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  4 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  8 +-
 .../selftests/net/mptcp/simult_flows.sh       |  4 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 85 +++++------------
 7 files changed, 150 insertions(+), 136 deletions(-)

-- 
2.40.1

