Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7014F5FA
	for <mptcp@lists.linux.dev>; Tue, 21 May 2024 07:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276456; cv=none; b=IeCE61jd3gTTbmEObSaciKUXGPVvDlfxNOQlhC+0UptreTG0vW7X6KMunflPx7J2q1bJBNUfNY2csr8GRcvWsBL+Kb18/2wow7QBnwkR7wFEPDSY1BuYm8UPhUREaCTpBei09t7jxEbAH7DVEvdJta7d2SISke6ESVWfsvWVS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276456; c=relaxed/simple;
	bh=hDfu/49DPbdcGeHStAle9RLe51vq42QcigaMwpgdutY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DFZZs8tEzkiVNc7tGv7ZwfWe8wyYFCszpRQRZj7YE8x3fM1Q/ScYh78MLLgM/04XhP6J8T99/5OvC1wt2bTRcN+XD1rxBZ503FJAlUGiFmJI0ASMhZCNPi/oK5w4B6Lv0ynKfGHeKRMnNwp9NMJDhmoaxxxxVQQIONdNIyfs4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vsh8MSa7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vsh8MSa7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A7AC2BD11;
	Tue, 21 May 2024 07:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716276455;
	bh=hDfu/49DPbdcGeHStAle9RLe51vq42QcigaMwpgdutY=;
	h=From:Subject:Date:To:Cc:From;
	b=Vsh8MSa7y6I+Pk+Jdi8RT1uxOeR/oxFf+H7ZPzAP8MiBlLDakb6YQvwgvN9D3f0tk
	 8nDvxVbB42H5eZ/kR+rlMnkoA9UqRhFF91+4mfz5Af1OKeBjyqnTICheE9VXz1GVLr
	 Z59OaE+30tRwkfhdk9iXxcFs6LrT3K0tOfDSZY22sLK7b7XkHtG3OTKIlaaG4qhxO9
	 HsfdhYSdSM+efkEpIkyTznXJVy/y2jK07lpB9fhgCTQbBz99h9bT1WuB1Wbct2BLML
	 5DCUhyLZ7EIKYPIbMh2Ik0CLOy5HmI20/S6o3uZXwZLdEpbf98o6rVhw279vKt1LKK
	 O5f6LaqQkQHMA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 0/4] selftests: mptcp: mark unstable subtests
 as flaky
Date: Tue, 21 May 2024 09:27:29 +0200
Message-Id: <20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOFMTGYC/42NTQ6DIBCFr2Jm3WlGqP1b9R6NC8BRiRQNEKMx3
 r3EXqDLl/fe920QOViO8Cw2CDzbaEefgzgVYHrlO0bb5AyCxIUqQRjZtYljiviZkpmwsVFpx9g
 6Nawo73SrHs21ImkgM6bArV0O/ht+B89Lgjp3vY1pDOuhnstj8adlLpGQBAupFWkj9Wvg4Nmdx
 9BBve/7F9p6jNPXAAAA
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hDfu/49DPbdcGeHStAle9RLe51vq42QcigaMwpgdutY=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGZMTOagzLOPuYhRWd+xmH/F8l6SCx7PQ7X8meSFwcMWFoJsi
 IkCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJmTEzmAAoJEPa3gk9CaaBzHNIP/jnB
 zfpOB4yjsFV8a5e+p1BlFPN2VFbwj2ZBJLDe4WOZ/cxBJ4fk1i2HbKuRH1C7oNvj+3Y8jFXSoVL
 3nyl+fdYU+OFThBjhEdXDgqchCbtuq430msyjZp+aKIJR8Q0QOu9Z4jj53q+msq3xmtXIJ278PL
 lKWjvuVdBGQ91QXghTGreJdoeQXnrkseneMuco9ACTkNvApOGG4ymiJ03w39vL7WF2YWaSlF5TH
 sriKHkVpzS6Sxrq6G8ThwEc8Oq5sRnSZypPQemToqtTYyj7fCWBH2CmBBngDHbvf+BIvZn9CvHw
 txtCsrzYx2t4UE1Ek1h0kJ2GDJyQYW3sEixOaHikZhr05ilTu4OPvJCEtyNDfqeNA8R60Ydi9ym
 BrIb1UwLui2/KdC8dEfBlMgxnXr9BpZoy97WMhxMWXOvjJXvK2luuFh1IpbR0M8NTsi7V1qnV5y
 RaCqVGbXxtJMtJtPH/jH7GN58tJprlUfRdwut5kxtb7/TA7ARhbo/X54t+VClnyk6pc+MSpqXIz
 +RvJN9Mi5ZjM4us2EpjwJs+9QgHNYe4FPBR6dFjLAvM5+/2joH066oeYq7OiV/Nq69rrGVr6urG
 yyqkBp+MSPoz4Dmhp+hkFqALhyzWebo2l7Jx/tDQI8mrkZ5sR2NXpE+qnpmgi64daNv2ZtrOQ18
 iuqfy
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some subtests can be unstable, failing once every X runs. Fixing them
can take time: there could be an issue in the kernel or in the subtest,
and it is then important to do a proper analysis, not to hide real bugs.

To avoid creating noises on the different CIs, some subtests have been
marked as flaky. As a result, errors with these subtests (if any) are
ignored.

Note that the MPTCP CI will continue to track these flaky subtests. All
these unstable subtests are also tracked by our bug tracker.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 2/4: only mark "unbalanced bwidth" subtest as flaky (Paolo)
- Link to v1: https://lore.kernel.org/r/20240520-selftests-mptcp-disable-flaky-v1-0-02e23ba0bc3b@kernel.org

---
Matthieu Baerts (NGI0) (4):
      selftests: mptcp: lib: support flaky subtests
      selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky
      selftests: mptcp: join: mark 'fastclose' tests as flaky
      selftests: mptcp: join: mark 'fail' tests as flaky

 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 10 +++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 38 +++++++++++++++++------
 tools/testing/selftests/net/mptcp/simult_flows.sh |  6 ++--
 3 files changed, 41 insertions(+), 13 deletions(-)
---
base-commit: 6816c73b882ab90adec3eb18ff296b30bea570b8
change-id: 20240520-selftests-mptcp-disable-flaky-380759d6503c

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

