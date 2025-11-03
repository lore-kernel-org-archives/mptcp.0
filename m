Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0936D347C3
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197592; cv=none; b=p6OhdEToz7qsCPHde6+KrgneQho90S7Iplc3jmlUKQgw9nptsRL/dibhDSOj5wEV5w72ADH8TAzSXyj7z8nJwKiIbGHysoca7pUJU8Dqgi8lP3+UgQ/4npO9lWyfRmfZ5Cer1khecsOy7exmzETjgyvFCLy7rBoDuE5+f4VWM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197592; c=relaxed/simple;
	bh=tSQOtxkFudeac0w8FOAMwRnvnMsPw3LtPxI9XE5DM0Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Iy0I9HxC5dD9Rn/hY8I8eCitnOYYJGi2Y5+Nh99gL4bi4H+J0vxiO0XPhEYL0v0z67E27Hpwy4jjZrbn3G8W0xaXG3HI7nUUw3NiRXi3SKMecEjOxVFejwmRS+JJKrectNYky/5sRp1/uqyXX8kv51Ep8FiqGRWmfKdnoM8Np/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTrbmHW3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTrbmHW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148E8C4CEE7;
	Mon,  3 Nov 2025 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762197591;
	bh=tSQOtxkFudeac0w8FOAMwRnvnMsPw3LtPxI9XE5DM0Q=;
	h=From:Subject:Date:To:Cc:From;
	b=sTrbmHW32Fa6tmLQeiyUrC96f+C7itG6GLBzbFDqZD6MFkP19R+jEMtp+hiTR2fax
	 MEM3RvmHC9NROJ/g1FDozwPdYVhLi3e11gq14TmaPT0JHolPrbtFUE1IYuvpd/DjFW
	 oYU3MINgTqjNaWCftz9QzqV/Wboo13e6iTeXD05BCl7d4nUimEIpsfYZ+t1JoLVa+k
	 efPYSVIcz4Wv8+zx0IHUrcfnYqLZOwVMZXlFFYd0mig/6syM8gXhPj0vTupjsmRCzF
	 VazE0mFt7SV7n7He2msdqSFC3QkQBxSC+wiq9u6STH1emmewuKBtSThC/K9Kdpjf6p
	 DA3OU0HmQUTLg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/5] selftests: mptcp: get counters from nstat
 history
Date: Mon, 03 Nov 2025 20:19:30 +0100
Message-Id: <20251103-slft-nstat-cache-v1-0-56025c09e56a@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEMACWkC/yWNwQqDMBBEf0X23AUTasH+inhIN2tdsDHNbosg/
 ntDPT5m3swOykVY4d7sUPgrKmuq4C4N0BzSk1FiZfCt75xrHeoyGSa1YEiBZsb4uEbf3zx1xFC
 1XHiS7T85wCsbZUy8GYxnVvj9qS92Fsbj+AH6LEYOgwAAAA==
X-Change-ID: 20251101-slft-nstat-cache-db4d2962c5ce
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1650; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tSQOtxkFudeac0w8FOAMwRnvnMsPw3LtPxI9XE5DM0Q=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI5GfxjzRcVH08Pz16z8W5IisU+nxbv7D8K17NUpvDP+
 fi87MqSjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImstGf4H9q8ZTpf5pQw76Dz
 ARXmPqI7u2Qacnm2iE+Lll7bzTzDh+GvuLbHe7a1QkX/n/3Nny+UVBX1+UKp7ryHBdPn+DxeG7G
 IGQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When debugging MPTCP Join selftest with a "debug" kernel config, I
noticed checking all the different counters was sometimes slower than
the test itself. Fetching the counters once, then reading them from the
history file that was already there seems to save more than 5 minutes
when running the whole MPTCP Join selftest.

- Patch 1: move code to mptcp_lib.sh to prepare the new features.

- Patch 2: simplify mptcp_lib_pr_err_stats helper use.

- Patch 3: remove unused last column from nstat output.

- Patch 4: improve stats dump in mptcp_join.sh.

- Patch 5: get counters from nstat history.

Based-on: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (5):
      selftests: mptcp: lib: introduce 'nstat_{init,get}'
      selftests: mptcp: lib: remove stats files args
      selftests: mptcp: lib: stats: remove nstat rate columns
      selftests: mptcp: join: dump stats from history
      selftests: mptcp: lib: get counters from nstat history

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 100 ++++++++-------------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  31 ++++---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  45 ++++++++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  15 ++--
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  15 ++--
 5 files changed, 104 insertions(+), 102 deletions(-)
---
base-commit: 1b41f9e417a8db60baf3686b81346131d2d81f30
change-id: 20251101-slft-nstat-cache-db4d2962c5ce

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

