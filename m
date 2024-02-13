Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6CA923
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707797680; cv=none; b=l2aLz8/45V9kXX4U7qjm6EbpgEnJ5JD3WcFM2x8X0askR49uVgalt79v+R4YJnOy8/BuU9C1S01sANA4nIx87T+2BVI/8RkzdnhoGVCgO4zgOJKmQYZCo3aDoHELCrA0uXK52o3T5gvyfPOd3Umqw6oo5HHd1CRbU4w5FM3UDlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707797680; c=relaxed/simple;
	bh=5vN92ZEGzeQUa1jbz5G0X2+yfcT4aSb99Dkx5aRNh9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oYywPwUZZpLuihRHbDcLtcHQQ3GCEF9uvvZDhIACNqQq/XCPC6thwlk6iytywM+UhZoTi39erZi74v62d+iE4M7TxYUXsaKYLjcj9Mhu70jBTstqVjh4/4VVeFhYP92ax9/pDGA775e76E+heuQxUWvHG/+vV3NgDLqEC2itgmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxmCixbv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxmCixbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEB4C433C7;
	Tue, 13 Feb 2024 04:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707797680;
	bh=5vN92ZEGzeQUa1jbz5G0X2+yfcT4aSb99Dkx5aRNh9U=;
	h=From:To:Cc:Subject:Date:From;
	b=hxmCixbv1bXLf/Cr177aV/FYm2RI9fGNKUS5yf2d+eSFvFmf93dFoWg+6dX8I5+NO
	 8sR2hd9N8cTrVk+aD43ua+iNyjBZJ+NcZJ9pfs5J4wVKou2EH+6Cl+ltaQN2meIWfK
	 zwBiWLwuOb2kqkZlywWYEPK3I9GtrAUhenxxcNd5Lhk0DAEZUYPZ5oe07YGRe2PKWT
	 Ymc5uSmD9+IIhuAGucsFQedLEdgWtJNwZjGymKWAZTL6uU3c7IiePrSK4onP5ojHbm
	 CmN0NKBlPVGv5jnWKuAHZKAC0p2gYD5CQ8MpGH3dqrWDgIk628oUeK3UIcKLSNFFAG
	 H27bAgN5PI0OA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 0/5] add helpers and vars in mptcp_lib.sh, part 1
Date: Tue, 13 Feb 2024 12:14:23 +0800
Message-Id: <cover.1707797566.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Part 1 of "add helpers and vars in mptcp_lib.sh", some fixes.

Geliang Tang (5):
  selftests: mptcp: netlink: drop duplicate var ret
  selftests: mptcp: simult flows: define missing vars
  selftests: mptcp: add ss mptcp support checks
  selftests: mptcp: join: change capture/checksum as bool
  selftests: mptcp: diag: change timeout_poll to 30

 tools/testing/selftests/net/mptcp/diag.sh     |  2 +-
 .../selftests/net/mptcp/mptcp_connect.sh      |  6 ++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++--------
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  6 ++++
 .../testing/selftests/net/mptcp/pm_netlink.sh |  1 -
 .../selftests/net/mptcp/simult_flows.sh       |  6 ++++
 6 files changed, 36 insertions(+), 13 deletions(-)

-- 
2.40.1

