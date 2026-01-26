Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED4027877D
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455489; cv=none; b=kB72Tvu0t0jqKoeVeviGPUiLWuozdMPoQskVsNtsHp2tkRRrOTh3KNmYrkXqURhRMtCSnrguDfC/7OdRfa/zfdf2ih+ODRcnzRhAGUnToBVtfL2um+ugZFPryz8ixKFXGjoeWkWHckMQsrsNDBVEGUKI+hpw5TWbmBaSSuPwssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455489; c=relaxed/simple;
	bh=u9yx4toBWvKhmHguhHkUl3AV9V01qg05Hme0Xa2Pdng=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aqC7lNse0Zh159kqMgdgFpTciA0l25OuQpm2Wrtdt+ujARzzpzyngIyC7aGM3d+nTTrh5TB/o7tXnWWaxnC1I+jIjOX3snQVla7fexqeSwUyfg46HDuzlQAdRzkc1NTObquve9RQuajigks0sOzO5jMYzf7lNdQL54G7GzOw6u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfmD+dPU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfmD+dPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0097C116C6;
	Mon, 26 Jan 2026 19:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455488;
	bh=u9yx4toBWvKhmHguhHkUl3AV9V01qg05Hme0Xa2Pdng=;
	h=From:Subject:Date:To:Cc:From;
	b=XfmD+dPUkSeK19MZ2gK+6FEr6GuTX/aEhJgWUTeIH621DHaR9M0kRB6qxd8qOIhdI
	 /RwaN4VpXznuCsLLwSiJGgjskG4wu7q9Egjfk7biKkMMs8R79e3xfKNVM48B9HFcLm
	 BsvhpRmE7Awd0f238B5w6VYFoXiPQpBMCT04FDgY70p4b5N6uyGMpMA++JJngtotvB
	 4owuQj7UVVW2ENKpEr2aTasOtXgAHpBBTCmw6mxipPq3PKZwZZJd5/6eeFCq4iesKi
	 4p3Yl4SvCN3bJFSFos7tVmuP46LzQqPChysQeUD2uQHIItNsbCnjqyPGicxlZCsYXp
	 bLnLIlBazE9rw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 00/11] mptcp: avoid dup events + error + misc.
Date: Mon, 26 Jan 2026 20:18:37 +0100
Message-Id: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA2+d2kC/2WNSQ7CMBAEvxLNmUFelI1T/oFyyDJJRoBj2SECR
 f47luHGsdXV1Qd4ckweLtkBjnb2vJoY1CmDYenMTMhjzKCEyqVSCh92Gyyy90/CQmgcq3ysi3I
 qB9FBXFlHE7+S8Qpf2NAGbawW9tvq3ulrlwn4aYs/7S5RYN9rQVrLvtJ1cyNn6H5e3QxtCOEDn
 yKVG7oAAAA=
X-Change-ID: 20251222-mptcp-issue-603-d85d967f7c0a
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Marco Angaroni <marco.angaroni@italtel.com>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=u9yx4toBWvKhmHguhHkUl3AV9V01qg05Hme0Xa2Pdng=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLL91eULt/CdGfxBCGji5dNTnxQ+P9QUt7R6XylUEUN/
 2mpu0fPdpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzk2HZGhj9CB/8wvDtoc7U3
 0uYR79e5z14WvNX8/Orf4sxEy22xC/cwMhy5oROR9UKz6a/DX539zvmqElybuiUUla+vvvhJR/7
 SDR4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

There are two fixes with their tests:

- a subflow closed event can be visible multiple times, see issue #603

- the subflow closed event didn't contain the error as expected.

The 4 first patches are for -net, the rest are small fixes and
improvements for net-next. Some tests should be quicker now.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Small updates on patches 1, 2, 3 and 5 (Geliang)
- Add Geliang RvB tags.
- Link to v1: https://patch.msgid.link/20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org

---
Matthieu Baerts (NGI0) (11):
      mptcp: avoid dup SUB_CLOSED events after disconnect
      selftests: mptcp: check no dup close events after error
      mptcp: only reset subflow errors when propagated
      selftests: mptcp: check subflow errors in close events
      selftests: mptcp: join: wait for estab event instead of MPJ
      selftests: mptcp: join: fix wait_mpj helper
      selftests: mptcp: join: userspace: wait for new events
      selftests: mptcp: join chk_stale_nr: avoid dup stats
      selftests: mptcp: join: avoid declaring i if not used
      selftests: mptcp: connect: fix maybe-uninitialize warn
      selftests: mptcp: connect cleanup TFO setup

 net/mptcp/protocol.c                              |  13 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.c |  19 ++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 149 +++++++++++++++-------
 3 files changed, 121 insertions(+), 60 deletions(-)
---
base-commit: b8bb952910af48167681524c5b217996c16382c1
change-id: 20251222-mptcp-issue-603-d85d967f7c0a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

