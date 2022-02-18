Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C693A4C96
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 22:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645222702; x=1676758702;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sl2Tyk70PJHm8sX1N2keklI0D0yLZDwoqmUOl+0C+uw=;
  b=KM859K2L1bMzHErTtNf6BoDq74dsF9nlaXvyEmlbD3Fosb0c/tH4jhko
   T3HU6pPp558I2fX78Wd/VlxEuD9mJif8DOLyFdCHN9mqI+voeFtN2/l34
   rZQkvSeBrVZ8b4Yo4ZpOGY5g/7LeXpGLkOVf7Lye74ispdf2eKdY66SVA
   dMCJvSGNho1kVYt7fjqJT+Dnemkkrk9cnGyYb9P465cwKw47llfOcyb9j
   E3D2ZKMjKZkZnidvlMjwmomnDSBjOWxlYxwWhq6LoQ9909GyMn+E895JM
   R2sPyvN+5TsUS8w4Dg8Z3N9fk/4XgVo3inbsDseCyk2rS0iX1KzSFEwM7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231857986"
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="231857986"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 14:18:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="542032033"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.65.242])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 14:18:21 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next 0/3] Upstreaming cleanup
Date: Fri, 18 Feb 2022 14:18:11 -0800
Message-Id: <20220218221814.72026-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The most recent patch series I upstreamed for -net needed a couple of
tweaks to mitigate net/net-next merge conflicts. The first two patches
here update the commits in "fixes net" on the export branch to match
what I sent upstream, and the third patch restores Paolo's function
rename in mptcp_join.sh.

Mat Martineau (3):
  Squash to "selftests: mptcp: improve 'fair usage on close' stability"
  Squash to "selftests: mptcp: more robust signal race test"
  selftests: mptcp: Rename wait function

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 -
 1 file changed, 1 deletion(-)


base-commit: d08b615cca7c8389461c7bf83d46ca8bc1fd72db
-- 
2.35.1

