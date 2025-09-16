Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C2E1A9FB0
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020509; cv=none; b=j682R/B97Kdu9qorixoJva2c9FbqoztHQguTX1nQ3uGbcZGi1lPLiEPOCvMqxhpaEI/mBjxy9ALymGipapiiEE+QvXHgRPNO0QDkndYAuEwo+r6UcGQqWGZeoMaBAIizR74feNp0Icyt4yBcwys/UUUmALr4qrlC3C3hTawukkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020509; c=relaxed/simple;
	bh=cKXWThk54yuvm1zOOc6x2A2oTMOf7lTBMPj6JJ2wcIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FXoxaIrI0A56gh36YgsrsIciAtt1/7imOE5A4BPi5EcwS5jSnaXNRyZkyA2xCTwtNS+YXiTvplwfbpYZS9BYxQd1DvTlfnKVWOtS4HBL2jxzy7kAfm6SX9sSVcvT4LH7SW3wRKAslOdfOHyooyMFHJis0QZ4l/uj14nQvnWimKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1GAvrpw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1GAvrpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9ECC4CEEB;
	Tue, 16 Sep 2025 11:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758020508;
	bh=cKXWThk54yuvm1zOOc6x2A2oTMOf7lTBMPj6JJ2wcIA=;
	h=From:Subject:Date:To:Cc:From;
	b=e1GAvrpwozv2+9ghG8ZuS5nPeSroF89xyfqmkhxoNdywf8zneuZ5j19zxUfC4uZ7n
	 R1Q/+CrTPNQZet6nlQzuvz5mKY7r7yMpYJ39m6PTY+fTrbTsC8UClBViO6/3ixNnBY
	 OGVkCvm0M3usbsubkSIDnwcbbZLVe3LgxVVPQUVgzw4IJEnPSLU/3X6tojMc6+IZDl
	 UkVK+6KC7jIBQd98NhtsT8wyvNGt9XSCCIOMVcysp4D8pJTxzj0XFhVtzXAdOwX2yx
	 3ZUkuECEtg/3IgLY/6RgoQ2kCmx+baBDfr7z6AB1kLc5jBKAjru0WwrhpzmWKMBcxz
	 uHI0TaNUW2IiA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/2] mptcp: pm: in-kernel: usable client side
 with C-flag
Date: Tue, 16 Sep 2025 13:01:38 +0200
Message-Id: <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJJDyWgC/3WNyw6DIBREf8XcdW8jxEftyv9oXCBclBSRADVtj
 P9eYrrt8mRmzuwQKRiKcC92CLSZaFaXgV8KkLNwE6FRmYGXvC47xtEvKFFbMaG0hlxCRVq8bEL
 dtI26CamVbCHPfSBt3qf6AYtP0qOjBEOOZhPTGj7n6cbOws9f//dvDEtsxpFXjCrVdax/UnBkr
 2uYYDiO4wu4/3JqzAAAAA==
X-Change-ID: 20250912-pm-c-flag-client-default-f676d8acfdc7
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cKXWThk54yuvm1zOOc6x2A2oTMOf7lTBMPj6JJ2wcIA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJOOs9w9354ruV8saHt6Smzy6Myoi9uP6T7ZJbC2Uirq
 1+ezY+P6ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiIrSEjw5Z5p2W0PRLKtNZl
 S/AxPGP/u6dk3uTiWOvNYomz3n3emsjw37/2MxdjwK2ZjywNGyJfzPnCcauI/YiboC7/mbf/HVZ
 cYgIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When servers set the C-flag in their MP_CAPABLE to tell clients not to
create subflows to the initial address and port, clients will likely not
use their other endpoints. That's because the in-kernel path-manager
uses the 'subflow' endpoints to create subflows only to the initial
address and port.

The first patch fixes that, and the second one validates it.

More details: https://github.com/multipath-tcp/mptcp_net-next/issues/536

Please see the comment in the first patch, and don't hesitate to reply :)

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- patch 1: move cond to new helper (Geliang) + rename var, squash comm.
- patch 2: move accidental .c modif to the parent commit (Geliang)
- Link to v1: https://lore.kernel.org/r/20250915-pm-c-flag-client-default-v1-0-6bb241e4d991@kernel.org

---
Matthieu Baerts (NGI0) (2):
      mptcp: pm: in-kernel: usable client side with C-flag
      selftests: mptcp: join: validate C-flag + def limit

 net/mptcp/pm.c                                  |  7 +++--
 net/mptcp/pm_kernel.c                           | 37 +++++++++++++++++++++++++
 net/mptcp/protocol.h                            |  7 +++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++++++
 4 files changed, 60 insertions(+), 2 deletions(-)
---
base-commit: 01d3ba86f43b6fe8e91cfd00ba178d6997095a04
change-id: 20250912-pm-c-flag-client-default-f676d8acfdc7

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

