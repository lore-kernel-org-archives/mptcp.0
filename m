Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74D5A4D4
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329878; cv=none; b=S3M2NUY6kldCkEY33yf0Diz0CcrKpSicxHHzizrxGZHF5zxpPHice0Xn1AzgE6NitJ1WbBp4Mvr5iuqocCqKUstRStR70XCe9wKYzoyG+HITzkyTV/w5xq3KTl+95WbgcmVXsfzo4ZzxGsQVHlzpdisty8TlOHsFDArNw6/FV0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329878; c=relaxed/simple;
	bh=ZBwaXa/DTcqGrEsSFhcwGM40hDVq+WP5CKGp63kboHA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LG5dm1GImKf3EKCUGoHIivfDkNDeCbIbqGBYBY9Vo/YAHHu7EMvply2EdSIbhTGjm5ec7K8aMt0yygHdW1FDJDQYUQRz3qDNGjOzk4iDJfW8M+9zgCp/lfF9hmXwdM1Q4bESRmAok8VCUEroEXjTQtYzJFj6g+5kHvOqA3fPvvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2R44GLs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2R44GLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64838C433F1;
	Wed,  7 Feb 2024 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707329877;
	bh=ZBwaXa/DTcqGrEsSFhcwGM40hDVq+WP5CKGp63kboHA=;
	h=From:Subject:Date:To:Cc:From;
	b=b2R44GLs1pF3ZjttqeNYUQNax/fWXqe/75HUJ+kdZ1t61LNcvaNWWuFWOu0FPI6F/
	 UxlVOEPcu2+MmxRJ86F6RBGA41b6RsaAq1MX/UjHAGoWCRzVY5wBkSjIZqUogJ977p
	 YvHrPIf1f06lUIH2j6+Y2eSgEhzdYM12gyEv9dSjdh2GDUJp9FyNbjBarh1RHCH6AB
	 gtgR3VOf2ngpjaR05rWU0iMPtd7pcIEqzJ+hOXhd7Io8pp5KKKLMWmvPyVePHh4ziA
	 0QC0u+s6f5b8JIkcMp48prv1lCBdobgSCYETzU7qf5In2smWbc2dZnrL2IwckE2hV2
	 QjbFSf33/KEjQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/3] selftests: mptcp: fixes for issues seen on
 v5.15.x
Date: Wed, 07 Feb 2024 19:17:48 +0100
Message-Id: <20240207-selftests-mptcp-fix-5-15-v1-0-005b0cdb135a@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEzJw2UC/yWMSwqEMBAFryK9tqENCX6uIi4ktjMNGkM6iCDe3
 TCzLF69ukE5CSsM1Q2JT1E5QoGmrsB/5/BhlKUwGDKWDLWovK2ZNSvuMfuIq1zosHHY+dm2PXW
 9MwTlHhOX7Zce4e8GvjJMz/MC8jvKWHYAAAA=
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=873; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZBwaXa/DTcqGrEsSFhcwGM40hDVq+WP5CKGp63kboHA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlw8lTmLVa6Wc5e13LX7fUlSFFthkIKCWxOMal0
 OSexQXOtpeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcPJUwAKCRD2t4JPQmmg
 c5mrD/9X7kekrK9OCtC5nwLcdfUvjFtY/WkzLlnZtlf7VeZ0Q3iy+r8ZMhBZ2QL0t6navQPTH3t
 +dk9sYgBJwFNKn0Cs6lEa8d1fiP/+3PNtBhYuU0OEpk7NPkgsxgVqoGGNh8VYHSu+qalxgBUjvE
 YS7wpDYD8vRPgsoXSzUIcoYiMAf1twfvVZosb6qJtRC7k15zVdXx0p3x1E7VsTJCZrbhUTddA9I
 Z1kmhrSP6kYdzRU9+IQU3WqnYOoLxya38P4UVmlFpcgSgvHeOrc0JMLSxP0imRJtsuD2MHtZtCC
 yQmPJo8WNR/keXyMQ0aLgsQJOqg5GbVTRplHn5BjEMzJLxTlm+k/Xd1d+sjmn37r1LTCPSZxikc
 bnCL64MSN2StYFN1qo4cs9zQoeYWFqhPkz/8ugDcbe3Et3JiqNAWGprBZOI1nihSTh6KyhAnY5b
 pipogmAbruf0WRV6DIhcCYIWz9hfHbQXCJEq1aJwAyyJ8ZZFR6jRVBoVlKwLvbK9isS/MVqUWtk
 W18VZT0X6Nn9ZprtaV8EYhnQJRIlHBFXkE+psMCKm8wrBCdUyKPAAk3ScMWFbX8wwN7u/XTtAM6
 9uKasPYt75Mys6twE6khRUet+eEFhhNywdiRCVrC1PBcbEJ799WVlwaWFTaRvw0gYB9JaHEvU1g
 0tiiNhVzQ0IMTBw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When testing the last version of the MPTCP kselftests on the v5.15.148
kernel, I noticed a few small issues. Nothing important, just some error
messages printed in the console and some tests marked as "OK" instead of
"SKIP".

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      selftests: mptcp: pm nl: also list skipped tests
      selftests: mptcp: pm nl: avoid error msg on older kernels
      selftests: mptcp: diag: fix bash warnings on older kernels

 tools/testing/selftests/net/mptcp/diag.sh       | 4 ++--
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)
---
base-commit: c2469b38e369c3f2b9577beeb9470cc757abc1b9
change-id: 20240207-selftests-mptcp-fix-5-15-8ca479089520

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

