Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A7917C7F
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 07:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069344; cv=none; b=uQbOAp+RaYA7Kz6Ypr9u5pmFMnoix2HEhgTvC2PBUx3ljdRbcTfR88USB/v6ZJypNGmRJgKhY69giCJHmc/rXT5Mp2xSALodAe3IYTHvc2Em4xcfSFFLSY4YOzLK9oLnJm4DdwdFF25XPFgh2qyd9j+1k5KqPFZtdUiQbWWLLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069344; c=relaxed/simple;
	bh=GLK3k8eZ/bW2s0dXIroRP6009usq+DFrndj6i+na0b8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bKZ5nc4QJoyZq9RJZknQcIRHmK3QB8kHRDwAtod4/ATdptE+9wZNruPLMShHLnRwkPjgw8ISwJHFQcE0YpWVoOnpOZf22b+dtMkkbWEtUDDLbujSlAbJkfy1cWqGJ1f28kJJxJ8UbP65nAmgExyfobuh1mrWTbQgLG4PeQkFQeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne2TmCNY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne2TmCNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D94C433C7;
	Fri, 16 Feb 2024 07:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708069343;
	bh=GLK3k8eZ/bW2s0dXIroRP6009usq+DFrndj6i+na0b8=;
	h=From:To:Cc:Subject:Date:From;
	b=ne2TmCNY9qiT/iZ/Fe5JQKLUYMz8pKllBfkiW0B+7p3tuY99zWtjA+kLCHn7bnMRT
	 zJNib9qmkmJHe9kpqySaDny52Dufu5KnwdmgP6uRRCN6Y3/YidRHI2EoNzhpgSrakz
	 iA9u5rPh4MHtx8bjE51LnwFlok7HZ04HanN0qy8u1tqaI5G1RiD/hzz/7wafsbq/Ve
	 50sZTlQRaIZoYj5l35cv2nowSPb0C2/V8C/WBo9b7ZZ3Amp3U3ejtSZCi76kRf2ZM1
	 WF/BnjKTShcYKgPcc4nkA2i+BlMfnoS8BvHvtbuZzzTtghhoQnqR6qQE5ktRDckloH
	 zqxBp1/k5SLEw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 00/14] dump for userspace pm
Date: Fri, 16 Feb 2024 15:42:02 +0800
Message-Id: <cover.1708069036.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v13:
 - fix the typo in patch #3.
 - add 'mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"' checks.
 - add 'mptcp_lib_kallsyms_has "mptcp_userspace_pm_get_addr$"' checks.
 - drop "userspace pm dump address/subflow" tests, test it in "userspace
   pm add & remove address" and "userspace pm create destroy subflow"
   tests instead.

v12:
 - rebased on export/20240214T102432

v11:
 - update patch 5 as Mat suggested.
 - depends on "fixes for userspace PM" series.

v10:
 - fix a checkpatch.sh warning reported by CI.
 - fix build warnings reported by kernel test robot <lkp@intel.com>.

v9:
 - add missing "sock_put(sk)" in patch 7, 17 and 21 to fix the "kmemleak"
   errors reported by CI.
 - rename the helper to mptcp_pm_has_addr_attr_id.
 - use my new mail address.

v8:
 - Address Mat's comments in v7

v7:
 - fix checkpatch.sh warning reported by CI.
 - fix build errors reported by CI.

v6:
 - patches 1-5, fixes for -net
 - patches 6, 15, selftests for "fixes for -net".
 - patches 7-14, 16-21, update "dump for userspace pm v5"
 - patches 22, 23, cleanups for set_flags
 - patch 24, flush selftest.

v5:
 - patch 2, save bitmap instead of id.
 - patch 3, drop token in reply.
 - update patch 4 and patch 12, add mptcp_pm_dump_addr and
   mptcp_pm_get_addr wrappers in pm.c

v4:
 - update patch 2, patch 3 and patch 12.
 - fix the warnings reported by CI in v3.

v3:
 - fix the errors reported by CI in v2.
 - drop mptcp_pm_nl_put_entry_msg and mptcp_pm_nl_put_entry_info
   helpers.

v2:
Address Mat's comments in v1:
 - patch 2: pass token to dump_addr too.
 - patch 2: add back id in mptcp_userspace_pm_dump_addr().
 - patch 5: update mptcp.yaml

v1:
Address Mat's comments in "userspace pm enhancements" v14.

Geliang Tang (14):
  mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
  mptcp: implement mptcp_userspace_pm_dump_addr
  mptcp: add token for get-addr in yaml
  mptcp: dump addrs in userspace pm list
  mptcp: check userspace pm flags
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: add token for dump_addr
  selftests: mptcp: add check_output helper
  selftests: mptcp: dump userspace addrs list
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: implement mptcp_userspace_pm_get_addr
  mptcp: get addr in userspace pm list
  selftests: mptcp: add token for get_addr
  selftests: mptcp: userspace pm get addr tests

 Documentation/netlink/specs/mptcp_pm.yaml     |   3 +-
 net/mptcp/mptcp_pm_gen.c                      |   7 +-
 net/mptcp/mptcp_pm_gen.h                      |   2 +-
 net/mptcp/pm.c                                |  16 ++
 net/mptcp/pm_netlink.c                        |  26 ++-
 net/mptcp/pm_userspace.c                      | 177 ++++++++++++++++--
 net/mptcp/protocol.h                          |  13 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh |  93 +++++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  39 +++-
 9 files changed, 344 insertions(+), 32 deletions(-)

-- 
2.40.1

