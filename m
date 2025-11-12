Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F21F2380
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940778; cv=none; b=s1GCS3fOMtfcEnCDHChQniEpL69M2H9dTSOXGn9rWdQlgfcq3Y9xtiOhIP6+OXOVUnWRKKI7skbvIcNBIz0ASKdqvMuyG8On5UnZnMpqCF47VSDMtvm5hm306jhjrtSXOKOzmgH1lGioBt4R64bgsGO1EMSWQeZMk1UO1v8KrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940778; c=relaxed/simple;
	bh=r6T/xxT44nqMfExUlp2nq5fyBoId5nBWW9WT3xFh7pM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rb85rCZwVJ5IyWp2UxbD3AZcQJe4Su+f9zgJVuykFnmolCaz4RI4NYwJZ26Rus/8JI2Y7zELP16Nleh/qWOUCGCmZ+rwqq2xJP4VXuKHaLeUKlTg+jjnGhZaKoDIle/gBE9s3OHgPSYkyeNkY1GbMFfXOh4ssTW1b5Ec8heXi1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSbSaGVB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSbSaGVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CDAC4CEF8;
	Wed, 12 Nov 2025 09:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762940777;
	bh=r6T/xxT44nqMfExUlp2nq5fyBoId5nBWW9WT3xFh7pM=;
	h=From:Subject:Date:To:Cc:From;
	b=JSbSaGVBFocqut3L2XvJkgpt3rZ46FY4QOAgYNSvUw+5MBoUaTP6i+PmVftj3KIHY
	 YJWUbY+g0r9DPHsfyRI8tQbD3oIWm7roisK9JwuPoeAUfzVUdmgNRcqe4TYmXQQT+r
	 QoqfDVqSm0irJKo/o3X4JprTZgbCwvQ/fGoPIELFlXmzDXMC2BxgmGCgATBDsqZlTM
	 CD8NB5kYgzt9p0wyFP4cwtO08JDTcwXnC1+p//DcPpbIE28ESBcepJxsCZ8/czKmDA
	 pk6hmLjftOeMPyROR65JiLYKeL2SEBrquHCmIGLCm+/5ewE9NQmrgDE9jQmWIVy8Xh
	 8DC4hzhy82kXw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] selftests: mptcp: join: longer timeout
Date: Wed, 12 Nov 2025 10:45:47 +0100
Message-Id: <20251112-slft-longer-timeout-v1-0-97aab145a062@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEtXFGkC/x2MQQqAIBAAvxJ7biEtofpKdJDaaqFUdIsg+nvSc
 RhmHkgUmRL0xQORLk7sXQZVFjBt1q2EPGcGXWmjlNKY9kVw99lEFD7In4LGNi21prFdXUMuQ6S
 F7/86wBFkCuhIYHzfD9tk83JwAAAA
X-Change-ID: 20251112-slft-longer-timeout-5a48e854a933
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=r6T/xxT44nqMfExUlp2nq5fyBoId5nBWW9WT3xFh7pM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJFwlODqx8XZh+xaZ7xWMzkIocX88tySQb+l8VP+Y5u/
 PjhyL+ujlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImYRDP8lTvo5LEx/cPD57w5
 i86tCV6fZdhm0L3G+XBs0qIwvhmP/jIyXOd0ixINYzB6r7H20Tu5XlEXYe7rvbfCcmdfslp9ulu
 NGQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A previous attempt was helping, but not enough as the background
connections were still stopped after the timeout. That's what the MPTCP
CI recently reported with the "delete and re-add" subtest taking a bit
more than one minute in a debug environment.

To play it safe, and because increasing the timeout for the background
connections doesn't change anything to the end result (the transfer is
not checked in this case), all subtests with a background connection not
waiting for it to end now have a longer timeout.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      selftests: mptcp: join: endpoints: longer timeout
      selftests: mptcp: join: userspace: longer timeout

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)
---
base-commit: 83290f9ea1dc9994e0064956147443b2fc290dca
change-id: 20251112-slft-longer-timeout-5a48e854a933

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

