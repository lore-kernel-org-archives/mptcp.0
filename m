Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097058113
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050122; cv=none; b=E1IuwVeJ3ezJnE43IhgV4+mehnaCe6hZT+B7SRE/p7NTDX5u40n1hbku7UDQyelWef9xbRNtE/2nKZIwm4FU4mNYk1g253go0qAFFz/XmgKtPAM4EfPqlx4+JGezL8mx3DnQCRiiifyymc/s17vs46WFLQk52JFt/+jSsbj8ugo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050122; c=relaxed/simple;
	bh=flMeAtnJY+Id8oMj23MDwHsToT1vG1OkS/spVAisilk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D6em4mu7RlNV31rNNwAhzvF28pBOhSjZZAbZYs7B025No1Ypuz2lxSuQ/48WuZazMC1AOGh5CatiHqJbSai7QW3izdaNWHs3A2wgvYpB6xeqhPsoiA19w62WuAr74E7MOtdB81gVuR98B1DQaUBAByJ4eZYtVPkgB1td8DIPovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg0iNz62; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg0iNz62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A76C433F1;
	Tue,  2 Apr 2024 09:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712050122;
	bh=flMeAtnJY+Id8oMj23MDwHsToT1vG1OkS/spVAisilk=;
	h=From:To:Cc:Subject:Date:From;
	b=Pg0iNz621u1ObXJVwTuM25IUt80Sh8WIJ+6kxoMxG5LnM7LT3xE9oFK8tMvIU1pve
	 b6tA3NKDBSbAX+JCnFOErYG4G3YfOguebVXseSRpbn/HmEVOKW2cx6UPrYx5xbIewY
	 zMPTEYXj6i2/eck2EBuDFcGJJAOqcT0VhBwJj/1Ep5+mEgQ3xE/bI4ojjzHpUiodUV
	 TGwNJ5ZXz0M7rUtktyQvJtpSxmBr36qm53+9+YNMk7YEo9vDs/W7vPZ+Qrghqen45d
	 M92sSz4IJ7DooKVbLUyosMNl55a0kq4Z11+n7QmsNXblFAQpQyiq/fXK0WX4bLv6C2
	 mOGQrGN22NEjA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/2] display "last time" actions info
Date: Tue,  2 Apr 2024 17:28:34 +0800
Message-Id: <cover.1712049966.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
 tools/testing/selftests/net/mptcp/diag.sh | 48 +++++++++++++++++++++++
 6 files changed, 67 insertions(+)

-- 
2.40.1

