Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7933C01
	for <mptcp@lists.linux.dev>; Tue,  8 Jul 2025 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996307; cv=none; b=gsQZyVXkZThv6RKpXBcmvqGrGf5L5scf/WciM6eWlNSN9AKwwG5T1Bynxo4cCRod5f29gBDSxComRtf2WIy8XWBons+844pAZL3k6LXjYS0Up7cvH5zTyfheGm7qgtVThiwjCvVQIyGDt4v1CM9xgxeI+AruYYRbtU7Wwzw2ygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996307; c=relaxed/simple;
	bh=oVzoa82966MSKMZAD97NHsIZHSVopmKB9D4ehb7PyPE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EX9l5s9+OdHkzVUPJY0Vk+x5osVyCi261iGaqVXBpXcfuF8om6Y4v2OfEp+kjj8UGnaYSZ1xpJ7uutuGwcKsEf+gEpRpKsR3MgpGNFyObN0Ak0cCDRpcVlTEq5dJKO00QB7rJcYk2ZCYKqujNWS5YXVdx5UG6MDcD26X8EK8emM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLnKtBIV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLnKtBIV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28287C4CEED;
	Tue,  8 Jul 2025 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751996306;
	bh=oVzoa82966MSKMZAD97NHsIZHSVopmKB9D4ehb7PyPE=;
	h=From:Subject:Date:To:Cc:From;
	b=YLnKtBIV51bNnicOyki/fEgg3/b3N5G6qt/bE+m/e2kHY6SXCZDS3MSLd48hFSyd2
	 Vh0iWf8ldne/0RHgnenbcWsWD9M113xveX8aohJjaNufGEdC4ZpNxurPJzIr0NYXI2
	 m99b9ifx5vP61kWoG/KUFhJJulFbUbt4jqwAlAqGdHYMYcJIZ8F57Yz96RWnh9AhNK
	 pAZyKNfBpOwQVw/CdcZTZeiZnbsoo1xmEEhjBU7rdZSGhn02d0np4vlQJpZcGbSOzM
	 lmXUCeESKo7VcSpjBwOVwITZbs6DevK5rUf6KH+AsbHRilXfj2ABYRYzwJ4SmlOyBp
	 /i3MoJwRa/TPw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] selftests: mptcp: connect: cover alt modes
Date: Tue, 08 Jul 2025 19:37:58 +0200
Message-Id: <20250708-selftests-mptcp-connect-modes-v1-0-f8e6f9828fd8@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHZXbWgC/yXMQQrDIBBG4auEWXdAA5K0VyldiP5JhUbFGUog5
 O6VZvkt3jtI0BKEHsNBDd8kqeQOexsovH1ewSl202hGZyYzs+CzKESFt6qhcig5IyhvJULYxcn
 7O6x1c6T+qA1L2v//J11BhtLrPH+RaOTUegAAAA==
X-Change-ID: 20250708-selftests-mptcp-connect-modes-5d7aa9e1158d
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oVzoa82966MSKMZAD97NHsIZHSVopmKB9D4ehb7PyPE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJyw/tceVNYLYTe9m2a8XLdvmWLSzcW7/x38drKjLeOk
 8LmRM/e21HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCR4kCG//Uszg0Pdxg4/118
 184pIPSw348nM33YNdYcDiuO5Ws1fMzw3+0P806Dh8sZJ537IWZ3p2Zv5AVPtsKai8GhkxbdDb/
 6hREA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_connect.sh can be executed manually with "-m <MODE>" and "-C".

These modes should be validated, but they are not when the selftests are
executed via the kselftest helpers. To fix that, new test programs have
been added, simply calling mptcp_connect.sh with the right parameters.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      selftests: mptcp: connect: also cover alt modes
      selftests: mptcp: connect: also cover checksum

 tools/testing/selftests/net/mptcp/Makefile                  | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh | 4 ++++
 4 files changed, 14 insertions(+), 1 deletion(-)
---
base-commit: df15676c95d593e64720b86babe913924c3d5649
change-id: 20250708-selftests-mptcp-connect-modes-5d7aa9e1158d

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

