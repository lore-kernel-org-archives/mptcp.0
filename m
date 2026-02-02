Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22182F2918
	for <mptcp@lists.linux.dev>; Mon,  2 Feb 2026 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059877; cv=none; b=T7fjegiJ2UaJYKWGPZl0JaIwEpPR9pGH/a774Vq9JXQZK6OVJdQhSq1BafRwlahWKTPtjVxZozGHe3VaRieQPLumUIBSQaQd66/V5zwd6TujQYFENHiOlG58aXDeeo2Xs2S8O2MpjXCKWTRus7qHruxOgkmuXwkBQiz2C4Ha8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059877; c=relaxed/simple;
	bh=y2LDQuURlFak38tRnbx8fVSADY6O8okXROW7y46Rmqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SG5fmn9H2CuiNG/orqlaYR+ceDnTPGJJop8MsQO5TKtlZo980HCCQxb2cPc3P6X+CExT0PTzQHUH2bvFlE75x0TZXZyXOEDYkor9V7Kd9WZgrmVlR6b71Tx7SOFfy2TPOD5QkTJtkmK8xqtJgm4GaLmcaFgfrAmFepc1HJ4NuFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAwUjieS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAwUjieS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD57C116C6;
	Mon,  2 Feb 2026 19:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770059877;
	bh=y2LDQuURlFak38tRnbx8fVSADY6O8okXROW7y46Rmqk=;
	h=From:Subject:Date:To:Cc:From;
	b=nAwUjieSohBKGBQ8RYjo0QS03Ye/aDfz6Kcxk01CUHI6v7bEadTJuiBUhLpCVX5h8
	 h8RqjXJyQSv+Vspy/6YqtUADKJyAZL5mq8TaVg7jvO+khQ7KB/gk/x42ag4ihn/UWZ
	 QOJCXU03vraUJA/9RYc2t7hVyl/2uoUYKXgwK6fFje62vtwcmAIoug0kzxtuxWyuoF
	 Fj5Xr6YmuSroN1wU4+Kz17RcBpCw9DlD/TfgfPZ37Jjzrm6Q9WYDNKK32Z1fxGnDbc
	 QhvcoVBqp7irdXWvdg7dTHQffuGc+jTs8JJ1svcJmCK1aeMVGyT/+hyiK+mnPWlJVX
	 xENczWzlWAo6g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/2] mptcp: pm: in-kernel: fix issue 606
Date: Mon, 02 Feb 2026 20:17:36 +0100
Message-Id: <20260202-issue-606-mark-subflow-endp-avail-v2-0-7f9df0ae6157@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFD4gGkC/43NTQqDMBQE4KuUt+4r+UHRrnqP4iLGFw1qDImmL
 eLdG6QH6HKYYb4dIgVLEe6XHQIlG+3ichDXC+hBuZ7QdjmDYKLgggu0MW6EJStxVmHEuLVmWl5
 IrvOokrITaq2lFMKYijHIPz6Qse/TeMLsV+3R0QpNrgYb1yV8Tj3xc/CDij+gxJGhMLyVZaequ
 paPkYKj6baEHprjOL5SC0YX3gAAAA==
X-Change-ID: 20251212-issue-606-mark-subflow-endp-avail-ccc3322ff800
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 syzbot+f56f7d56e2c6e11a01b6@syzkaller.appspotmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=819; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=y2LDQuURlFak38tRnbx8fVSADY6O8okXROW7y46Rmqk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIbfiSHu0opvAu4y3xwwZtPvXnxd078091VLv973e7KX
 e7p9l6dHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOxiGJkuHLW8/fcNby+l633
 cx5xsnzuEmcnv3qHoMdF/1nay2xkvzP8Mw9vNV/c8Crgu4/XqSV3v53eofe+qXb+CVa3aSsXn7A
 P4wYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The first patch fixes it, the other one clarify the code. I think both
can go to -net.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 1: avoid setting the bit twice + comment (Mat)
- Link to v1: https://patch.msgid.link/20251215-issue-606-mark-subflow-endp-avail-v1-0-2f1b36da8993@kernel.org

---
Matthieu Baerts (NGI0) (2):
      mptcp: pm: in-kernel: always set as unavail when removing addr
      mptcp: pm: in-kernel: clarify mptcp_pm_remove_anno_addr()

 net/mptcp/pm_kernel.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)
---
base-commit: 1f27d14ad2803370bd6232df91f864f12f77ead7
change-id: 20251212-issue-606-mark-subflow-endp-avail-ccc3322ff800

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

