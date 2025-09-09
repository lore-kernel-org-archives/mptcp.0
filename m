Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A33469FB
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428430; cv=none; b=a3Z/TkKJWf/gr6dmTFnhFNtph4Ck5KWuZkwsfs//X1w2N7Oi6KKFc/qwNrfdvVoqxYhw7R5x7b8zDeAuNOdyBWLvgHL5BZ8PvdIGKsegFDg5DpnGHEDBkMV8t/wqW29Z2uIe7q51iS0aZVmq3YBy/K8XDZzUz8JKDciNjwEOS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428430; c=relaxed/simple;
	bh=nPkJ2HD9URqXPc6DZqvW+SUx9mOCJUfpOiiWRUeJ/Ck=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gEEqD3VHEZdrSCETUV2YHDZ65kiXNOiMtD7h5EmDwENQ6HVYKlk3QTckSu31dRXC7sff4pYmDxlaqH/3DfCwbjta30ZaFr70tZLX6J5ABzlV08O6RMrgDJDmnKxlH+fX4comXUo03xeOfpVA10gfq20PLqVuHI3zLa9pUi14up4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNyWmklj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNyWmklj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D161C4CEF4;
	Tue,  9 Sep 2025 14:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757428430;
	bh=nPkJ2HD9URqXPc6DZqvW+SUx9mOCJUfpOiiWRUeJ/Ck=;
	h=From:Subject:Date:To:Cc:From;
	b=tNyWmkljlrpYGuwAIJ/0sp0MFrNAsHFeP4sRZner6TV8VU+FtFplNFij0j1BI125p
	 nY0zWOqsozSYjqRucGHAt4NV9SJlM/Yzx0ODIfBRYpggcsku9hyXuAa9FDTIaPBYq2
	 R6PtuuW/JQ6ZkSwRkV+izpIYLtkhsa64sLOCqrNpmYxba8RHWSrJg1ZgYDglKOGzYl
	 8c4nWeAZCoBXymUunfsKbi2Js8BQrPuBtGuTXTaiSuPsVY+/NEHR+LEz/SARbV/UWe
	 k+sltJKmSdJ31ugSqsGeZYUSp/QbYeGjLSQojRPDHne/FsMbJsQlHluuxNnj6K/48H
	 QSiydRwO45Czw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/5] mptcp: pm: nl: announce deny-join-id0
 attribute
Date: Tue, 09 Sep 2025 16:33:29 +0200
Message-Id: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALk6wGgC/22NwQ6CMBBEf4Xs2TVLEyx68j8Ih9ou0AilaSvRE
 P7dpl49Tmbemx0iB8sRbtUOgTcb7epyEKcK9KTcyGhNziBINCQF4eKT9ugXfGUSNQ6zGlFJ0xi
 piPRlgIz6wIN9F20HP8Jxgj5Xk41pDZ9yuNVlUNytuP53bzUSyvYhGmOUlNTenxwcz+c1jNAfx
 /EF8aIFd8QAAAA=
X-Change-ID: 20250720-mptcp-pm-user-c-flag-a7d5d7a00c6f
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Marek Majkowski <marek@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2759; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nPkJ2HD9URqXPc6DZqvW+SUx9mOCJUfpOiiWRUeJ/Ck=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOWB1b+e7kh2/efPMWsDBrpS/8uERqr02IX8oF36nPf
 1Yy7X13taOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAi/zoZfrPxV5z/dCn5WpwV
 Z8orpsO1f96uZFhmsUmU60zVFDH9H2sZGU5/kMvYMuHA7P23f/TUOTY22ckd6xLOeuX4u7VyP7/
 cRQ4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

During the connection establishment, a peer can tell the other one that
it cannot establish new subflows to the initial IP address and port by
setting the 'C' flag [1]. Doing so makes sense when the sender is behind
a strict NAT, operating behind a legacy Layer 4 load balancer, or using
anycast IP address for example.

When this 'C' flag is set, the path-managers must then not try to
establish new subflows to the other peer's initial IP address and port.
The in-kernel PM has access to this info, but the userspace PM didn't,
not letting the userspace daemon able to respect the RFC8684.

Here are a few fixes related to this 'C' flag (aka 'deny-join-id0'):

- Patch 1: fix a small typo in if-idx type. A fix for v5.10.

- Patch 2: add remote_deny_join_id0 info on passive connections. A fix
  for v5.14.

- Patch 3: let the userspace PM daemon know about the deny_join_id0
  attribute, so when set, it can avoid creating new subflows to the
  initial IP address and port. A fix for v5.19.

- Patch 4: a validation for the previous commit.

- Patch 5: record the deny_join_id0 info when TFO is used. A fix for
  v6.2.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Former patches 4-6 have been already applied
- Former patch 2 has been dropped (Christoph)
- Patch 1 is new, not linked to deny-join-id0
- Patch 3 replaces former patch 2, and was linked to former patch 7, but
  now using 'flags' instead of a new dedicated attribute (Mat)
- Notes: changes for net-next, and the deprecation of server-flags will
  be part of another series.
- Link to v1: https://lore.kernel.org/r/20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org

---
Matthieu Baerts (NGI0) (5):
      mptcp: pm: netlink: fix if-idx type
      mptcp: set remote_deny_join_id0 on SYN recv
      mptcp: pm: nl: announce deny-join-id0 flag
      selftests: mptcp: userspace pm: validate deny-join-id0 flag
      mptcp: tfo: record 'deny join id0' info

 Documentation/netlink/specs/mptcp_pm.yaml         |  4 ++--
 include/uapi/linux/mptcp.h                        |  2 ++
 include/uapi/linux/mptcp_pm.h                     |  4 ++--
 net/mptcp/options.c                               |  6 +++---
 net/mptcp/pm_netlink.c                            |  9 ++++++++-
 net/mptcp/subflow.c                               |  4 ++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  7 +++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 14 +++++++++++---
 8 files changed, 39 insertions(+), 11 deletions(-)
---
base-commit: 12e66f7051b4b535a990cd20c149d76a98ec68c3
change-id: 20250720-mptcp-pm-user-c-flag-a7d5d7a00c6f

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

