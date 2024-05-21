Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518E2E859
	for <mptcp@lists.linux.dev>; Tue, 21 May 2024 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287860; cv=none; b=NGz0kWMaBExKqMxRKjew34hcGz/VU7Zut8l1wQvoT/Q7vqKnnM0YUqXCv3QLD2RfymQ0aYzdT1YjBRDLTFEOcME5Gf1nvBba5TzfklwpYYbm5HVYXnpPFjtu8VttpQ5iGR5HPJWGBwSdCzatovzcYnOK8Xk4SDyK4EqZnyyxoVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287860; c=relaxed/simple;
	bh=rWfdUfoybZpLBoIoK2jHXou0I7vTkv6sEbW8NZmywgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXCHyae4XpGE8gk2Ct7ylkbKDshhoDrWoI4/Ms57B5KgFVkGa3J5yy518X5J0HsljPZZmtPyJI5OtS3sc3KQSiI+1QAsT0m3L1OLpjwKTOhcjcbUh+O2mRp2eJrfyXAdwA//vCQ0HzYw0iNJJChwe6GknhYs2qNXbszgWkUmgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGKAiHp8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGKAiHp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73884C2BD11;
	Tue, 21 May 2024 10:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716287860;
	bh=rWfdUfoybZpLBoIoK2jHXou0I7vTkv6sEbW8NZmywgg=;
	h=From:To:Cc:Subject:Date:From;
	b=RGKAiHp8955+CfFHWtrIE8KGqyyRlcgmtjIkN7rGzrlDRFJcgBAWvYH4kZAvj53QC
	 HtEdPPqnhExPooe1fB+t/K8P+9Ixon7R2bKC7vTo+7RFjcVp7OoLHHayHsRXhxG2kI
	 MA3Ma8Or8yuafA0z3HJOzh9MH1nbu20DDEINSKkFY2RPMRlRz9NwD7yT5FZ96jhSjQ
	 KRsddi5zW+RUVmzI5YVkhw/jq2dJ94i2z9DAGvQyCLz5/ocasTmdFU1NHiejy6zRk3
	 dPvamr8das0rMhLAcd6yTiz1gKaxCgMPUO0toTFm6DiZILg2+rZhVr7AXkYQCKPNX7
	 ihobUSKJ1fyDg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/4] use helpers in lib.sh and net_helpers.sh
Date: Tue, 21 May 2024 18:37:27 +0800
Message-ID: <cover.1716287732.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This set uses the public helpers defined in net selftests to replace
helers in mptcp_lib.sh.

Geliang Tang (4):
  selftests: mptcp: rename ns to ns1 in diag.sh
  selftests: mptcp: use setup_ns helper in lib.sh
  selftests: mptcp: use cleanup_all_ns helper in lib.sh
  selftests: mptcp: use wait_local_port_listen helper

 tools/testing/selftests/net/mptcp/diag.sh     | 58 +++++++++----------
 .../selftests/net/mptcp/mptcp_connect.sh      |  3 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  2 +-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 43 +++-----------
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  2 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  2 +-
 .../selftests/net/mptcp/simult_flows.sh       |  2 +-
 .../selftests/net/mptcp/userspace_pm.sh       |  2 +-
 8 files changed, 44 insertions(+), 70 deletions(-)

-- 
2.43.0

