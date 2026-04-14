Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF133146D5A
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173659; cv=none; b=UyTs/pyocJZcEqmxf02q/YMPs37p/8OGXjwzK/x1Nl1suG1yjtpvKzL/S/qYDT5ZVQCR6xfJ6Ua5ZJKhuE4N4ZjoPW3cKANb2YszejT7tGgyOZJvvMSO6A1G6uBD6y3EawYonuENpTzJNdHq5woJoIeTJAZ1ITBkp4JA7op+wqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173659; c=relaxed/simple;
	bh=qJYr59Bc8P5gY4hTKhL7j3KTnZNz1z//RT7gpc1DOJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/jM+O81MY+xq9Uqw1cxPuFqoGye8oQkYH6/hFZc0is3tuWeDjqaes0CZc9LPGcuoP5kJpRsUIAE//+mvPGofIx6shzNeT4FRH5p4RBVcT3IV2C7h1epR/CszkI4dBMhg1haDDapgB2aXLX/nf/mDizjs9GSDtUT/rDkqr2fguI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuIUMdpL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuIUMdpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C07C2BCB0;
	Tue, 14 Apr 2026 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173658;
	bh=qJYr59Bc8P5gY4hTKhL7j3KTnZNz1z//RT7gpc1DOJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KuIUMdpLRaHr2Z0Dt0/STwzVJlLW/f4EPglVWeTLxFkEErrb6KAdm2BGHPD7xy44A
	 xvFR8P4kKrmCsq6wXnnkjsVIq0BlLixxyPXOO1kVaqMwLW29TYUxL6IJehtCPQSP2u
	 /9CIG5KS2+djAxXMQ54DBMAiuE9R8cUK4oZemHHTWdIqUcSzyNuTfP77g16g84KAoP
	 oP1LDPJ4j+2WStqnQMsk3SaSz1FuXyGSqZRFmwbPtqvTn3D0ezfFKXW5gFrYSuN14a
	 rh0FvTUEZHb9fBoIhd4CsnHi97X5BQLRpoag57q5dn6jrvMW4RgUwX0smyK3x7mAOn
	 yPeqaveWVwyhA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:34:02 +0200
Subject: [PATCH mptcp-net v4 09/20] mptcp: pm: prio: skip closed subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-9-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qJYr59Bc8P5gY4hTKhL7j3KTnZNz1z//RT7gpc1DOJ0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOfm2y6x8sGrfyYu/p7cyhM1+qnpmztonniZiWu87l
 Odls05q6ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIqi3DP21f2/+f+7/vPDj5
 9dFPzpYX8pOnJQkyVV2on1QvWJpU38fwT+vr3YKqgykVzROm87RfVZV5e6423mPx6wbPN5NzQ/W
 ecQIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When sending an MP_PRIO, closed subflows needs to be skipped.

This fixes the case where the initial subflow got closed, re-opened
later, then an MP_PRIO is needed for the same local address.

Note that explicit MP_PRIO cannot be sent during the 3WHS, so it is fine
to use __mptcp_subflow_active().

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f32015d4fb87..236a8087da29 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -284,6 +284,9 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_addr_info local, remote;
 
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
 		mptcp_local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;

-- 
2.53.0

