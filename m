Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC024C092
	for <mptcp@lists.linux.dev>; Tue,  6 May 2025 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521732; cv=none; b=bSPdDwAh7NKG6tc5zWgZn7V0nlas3GfXGI0pwLMq6rorUEZlXX6Unw1CmUhZgLsu+f8DW6SlUP1pQxhaE8X6hVC6FHMSwDNhmXwDneJ3PCMma39jjlF7exz/TXnvNoZos9KEa1+xyAeebKW5b69LOf22oCIfHynel3Ys/ag8Vdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521732; c=relaxed/simple;
	bh=pnwP9vJYSWCD6dINZTF39hM5u3JzUH6tau/eFH18x1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=isa24nqkobzb4GcQiy8UeAT4u5MQXqsNW2+kKe/GDrzSrRvoUgfKiUI0OM46P2h0ZxRru6l9ntlRosch82KjvvTZ55Zfaz450AG8h4Yv/9XqhXBIsz/eQm5eDUbCeZf3sv8Zwd44aIhL5ZK31tO/sn9grQyJPkm/hV7Lj7pg2+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE394O/v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE394O/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF425C4CEEE;
	Tue,  6 May 2025 08:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746521731;
	bh=pnwP9vJYSWCD6dINZTF39hM5u3JzUH6tau/eFH18x1I=;
	h=From:To:Cc:Subject:Date:From;
	b=uE394O/vgECIFhiI145P4H9nP/XRHrg0OY1s5SNvzc576WZxdUz7gywQ2R1oy/cXD
	 VmoYSlROeBNyeSmnOQKZVbyUOBY4/Kepoyj4B0ohpVlSoSJ6q5cuirQ0k9EYqtK/SY
	 DmjaLntgJEfLJD0LmJFMSBG/6z2Zld9paPZJyayvN918IrdNVzhgUlv7x1vKZkXjhJ
	 5v0PewxweHccCotB7DQ/LhZtWUiZbQ+sWdDXaVH9Hya1f46RvHsBpNocQ4Wo5mdeq1
	 OY6INAd2QGEWf/zxbRK5gmKk/8QoXrN7lFkJI92VlIaIrnflMGeIH9h49kfDK2VLha
	 LxZVz1brsd1HQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 0/5] BPF path manager, part 6
Date: Tue,  6 May 2025 16:55:21 +0800
Message-ID: <cover.1746521233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v7:
 - drop 'mask' variable, use MPTCP_PM_WORK_MASK instead.
 - add 'status' parameter for __mptcp_pm_kernel_worker.
 - no longer renamed, keep the names of mptcp_pm_addr_send_ack and
   mptcp_pm_create_subflow_or_signal_addr unchanged.

v6:
 - squash accept_new_subflow patches into one.
 - change "pm->subflows == subflows_max - 1" to
	pm->subflows + 1 == subflows_max.
 - not to call accept_new_subflow under the PM lock.
 - add mptcp_pm_accept_subflow helpers.
 - drop READ_ONCE in mptcp_pm_worker.
 - clear all the pm status flags once in mptcp_pm_worker.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1743133948.git.tanggeliang@kylinos.cn/

v5:
 - add comment "call from the subflow/msk context" for mptcp_sched_ops.
 - add new helper mptcp_pm_accept_new_subflow.
 - add "bool allow" parameter for mptcp_pm_accept_new_subflow, and drop
   .allow_new_subflow interface.
 - use a copy of pm->status in mptcp_pm_worker.
 - rename mptcp_pm_create_subflow_or_signal_addr with "__" prefix.
 - drop "!update_subflows" in mptcp_pm_subflow_check_next.
 - add_addr_received/rm_addr_received interfaces will be added in the
   next series.

v4:
 - address Matt's comments in v3. 
 - update pm locks in mptcp_pm_worker.
 - move the lock inside mptcp_pm_create_subflow_or_signal_addr.
 - move the lock inside mptcp_pm_nl_add_addr_received.
 - invoke add_addr_received interface from mptcp_pm_worker.
 - invoke rm_addr_received interface from mptcp_pm_rm_addr_or_subflow.
 - simply call mptcp_pm_close_subflow() in mptcp_pm_subflow_check_next.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1742804266.git.tanggeliang@kylinos.cn/

v3:
 - merge 'bugfixes for "BPF path manager, part 6, v2"' into this set.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1742521397.git.tanggeliang@kylinos.cn/

v2:
 - address Matt's comments in v1. 
 - add add_addr_received and rm_addr_received interfaces.
 - drop subflow_check_next interface.
 - add a "required" or "optional" comment for a group of interfaces in
   struct mptcp_pm_ops.

v1:
- https://patchwork.kernel.org/project/mptcp/cover/cover.1741685260.git.tanggeliang@kylinos.cn/

New interfaces for struct mptcp_pm_ops.

Geliang Tang (5):
  mptcp: pm: call pm worker handler without pm lock
  mptcp: pm: add accept_new_subflow() interface
  mptcp: pm: add established() interface
  mptcp: pm: add subflow_established() interface
  mptcp: pm: drop is_userspace in subflow_check_next

 include/net/mptcp.h      |  5 +++
 net/mptcp/pm.c           | 85 ++++++++++++++++++----------------------
 net/mptcp/pm_kernel.c    | 42 ++++++++++++--------
 net/mptcp/pm_userspace.c |  7 ++++
 net/mptcp/protocol.h     | 27 ++++++++++++-
 net/mptcp/subflow.c      |  6 +--
 6 files changed, 105 insertions(+), 67 deletions(-)

-- 
2.43.0

