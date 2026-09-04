Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755883B19B6
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512932; cv=none; b=HjemDgElG1aqcswNcdtZj3HBROU/o9V3MBjkly34U2D5VXVr8yU8lpAeW6Tfn8CTm3f2z5cXN0doyo+ij45ZJ/E/oSIP0MDjcX8bhMEEkDLxE5I+ZAO2X3oEC0PHmSS6ngYeAniVTq4AIZ1hNDua+p+lOIgTIlxUcSHleTVxYVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512932; c=relaxed/simple;
	bh=0HCpcP8svZ/0H247b0Y3hTKwsgK4BT7cy55GIQqZ8s4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n9CTMFk5BGJU6gVSAKu8joWnNXefEqYumHPmzXYVXEgFxIhSjkamJt34f8D3BvXNaXHAQQAAB4KKM+waZV9D57jKDHf26OZjgy79aSbmvLsV079MGxPIKSPxjRPzV9doV7k02MXpFkKglzUbHeuETLNeV342gvRgPlr+FDG2pMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCGkhAGE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCGkhAGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC141F00A3D;
	Fri,  4 Sep 2026 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788512931;
	bh=2/jPrNOWoJstSkMKEQW70C3uAhRCIXPLALDbrKo7Yu0=;
	h=From:Subject:Date:To:Cc;
	b=WCGkhAGErPljpZmsjkUflg8pReALAiDBJiCcIR/nxtTy2LNZ9/WgRvj4mYV+wjdul
	 eD6mMrZJ1qDS2zsuzFxxHZH3CQjk1PQsk7LY8qPKMZ4B4HvicXQSsJDJCCln+Li2fz
	 59N7+ff3TmEUIi84slMcygbm6bYmb+iLapwGTNVSKs3UQf7pRsatu39vvTbgc0L8pn
	 M4KfrpcrttGI4prUNRrCeLG/GQuaJmkMihEvgLI8x+pYtgdV9y8HVV46OOz/1Nsf3T
	 yec8F7Nm1L/gcnBkwMysvgFGNvi6+oOhIPsm4wjMdKoRle+z2dw0UGK+5lVONVoDAh
	 VkGQ9JycO0s1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 0/3] mptcp: options: MIB for invalid & drop
 suboptions
Date: Fri, 04 Sep 2026 11:08:38 +0200
Message-Id: <20260904-mptcp-mib-inval-opt-v2-0-a72003dc4425@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OwRKCIBiEX8X5z9EAhman3qPxgPSnVAIDxNg4v
 nuK1447u9/uzhDQawxwKWbwmHTQ1qyCHwpQgzQ9En1fNXDKK1rzhowuKkdG3RFtknwT6yKRilV
 UUE5ZTWElnceHnnLrDXbA4BSh3b3w6Z6o4la7pQcdovXffCGxzOS1hpZ/1xIjlJxPUohSCcG76
 vpCb/B9tL6HdlmWH2eUdy/VAAAA
X-Change-ID: 20260729-mptcp-mib-inval-opt-ac1605020170
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0HCpcP8svZ/0H247b0Y3hTKwsgK4BT7cy55GIQqZ8s4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJmdc2fc3an6Q3jPUbrkkLPeF3WZ3e+Zv4zvIPlvbxWU
 /9CvpdbOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACayroCRoe3iZH++guC389ft
 5bL6UBq557k8F/vieTGznrXckW+eHs7IcGhqA+vfGzNTPxnVVomXWZdUp6vob9xd9vfg7FP3Iis
 +swEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are a few improvements linked to the parsing of the MPTCP options:

- Patch 1: Move the only non-suboptions from the 'suboptions' field.

- Patch 2: Track invalid suboptions: unexpected suboptions combinations
  or invalid sizes.

- Patch 3: drop any previously parsed suboptions in case of invalidity.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 3: break the while-loop, not the switch-case.
- Link to v1: https://patch.msgid.link/20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org

---
Matthieu Baerts (NGI0) (3):
      mptcp: options: use a dedicated bit for csum reqd
      mptcp: options: track invalid suboptions
      mptcp: options: reset parsing in case of invalidity

 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/options.c  | 92 ++++++++++++++++++++++++++++------------------------
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  8 ++---
 net/mptcp/subflow.c  | 12 +++----
 6 files changed, 61 insertions(+), 55 deletions(-)
---
base-commit: ead8d38ce308bbb7375717d5b791b403ee0c67d5
change-id: 20260729-mptcp-mib-inval-opt-ac1605020170

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

