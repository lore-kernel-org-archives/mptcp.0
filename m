Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F8A4A08
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997216; cv=none; b=OU0woh7bC7l4LZiT68JPIF2l8v/XrSfYZEKbiq/Wv9XpJZNoIBa5emJ7E6MKimbyA0g7NiiHA+o5532hLn3sPnS6teQD2PKZkeDHYTGaQQmZ/P0yo1WsCz/GihHPCiY/ZUYk6P3OFIB5oJcNxAH6CzwLkgvEPqvCD0H0w7lVO64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997216; c=relaxed/simple;
	bh=XOmFwEgF2lBVOJw21YXYeq1SQ3k9S4U93oHX8oPUCeg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=itysCkBSLQn8+587fas47S2CER8Kiwvk7YzEWfiQIJBqXzxASA2rjeTxphCeRu/jdfXlZMKrvosRxES8rVLYkKNymmZRVvmGSrIMy31FUrpxQ83dmIQMvXrsvYKO4MwhTDtdD+mILIuBoVhsst1DyzFNk07oVdppgPnViFXI7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2Nyr9GO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2Nyr9GO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093F9C433F1;
	Thu, 15 Feb 2024 11:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707997216;
	bh=XOmFwEgF2lBVOJw21YXYeq1SQ3k9S4U93oHX8oPUCeg=;
	h=From:Subject:Date:To:Cc:From;
	b=q2Nyr9GOYy9KoiG3VHB/VA7dBJPcJYKAThbFuResJ+jAhAb5kQGPSRoquFvbL/TQr
	 YglGA37TPmjofd/2HkLUXee+zvQbw71jfkqTBKsaanDWRI5pVI6dLc9pIs/n25q0af
	 OvHxjJ1SIYTwBF83vmg1eNZzNJ/KmVc/IbKLZ3mcZckX6hSf30Vhin92lwwzOWgdzh
	 yxCof0ivqOtShF1F8ddq88yT/SymDozVPSJNvivTEqrGfywLMNe3YJr9Ti46CzBGCj
	 FzEUn8KP4JElAFH0CcY4JX7y9RJ5OaTZPOKIgukuY49B8hf/CVZhun0Uh842CnnK9l
	 B0kqNneS1uy0Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v4 0/3] mptcp: check the protocol with DEBUG_NET
Date: Thu, 15 Feb 2024 12:40:01 +0100
Message-Id: <20240215-mptcp-check-protocol-v4-0-16e932665e21@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABH4zWUC/33NQQ6CMBAF0KuQrq2ZtpSKK+9hXGAZoEFbUpoGQ
 7i7DS7UGFz+/PlvZjKiNziSYzYTj9GMxtkU8l1GdFfZFqmpUyYceA5MMHofgh6o7lD3dPAuOO1
 uFAVHKWrIKyVJmg4eGzOt7Jm8FhanQC6p68wYnH+sHyNbL/7jkVGgFRRQqAauNRxOPXqLt73z7
 SpG/lY4bCk8KQy5FNhIVpbwo4hPRW0oIilK6aLUsiwaKb+UZVme/pkuAVEBAAA=
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1958; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XOmFwEgF2lBVOJw21YXYeq1SQ3k9S4U93oHX8oPUCeg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzfgeBxfPGCTQoJOvgpQPa+EZk1B99Po/7SsiX
 Oz74lehsSWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc34HgAKCRD2t4JPQmmg
 c33FD/4oh4a3ZvrDL2YtvBF8WoRioX7Wm0SP/njVeHjzd0x3/ZPOUFZ+num+FOhoQpx/0dz8dFg
 9YdT4KuAMzYHvULdMu+ONt5WDZXrOdLZnGnrAN3NmUk7jpCzH5lesDNOgZOixgYA5XswRMNm72G
 O9Zl+3grL9SCRb5Uwa7TUpluyowdycZkme215oGf3CRAiZy5+8WyH6ucFL4GZHL6QxBydkDp0ZZ
 zQsTUD5XZBBWtH1XoMTP9SmQPh2YOPSD0kgYK1BKlVjNyTeHu9p7bHxoQQG9T0YI0cIpbb09lou
 QUqLT3HsqZlaPmUR0eSRFfSCyViEaqyqU/rOqKMEMwMTdtEpriTi+7zGp5iAIeuj05tu82bOVyS
 wQWRri6N2kBc3JJCa1Th9QsZjVKuJwd2sy78/H/j4Jk+/e9/8ZanMlHyXi/5GdRI9BUYyoKKUzP
 nRbphfMYlr2lL7I/7fzUxML8N9n2gOgcecKK1zqsJq1DkE7nCb5z4RBw7rxDXed43K9dljqbf3D
 wZ3BZXrVW8UZg3jTLu3inlgH/SCSfsF+O4UinGgV/JU5nlnOzca+UGtEGEp2jbjDjlFjdcWSd60
 h7bwC7VtjKZvonzT+LdOZ4rmEzqxWOR+/IQJJJz2VK0vJazozTx+JXvABMH0vujFKAqyYfQXGAg
 OnklUHvHUOzhymA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, Paolo fixed a bug where a TCP-specific helper was used with an
MPTCP socket [1]. The bug was not detected by fuzzer or static analysis.

Following this, it has been suggested to add a check, only in debug
mode. This is what this series is doing.

The series has been split to be upstreamed: a preparation patch for
MPTCP, the modification for TCP, then for MPTCP. It is not clear if it
would be OK to add that upstream. If not, we can squash these three
patches in "DO-NOT-MERGE: mptcp: improve code coverage for CI" commit we
have in our export tree.

Note that the MPTCP Token kUnit test needs to be adapted for this new
check. This is what is done in patch 1/3.

Link: https://lore.kernel.org/mptcp/35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com/ [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v4:
- Patch 2 and 3 have been modified, please the changelog on each patch
- Link to v3: https://lore.kernel.org/r/20240207-mptcp-check-protocol-v3-0-77c69c596f55@kernel.org

Changes in v3:
- Patch 2 and 3 have been modified, please the changelog on each patch
- Link to v2: https://lore.kernel.org/r/20240201-mptcp-check-protocol-v2-0-1e253ef51990@kernel.org

Changes in v2:
- Patch 2 and 3 have been modified, please the changelog on each patch
- Link to v1: https://lore.kernel.org/r/20240131-mptcp-check-protocol-v1-0-a06067f0bd08@kernel.org

---
Matthieu Baerts (NGI0) (3):
      mptcp: token kunit: set protocol
      mptcp: check the protocol in tcp_sk() with DEBUG_NET
      mptcp: check the protocol in mptcp_sk() with DEBUG_NET

 net/mptcp/protocol.h   | 16 ++++++++++++++++
 net/mptcp/token_test.c |  7 ++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)
---
base-commit: 52e05de42e1094a943053af93ea08c51a44091f7
change-id: 20240131-mptcp-check-protocol-e32e53d04a75

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

