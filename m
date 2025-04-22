Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5D200BB2
	for <mptcp@lists.linux.dev>; Tue, 22 Apr 2025 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745314319; cv=none; b=Vq4DeA/oaBTstbr2xz5ojqANwp0qQ/3mNCk6VgUQ0jUOKDPXOKwTodwpUevpoJ6/XV80yPvis2ck84kgjFEvu0lB9iNkxwvASeMSOVgmfTDAx2CFtArLYywdRL8AqMDU85eQ+WwL9F22tbz8Btau3TS+N/BGEEg5YCcg4KJSiKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745314319; c=relaxed/simple;
	bh=Uoj2aTwwH5rQUA+L/bqtfw3/6eU2ICOza0OOGkeFi40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFfQgHQCIrqN8UItO2/KCxjatKSMKgm/A79cBr4JzbbLIqpHf1nWRpltCOieYrHJYUwG6DtiJCOzjUwkbEbyHfZhhUUZn25SK1yyRfFwERlGvAEHOVIp0i5rQ6A+pmehNHGKn/p39V+F3EyBipKD12SFk5WA6cQQMTnySoiNHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDBK/Q6g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDBK/Q6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7126C4CEF0;
	Tue, 22 Apr 2025 09:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745314319;
	bh=Uoj2aTwwH5rQUA+L/bqtfw3/6eU2ICOza0OOGkeFi40=;
	h=From:To:Cc:Subject:Date:From;
	b=oDBK/Q6gXVFtuHPa8J1OWeH7WA0Z+X/pjTpdkPTuhS2AAun4BGHLuQqYUHoqI+mDC
	 m+uOf8JkA3X6jQtlOb+iCLz0pcl445inxkK53oJU+iKAl/my/qJfLbKqMPBv1ZH9aq
	 vwyiPjbnunQHJkKZ1Y2xSGkR1wI27Z6n3s6rg5BG4V/7caYS7142ylilwzPhAk9lpE
	 Vp2M5tsl8hyKMALlkmWoQeQxbbcG4NsIxQQomBoxQ+sQ5SzrXNMQhebvbvjc9N9Xh1
	 qlsKtvtMLJo2ja3vBslKSSffs5N3RE2cijKwVyWdcPYL9OyZvbsqDEk+tQayj/p4dQ
	 thSmkWaqVmyNA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 0/2] Add TCP_MAXSEG socket option support
Date: Tue, 22 Apr 2025 17:30:43 +0800
Message-ID: <cover.1745314165.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/515

Geliang Tang (2):
  mptcp: add TCP_MAXSEG sockopt support
  selftests: mptcp: sockopt: add TCP_MAXSEG sockopt tests

 net/mptcp/sockopt.c                           | 29 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.c       | 22 ++++++++++++++
 2 files changed, 51 insertions(+)

-- 
2.43.0

