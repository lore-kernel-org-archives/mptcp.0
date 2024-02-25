Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0950FDDDA
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866251; cv=none; b=kv8umkXQTb8JBZL+oRpApY7p5HUTwnQboDNpFAHFY7ZiWm0GO5UmjD8uvlCFcFEFvsETlz6ks6Qi2W8kXXXo1hkEMGepm3OlwccPxMaQ8btmi7V7AbQDhRz+vr2zqxJOPMYuF02NNl0nMMFVmerWJXTZuTaoiS8gp7Nt5ykBpMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866251; c=relaxed/simple;
	bh=jwSjQTKt+uw111tYY6fb+KXFfPe7s0zsxIk06u8Dckw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZnEyB8OFfx9BGZw0zhlQATVlTI+w7sHVqfQe+HoLrKclwUJyvcQvk/bQUHImGo8l34rfkRgNaj1im0QaIRndC4kR4iXAUOTu9geBtxrFrvg1UIcuexZDd5E66PEHbW5wZfmHVAliQAqCbtkbmv3Qm+laCF+KI5QXmFcJW6esu4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rACS/sIA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rACS/sIA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2A7C433F1;
	Sun, 25 Feb 2024 13:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708866250;
	bh=jwSjQTKt+uw111tYY6fb+KXFfPe7s0zsxIk06u8Dckw=;
	h=From:To:Cc:Subject:Date:From;
	b=rACS/sIAZr8RgKXAPK6S14RqwwoyKPRdT3NsTy/Q6dPm2IbJUfECCTW1uPtEKwNH2
	 bP7M8tBt880rDgTFesw6QMQaH6cCAEunmIhmUuGCQW3XAApcwu7lj+0DIykcyduz08
	 xYQiJYxvpNXu1wQgjU1EGAo8N/40xagscgP2OwCKlh3TqMB5+KIy4w5GLy72raALXY
	 gbsnw8DxmZv4aorL0ghrNLgphOkHks4z2i2YikMkh4CUzf8S6UDMc8sbA8DMxs1lth
	 evMHBuLCAYRSTSnYn/F4WkSa1peU1RPgFSn8x6lubhWaSsY/sE0TqxJR9e433cnDKy
	 ZlNIhRuuJU80A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 00/13] add helpers and vars in mptcp_lib.sh, part 3
Date: Sun, 25 Feb 2024 21:03:48 +0800
Message-Id: <cover.1708866087.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - fix shellcheck errors in v2

v2:
 - fix shellcheck errors in v1
 - print test results with counters

Geliang Tang (13):
  selftests: mptcp: capitalize ok/fail/skip
  selftests: mptcp: sockopt: print every test result
  selftests: mptcp: connect: fix misaligned OK/FAIL
  selftests: mptcp: print test results with colors
  selftests: mptcp: connect: add dedicated port counter
  selftests: mptcp: connect: print out ping tests info
  selftests: mptcp: add mptcp_lib_print_test_counter
  selftests: mptcp: print test results with counters
  selftests: mptcp: move test_fail out of check_expected_one
  selftests: mptcp: extract mptcp_lib_check_expected
  selftests: mptcp: export event macros in mptcp_lib
  selftests: mptcp: add mptcp_lib_verify_listener_events
  selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL

 tools/testing/selftests/net/mptcp/diag.sh     |  18 +-
 .../selftests/net/mptcp/mptcp_connect.sh      |  87 +++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh |  73 +++---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  95 +++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  34 ++-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  11 +-
 .../selftests/net/mptcp/simult_flows.sh       |  13 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 210 +++++++-----------
 8 files changed, 297 insertions(+), 244 deletions(-)

-- 
2.40.1

