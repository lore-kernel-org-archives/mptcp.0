Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1766AB9
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 01:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119964; cv=none; b=BintAcRG7kf2YFtcj0eRANLo1Sfx9Xm/+BfkXIKR9qBsRT0JcwgeUw79/rvd6U9ZxOXEIrsTUCTbeMHqZX4HD1j/sie6S89JVAvU75fDTOQ9hqAuzMHbSmhRdmJl6SgHFrUZk0iAkij7avkEjCF+LlYwTgr9a6K34210XKxO+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119964; c=relaxed/simple;
	bh=UWkvG1+joDSXSluMWCnpeSNCa6GhIQCT1d/abUrDsbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXwIFjaljUs0zqI2+L6cZgK+xErZsGXTJYzG3IjrmN2ZjAdlGH6yw7ffkAH3W/p0+E+14+Ho3+l0Td8qhnnPqdPQOm0ySNQy4+kqmYRSckm/bi0sFQ4ckryumToj9RpYgh5u3w3QllZXiD11atVt8Dluciblo+P9VteZH5knZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdn0G5tM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdn0G5tM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74987C2BBFC;
	Fri, 31 May 2024 01:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717119964;
	bh=UWkvG1+joDSXSluMWCnpeSNCa6GhIQCT1d/abUrDsbY=;
	h=From:To:Cc:Subject:Date:From;
	b=jdn0G5tMSiDisUlA1USr1JpC0VnAuA5A8S/xkV/kQ3yud39Ic1yj6qvbs7Oda58/Z
	 nP/PTzfz/0+sycC20jV+UCHeTJ6M6FbTAmxUXiwN3xK1EUstKT2sDLTksumamxmeTu
	 DZwsyxVd0DnoJwxWXHykmq2lhSmRCN3YngCvA2/11C2xg0shS1Ln/Gqfm4kbBO/lpQ
	 Pv/QhjFEn8SlG78NU6quosjJgEm3ANrnsDraZBi7pGe0Kg2S6y7ZORT5ggmSQ7WkXv
	 C9GFbBwkqlscQbSTPNNjDkIb2i15L323WBSVBVBpDSnCL0LrINefwShHxHPL0IFE1x
	 rDb9A6+2ezXVw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next] mailmap: map Geliang's new email address
Date: Fri, 31 May 2024 09:45:56 +0800
Message-ID: <58464660b9d2f74d45c0c91663fd71132749db90.1717119915.git.geliang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just like my other email addresses, map my new one to kernel.org
account too.

My new email address uses "last name, first name" format, which is
different from my other email addresses. This mailmap is also used
to indicate that it is actually the same person.

Suggested-by: Mat Martineau <martineau@kernel.org>
Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 Sorry for sending this patch too late.
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index df56e43cb57f..6edbe3bae905 100644
--- a/.mailmap
+++ b/.mailmap
@@ -217,6 +217,7 @@ Geliang Tang <geliang@kernel.org> <geliang.tang@suse.com>
 Geliang Tang <geliang@kernel.org> <geliangtang@xiaomi.com>
 Geliang Tang <geliang@kernel.org> <geliangtang@gmail.com>
 Geliang Tang <geliang@kernel.org> <geliangtang@163.com>
+Geliang Tang <geliang@kernel.org> <tanggeliang@kylinos.cn>
 Georgi Djakov <djakov@kernel.org> <georgi.djakov@linaro.org>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@de.ibm.com>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <gerald.schaefer@de.ibm.com>
-- 
2.43.0

