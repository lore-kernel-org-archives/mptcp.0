Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45E13B792
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807524; cv=none; b=KIE40OfoWVRMI1nrYPlFkBvwlyGFir4UEoudt3bZ2NpZYxaIEvljP3xPXnsWVobdu+rLMJB42pB7RXwqPtYMX8/Wd0wGLwdtAbwAGVl9IZZGGZYC48HzygsPrPayjEXWfo2VG6tpeSJyZyV9/uItXyocwpMdrqRYZpDweR2S2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807524; c=relaxed/simple;
	bh=1am+ZyeiTDbOL+7LbepMkGS/qKilpk53vooTbjaijrc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M73DpUxdJUbuSSNKiUcT14URZv/M6HsVgLtzzlbzQj3it1HM16LOCWw8ZeZ4zB7o/mtqViDiFqtIUW8rFhr52f5FE2+g7d+opzVNJEPkCZfI1TRATyTll33KJ/+uIxscEnifBguO1XijnrVMnUKcxaZT4G+GLMV9VabV1YihX4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3eHI/B9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3eHI/B9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06100C2BBFC;
	Mon, 27 May 2024 10:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716807523;
	bh=1am+ZyeiTDbOL+7LbepMkGS/qKilpk53vooTbjaijrc=;
	h=From:Subject:Date:To:Cc:From;
	b=g3eHI/B9ysNrjpKUvee0bfgh4zuGy3/e/lIni9qP6i7GX/uEJzrVVRWYNeW6E1dJl
	 3J7L0cYENCsSkC8xKuqZ0WFubgVCuIUpQZo4N0kn3yumJAnvCLSJe74ai3J7fLmM1b
	 4U1CqoATxvsZkKuikjgOelplPCZ1XvU1AFy61CB36Z2QTVl2nJoLR5ZItFtjsdEDei
	 i+zvufQA/lRWrXjhxW7wo3/FCIRkx7wg/cx2JZrnOJF0aznQL2oocJK13POrIiu0L8
	 xC+oYZjdzEzhEToTKvwePAka8G0UvtiDAaKkg4P+o2Uj+Pf/LxPGXVov1pRdQALCNu
	 y23dZtuCrJgtg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v6 0/9] use helpers in lib.sh and net_helpers.sh
Date: Mon, 27 May 2024 12:58:27 +0200
Message-Id: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFRnVGYC/4WNQQ6CMBBFr2Jm7ZhaKBRX3sOwoDDARCyk0xAM4
 e42XMDlz/vv/x2EApPA47JDoJWFZ59Ccb1AOzZ+IOQuZdBK58roHIWmPpJEQU8RJ3bY80aCpim
 Vs13mrLaQ7CXQCZL8gs8S2yUJW4Q6sZElzuF7nq7mbPzdXw0qdBWpqrCmvDfZ803B03SbwwD1c
 Rw/NVy6w8sAAAA=
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2535; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1am+ZyeiTDbOL+7LbepMkGS/qKilpk53vooTbjaijrc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVGdhIZoEgG+S7e4fAal3XgEyW16bG88gkmN0a
 ugTq4uPYjKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlRnYQAKCRD2t4JPQmmg
 c+sWEAClaRjSIvh+103TUqDql5xhUoFMBGeWVIPV2bcGpDo90hBTz++LntX9/Ej8YTl4rvyouK8
 bzTBhq2wUd+kiBTaAP8yalaUd7gPn3aFOdjezRZyg2C4tD4VG2r9UnvzWFcyY8NYM168FKWcCJg
 V0WP9kUGGx8SqvnwtujxrtnSTwbSP1C+26hyQGZvgQsek4v0ltaHkZb6mPTCXouuQ0S1B9B/DOw
 3W6CEW1VcENnOEXr4tsk3TJ+4lXvy3gEihPkn1gk3arWjjnGippV2KHUPTc9SSGVTOKxvJbJxbz
 zF3175iKgjRZGDKEtVna2D1wxGlM0c8HfPzletd0laGzvn9RZPjXC5U8pgEZzulCAWvxNRFULQt
 Tt1sgQlDEMC36tWrmW8I4bctNXV6MC1kDV/KLhcAfMoq1BFSsHpSALJJ78ftpyVL+u0nMT12yKo
 RdNVe31IimY3yI83hTE/cF1lsrDe128bcH/6fHYNf2JNLQuMdsYRQqAPHHQLDKUj3hKYeoComoG
 gO2I6m5gnjONsbtHgyGhN+PBUG70V1RV7KEedYIErx27vTn0BKy0V4eZu55d5Wja5uAeuN0KACG
 BjHpCKF7ECc8qmXgXYSNPvz/79Zmn/7x6AXZA+eiv8+D5YUhRG43F4nSZTEseXwgtSKeko8D49h
 tvSfuCCMGIGs01g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

(This is a new version for the series created by Geliang. @Geliang: I
 hope that's OK for you like that, it was easier to describing the
 modifications by email. I validated my changes by running MPTCP
 selftests only)

This set uses the public helpers defined in net selftests to replace
helpers in mptcp_lib.sh.

v6:
 - Replace "rename ns in setup_ns" by "remove 'ns' var in setup_ns": we
   don't need it, avoid extra conflicts.

v5: (Matt)
 - New patches: 1-6: some unrelated fixes, some modifications to avoid
   adding workaround on our side (changing variable names, trap, etc.)
 - "rename ns in setup_ns": drop the modifications in cleanup_ns, exit
   in case of error, and updated commit message.
 - Drop patches 2, 4, 5/6 from v4.

v4:
 - two more fixes added
 - exit when setup_ns fails in mptcp_lib_ns_init

v3:
 - address Matt's comments in v2 (thanks, it's very useful.)
 - don't rename ns in diag.sh, but in lib.sh
 - ns in get_counter needs to be renamed too
 - add a ns_name valid check in setup_ns
 - drop $NS_LIST in mptcp_lib_ns_init
 - don't drop mptcp_lib_ns_init, use cleanup_ns in it
 - don't use cleanup_all_ns, still use mptcp_lib_ns_init

v2:
 - only patch 3 updated, mptcp_join.sh, move cleanup_all_ns from
   cleanup_partial to cleanup, setup_ns will delete existing
   namespaces automatically.
 - update commit logs.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v6:
- Link to v5: https://lore.kernel.org/r/20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org

---
Geliang Tang (3):
      selftests: net: lib: remove 'ns' var in setup_ns
      selftests: mptcp: lib: use setup/cleanup_ns helpers
      selftests: mptcp: lib: use wait_local_port_listen helper

Matthieu Baerts (NGI0) (6):
      selftests: net: lib: set 'i' as local
      selftests: net: lib: support errexit with busywait
      selftests: net: lib: avoid error removing empty netns name
      selftests: net: lib: ignore possible error
      selftests: net: lib: remove ns from list after clean-up
      selftests: net: lib: do not set ns var as readonly

 tools/testing/selftests/net/lib.sh             | 71 +++++++++++++++-----------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 33 ++++--------
 2 files changed, 50 insertions(+), 54 deletions(-)
---
base-commit: 55aceb609c1baec3e762e938e2028df7ecd545e1
change-id: 20240524-selftests-net-lib-fixes-5a70b8d3b828

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

