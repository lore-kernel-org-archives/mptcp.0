Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36989433D0
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401739; cv=none; b=Si2ny5TyujlGzcvXLlTXfjLfd2pF3pnbt0p7IVI4rTscKWpt3o88lmZ4v4AxWvxIIfi3XvsdzK2vRp/7l5Dt4jtAr24s94kq5iKay6RsT9Vh8q6+Mw4SuO6omfTHDd/BGa2MsE42u+GjPHoNKyjIVhXIxW4nsHNi3RGfEBf0mhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401739; c=relaxed/simple;
	bh=w9np0LF+pWWBLKL8IX6dWzwtjTlJSKUSQjRJdqQ7ojo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E2HS7qrjZ8eBV36wYoXm8NyBXaAapQbBfGttym9Gd8lbQrNlPo93Y+vtOAxRFTfR6RNpKk7OvNQ3iQ8THfwh/B3bg4+Od0nK6pBQsoaDWb72UA/qVK5z2lSrHAPBSKU6nIoxbz4HNl29++/veM+bXaSXAdKT/z2XAbcqHbzuucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktpKrdpO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktpKrdpO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1AEC4CED3;
	Tue,  8 Oct 2024 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728401738;
	bh=w9np0LF+pWWBLKL8IX6dWzwtjTlJSKUSQjRJdqQ7ojo=;
	h=From:Subject:Date:To:Cc:From;
	b=ktpKrdpOzG8oiekq6CW3+Ddnx1l0ZFi0fHYhM/ec5Ew4ypuRA2OtbzkwIqvi9GpeM
	 cstp8tVZVNpSl21fbC5g0bUnS+s7+eoZXF4+nFiBv2IscLDCvcu5tGHRy5RKKUpGNO
	 Yi0TlwZiq7+gH+18CFeIs4vzBiokcAvyR+vDA3u+HGJtCkt//8jVYT0UOQyJmdcF0r
	 XfTymwMBcS3qzNa2X6msknPxqeK/1+Bu+N9XQUBVQPuqUVyPxoBVyX9UaDa0Wwp5+d
	 dB97SdkfsygDUYKfkoShsbTMVKnzrZid48pBwvSHUrjrYnVFhZxsSpxgeOqrHF3qDu
	 Fh3FYghN3uyuQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v3 0/2] mptcp: prevent MPC handshake on
 port-based signal endpoints
Date: Tue, 08 Oct 2024 17:35:22 +0200
Message-Id: <20241008-mpc-hs-port-v3-0-cec1363f0353@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADpRBWcC/22PS27DIBiErxKxLog3uKvco8qCx28btQYEyGoV+
 e5xvO5yNJpvZp6oQ0vQ0eftiRrsqaeSTyE+biisLi+AUzw14pRLRqnBWw147biWNjATTgcdGPP
 CojNRG8zp96J9oa2OUHGGgR6nNbey4bE2cBfOChEcqMlyF1RUXnChrVRBRy8FU6CFnJWhijDDz
 WSk5ZosaZDqPOR0bxBXN0go27t2TX2U9nd92PlV/u/cnWOKaZjAWG58pPP9G1qGH1Lagh7Hcbw
 AePA0yg4BAAA=
X-Change-ID: 20241007-mpc-hs-port-13a6c6c11b38
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Cong Wang <cong.wang@bytedance.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2324; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=w9np0LF+pWWBLKL8IX6dWzwtjTlJSKUSQjRJdqQ7ojo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnBVFJRbwdENfB/2NLV3npp16sPQ4G4IcHSMUpg
 TKIhzXwTmqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZwVRSQAKCRD2t4JPQmmg
 c1SwD/4sbhcaGnCID51I6k9Bj+4o9ZMSnO0XppJtogR3Wg5zJcAQFASjsoo56GuEmRZ5M/29VDt
 fSba8tFSBjQTuuuWkuznkGC9yB9SaBissmunevIyzvBPsACrIhiGq1tiECma3lJCIcGw10x6V3c
 6fkIMxG4DmkqhdwqeY7lNKk9+1k8fiSjIu7VLDM8T9K2xFZANjL6zTdmh0XihcNnUdldH8Hg0Z1
 d90t7IRdDMiY5Zb6y//+vsg2fNDOK85tVHsNbNNsrc2VKBh34Ro30E8j/Iy6wbESLw9XjLE0Gdu
 h6mp2ZHmXB/oSXVC/t4HLBNqG273VkVKBroe7Yk09bSvnrue4SVz9GFG+RXeFVdwz7uA0TgeSyP
 VM4kVBT9r2bPrCpMDJM0jfd9uYXbVDoaxTzgoqNA9Ty5yNWhX5jYkf3oNPCXB6dyJwPbPOUXJLm
 bjmOT7ACg60Rtjprh0adSW2bwdmDd+qdF9Qs49xo12IxaEd+fubyDLe0MnqoA72xPN/DZoqZLWt
 X8vaJAMm5c0Pj1P6oxQo2ZqvHLNl7Vu4hgt66Ax9yxY3QHLBDDbTYpcwNTS0WIzfkIl9b3Gs3Tc
 8A773CyC5qEbX5jBYxaTFUESflqTrae09JDHulL8QDz48aHK4hE9TEE4M6R1hAIHeg7zfFpD06Z
 TVAb6BJP99Bm2dg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is a new version for the series sent by Paolo, related to the
lockdep splat Syzbot reported a few weeks ago, and for which Cong Wang
sent a different attempt (Thanks both!).

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- patch 1: reduce comments to fit under 80 chars
- patch 2:
  - Add Fixes tag + comment about it
  - Add my Co-dev tag instead of RvB
  - Add a note about the new helpers in the commit message
  - move cappid declaration under capout
  - move 'cat $capout' to cond_stop_capture
  - move 'local port' declaration above to keep the reversed Xmas tree
  - use 'retl' var instead of 'ret' to avoid a clash with the one used
    in fail_test(), which would not have marked the whole selftest as
    failed in case of problem only with this test.
- Link to v2: https://lore.kernel.org/r/20241007-mpc-hs-port-v2-0-0c9e7827bd0f@kernel.org

Changes in v2:
- patch 1:
  - moving and renaming the MIB counters
  - move comments/functions on one line when possbile
  - rename subflow_reset_req -> _endp
  - use MPTCP_RST_EPROHIBIT reason
- patch 2:
  - fix shellcheck issues
  - capture: handle $capout
  - fix indentation issue
  - helper for the port
  - stop the capture after transfer like before
  - move new test to 'add addr ports' ones
  - move the validation part to a new helper
  - add missing 'check' names (subtitles)
  - skip if no counters
- Link to v1: https://lore.kernel.org/r/833cae5982ac5d5b3236845c6db4315e634f5705.1727974826.git.pabeni@redhat.com

---
Paolo Abeni (2):
      mptcp: prevent MPC handshake on port-based signal endpoints
      selftests: mptcp: join: add test-case for MPC attempt towards signl ep

 net/mptcp/mib.c                                 |   1 +
 net/mptcp/mib.h                                 |   1 +
 net/mptcp/pm_netlink.c                          |   1 +
 net/mptcp/protocol.h                            |   1 +
 net/mptcp/subflow.c                             |  11 +++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 117 +++++++++++++++++-------
 6 files changed, 101 insertions(+), 31 deletions(-)
---
base-commit: 2ce52e0f26d35f97f56615bb7854afa633f5d231
change-id: 20241007-mpc-hs-port-13a6c6c11b38

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

