Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512F154F95
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163211; cv=none; b=EZa+PmByR0ZoMOpfo6kQR5+oiSATs6aZTJR/honY6ebqHQIdfq9cbmEzKxMKEESAOCM+JClkCukl96HhZARta+U/CkXW/gXwzh4SIDwb8hYJcWiFAsXv2mojRD6oAtB9N25zHFxeoPkhs5LAW/xLX5XkqYPrX9dBo+DnDP2jSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163211; c=relaxed/simple;
	bh=o6LlgxvdIEwLce8tmc9hgvLbwZq89r/BeJFILy0OplY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MRBaahZFxLPXGn627VgIXAFp9BfANm1j/8hrLfOKEEklA9ETFn6iABQGnzdVC4OAxzVOQP2nxmVUiBR/MoDeFn3p/0aE1oODissC7ii9XYZ1u28B74T3RAnKOK8awg5zvx/I/EUOgKyE+aK+UiEqE3/hgIgVekIPT/y/dA4gK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L01a8f0O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L01a8f0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A469FC4AF0D;
	Tue, 16 Jul 2024 20:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721163211;
	bh=o6LlgxvdIEwLce8tmc9hgvLbwZq89r/BeJFILy0OplY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L01a8f0O0noAbqWTOC/DiViGdu1crgsbZydNuWrV7x1ZPUlTprBWRVR4bZunOe+mT
	 oW7LkAYBcjx/iDBSR80GiYYaM3ID5Cffw/XJ6ayk/KaQv8whXl2ifGf/IUVO9iLPaN
	 JvOzTNWVDEMbZjUNASNVf1HFX7SR29ZaOcV87s1Yp8Wvx0qrIK9tWIlxymgPSHbD6t
	 hIRWl5HknKsZ4LNrTkAyPKmxFWif87CONimQeAKjVq42vgm+0Q9YuouGKoX8jj5ydf
	 sPIiDNqo+54wzsY6/DvK7iufqsh7rlhTCKsH0VtkOJiYx7GvtteEdEwU0V/YypjHlM
	 sEq9Jizr3f3AQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 16 Jul 2024 22:53:20 +0200
Subject: [PATCH mptcp-net v2 8/9] Squash to "selftests/bpf: Add bpf_bkup
 scheduler & test"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-mptcp-backup-mpj-v2-8-4d50247405fb@kernel.org>
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
In-Reply-To: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=973; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=o6LlgxvdIEwLce8tmc9hgvLbwZq89r/BeJFILy0OplY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlt3BUS6puVxNHHc4vdlsizNScgtQLNIB+cETv
 U2kTSkwLpKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpbdwQAKCRD2t4JPQmmg
 cyN+EACa49qIxYVm3t+5jxhWLuO6Ulef/h3rqKAay6xukdAA6oelTPGHQFWcu9qieClfbaQ/Z8h
 u3x9fYX0t3fcKtjvMUzrkdMIaWuMg5RzCAHzqviUB2VlBJoh4fOQZeN59Nb2WwqSk9aIAmqIfBg
 Ki4h6nlo/ZERMqLoTxcgf4eNvBPBWR60/4BmJM0uuWnjMM256tB7JZOZELkvh5xjMsL45HTdP8I
 3PyMnqNQF7jqF7YgriI+lj0o/FW6Nw8aGxki9SMZCfDo7SZZmSGF+1w+p1mlQcaRxalVREDSanT
 yxGTIv9pVsvv2GTUpHgQIW6JZIJn5KlAJtjJJU7opSCvJcpp7UcV4yJxy4cK9l3TsVVnlyUbnkz
 dkE3ec4yusWYiKTdNYwyV2mF+stVV88lerxTYQhLRATHaO4ZYtDdfMDrQ2x3aBHA9TNTDRYSZZQ
 jW9/tDIi/nYDVqYKdkl0yFct3r5dA/B9hmUsnmVh3yQZkKIOxsv9/RTyg/ZGMXzYf4NZBcy0RZD
 Y/EjuETTtXURmL3N9BD8sNMy+M2urFBTHd/Kv2r38pq3PHY9qkptbjAHfwPGXEVhBXbJk1Zs4Sl
 eELhV6PULccxcNZzhlmLDpOg10Qil4Wq/Em8AtClOWy6fqw2DTi99yMWcplsB6yrwvybz61FHev
 XGoJ0G81ikGBS9Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to "mptcp: sched: check both directions for backup": it didn't
matter before because the two flags were very likely set by accident.
But that's no longer the case now.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 14091bcc4cde..296f0318d843 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -29,7 +29,8 @@ int BPF_PROG(bpf_bkup_get_subflow, struct mptcp_sock *msk,
 		if (!subflow)
 			break;
 
-		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup)) {
+		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup) ||
+		    !BPF_CORE_READ_BITFIELD_PROBED(subflow, request_bkup)) {
 			nr = i;
 			break;
 		}

-- 
2.45.2

