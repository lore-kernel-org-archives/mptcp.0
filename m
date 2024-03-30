Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA2179
	for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711788654; cv=none; b=KEiyafGdKpRnTq0iewpqNrP+C3L5/722ChRXuxX8dXEdDqdqDgM84N4EDNDma6iwalgMqIsInR6oYZXK38KKFkungdndELnyzk9DDWPDTjWzWVTlf9l7XXVhbQfmpWiRuz5SY5434J6x7knZz7q+Z6RlYCn5KpbDxu6s5Jho2QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711788654; c=relaxed/simple;
	bh=hbJaSM/LY3CG/gWLByahU9vnisgaX3Q4UiX/MXo5kF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nMrmtiz/fbNJFnvLTOMZxiGt1OrFILdPRtbC8tQAqNKCYVwXxJvqT6hYlMURJeBn58cCzgrUaMmrdZdvIIKEKYG48arQ1pY9BgYn3E4ZF6kgamQshSBmwCMM+WLQEKURKZGC6eGnWSeMGkR6CAzbp3tcWfLuMruXjipmjgSS/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhqUp1gP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhqUp1gP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CED2C433F1;
	Sat, 30 Mar 2024 08:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711788654;
	bh=hbJaSM/LY3CG/gWLByahU9vnisgaX3Q4UiX/MXo5kF0=;
	h=From:To:Cc:Subject:Date:From;
	b=KhqUp1gPr986qP3Iq9CxiF9ymH4GEdhQLeH2e1LrFwil/bPA0qGdVv1jzPH0JDkS4
	 rRMc4ZXizWgf4kbKK5+2lImdN4WB6E0J7hx2XIsGxlXFjJdo7rfPn3AE3TzTDTCeuG
	 5n8WjLejQhV0YNk+5rbTwj42uAaM5hD+1xqKzuMUo5bfHw4hrJmaQdvAh2ZzK7PlQB
	 r5upa4ksuUFuyB+AU8gZA0xvAoVvm62hio6Z7D5SKrmwE1z3uIPUnqK2DWT9QLr+4n
	 Q0OPcZxJoRAjWuh8E6YTpiA8gwCN9qTiJ7WRhbf4+V+9V1VIAiRqcYbaB9dJQ8jFXj
	 d3Jd+Qj+HcDhw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/8] refactor mptcp bpf tests
Date: Sat, 30 Mar 2024 16:50:42 +0800
Message-Id: <cover.1711788593.git.tanggeliang@kylinos.cn>
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
 - part 1, bpf schedulers.

v2:
 - add two more helpers, send_single_byte and send_recv_data.

Refactor mptcp bpf tests using newly added macros MPTCP_BASE_TEST,
RUN_MPTCP_TEST and MPTCP_SCHED_TEST macro.

Geliang Tang (8):
  selftests/bpf: Add RUN_MPTCP_TEST macro
  Squash to "selftests/bpf: Add bpf scheduler test"
  selftests/bpf: Add MPTCP_SCHED_TEST macro
  Squash to "selftests/bpf: Add bpf_first scheduler & test"
  Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
  Squash to "selftests/bpf: Add bpf_rr scheduler & test"
  Squash to "selftests/bpf: Add bpf_red scheduler & test"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 267 +++++-------------
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |   1 +
 .../selftests/bpf/progs/mptcp_bpf_burst.c     |   1 +
 .../selftests/bpf/progs/mptcp_bpf_first.c     |   1 +
 .../selftests/bpf/progs/mptcp_bpf_red.c       |   1 +
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   1 +
 6 files changed, 78 insertions(+), 194 deletions(-)

-- 
2.40.1

