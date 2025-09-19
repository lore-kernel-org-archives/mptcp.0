Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392DD4502F;
	Fri, 19 Sep 2025 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322295; cv=none; b=b5l5ASggNKJMZ8QU+ELprg0KiTpXAC4udIEF1VsP6Eae5zGzM/jMBVStRfBMny74XSfRHub8BR4B/Xq1wL8Ctc6uWXja7FjnAUtOuDPmwgfMwLAdoSlqR0sXZ8PAHaWmLQMrAJh/BUGySZ/33NiprqgCpcZV75PtAb1qPRv2Lpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322295; c=relaxed/simple;
	bh=R+jreA5PmawCFvwzHIu88do9t12ueniqQkFMrswI/nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pmAApQEUfn/xFrmH8wkMt0Ti41uPgaoJ3x1H3EGyZ+8YlqH3dO0jen4v/XKwufHC+sLlxhC/qLGIDfAraoBe83F6RjGE+bxGEU+BuoiUfSZW7zm3vfvPUY3DOx6Y28Buhtr9MjIjibsfgU84eNhg4NjP4VfaBZ03RbGjOS9uK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBzwbCIm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBzwbCIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72EFC4CEF0;
	Fri, 19 Sep 2025 22:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758322295;
	bh=R+jreA5PmawCFvwzHIu88do9t12ueniqQkFMrswI/nw=;
	h=From:To:Cc:Subject:Date:From;
	b=mBzwbCImz18bj0qnFi2zXHA0VVEogRDE2wAxbxUHCCE+JCnmQiL3WosDT0VfF+Cl8
	 gJ5IaG/G1YwCEVmaO+SRqv9/+2GuWZuds1HWN0as5lsrva4ddIaa986OLohceGH8hS
	 OAiaPI2rzUoN3EyRg+0igbsUYprfX879KhJ2s5uiwANrwQOUHc+i7Y5aTunHFKuFJz
	 XgTHyFBt/KLOgV5eWPypVZPCw9OmoJhB0sZCPqzwaB18+f9aLj7TquZPi7b0fHcpFW
	 oktAG3pzkYNymx3rpWHiM7SnaKoCRWrkp4xSq0WC5gVIrFMIbMyYfLlZnvURJcrIS+
	 Ez3jsVTAY08XQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.1.y 0/2] mptcp: fix recent failed backports (20250919)
Date: Sat, 20 Sep 2025 00:51:19 +0200
Message-ID: <20250919225118.3781035-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=762; i=matttbe@kernel.org; h=from:subject; bh=R+jreA5PmawCFvwzHIu88do9t12ueniqQkFMrswI/nw=; b=kA0DAAoWfCLwwvNHCpcByyZiAGjN3mehAdt/A7fqDcjsoDnSI5ZgtkN/4TvPYqJuUuElG/YZH oh0BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmjN3mcACgkQfCLwwvNHCpc04QEAwB1q 2QRauRWxseGhHXy3A7aiWuhi1Qy/gNhlJMuOzCsA+LJNmdmedEtxqDbn/v6Jvzt4GjE3fwhqrhu jC8KhbAY=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The following patches could not be applied without conflicts in this
tree:

 - 2293c57484ae ("mptcp: pm: nl: announce deny-join-id0 flag")
 - 24733e193a0d ("selftests: mptcp: userspace pm: validate deny-join-id0 flag")

Conflicts have been resolved, and documented in each patch.

Matthieu Baerts (NGI0) (2):
  mptcp: pm: nl: announce deny-join-id0 flag
  selftests: mptcp: userspace pm: validate deny-join-id0 flag

 include/uapi/linux/mptcp.h                        |  6 ++++--
 net/mptcp/pm_netlink.c                            |  7 +++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  7 +++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 14 ++++++++++++--
 4 files changed, 30 insertions(+), 4 deletions(-)

-- 
2.51.0

