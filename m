Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7B3DDAE4
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005993; cv=none; b=PoBbygFlQmrTtYSG19QrtFYe+2Dz4UI0cCJ4wfEp1eDwcqyY0QmTMGn1XAC2Kqon/fIfasvg3XxULI88zhG3XDlrfCho/tCna1hAP4slme4nn6a58VAkiHHaNb1hrGog5rBEmeC26t60NIh2PzgPTBLYOiHpzzbBCqOzdrbBEBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005993; c=relaxed/simple;
	bh=UrpNBpDaDfJ75UtE1w0uMsDyBUYjVyqXpfXuURcBuzs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lMzCW1aKO0I0qIuCX4icpqf9HN94QtI4ur31Z9tf7D+LtE2HkpDG5I5bBK0YXqaOzBNLvOgiZukQY5OjhEuxG9AwVzJMKbvhQLeUA/NQL1lJXU+ZL+SEibCKHoJaIteyIzFwyKbx6yH9po+25vvuHd4PiXv612QzOi7zZF7O2OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1a4+iRM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1a4+iRM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82521F000E9;
	Thu,  6 Aug 2026 08:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786005991;
	bh=ed8uykDcWG5yd3xgy6yq1x+9bOT97EnIWZlr1gK31Hs=;
	h=From:Subject:Date:To:Cc;
	b=U1a4+iRMAo1XmbRaIXg5NjDcaFsQ74NzL6VTDmqgqLNCvdXZ6hiE8FwHkGThACWTp
	 pXEBxOkClEsZK+oamWT/Fb+mbkjONHAbJUdEiwodkq5BuVsMtG2+2TpjmvVd/ft5IQ
	 VhpjWMvYMag4U0eB6D5Tvc6M//7NzAP1FZpO0IOzwZXhMe9oaWjJ9F3w5GSw7mQqvX
	 /WAnzwr43we5okNCVfZMeVnvmb2SIashV9nNcEibDXaL7g+pMMpXlv6pJUgxya9+oC
	 Xm/EdHghz9icYhMW+d4OEL/L+sol0A/nVddT5mt0LkBmHZM7hhKCCTBHSoPNLnjb8J
	 AuFW9NzAV1Cew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/6] mptcp: pm: userspace: properly deal with
 the ID0 case
Date: Thu, 06 Aug 2026 10:46:17 +0200
Message-Id: <20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OQQ6DIBBFr2JmXRokBLSr3qNxgXRQ2ooE0LQx3
 r2oXXf5M/+9PwtEDBYjXIoFAs422tHlwE4F6F65Dom95wyMMkEl42TwSXviBzJlMnqltwYlWkU
 khkpuBOdC6AqywQc09r3bb3CADhM0xylO7QN12uxbubcxjeGzfzKXO/IblX9H55JQUldSGspU3
 Sq8PjE4fJ3H0EGzrusXwsWvxuQAAAA=
X-Change-ID: 20260724-mptcp-pm-userspace-id0-case-f074f64466c8
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=UrpNBpDaDfJ75UtE1w0uMsDyBUYjVyqXpfXuURcBuzs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKPO93T5LeenTui5O2dvfuvCr/KlC6bB1b40zFvZrmn
 2qFLhQldJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzEkJnhn4GpQRDjPNfl0pO0
 n2W9tt/+5uGpV8p1sjbPTqT8NIxlX8LIcMo1u+7/pp9Pz188tmTOFsvVBc9KCv+uEfEPSXhlbvL
 rKi8A
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
Changes in v2:
- patch 1: commit msg + local_addr_used and needs_id exceptions
- patch 2: commit msg
- Link to v1: https://patch.msgid.link/20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org

---
Matthieu Baerts (NGI0) (6):
      mptcp: pm: userspace: properly handle the ID0 case
      mptcp: pm: userspace: allow announcing ID0 addr
      mptcp: pm: userspace: no ID0 exception for RM_ADDR
      mptcp: pm: userspace: don't dump initial ID0
      selftests: mptcp: join: new ID0 subflow from the right IP
      mptcp: pm: restrict in-kernel worker actions to this PM

 net/mptcp/pm.c                                  |  8 ++-
 net/mptcp/pm_userspace.c                        | 91 ++++++++++++-------------
 net/mptcp/protocol.h                            |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  7 +-
 4 files changed, 55 insertions(+), 52 deletions(-)
---
base-commit: 0715f5ba093a581def25b88da61c987b1719bc6d
change-id: 20260724-mptcp-pm-userspace-id0-case-f074f64466c8

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

