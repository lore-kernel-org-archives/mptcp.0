Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD33022F13
	for <mptcp@lists.linux.dev>; Mon, 18 Mar 2024 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749016; cv=none; b=EaZqdbCL5igr9UAAEVIupdZm0VySyMJ71FbPzML1e1fRr1XgwVP3ixxGhFPH6awORDwCB2mvWwGUN1gOQOkbL9x3tDR0MkUs9e3Nxgk/CzG6EzV+OKpA+2SzBBAMwEZt+6LJntNlKRHWYdvLchyZsqRzKJXrgyc0NJrHfNN9b/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749016; c=relaxed/simple;
	bh=/d0pTm283O2Ogi/B50qBvI43byTrkDxMAfxXAdhyl2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oErTbg7ogsd5OuQ+rijRXdv3q5nXCDv3bp2krzJtr9DuzSinEDQdrykf2Tv2FH73vlMl3SJNAxY/7QgIz7bNb7Cj9ouxiGYu9q3DRJ+J9eL9VuK25Cr/rYH9wIJcCZrB4lqTTNXr5Bc2bB3APzeAjyiaA1YmAeh32I2qU3ETq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTp/qJDr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTp/qJDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3622CC433F1;
	Mon, 18 Mar 2024 08:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710749016;
	bh=/d0pTm283O2Ogi/B50qBvI43byTrkDxMAfxXAdhyl2o=;
	h=From:To:Cc:Subject:Date:From;
	b=UTp/qJDrLPI+5/yAfMTvY+HTFd+mNToqjecCZW5EvjaobVkLOIA6jx8DL+pDLXjs0
	 MVQ3XTmT60qgd662rufZCc2REdwKOc+t/n9s21tQEoD7Y3eOXrKdl1Umo/1IRhsD97
	 afEZEeJ0sUUsG2+w2e9rIHtrZOF/+HBPiAFkb0jrrKenaOvQl4I9rq/xYlW6OTZzQV
	 6Ay8vHqIos9Du8+ulie2HbpG+eCYjgEm6fXQJUJWTposuuHzQytVV44ZiKiHVeqRna
	 4aZKJ6hd0MiHooUjTuHKkUaYWk9Qd6AdII37UxlImL+HmRuZNM5YSIq0BODd9TbuS7
	 u3ElHDHjpvu2A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/3] display "last time" actions info
Date: Mon, 18 Mar 2024 16:03:28 +0800
Message-Id: <cover.1710748923.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/446

Geliang Tang (3):
  mptcp: add last time fields in mptcp_sock
  mptcp: add last time fields in mptcp_info
  selftests: mptcp: add last time actions tests

 include/uapi/linux/mptcp.h                    |  3 +++
 net/mptcp/options.c                           |  1 +
 net/mptcp/protocol.c                          |  5 +++++
 net/mptcp/protocol.h                          |  3 +++
 net/mptcp/sockopt.c                           |  5 +++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++++++++++++++
 6 files changed, 38 insertions(+)

-- 
2.40.1

