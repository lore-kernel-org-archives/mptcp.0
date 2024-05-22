Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2879B9D
	for <mptcp@lists.linux.dev>; Wed, 22 May 2024 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374873; cv=none; b=WQzLp7c0PjXd4cAsNUDmvxUja5CTCjrsklxIDT3zgQXhofts2emzG0ThVccvRJlA9iQI57yL/BMdWN+PsUy7ngbYjXKEpfdeyj9q8ujjiyMx+xMdqcAVPMD26QqDSNg2cSJZRRRAq7VF+7hQvnUbU7Ry12yLhKecRlCPm2VFVJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374873; c=relaxed/simple;
	bh=NYDmmq6YqC7WGOoFSY1cUN1HwKig7pv2e7E6ZNe/QKI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aw+Q+cCs+brKs2hzr5AtLEruNkyB+cMX21LIkMGI4SOSkODUUiFHO+GZsJBw3nx3VgTD6JjVMJfFqbrdPrHZVXChsxo7c76TARkjH+cjuPlz4BddsCNk0PeBGs7yfhxd1KSS3qwyntIlWifKnPQBcA9NVvaT3xb91qzldRh3J/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGMo6MNu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGMo6MNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B469C2BD11;
	Wed, 22 May 2024 10:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716374872;
	bh=NYDmmq6YqC7WGOoFSY1cUN1HwKig7pv2e7E6ZNe/QKI=;
	h=From:Subject:Date:To:Cc:From;
	b=AGMo6MNuLe9Ui4sPyu5M8S9PnOGD2j/o/uwNpWQKR50Haom0rd0oVFq7U/eU8lEu/
	 9vjwUWdDu5KEuAY9KSg+hz1UfRLrah7zh5Zzggm5ZGQcxO1GkSeVI9wuPb7AeJWnn1
	 OtgU2+o6YE0l3YEfQcY04vMbbgaR5dmid5VXP/v+JtvrwcaXAvnziMBKeK6qXYn4VI
	 JAKSYi5n00Szi3i503qVJcbkSHWGRX0wx0TNS/jSLpbwyI9jfkfsJaBtogNe1jz3Xk
	 rhRrdVrdbJwSEAG9VM+iiD4HTLWvqSIRC9WCO5DHgzH+O+PJ8mvlbCEcUHOnKEDo1v
	 o54Bpjq9GrRPA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v3 0/4] selftests: mptcp: mark unstable subtests
 as flaky
Date: Wed, 22 May 2024 12:47:42 +0200
Message-Id: <20240522-selftests-mptcp-disable-flaky-v3-0-a10c68bf2680@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE7NTWYC/43Nyw7CIBAF0F9pWIuZQutr5X8YFzymLSnSBgixa
 frvEtzoSpc3M/fclQT0BgO5VCvxmEwwk8uB7yqiBuF6pEbnTBiwBloGNKDtIoYY6GOOaqbaBCE
 t0s6KcaH8BMf2rA8tcEWyMXvszLP4N/IuOIzknk+DCXHyS1lOdXn4cyTVFCgwZFwKkIrL64jeo
 d1Pvi90Yp9c/YtjmUMp6oZLJYWGL27bthdpwcXbJQEAAA==
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NYDmmq6YqC7WGOoFSY1cUN1HwKig7pv2e7E6ZNe/QKI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmTc1XGILAnCMH/enPQhoMNOSocmIJAV+xYXeLa
 If8oWrRqoKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZk3NVwAKCRD2t4JPQmmg
 c4jPEADo8cEG0gHpxAa884ziCDbLiMuisXx//1o0woDsHSvtTa5/lB+1SblVPNDBJCKsy1eaXNV
 Y+PDhScAVepp1hcNz/nSb4kvJywPIHk9mp7HbPWdMOOfjQPcdFx8ZR0+iPRy9iWl7xLYLeiGnAq
 4gRHAYH/wEm/glXboZHaP5Vh/B50yu6wWcIjatNGWqmSwEjxltPFFwuZC0rGp5dPD4TMI6sHZPb
 mmjycMViCc1TEIgeYJkDSFXEqKqchKMOKP1vus2/znkzb2l73skojB12XGiqMe9VyW9n/q2da+v
 J2oTQlpuieumneOPqmXkmwzXf1c/uJ0Slytn4Glwoxz5ILsbSz0MegtDGOdIimUvr53DtEsvCzE
 nJD55aTgrHMqsj4L6oh8T6T/dMLkDdDZugfXL9SBVlb8LqnMJg1UHyd2rUk0maeMcDW0QeFKknU
 tKzZ+AP1BEHKhSaw7gmQfimtywFBNCUNElU1dE0Xd2wLXyiJQjBY/EFtWzMjZhecbxkFJFvX9ZJ
 h35V+0knXqTERnZUBhgioco2TC0X2IBiVuakZlr2eNJgp5SlRNwSbor6WSEHuR88UEy2W12Aoi3
 8jjl8oLFqjgmADr6UBESBNVPLwTFBpUhkUVdx52ghtYcUA9uHm0TN9cbxdFxpZ0Ed/98/fB+4fR
 ye+USHMuMrjWM9w==
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
Changes in v3:
- Patch 1/4:
  - use SELFTESTS_MPTCP_LIB_OVERRIDE_FLAKY env var (Mat)
  - clearly indicate 'flaky' in the output / TAP format
- Target mptcp-net: these are "fixes" for the selftests. I don't think
  we need to add Fixes tag, right?
- Link to v2: https://lore.kernel.org/r/20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org

Changes in v2:
- Patch 2/4: only mark "unbalanced bwidth" subtest as flaky (Paolo)
- Link to v1: https://lore.kernel.org/r/20240520-selftests-mptcp-disable-flaky-v1-0-02e23ba0bc3b@kernel.org

---
Matthieu Baerts (NGI0) (4):
      selftests: mptcp: lib: support flaky subtests
      selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky
      selftests: mptcp: join: mark 'fastclose' tests as flaky
      selftests: mptcp: join: mark 'fail' tests as flaky

 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 10 +++++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 30 +++++++++++++++++++++--
 tools/testing/selftests/net/mptcp/simult_flows.sh |  6 ++---
 3 files changed, 40 insertions(+), 6 deletions(-)
---
base-commit: d048726b432ccff9b4e3d8b0012a7328c5c7c2f6
change-id: 20240520-selftests-mptcp-disable-flaky-380759d6503c

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

