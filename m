Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072113B2AC
	for <mptcp@lists.linux.dev>; Tue,  6 Aug 2024 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943146; cv=none; b=KftVL4P0r+rxbYNuHNWMV9NbhVW2MiSvg8vWUpV1/LkQOn0UR4OeUFjjNfjK5/rvrG/dEeDGlN5YcpBaQOPcAnqNlyOpnNG4pUMVDnhGHvESLrvzOEFt1wzNzVw1Lqb4R9G5iqXiW1lY1djDnFG6/zK9SMIQct+pbCEWLgjo4C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943146; c=relaxed/simple;
	bh=O25Lwjom6/cCvrYWAXe4KMjyA0sdr7i8IUZ5UP4nA+c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EFYwxKUxbftw9lCmPf74jBPVrETFSygzIg9hXzUmvyaqL8oOJYJtcNeM7X3hIoZjq9p85YP1aEqDZ/0QVYbMbDiF2UqDxPuBiBzawMEhAROBwqfkn6O0guB/tzyEUcfzxvlQ0wy/psmyhYb57CN1X4YCqs/eSZ/6bQ9dZAy2PYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ru+dRvNP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ru+dRvNP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D9CC32786;
	Tue,  6 Aug 2024 11:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722943145;
	bh=O25Lwjom6/cCvrYWAXe4KMjyA0sdr7i8IUZ5UP4nA+c=;
	h=From:Subject:Date:To:Cc:From;
	b=Ru+dRvNPpHk62/fA5V8mnAp5+EOE/MPFahyOhtKF043fUtZ/sDKJct/MMcBHkH6me
	 mNQ9cfwu0K+SQcT3ppqKloSmue4VT1TNZ833iaF0fEIPbwp1XXgBOjylvwXEgUFQTb
	 Qp7nlyAU6MToSX/8j4gKr+K21j8XwH55cF54FkQmr4C189tbk+gZ08h2zYnXhdpRb3
	 1ynQVmFytY97j03z33PKMpDxEYWGpskTitiAtlEkj0SUQjTs0BQBSL1h+/aypWB2+d
	 09GqXb9CuFRFYelPUwTcApJNJa2uFz0TfHkKIhnC6VAQ38FNpmCkLomQBW/1jpXXIo
	 H6fbpaqI3UAAw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v3 0/8] mptcp: MIB counters for sent MP_JOIN
Date: Tue, 06 Aug 2024 13:18:48 +0200
Message-Id: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJgGsmYC/23NTQ7CIBAF4KsY1o4BSvrjynsYF5ROW9RCA4TUN
 L27BF1o0uXLvPfNSjw6jZ6cDytxGLXX1qRQHA9EjdIMCLpLmXDKBa24gGkOaoa71QbCApNuoRb
 IGUrR8qIkaTc77PWSzSv51A0ugdzSbdQ+WPfK7yLLja9c7siRAYWq50w0raSd6i8PdAafJ+uGz
 EX+SzR7BE9ELRVWtO9SSf4R27a9AbutafcCAQAA
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2538; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=O25Lwjom6/cCvrYWAXe4KMjyA0sdr7i8IUZ5UP4nA+c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmsgaona4COZUr9flcg0+P+KHnrxK/9lGcAVXKO
 /NkwedKI7WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrIGqAAKCRD2t4JPQmmg
 c6oUD/4rWWRO5B/SVxcPgQc0wOrm+nTAbtdL2kODLsWx5WVV8m8VLW6kTe3dkZsE/Y5C4YotJVJ
 Ns33UIZBFSuuiSeXA8l2YwQikoMl7gh8cM+tr7xCj2QJtrOQmIdgJzBTRsGjBpFrgaZ2UT9RTcM
 pPr/c8gTeNl9TtTgSghCyP87hxlWc99ypEuRt0nWzS73OMj7pIT4p1vBFYbMflpGysOye/2qqfm
 rThAPPLe+lheS7oaC55PsFjVjCk/q/4o3RRr9sRxa4FRzyq0hjVJejVok6dTeO/xWqu2FtZIr1p
 osy1mE0NAp06Dd6A/KYCmDfnhnzADUn7g0IWNtgrqLMQWX9Ih+tirmrw7ZRBelsh8Az87kt80U1
 HypUSR5FLwXT/Vy/a5ItDP6zZbk1akNoSw02z3nbb02oSZ6eJeOYcqSoOsD5B9/oXgyNddHpqKl
 Pj8VlhX7zr3Niy5LB5aqoy+hgP60QgbfXm7R3OSwEwcvoX05DLCK7CFKxVzZHszx3PexiIkBp0W
 ox/DCiSBJz0PKeG2r+xNaAUF4XEmkIwcFG8tolRz8ZP54jTJNOHnW09bWjK1ZQJnCcqF1BDnhYm
 U9I/6cRMsczQciT3pDKUeBVJXKf+ggqyZ51Uc4h6NyQx2LMiwX5QaP9BouGeiePZHxEnzSXBqJ9
 mMbyewhhq8E87Fg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, a few issues have been discovered around the creation of
additional subflows. Without these counters, it was difficult to point
out the reason why some subflows were not created as expected.

In patch 2, all error paths from __mptcp_subflow_connect() are covered,
except the one related to the 'fully established mode', because it
should only happen with the userspace PM, which will propagate the error
in this  case (ENOTCONN).

These new counters are also verified in the MPTCP Join selftest in patch
5.

While at it, a few other patches are improving the MPJoin selftests:

 - Patch 1: a fix when using an old kernel
 - Patch 3: reduce the number of positional parameters
 - Patch 4: only one line for the 'join' checks, instead of 3
 - Patch 6: more explicit check names, instead of sometimes too cryptic
            ones: rtx, ptx, ftx, ctx, fclzrx, sum
 - Patch 7: specify client/server instead of 'invert' for some checks
            not suggesting one direction
 - Patch 8: mute errors of mptcp_connect when ran in the background

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- Patch 2: remove fully estab error
- Patch 5: force bind error + always validate join tx
- New patches: 1, 3, 4, 6, 7, 8.
- Link to v2: https://lore.kernel.org/r/20240729-mptcp-join-tx-mib-v2-0-8ace70fd407a@kernel.org

Changes in v2:
- Patch 1/2: Add "ERR" suffix in variable names. (Geliang)
- Link to v1: https://lore.kernel.org/r/20240726-mptcp-join-tx-mib-v1-0-7f2149ba0dcf@kernel.org

---
Matthieu Baerts (NGI0) (8):
      selftests: mptcp: join: no extra msg if no counter
      mptcp: MIB counters for sent MP_JOIN
      selftests: mptcp: join: reduce join_nr params
      selftests: mptcp: join: one line for join check
      selftests: mptcp: join: validate MPJ SYN TX MIB counters
      selftests: mptcp: join: more explicit check name
      selftests: mptcp: join: specify host being checked
      selftests: mptcp: join: mute errors when ran in the background

 net/mptcp/mib.c                                 |   4 +
 net/mptcp/mib.h                                 |   4 +
 net/mptcp/subflow.c                             |  21 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 308 +++++++++++++++---------
 4 files changed, 226 insertions(+), 111 deletions(-)
---
base-commit: d8ff9c0319613035c0fbc35dc2ce12f8f2948dcc
change-id: 20240724-mptcp-join-tx-mib-84e21ea4b236

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

