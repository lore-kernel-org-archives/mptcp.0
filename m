Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972BEEB2
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004126; cv=none; b=DrICaoAgoAN0dnWXLuGXtS3TapzNo3MoscqrxEuEx1tuNZBd0wwTGmHyBnvTpuwKFqBP2Bs8jAXGn5ixFwLE9hKUNLsH9EAM90DCPOrIBHQ28SrBpge6tSqnWiQ0CtKxTU+7WQ7tu1xizrxLe+2LS9v8qgP7SXjJgtjWPmbfLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004126; c=relaxed/simple;
	bh=NvcP0k4GCIhKFS6v3tA4FTqBh7yGpVkpo9m9fU3P3ao=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p+xE66qCS+OysKAdR4yfVcXsEGZWM/DVkkLCELjF8mrwD56slSZAXhemZW9730gDAF3bSMSLyTOrHUlygheuSRNkbiPFGCmWPsBDL1TacnI0S0CCQsP4ntaqeKmes8XKo9u3A+8QxvsgaLUbE88vAGS/Lo8M7vooaFGMi91Rrm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHaKdLCR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHaKdLCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB699C32782;
	Fri, 26 Jul 2024 14:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004125;
	bh=NvcP0k4GCIhKFS6v3tA4FTqBh7yGpVkpo9m9fU3P3ao=;
	h=From:Subject:Date:To:Cc:From;
	b=bHaKdLCRfHhZciM3RpoCjyitXezZ+3k2l2HsKS00pOU5g54hOOZQuvItVlzC+5eDm
	 QXv6mNeKU8flzeA5+cB6bYyYaVEaSYoeeeSaLDuNer2Yu9Gx6Fjm45XJZQW2egHgTu
	 7rdhXKydRL3lw02AkqWtP4Rj8DPdRNiIVGMB1QtP1GB4YFOyprTP0/vH4t3h3086lI
	 P7Wr5JkCebhXgmd14/ZTH/idobheqXUZiwb9ptBl7qBINhwRc8RyUb2eV0tyu9j0q3
	 wCDJiCku3XirmCHmvHZ7kl+c5kTFOodtv0kB8Qoh3qj7bt5rHX3paGbZPaYeSztH+M
	 Bj680r/JxBL2w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v5 00/13] mptcp: fix endpoints with 'signal' and
 'subflow' flags
Date: Fri, 26 Jul 2024 16:28:26 +0200
Message-Id: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIuyo2YC/2XNTQ7CIBAF4KsY1mI6wLTiynsYF6UMStS2oQ3RN
 L27pJr4w/Jl3vdmYgMFTwPbrSYWKPrBd20KuF6x5ly3J+LepsxEIVRRioLf+rHpeX/jdaz9lTs
 kqbEypBSwhPpAzt+XwQN7dVsa2TGdzn4Yu/BYXkVYCu9V+F+NwAtuSi0sktlqg/sLhZaumy6cl
 q0oPr4CzLxI3jUIKI0FV1Lm5bfXmZfJky4NooaGrMy8+vJCZF4lD2icraQluVU/fp7nJy8SW21
 4AQAA
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2812; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NvcP0k4GCIhKFS6v3tA4FTqBh7yGpVkpo9m9fU3P3ao=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo7KbxXn0tXPrLceXK86Yn731I3piK8DtXv/J7
 e24zaR+kNGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqOymwAKCRD2t4JPQmmg
 cyp9D/9/54OyXfib/tZoPgGOvhxUOO4OUvE2ntxBz2lu6GHOjtVIs4VcMZA/yctJOiIcTJpRmmZ
 X3uSQFWeDZsPNjx63Z+G4sOITcBtdbdTcFK86mzkPHY9vvg27XmqyoHhHY4LDQo0rnk1EneEwW1
 Q6yq99se0vwQh253T1VzNYR9yO++oVuMyEONMcGCG+F1TP4fl45BcGg7ffIygWbc0CsVw1iQksB
 Rcxkl6u7/i7UnrbBFdBbrJJMq4A1812BqVfbxgG1n9jL9DtUGzTv7l/BWwdfC3GOUWNy+i02zn3
 FVeoCesXHodpSFC1PG4qf74t9YDTMyvbvR4B/t38HJ6HNBtmTZQQTlxa83vxY8qjTl34WkGCAFS
 a+S6LAbl8JdoOnN8OatT1spfPgmdjAgPCSvhbWctFucz60it2V0mmTeHQrBOTK/5140oKDruFZp
 zL82saN5dQi2bc6HG90/6IA4LMqE0UOmtAY5FrX6joDK/oadcHodv9TLEOe1QrRfpMzH5YLq8yL
 aQRitxp9XHDqVxEVC0BsonQKvheVl87GMakkzK2KDOmEUxLhV6drXdY3zwq72D8uZKAX4L/2YS5
 3KHYa9XPYpoYYNR4WitzILv6hv/u8QNs5pdqkGOdswG+dYykU0Q/6nstzaUujRJ5pbR5iQtsEIM
 V3MoQTrElomC5iw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The first 11 patches have already been applied. Here are the remaining
ones.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v5:
- Split patch 1 (previously 12): the renaming has been done in a
  dedicated patch at the end (patch patch 12), for -next.
- Patch 10: fix typo and avoid memcpy.
- Patch 11: fix comment.
- Patch 13: fix build issue and use a new dedicated struct.
- Please see the individual changelog for more details.
- Link to v4: https://lore.kernel.org/r/20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org

Changes in v4:
- Patch 19: check for msk->first != NULL
- New patches 21-22
- Imported patch 23: might be easier to review all of them, then this
  single one alone, while it depends on the previous ones.
- Link to v3: https://lore.kernel.org/r/20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org

Changes in v3:
- Small changes in patches 10 and 14, see individual changelog (Geliang)
- New patches 18-20: small fixes
- Link to v2: https://lore.kernel.org/r/20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org

Changes in v2:
- Do not split id_avail_bitmap per target in patch 5 (Paolo)
- Explicit deny (patch 2), reduce indentation (patch 3), stop earlier
  (patch 4) (Paolo)
- New fixes and tests (patches 8-17).
- Link to v1: https://lore.kernel.org/r/20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org

---
Matthieu Baerts (NGI0) (13):
      mptcp: pm: re-using ID of unused flushed subflows
      selftests: mptcp: join: test for flush/re-add endpoints
      mptcp: pm: remove mptcp_pm_remove_subflow()
      mptcp: pm: only mark 'subflow' endp as available
      mptcp: pm: only decrement add_addr_accepted for MPJ req
      mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR
      mptcp: pm: only in-kernel cannot have entries with ID 0
      mptcp: pm: fullmesh: select the right ID later
      selftests: mptcp: join: validate fullmesh endp on 1st sf
      mptcp: pm: avoid possible UaF when selecting endp
      mptcp: pm: reuse ID 0 after delete and re-add
      mptcp: pm: rename helpers linked to 'flush'
      mptcp: pm: reduce entries iterations on connect

 net/mptcp/pm.c                                  |  24 ---
 net/mptcp/pm_netlink.c                          | 195 ++++++++++++++----------
 net/mptcp/pm_userspace.c                        |  40 ++---
 net/mptcp/protocol.h                            |  19 +--
 net/mptcp/subflow.c                             |  29 ++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  31 ++++
 6 files changed, 180 insertions(+), 158 deletions(-)
---
base-commit: a9a9b3b154d187864b73eb0e86a0ff737d79a10a
change-id: 20240620-mptcp-pm-avail-f5e3957be441

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

