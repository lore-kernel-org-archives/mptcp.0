Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C73D668F
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092122; cv=none; b=PNhToc2OkxrJqCef8bwJQoiHpTTioPJBIo3ZeyaAZgwMUqeUXw/Eh1RxPJJfmf+dzC1PB3S3aNt02Moye0aTOniZ97wOYIC3tFkvWwnnXYWOP8bS9PGAf/byoKe9BWiUfd4I19uZAYY1+HejegH7wszMz5PaXGZ3VsD3nJQeq2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092122; c=relaxed/simple;
	bh=MldRfCaEdwL/qZxtVJffCxib+1lvxI5sEu/x7uz/N58=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iPIr/XYWvzL8YbJeeNN/E9kaSq8kJEviHSQbZ8ezxj9+QF6x3A0hbT58xT7h6Y4VXPxRlkTTq79x9vSzlqPLlgu39TNmMHbBnKjD0kYfT45p5nU50iQFIzVDQXzOZuVRYyIu0wCEO1u/aEZoDNOqSVx9QkopSQewaxGb2XxaK38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOm4rEXM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOm4rEXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BCF1F000E9;
	Fri,  7 Aug 2026 08:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092120;
	bh=pa80ex66OydzM7t7btQXjuQCDCF8AXIfQ261kLgx6y0=;
	h=From:Subject:Date:To:Cc;
	b=ZOm4rEXMA9AlXZM4qtq6M+XUFRm6cHv7UQkik7ihMSlgitMIOOU6RQ5tVoP+gHeQv
	 JgHFEZiSXWQx2/Jdv50GLYGmx6wTPMdciMSViWEx4+3tm93IJ1N5z6LKJbEDLfX2F0
	 yDvDR+UKBEuSF83htZdNpixRdlnNplxlOSabUvu2zeYkB6LlSmXJTBqoF5WityBZkl
	 PcWiai2P6n0Sib29txMKVVFJtVzyOEK1ViXeid5VEfMobFtTpcZtp8xI28lQjibTZl
	 POy79y39abifUnJb9g65Qlyp4ZwHujykumEqmQh19Upxc4jieWD2op1/mHBtXxXPHy
	 cVzDiDhmBP7sw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v3 0/8] mptcp: pm: userspace: properly deal with
 the ID0 case
Date: Fri, 07 Aug 2026 10:41:47 +0200
Message-Id: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32O0Q6CIBSGX8VxHQ3JALvqPVoXSAelEhmgqznfP
 dS21o2X/87/ff8ZUQBvIKBTNiIPgwmmsykcdhlSjbQ1YHNLGVFCGeG0wK2LymHX4j6RwUk1Nwh
 WMgDWhBeaFQVjSqBkcB60eS32C1pBCxFd11PoqzuoONvncmNC7Px7+WTIF+Q7yjdHhxwTXArON
 aGyrCScH+AtPPedr5epgf5kgrBtGU0yDTIXRECujvxPNk3TB8KEiU8xAQAA
X-Change-ID: 20260724-mptcp-pm-userspace-id0-case-f074f64466c8
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MldRfCaEdwL/qZxtVJffCxib+1lvxI5sEu/x7uz/N58=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKZwU8LPQ+mehS1HWPV+7jFKXd12Obsv+e8/i8VHJu+
 TOz8uNxHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPpbmFkmMXLNj9u24ZdWuXM
 dvFSBY/TPrVrx8cxJLqLPTH8v8+/jJFhAp9qYxTXB7tTt75fCD7jcmD152U9ZY48cyOaGcret5S
 zAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In MPTCP, the local address and port used by the initial subflow has the
ID "0". It means that when this address and port are used for some
operations -- e.g. creating a new subflow -- they should be linked to
the ID0, and no other addresses and ports can get this special ID while
the initial IP address and port is used.

Instead of dealing with the ID0 case as an exception, add it to the
local addr list, and deal with it like the others, with minor
exceptions. That way, it seems easier to maintain instead of adding new
exceptions at a few places, at the cost of a few more bytes, which seems
OK in this mode.

The first patch modifies add the initial address to the list, and the
others remove exceptions, and validate that in the selftests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- patch 1: split exceptions + set msk port to 0 like before this series
- patches 2-3: new: from patch 1 + fix
- patch 6: use new is_init_id0 helper
- patch 8: avoid conflicts with WIP BPF MPTCP PM patches
- Link to v2: https://patch.msgid.link/20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org

Changes in v2:
- patch 1: commit msg + local_addr_used and needs_id exceptions
- patch 2: commit msg
- Link to v1: https://patch.msgid.link/20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org

---
Matthieu Baerts (NGI0) (8):
      mptcp: pm: userspace: properly handle the ID0 case
      mptcp: pm: userspace: lookup: match port in priority
      mptcp: pm: userspace: ID0 is not part of local_addr_used
      mptcp: pm: userspace: allow announcing ID0 addr
      mptcp: pm: userspace: no ID0 exception for RM_ADDR
      mptcp: pm: userspace: don't dump initial ID0
      selftests: mptcp: join: new ID0 subflow from the right IP
      mptcp: pm: restrict in-kernel worker actions to this PM

 net/mptcp/pm.c                                  |  8 ++-
 net/mptcp/pm_userspace.c                        | 93 +++++++++++++------------
 net/mptcp/protocol.h                            |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  7 +-
 4 files changed, 59 insertions(+), 50 deletions(-)
---
base-commit: 5cb376373d7f0915c9c2dc6648631bb54ab7a6cb
change-id: 20260724-mptcp-pm-userspace-id0-case-f074f64466c8

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

