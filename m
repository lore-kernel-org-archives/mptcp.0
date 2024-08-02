Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11E1AE029
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622669; cv=none; b=T5Nt7ofl0ouF25TWY0GK/GgGDk/ybLryOezxQjfCxIH2o4m4pFyU2q33ShgxdVHnbjiOljuYp+X4pMtCdtgg5sxNY5cyeQR7ekRUx8FUeZLhLMKcOI/lYR0LLYVPyZqyvaa0nvi7RN39Gz4vs6hZhmyIWUAl8paq8TsVj8ZaWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622669; c=relaxed/simple;
	bh=2HLs2UFid0n41HZ+uC61TQTSim+hm2P4jmSj6TSjmmU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UXhqdTuQ9TUhar27CHtu8yylYcj65o3JYvEWnBMcbhIMdkdA+MsZLxPC2VKZy5pUx1pPSQxKBKCdmuxW+sZDw9nqx5vMmu644+pt9tM8yBtAxSu+WyIm9YVp7uyVvir72ojSn5hi6enq9GY9W8FajukArlm0QZCucMvLGpzom/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9/ybg+H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9/ybg+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DA9C32782;
	Fri,  2 Aug 2024 18:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622669;
	bh=2HLs2UFid0n41HZ+uC61TQTSim+hm2P4jmSj6TSjmmU=;
	h=From:Subject:Date:To:Cc:From;
	b=I9/ybg+HTcxs2uDCCEeEgQyS1WZEApp0eZ2waiOs3LcAg6d7wrBEp4dm++j7MPrR/
	 Gj2aEnSvM90z2QnP2rarT7+u9lrxBDMiG1lOevJVCUvQFo63WDvV5EdMgUO4783MkA
	 rHs/hdED6awyswJNmHjHwf/Th09eYa42nE4hIa3Br52wN5fPed7V4rOBvFnk+IYitF
	 WaN9fcb73XWrqchDncMj+s9+Zclfkc/K48ZFHYEAjTfR3zqaOkASVBncTNL/NpbDZ2
	 X6nIZFVw/NQJi/GhMx1CskZRYHzcFwFqmt8XqHuVPBvBfVW9Ox2tu0dyd27R00qBgF
	 H0E1H/S2l/o0Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v6 00/11] mptcp: pm: more fixes around the ID 0
Date: Fri, 02 Aug 2024 20:17:37 +0200
Message-Id: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMEirWYC/2XOwY7CIBAG4FcxnMV0gKGyp32PjYdSBiVq29CGr
 DF992WriVWOk/m/f+bORoqBRva1ubNIKYyh7/KgtxvWnpruSDy4PDNRCVVpUfHrMLUDH668SU2
 4cI8kDdaWlAKW0RDJh9+l8Ic9sh1N7JBXpzBOfbwtpxIsgWcrfLYm4BW32giHZPfG4veZYkeXX
 R+PS1cSL18DFl5k71sElNaB11R4ufam8DJ7MtoiGmjJycKrlRei8Cp7QOtdLR3JvSo8rr0uPP7
 /bwGgdo7I6zc/z/MfgXYuZrgBAAA=
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2242; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2HLs2UFid0n41HZ+uC61TQTSim+hm2P4jmSj6TSjmmU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmrSLKmZ7QEsWUgyft6vzYPU7DCh4cpAv279lYB
 R8+BjY+npmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZq0iygAKCRD2t4JPQmmg
 c2FYD/wNQ1lstho5KIIjHCjMwyRcBa4iG25ybs9aDopn5HFf6E6uD4bmuP9hXldZLdOzjhP+c+m
 E+eIJDIaN2ruEvdgCG+HOqnUoBFE03VhFEK6VpW2Aw2OKEZVir4Tq4NJdpgnayx1gEQ/PHlXdNy
 vL2sYX0YifgIu3RdQKHYDzkupzI5scXKycHcpnc7S+JEgyanyywoMmeqTLwPoos+16zUfBn8d5Q
 o3ZOkcjqdd4KRxqE7LmtrV/LzfvjQ5ZgMu9sZKEKEl4jWgi4Ab23LfxEcYmkxTmeus6uPU/ZaFy
 P/O1wpiK4QXYU2yMWJW/Bm4eVrDDqyeOtXMGfb/Lc3/VV9US2v5UqBbUlXyEyKSsfSjvY8/mJJB
 97tRZVrVyiw3p68z6ovP9PgSNDgXC2pGMJATUWnFntzVXoLUqA43hdvWBKIWF6z6j/a02ct4RkZ
 7wWRmTFPexwjGvfs+HCYct+Xtqs7wOVZz5So5JfqgFavTdByGw2rBKiz+cQDJBdYo+3AyKK4GKT
 wtSUdN7ddmzqJbOQ4VDAOGMdkgaNQCqn//qsBi9k6+IBWul5iLn+u9P4MW5lXn3szufUrSTUY+t
 7pP/9nKfzY6h41HY7C7yIX2L6ta1l4AzXysngqvBKus+yn6wKdx9spzcz64IZArYC4OeU3S3JNB
 nuFKyYCyZfJGNYA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The two first patches are some small improvements for previous patches
that are already in our tree, but not sent to netdev yet.

Then we have a fix to send a RM_ADDR with the correct ID 0, instead of
using the ID of the global endpoint. The test that is linked to that
doesn't check if the ID being sent is 0, but we can see the reaction of
the other peer if it closes the connection or not.

The next fix is to correctly reset the ID corresponding to the initial
address: to avoid some confusion, or not to send the wrong ID if it is
re-used by another address later on.

That leaded to two extra fix: sending an ACK on an active subflow, and
allowing to create a new subflow if the subflow was not closed: that's
because when the RM_ADDR was not correct, the other peer was not closing
the expected subflow, and the connection ended up being half closed.
This last issue is fixed by the next and last fix of the series.

The last patch is not for -net. Something that sounds better to do.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (11):
      Squash to "mptcp: pm: re-using ID of unused removed ADD_ADDR"
      Squash to "mptcp: pm: fullmesh: select the right ID later"
      mptcp: pm: fix RM_ADDR ID for the initial subflow
      selftests: mptcp: join: check removing ID 0 endpoint
      mptcp: pm: send ACK on an active subflow
      mptcp: pm: skip connecting to already established sf
      mptcp: pm: reset MPC endp ID when re-added
      selftests: mptcp: join: check re-adding init endp with != id
      mptcp: close subflow when receiving TCP+FIN
      selftests: mptcp: join: cannot rm sf if closed
      mptcp: pm: send ACK on non stale subflows

 net/mptcp/pm_netlink.c                          | 72 ++++++++++++++-----------
 net/mptcp/protocol.c                            |  5 +-
 net/mptcp/subflow.c                             |  8 ++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 49 ++++++++++-------
 4 files changed, 81 insertions(+), 53 deletions(-)
---
base-commit: 2b058d91b96082b282ab2b5bd2dbc7abdd28bacc
change-id: 20240620-mptcp-pm-avail-f5e3957be441

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

