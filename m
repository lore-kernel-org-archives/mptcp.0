Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B02717DFF5
	for <mptcp@lists.linux.dev>; Thu, 22 Aug 2024 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318581; cv=none; b=LTIHgmmYLWaG9c4iR81p4HMnelPSUBrivLMUw+T+yPRgVoFUIsi7v2uIpRxYR5TfDiXIg+flmHOVvLVzygYBZg0TGXnlz9H76piq15HVIIGW8UehUwzDHCizeMexf+AhI0B50BzqAxZ4fxwTJdNZjpo0Yrf6TE8PKeSLPV7WDFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318581; c=relaxed/simple;
	bh=HDeWCdmdYkZ2MROkmKdxQHlw7J13wCPSfo5drb/1+L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mg0yabYE6VNrxuN6TvgmVUv/ieFKvdYAydBS6nyTwz2JglO0QneMXGD+kWUNH+H/8N+PM7PSo+2m6w/3tgnOGHX55lhMsrvEFrkCd4EIdaErYIGWbu7o01jdDtHZHRBa5pVmx7cIfFRBqtDIbV53v6aezqckJCjEoTIVEOP7eTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgCHrQVO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgCHrQVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB216C32782;
	Thu, 22 Aug 2024 09:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724318580;
	bh=HDeWCdmdYkZ2MROkmKdxQHlw7J13wCPSfo5drb/1+L8=;
	h=From:To:Cc:Subject:Date:From;
	b=NgCHrQVO6itkt+qU4dkiNmpbdgMXSS8lAfBx4n5Z57u8zbOgMqoZSoxz24mDxpbAs
	 mEA99zd7VbL9UKszwynjvLvoewdI18mfH5Nd14AQ99rje+9+FN6AkiQaFSNhiVJ4S5
	 TewVu5eQCwp8so0ZEBA97ozjnTfs3s6UKlFzQRm4NTdxQuHTk8jT+pFsc0GlxVKyHh
	 dtvRPbKfvwrWSz2x8NmhZHAd/U43BZ68thIApkCWyskv+BT7aMtCrnq43TFTaRFtOF
	 jiZySGFXa9RjyDziUxSUWYejE6tuOZ4xJeaZsz5oD9L76KNeNjLdkXcot2a+qU6/t1
	 BYFmwzMSfDT+w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/2] fixes for "new MPTCP subflow subtest v4"
Date: Thu, 22 Aug 2024 17:22:49 +0800
Message-ID: <cover.1724318341.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - drop "ss_search" from subflow subtest
 - fix mptcp_for_each_subflow_safe
 - add cond_break in list_for_each_entry/_safe

Two fixes address Martin's comments in "new MPTCP subflow subtest" v4.
Patch 2 will conflict with "selftests/bpf: Add bpf_first scheduler & test".

Geliang Tang (2):
  Squash to "selftests/bpf: Add mptcp subflow subtest"
  selftests/bpf: Add getsockopt to inspect mptcp subflow

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 53 ++++++++++--------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 35 ++++++++++++
 .../selftests/bpf/progs/mptcp_subflow.c       | 55 +++++++++++++++++++
 3 files changed, 119 insertions(+), 24 deletions(-)

-- 
2.43.0

