Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DA62DFF0D
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756777209; cv=none; b=IsnB2KmMV+OuVQZKjHFhxNlG+TxEPpVEzdJfWtafO3g/G1M1yQpHPt9NkkWtsdiNGMZSt4d3Qt+zYn2gc7M190t0qvoU9Saym6lnGIh3CQc3X0SYiCg/AkOtaIxErvfvXO3qNnuWR+HWlxt5NhbFaWjr6Xp+AKAE2LHI1aMtCbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756777209; c=relaxed/simple;
	bh=xP4r6VvVsFZHEFnAO2nmKmyrlx8/wYN3glKFZ3Kpl5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1Vw9z+abBmsDMEy3LJSl5eonuH2afJ6etRXZ64ar42aUZlGtAPcavzBmEBROeyf/gX9rXMH5MadsTJRkPqplM7PLGHP8Q6mRzjv5tapDc0uJa2djzqFrKxvWvWCLRrRB/2hLIxTThWQRnxdyp45feJpAFyqIIG5uRG1JcP/mCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5kJgXdo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5kJgXdo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9828BC4CEFC;
	Tue,  2 Sep 2025 01:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756777208;
	bh=xP4r6VvVsFZHEFnAO2nmKmyrlx8/wYN3glKFZ3Kpl5Q=;
	h=From:To:Cc:Subject:Date:From;
	b=n5kJgXdokrpxGs7a0cWqpU2uQ4uBiOqJzljZXz2rG+XXywFjFFOIu7X0zG+MUZp1Z
	 2JvQt59qOYNRAq710IuIVmo9yTLBnx9rMmHNWEeFZywyIa9z3Zbti1Aj8jECZfa3wu
	 DmnsnEdEXRpkfnDWi6s4BW+c8TY20MIXMCr1NYvW4U23tlY3EYkl68A/E0BHeWDw0N
	 PC7AW71ORxZXwC0qffVXX8zyfDYJFKdBwAKw4oc4ianC15zMx/J9Ks+B3eIKAL+r16
	 otfYjzo2PW/kZ2Gi/eaKw/CSoGEa/iYof8KHamgg/IwQolgR45V01fPNQTazRAOmMf
	 IhxhlnF0jmxAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 0/3] misc fixes for sockopt selftests
Date: Tue,  2 Sep 2025 09:38:33 +0800
Message-ID: <cover.1756776801.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch series addresses several resource management issues in the MPTCP
sockopt selftests:

Patch 1 fixes a resource leak by ensuring the server's listening socket
is properly closed after processing clients, rather than leaving it open.

Patch 2 eliminates double-closing of pipe descriptors by removing redundant
close operations in functions where these descriptors are already managed
by the main function.

Patch 3 corrects an error reporting issue where the wrong variable was
being checked in debug output, ensuring accurate debugging information
when assertions fail.

These changes improve the robustness and correctness of the MPTCP selftests
by ensuring proper resource cleanup and accurate error reporting.

Geliang Tang (3):
  selftests: mptcp: close server file descriptor
  selftests: mptcp: avoid double closing pipe descriptor
  selftests: mptcp: sockopt: fix variable check in error reporting

 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 3 +--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.48.1

