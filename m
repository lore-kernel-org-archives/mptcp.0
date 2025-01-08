Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBAF1487F4
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300659; cv=none; b=Sy0DX9De8hROSqQUCRc31u76B1uryb2hTm01XzwefpEbTi3fiVfpJfEkuGEOO+b30i1HMoMFDMqVP25kIGgqUqACxJMuVLkPqKmTRgHR1isSgAkoVbjbFbU9pAtk4pXdtpxV5z8HsQ4GB5cR9af+Hl0luWResiOLmW0Tl2kPwr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300659; c=relaxed/simple;
	bh=MxvO02QY1q1TRDJwiDkRxvzi3nQjGSFrfLvk8itjdDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sy7mYolZI+3Cg+Zxso6FHakGOouBdlIIBQPQuZ3EB643+VsRXaVZaAhXlKS8rALrQkUzhwCHI2nao2cG6EqGkVDRyqsO6ncGs4fezuwpR2sSLzFF3BCHUifZqc0hMTqqrpN6BzimyGLPe8n21sHzcYRE5KvaVWMNEo6/H9crk6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF6CT/Xs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF6CT/Xs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC21C4CEE0;
	Wed,  8 Jan 2025 01:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736300657;
	bh=MxvO02QY1q1TRDJwiDkRxvzi3nQjGSFrfLvk8itjdDg=;
	h=From:To:Cc:Subject:Date:From;
	b=hF6CT/XsenpR5+n9TpjzO9K/tFWpLyDZxzKccnxJiDd60+NvFVGIisY5dJD0b8lAw
	 8vQaiJMi6Wa20a61kLdEeEcj2PRGOq37XY8QdGuVhQkqwN9QYFQuxxYrOpT87R1PnW
	 NcioNTZyYq4sVVyplBzDegE/i890S2eErRdc/AwbI3HvfvEYOVo99ytS3igMW5bpll
	 /Fdc29r33or4/lbqpI+5wlnSSIMZ4HxSmop/2PDNWY7KjTty8BtaosIrqkEVhGXWXJ
	 4vHew7tgLa9VCHNH6zgRmEaFzsHYHTwZ+/xX+zKJ/8rIyIWfMPfrzth0EUFk5mCz1D
	 o154KNIP3pT2w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 0/8] mptcp: use GENL_REQ_ATTR_CHECK in userspace pm
Date: Wed,  8 Jan 2025 09:44:01 +0800
Message-ID: <cover.1736299989.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

 net/mptcp/pm_netlink.c   |  43 ++++++++---
 net/mptcp/pm_userspace.c | 149 +++++++++++++++++++++++----------------
 2 files changed, 119 insertions(+), 73 deletions(-)

-- 
2.45.2

