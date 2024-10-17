Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477D71C5793
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160195; cv=none; b=bAK2+5Xn98xvGUcvVhMc9u8y+e1lNymaET6nU8Nap+L/qy2//TWGGasnclVb2aCRSGF08XqVH1odpkAXBDprviDy5dfZssf8O+qZgpqoxLny6S+4P63y4O3ZoB0NfD6+Cx3etn9Kwi0jt+HiOyjW7PWRRimHcZFBsVr3PmQi2mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160195; c=relaxed/simple;
	bh=xgInLOwk5O045Zj1AYkMb2HyuYKeK/vOhzcGNmfV93o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ciD5nK+9ZawhYWaCxIv3Xqb+aE1sA3Kehs4E9aPpfJ4NCowUtToj9eDwMNsDDJTurO9JIwEoZqGB8QS8lZEaUvO9Cx1lS+Sj+I1MRJYuOCrVZV4bXo8OE18ehYNKqdbiKzCFy5w2ttkv4hXKe1ZMFngUBOOaWemO8vIqTtLVLOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjjV4H65; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjjV4H65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63093C4CEC3;
	Thu, 17 Oct 2024 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729160195;
	bh=xgInLOwk5O045Zj1AYkMb2HyuYKeK/vOhzcGNmfV93o=;
	h=From:Subject:Date:To:Cc:From;
	b=qjjV4H65HzF4f11E4iHauo3K2E4Gz+JKJFQOK2P23entFOh6Y78VfWFmkwdFv3AO7
	 n3NPGzfPbyBA2Zjuu48web8pq+tdC+WFNNmJMZ++MCEVn3+rdD1feQ9mKnn3XAMEQb
	 uDLZBbn7/eFkCy0iDdZUdgHhbgRuvhKM8itjvBPnjj4TBKkw2+PKBOrmo3rz6Qe0U5
	 uIum7B5U8vZwP2IpMl7n/vAZiw/e7u/zGVeo6/nHhRZqq1f89KYB+W1uBKi76gvxub
	 INvvUZDv+4SFAZwPTEnJXGN03YsgyvfNyd30QSrZUHUsmV1k3IC8PM7gwEh6uC94e2
	 hOA6Zt//BuV4A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] mptcp: remove unneeded lock when listing
 scheds
Date: Thu, 17 Oct 2024 12:16:24 +0200
Message-Id: <20241017-mptcp-sched-avail-lock-v1-0-028ef592c6f4@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPjjEGcC/yXMQQqDMBBA0avIrDuQiVJLryJdxHGsQ20MSRBBv
 LtBl3/x/g5JokqCd7VDlFWTLr4EPSrgyfmvoA6lwRrbkKEW/yFzwMSTDOhWpzPOC//QPU1LDfe
 1pRcUHKKMul3jDm7jJcPnOE6kc19ScwAAAA==
X-Change-ID: 20241017-mptcp-sched-avail-lock-a60714cb3218
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=688; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xgInLOwk5O045Zj1AYkMb2HyuYKeK/vOhzcGNmfV93o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnEOQBOnJJV/YwqS5eUwqPRTcBerZEx48C6WKD1
 4gJ7i8AflCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxDkAQAKCRD2t4JPQmmg
 cyZjEACj1CKSBFrScZ9E2shNa8yPM7lABAbZAkQH/jufdk7wvbVCPKUVrXlWU806TICCp8fNeai
 jBSSncnVy9QG/RRE9bnM/ibhi9846608ecHkmhaj0B9Mr+K05pokwz17WscVk0vQReivEzrErDh
 GsEfQtIYP2L9tuFB+HkP2eNNv5FwO/I8py7NIt0qsNNVUMOoWJo765jCWSRKtQ7gIOYlT0taCij
 isqpjMxatM3H55CJqDyfJ5OTZS+dpqnLqU2+PDphiuflv1D5Q1Yq25QuD9f7YdLhUfviVdNtbT1
 nKAw4dJzq8hBX9ix+AbyJpyxx0Qrpd2vclwWLwopmdPqhJ0r+41t3ZXIMRKoHee0mwPVDINitYP
 X22UaocPhO2dYfFxAqUZIvZUhBPPLCxzoYsDmDVdU/pe9niqxVBrDMJfN+v/I1pWwt0wEEP1jzS
 BznoK9A3Z1Ck5UmJnmGcKTea6H5Fy3V52EYjcJNqQmg2NNjZMceyRreksFmubI3eAllzqJLivtS
 DV7s0elhPTYUExgWkJOOlbOp1Dz7GbZssRcwlk+lSxLhNrWTYC9egAUZCCrg3iRQfKGmkODl5ih
 CtoxTnVKtP+aaIIvK6Z2VycJL13jPCp2k/p4SchoGznYPICQFhTwm0JwoGalLN1AUPOMfFvOBjU
 8pwGeQexjvhlnDw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A fix suggested by Paolo, and a small addition in the selftests to
increase the code coverage. I guess they can both go to -net.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      mptcp: remove unneeded lock when listing scheds
      selftests: mptcp: list sysctl data

 net/mptcp/sched.c                                  | 2 --
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 9 +++++++++
 2 files changed, 9 insertions(+), 2 deletions(-)
---
base-commit: c60af6efcac3836a49c583f8a127560697d8c3a8
change-id: 20241017-mptcp-sched-avail-lock-a60714cb3218

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

