Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3A353A85
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616980; cv=none; b=bhm+MZQtMGCTnvsG6dCBA83xCsdOWlbm4Zo2fqbwgvKKS61AfSIyAUbevVW1OTRBlqU73TPSk8jVMxaUOg4KCEHFokTnm+YKpGqNVV28sZTklWF8f8SAHftXTHuHOjzsOOyXbqe2Q4uDLVCB4u9YSgwEQVOSQ3yXcu1PiYy/X9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616980; c=relaxed/simple;
	bh=51g7PkB0e7AqzWRj8dUBzWnWKHRsLfgV6MAquVa/GZc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mmCMBP4u6uB2KwiOr9jCEO6KPX2P1NqW90iypVgicw9JDrqdAjO/eVuqDLsABuaytSCyjjifhRWCtsCCDR1qJajDrNSEneguCSKd7iYzcB0jvlA6/2SmXjJ+DQeEzPXuli8nf1bUO5jVVVKiXhpJdH5Gosw90N986vYe38xemWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xmt8rMJj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xmt8rMJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A921F000E9;
	Thu, 13 Aug 2026 10:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786616979;
	bh=dt4uyu+JH4RuHqtUTmjBR5x7OiRFaaxIHo9UsH5tCbo=;
	h=From:Subject:Date:To:Cc;
	b=Xmt8rMJjPzR5F6oQWHUbe1B6VdHsWUYQfC6nrTFQyov/L3WgzZ818DHKh7uo/s1YR
	 ecCdJo4jR7DmW9HWbfIFJxdEdWtHJ2dgkid0UaWdzl1YBoRqD0UzzSg769fNyjXsL2
	 MVJBx2vRxukWlFgl1UBabb6eWvozsghtbEySSWYE83n75ozgSvkEoyDap3sVrmSLSo
	 keSrYcQmewF/TIfjgiUlPYTzZGZgnqEhGKaHsHjx1KIOQrF4X1OsY336ZKsOLmnTeW
	 qqsBGULs7BwPDPnoQrH8U+ZdsYBmSot/5mZ+EXlYuA1kUMDRAbAWqou8dgvjbj0RtH
	 XNygfefjkY0BA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] selftests: mptcp: lib: get MIB counters for
 the right test
Date: Thu, 13 Aug 2026 12:29:31 +0200
Message-Id: <20260813-sft-mptcp-nstat-hist-v1-0-5bb96bae7ef6@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2MywrCMBBFf6XctQNJU7T4K+KixokdwRgyowil/
 258LA/3nrNAuQor9t2Cyk9RuecGftMhzlO+MMm5MXrXb93oA2kyuhWLhbLaZDSLGoUweL9z4xB
 cQlNL5SSvb/aA/5sNx9+kj9OVo32yWNc36+MRDIMAAAA=
X-Change-ID: 20260813-sft-mptcp-nstat-hist-33411708430f
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=51g7PkB0e7AqzWRj8dUBzWnWKHRsLfgV6MAquVa/GZc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJq5/QbWu4qel71Rp633CPHd6f+qenL+w7Kv9aOurblj
 u2tmKCNHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNJ/8XI8FndIFl6UsMyXrtJ
 KYV/ird5H1tae+zo/El/BAIm/m5PPMbwT+l2yoRT5b1db/9tex18Nkf/QG+B7Mety/vaA/tO2+z
 NYAYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In case of errors, mptcp_lib_pr_nstat is called to dump the nstat
counters, but for some tests, it was dumping the counters for all
subtests, not just the current one.

That's an issue for tests that don't recreate the netns for each
subtest, e.g. mptcp_connect.sh. In this case, 'nstat -a' will look at
the absolute counters since the creation of the netns, making
debugging harder.

Instead, it should dump the counters for the current test, by using the
history recorded in /tmp/<ns>.nstat, if available, and not using '-a'
which was dumping the absolute values instead of calculating increments.

While at it, rename the previous 'hist' variable to 'cache' as it was
used to look at the cache, not the nstat history.

Do the same in mptcp_lib_get_counter, even if it wasn't an issue for
the moment. Still, good to fix it for future usage, and to align it
with the rest.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      selftests: mptcp: lib: dump nstat for the right test
      selftests: mptcp: lib: get counters for the right test

 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)
---
base-commit: ab76ed72e0bed8352d3b8e2b4d1be7c823e5fba3
change-id: 20260813-sft-mptcp-nstat-hist-33411708430f

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

