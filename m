Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC430504D
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435439; cv=none; b=aSfmkKlpL9mtLpUka/OyrxbFVvsy3qANsSe1W1df7TQ6n25HLvnSyhGiyJBthtJTtqN3//n0J/6cI3uAqucwP1HqNcCiN8PhFiKfvRRv5QHKYgvFUiu40pfZO5m6Hp3bslfJN4uQ7u2szSW6I7qpoj6MVPLK53usnqYrVHLigec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435439; c=relaxed/simple;
	bh=/EtDA45ORjx85opna1gKwT9tBpHZTm+5MT5OoJsyA2c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Et0ligKXYpzPpYdh/pYZH5qRsXmVKPWnrXkfGaNbRNftf8ZyZ6k7XaMnHoE9ZL+vpwJRmIQTmQuyFPVmYQTE18Ft/79BmKLL7jEqcj1RKzb/YNx90FdtDRbXhACaqF6VcPezUeaJH/5W9rU0a65O0ye1kPz+gzDGqoVX+NP+rPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7/9J4JF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7/9J4JF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38206C4CEF4;
	Tue,  9 Sep 2025 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757435438;
	bh=/EtDA45ORjx85opna1gKwT9tBpHZTm+5MT5OoJsyA2c=;
	h=From:Subject:Date:To:Cc:From;
	b=O7/9J4JFtoTMueYmmA2O4wDla5U6oL4sbtVKmyD+8MYPl8nOw5yyF5Xe8eyaufszp
	 08HvzebUq9YctTtm1UweQSsvylk1HqiQ3bCZmydcgIPx1rhneWY4ZsrJHRNMRcXo0q
	 2koAv0TEpT9dYDTuTgJyKYizf/e1ceCxD27dYg4tVqi+v5WZ4yH8/Iam9I62XYVer0
	 fbkSpBMtUXFOF5rjpTREy/N+s5jfHbKZV6DY/fLzOu91KYih9C+RtkEqLtUS3GsO64
	 7czOiCrHQOcQK2RHCxG7DMKJbcoak8u8xauH5W2pK85AGnUCQoqJ0vArGj9/GPXCf1
	 DNncPPPLDu5LA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/4] mptcp: pm: netlink: announce server-side
 flag
Date: Tue, 09 Sep 2025 18:30:12 +0200
Message-Id: <20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABVWwGgC/13OzQ6CMAwA4FchPbukG2xjvIrxsHVFlwgiIDExv
 LtDjAcPTdP05+sLJh4TT9AULxh5SVO69bmQhwLo4vszixRzDQqVRodOdMNMgxg68cibIseypRR
 ZtFd/FkpWVFfBYVAS8pFh5DY9P8AR9t2enzOc9t7I90c25+/Aj2yKD2gV/oG0M95GHa1HJNM2i
 9qk4CcWdOu6NOf/FRvTWtQyVEGX2juHFBWSrFy0xruaydRUwmld30GBqDoEAQAA
X-Change-ID: 20250909-mptcp-pm-user-server-side-flag-214c84b90b21
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/EtDA45ORjx85opna1gKwT9tBpHZTm+5MT5OoJsyA2c=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOhGnsXB+nGH9b5pj/3N+d1RM+hYYWqXDYnL/i8r/k4
 e8li27ldpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkkSjD/2L/tOiI8wuk6jk/
 HPM/cuiowxX+fUkaqbXbS05tmFDocYSRYeZD050aol8+Lp9Qo9xSlbw5bMGBV+ENzs+6Pqi9bOT
 7wQQA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Now that the 'flags' attribute is used, it seems interesting to add one
flag for 'server-side', a boolean value.

Here are a few patches related to the 'server-side' attribute:

- Patch 1: only announce this attribute on the server side.

- Patch 2: announce the 'server-side' flag when this is the case.

- Patch 3: deprecate the 'server-side' attribute.

- Patch 4: use the 'server-side' flag in the selftests.

Based-on: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (4):
      mptcp: pm: netlink: only add server-side attr when true
      mptcp: pm: netlink: announce server-side flag
      mptcp: pm: netlink: deprecate server-side attribute
      selftests: mptcp: pm: get server-side flag

 Documentation/netlink/specs/mptcp_pm.yaml         | 5 +++--
 include/uapi/linux/mptcp.h                        | 1 +
 include/uapi/linux/mptcp_pm.h                     | 4 ++--
 net/mptcp/pm_netlink.c                            | 9 +++++++--
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     | 9 ++++++++-
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
 6 files changed, 22 insertions(+), 8 deletions(-)
---
base-commit: 12e66f7051b4b535a990cd20c149d76a98ec68c3
change-id: 20250909-mptcp-pm-user-server-side-flag-214c84b90b21
prerequisite-change-id: 20250720-mptcp-pm-user-c-flag-a7d5d7a00c6f:v2
prerequisite-patch-id: cc65204dc8620f1675f8b8cbdf6dc0fecf20379e
prerequisite-patch-id: 88640c51fc66f4d630e2f99db72c18830273fc83
prerequisite-patch-id: 5773e6ceede07a2c43550774eddad1c32cde67e0
prerequisite-patch-id: f9196f35eff69835799db4312e82c795f1b15eb0
prerequisite-patch-id: 8ec26f3fe4baa5128ac2f01f7284184bbb0e651b

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

