Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B114A08E
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494249; cv=none; b=MMEOlzkN1wKXOumxo4po0pa1Vmy6qBRNfGa7hCPFUnT09456azJrJupkAtYbOU9iGYs2UHBCtGCk5tng2dvVU6zd+p+Y4axPRJ/kEr84unnHi1F7b7+8LlZDRpI1kiu1kSAAuAyGsyH16Yv8u9L7IU/ddOhx1Ovk29CpmSeHRYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494249; c=relaxed/simple;
	bh=oDefqz3BOEivNeXB+Eppi/ysWzZCLzZuvE88LIjNAdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mqXQ4PJm5QvMxrTOk/CS4g6AS9B78X6OvRvlEEci9D0COdDCKzqSfoJ2b3znfLyVeFwXlFAooFrTGMWFcsW+E6pBzp2Bsk2kAZZjNraR7N2OgRWUy2RmHf/xxd1UrFyNrdyCtVn4R0UgH6NQuoahh5gleXBWjwPuegQoBeDMcik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdW+ruVx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdW+ruVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87521C4CED6;
	Fri, 10 Jan 2025 07:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494248;
	bh=oDefqz3BOEivNeXB+Eppi/ysWzZCLzZuvE88LIjNAdU=;
	h=From:To:Cc:Subject:Date:From;
	b=JdW+ruVxKZDppKGg0zlevHiIAK38HPQe0tN53jBU52W1PQ4iJ3hJ/GoA7/U7N8eSm
	 xygVh8XZCyREmj8lABqt/8Npgns5tNrTtcAECyGOsY5jH6RkoKnu8SlEc71Ru1aPXE
	 RcIgidY289plaQKPLpKXIC6r6U68dHbreLwL1y8p++vVmyxvnobHvXvhDwd+01wzeW
	 Xfk/+zvJsf3NoZbfb8ZKqPdRmWXVrtOpwOG9dD8xpQrxwOfQoAxgjyLUQMNGmsac/m
	 4Gyi9ovl5XfPHZOd0R5CcIrk5AyiaqL8YolaGfsqMLdosgC4uw8BmP6yMYkLqcg7H0
	 jgrU9oYOxVJig==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 0/8] use GENL_REQ_ATTR_CHECK in userspace pm
Date: Fri, 10 Jan 2025 15:30:34 +0800
Message-ID: <cover.1736493803.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v9:
 patch 3, move the code using NL_SET_ERR_MSG_ATTR into patch 8.
 patch 7, adjust the location of "pernet = pm_nl_get_pernet(net);".

v8:
 - move the set_flags() patches out of this set.
 - differences from v6:
  - adjust the order of the patches.
  - keep "pernet = pm_nl_get_pernet(net);" at the beginning of
    mptcp_pm_nl_set_flags().
  - not use NL_SET_ERR_MSG_ATTR in mptcp_pm_nl_set_flags(), since 'attr'
    will be removed in the commit "mptcp: add local & remote parameters for
    set_flags".
  - update the code related mptcp_userspace_pm_remove_id_zero_address()
    since a new patch to drop "info" parameter of this patch is added.
  - add a comment "mptcp_pm_nl_mp_prio_send_ack() only fails in one case"
    in mptcp_userspace_pm_set_flags().

v7:
 - update set_flags() interface.
 - drop 'info' parameter of userspace_pm_remove_id_zero_address().
 - rebase v6 on top of these changes.

This is a newer version of the series started by Geliang, now making
them more uniform on how the NL errors are set, and giving more hints to
the userspace about what's wrong.

Geliang Tang (2):
  mptcp: drop info of userspace_pm_remove_id_zero_address
  mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK

Matthieu Baerts (NGI0) (6):
  mptcp: pm: userspace: flags: clearer msg if no remote addr
  mptcp: pm: more precise error messages
  mptcp: pm: improve error messages
  mptcp: pm: remove duplicated error messages
  mptcp: pm: mark missing address attributes
  mptcp: pm: use NL_SET_ERR_MSG_ATTR when possible

 net/mptcp/pm_netlink.c   |  43 +++++++++---
 net/mptcp/pm_userspace.c | 148 +++++++++++++++++++++++----------------
 2 files changed, 118 insertions(+), 73 deletions(-)

-- 
2.45.2

