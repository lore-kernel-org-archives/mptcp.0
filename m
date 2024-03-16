Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0751946BA
	for <mptcp@lists.linux.dev>; Sat, 16 Mar 2024 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710561085; cv=none; b=o4E//1mr6X0cGCNvIGABJiFUyRt+pt/DM0TtlPHAWinzEy9H5gluvHky6Pn6RmKdHGhDkJRA/HiTILeSxjVoH/41HBfFOoZ3kWxFL/Pg4/AnjKFIvpZx5xvgYzUHX5+GOv19XxGN4NbfeGVVsPlOq8xPVWYswlrGUprRhEQh3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710561085; c=relaxed/simple;
	bh=7FIJcjiXAQEs8Zjfrvuy86l5AbymPoEWzqfTTTGjMEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LEqx9it+lp9BBjdtEgrmlRvLVnv1K/QZ2k8svpEIV7YBk1hFR9uyu94X520ZGOnNQWz8VgA/nKA3ZhB2P76tiBIicR+5HVNQKkowO70x1ZRR1XrM1ptXaA5U6uXwcivOxjuuhHq3eLvzSllVLWlryQExMGF54BBVLWOSOy2kH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCjFMCH9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCjFMCH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9B9C433C7;
	Sat, 16 Mar 2024 03:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710561084;
	bh=7FIJcjiXAQEs8Zjfrvuy86l5AbymPoEWzqfTTTGjMEg=;
	h=From:To:Cc:Subject:Date:From;
	b=PCjFMCH9sYDkPaTV7Nago26mSAFncFPOF+OwHkEkrLmWcXISB59zMYModYwasV77N
	 GXJe53pAWbILLRTjZp27DARWAKmxXbnywgScU4lt+E+fHlo92QP3Du03f26WxrgNkV
	 fuWIY4N1N9/gu/B8y6aTDvTu5/19wU/pMfv9UrDbJrDtUtwP/KeirhGv2XFwdVsbRy
	 CFfwMK/xLW5sK2+jDDpgLl93zodqRp9VUB8WjnJwm+nwrdMBn2BjGCR1q17CI8W00L
	 yw5H4guAEnfbSGdjRfcIMryWByCYxYYHMPs2dl88Ft7c8Z5m2Cy84tscNl2uli9f5u
	 7wJPh1DlqNd9A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/9] add helpers and vars in mptcp_lib.sh, final
Date: Sat, 16 Mar 2024 11:50:28 +0800
Message-Id: <cover.1710560839.git.tanggeliang@kylinos.cn>
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
 - address every Matt's commends in v1.
 - depends on "selftests: mptcp: join: fix dev in check_endpoint"

This is the last part for "add helpers and vars in mptcp_lib.sh" series,
add endpoint operation helpers into mptcp_lib.sh.

Geliang Tang (9):
  selftests: mptcp: export ip_mptcp to mptcp_lib
  selftests: mptcp: format limits/endpoints outputs
  selftests: mptcp: add get_limits helper
  selftests: mptcp: add get_endpoint helper
  selftests: mptcp: add change_address helper
  selftests: mptcp: join: update endpoint ops
  selftests: mptcp: export more endpoint ops
  selftests: mptcp: ip_mptcp option for more scripts
  selftests: mptcp: netlink: drop disable=SC2086

 .../testing/selftests/net/mptcp/mptcp_join.sh | 141 ++--------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 163 ++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  34 ++-
 .../testing/selftests/net/mptcp/pm_netlink.sh | 240 ++++++++++--------
 .../selftests/net/mptcp/simult_flows.sh       |  14 +-
 5 files changed, 347 insertions(+), 245 deletions(-)

-- 
2.40.1

