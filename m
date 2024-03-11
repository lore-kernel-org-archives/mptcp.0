Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9009A35
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121733; cv=none; b=BOaVhMt4tMSyar5vmcb6cDpEAlu9SsxPAVWCI1cWEDGGj2FJNxpK+3M6eIxXbeoDfH42NspS2aU2WojzV/48yFpb4V6vQbPbLbGua0lNjsJcIjT/5NGvpc3mOJGOp529g35/aGsgaLNR86pcfYAmp3dIuS/EBKui+qunFWIJTxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121733; c=relaxed/simple;
	bh=PXapCOkSkDHvDm2coDrinh6+rR29eXLaVGl9WZhL/RU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pAY7OZwn0282d59roAhSct1pXt4PghqbyLzmkGItvLcTVSyR2t6Sm52/ZKFNlBBo4zabAcQ0EwoAaDB4dUk8Ust+AO7uhb7MXAFW2Zp2c5xBBy2JwEQaolH5Wh4cbceFae8dQMBmHyjgEab6qs8NFktoaALvt3/jCySz2eHiHn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUux075J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUux075J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBEBC433C7;
	Mon, 11 Mar 2024 01:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710121733;
	bh=PXapCOkSkDHvDm2coDrinh6+rR29eXLaVGl9WZhL/RU=;
	h=From:To:Cc:Subject:Date:From;
	b=kUux075JIoFnVCa4TU+FtURLDBnPB239TP9URwRHwcSkAFNYrmrA7bY/fTDZWSnX0
	 XsazH2QT96pCnBWilBa8hhlPzkm3rrGFoZHuYQeWtxvF1ElaAgD73Z8Ii7Tbk7Yl2g
	 HiY5BoQQcnNXCOCBBCPCD856x+28f0ROLzZ5MzO3IEQ7nxSfqiK8X3/fjbwILE27VM
	 i3VWuVs0TKudjFYi+2IAhRBMDR+ELD4CaDe4C9/8olx/zkk0zx14wGL+TtFkg0daAq
	 MJOPVJrMmsq6mJ2pZZE3ms7CD/8CRr6JSGUqhMDmnKqK8CDUVheHXKkEgVvitQ8zTT
	 V/VnMiADxgyiQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 00/10] add helpers and vars in mptcp_lib.sh, final
Date: Mon, 11 Mar 2024 09:48:37 +0800
Message-Id: <cover.1710121590.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This is the last part for "add helpers and vars in mptcp_lib.sh" series,
add endpoint operation helpers into mptcp_lib.sh.

Geliang Tang (10):
  selftests: mptcp: export ip_mptcp to mptcp_lib
  selftests: mptcp: get support for limits
  selftests: mptcp: id support for show_endpoints
  selftests: mptcp: addr support for change_endpoint
  selftests: mptcp: netlink: fix positions of newline
  selftests: mptcp: netlink: add outputs for ip_mptcp
  selftests: mptcp: add endpoint_ops API helper
  selftests: mptcp: use mptcp_lib_endpoint_ops
  selftests: mptcp: add ip_mptcp option for more scripts
  selftests: mptcp: netlink: drop disable=SC2086

 .../testing/selftests/net/mptcp/mptcp_join.sh | 108 ++-----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 166 ++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  34 ++-
 .../testing/selftests/net/mptcp/pm_netlink.sh | 288 +++++++++++-------
 .../selftests/net/mptcp/simult_flows.sh       |  14 +-
 5 files changed, 401 insertions(+), 209 deletions(-)

-- 
2.40.1

