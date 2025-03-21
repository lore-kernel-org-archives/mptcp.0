Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18222846C
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521539; cv=none; b=rMm6vho8deazaP8LimC32Ghw2b95xPbrRHyRTYe2elrtGWQH6FOA8nszUSK0TIEyGXJ4qwVSCeNq3JpXOvNKY0SQCo5UgaM1jjL4MiCtYhTED8+HSrilvrrNXM3P6v37iHbv2yxUhllM7hX2gjwgwJHndF6MUX+t6EmPYv3iM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521539; c=relaxed/simple;
	bh=pqOijwYf6Q3G+vKNc8H7YUqE5ym6OL/q0YqLTbeWCrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2KkCy8Fn4hJMXEteOaQOHoaZD1+dIQZ3RPkxxKaFMrsu3Cv8limp7fBbaH+Akslyr12oe0IxGmsuIsHNezzBFN+jTqIvhW/LCDlpXVktdhjZte3tYtjtXb8XRLUDrx7N7O2H/UvXaBzEMOL2iD0/Cyo93tUigZEG+Qk5xnhwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFQ5mKsr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFQ5mKsr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624EAC4CEDD;
	Fri, 21 Mar 2025 01:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521538;
	bh=pqOijwYf6Q3G+vKNc8H7YUqE5ym6OL/q0YqLTbeWCrM=;
	h=From:To:Cc:Subject:Date:From;
	b=HFQ5mKsrCmVruSdk+STzrt8lWJ2tno7Q3gnTFB6TTwZfjtlduSerGdBkepTRnY3GZ
	 ysPInB9HlhbJGK/DC85m9Nmr/zV8Qswwu0GCCKYGElg2ugR/DPlcT3NdyHFEonxlvs
	 lB0a1XYwfMXHvZNZQlk57C1pUURcGpBxeHu2FCEC1E7SSumIIU2rTG4ds9R2l0WaqK
	 +78BJg20DsRm2c2zC1rpz0UswGN30eT6xYkktkUeR4c0/8ND2HPxKR/updJWe5JQj/
	 VJYgLHR4SVtoBHIkA1ciwcEaECrfQvdBflJh+dkZ0m5hX6hp76qweV9CXsUhxmJ1Ox
	 /xKUCuQFI5gMw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 00/10] BPF path manager, part 6
Date: Fri, 21 Mar 2025 09:44:54 +0800
Message-ID: <cover.1742521397.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - merge 'bugfixes for "BPF path manager, part 6, v2"' into this set.

v2:
 - address Matt's comments in v1.
 - add add_addr_received and rm_addr_received interfaces.
 - drop subflow_check_next interface.
 - add a "required" or "optional" comment for a group of interfaces in
   struct mptcp_pm_ops.

v1:
- https://patchwork.kernel.org/project/mptcp/cover/cover.1741685260.git.tanggeliang@kylinos.cn/

New interfaces for struct mptcp_pm_ops.

Geliang Tang (10):
  mptcp: pm: drop redundant MPTCP_MIB_ADDADDRDROP
  Squash to "mptcp: pm: add get_local_id() interface"
  mptcp: pm: add established() interface
  mptcp: pm: add subflow_established() interface
  mptcp: pm: add allow_new_subflow() interface
  mptcp: pm: add accept_new_subflow() interface
  mptcp: pm: add add_addr_received() interface
  mptcp: pm: add add_addr_echo() interface
  mptcp: pm: add rm_addr_received() interface
  mptcp: pm: drop is_userspace in subflow_check_next

 include/net/mptcp.h      |  16 ++++++
 net/mptcp/pm.c           | 117 ++++++++++++++++++---------------------
 net/mptcp/pm_kernel.c    |  79 ++++++++++++++++++++++----
 net/mptcp/pm_userspace.c |  27 +++++++++
 net/mptcp/protocol.h     |   4 ++
 net/mptcp/subflow.c      |   4 +-
 6 files changed, 171 insertions(+), 76 deletions(-)

-- 
2.43.0

