Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98D2C9D
	for <mptcp@lists.linux.dev>; Fri, 24 Dec 2021 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640340020; x=1671876020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sn9zgDOv7uci6noFgnd4KAaBkeLNUIRege9DyPDdM2U=;
  b=ga2a4XdHGMztHuZBN9R0GmisK8+taNm6PG6VOF8Imc7xZHy27HUc0GYq
   YW5GC45SaVe5ph37EN2SyUlL/unG09hmR8iH+DoQwkMjRJIXPiEKKOEua
   XBrieYR+LPoBLpdJISW5nnl2zWCa3+NF0O1BsnxFdalLomGrt1osZALAw
   U1kbA1Wthr9bvnq3x38/uK8M9mfHq7IiIrzxFuodHRM+xQvuZEnyuABDa
   u50LP4Vy9x7ed3zPU/32LIbn4Q9hRZwHfT8u1FWh3UfY52wv7DjiWeDj/
   fU8JQDg/UCC2ufW0pgkTj3KdTWqe5sWQ6DyuKNJM5NOPg+UeRMlHN7htN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="239745915"
X-IronPort-AV: E=Sophos;i="5.88,232,1635231600"; 
   d="scan'208";a="239745915"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 02:00:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,232,1635231600"; 
   d="scan'208";a="522397580"
Received: from jzhao8-mobl1.ccr.corp.intel.com (HELO mxinjiax-mobl1.ccr.corp.intel.com) ([10.255.28.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 02:00:16 -0800
From: Ma Xinjian <xinjianx.ma@intel.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Philip Li <philip.li@intel.com>,
	kernel test robot <lkp@intel.com>,
	Ma Xinjian <xinjianx.ma@intel.com>
Subject: [PATCH] selftests: mptcp: Remove the deprecated config NFT_COUNTER
Date: Fri, 24 Dec 2021 17:59:28 +0800
Message-Id: <20211224095928.60584-1-xinjianx.ma@intel.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NFT_COUNTER was removed since
390ad4295aa ("netfilter: nf_tables: make counter support built-in")
LKP/0Day will check if all configs listing under selftests are able to
be enabled properly.

For the missing configs, it will report something like:
LKP WARN miss config CONFIG_NFT_COUNTER= of net/mptcp/config

- it's not reasonable to keep the deprecated configs.
- configs under kselftests are recommended by corresponding tests.
So if some configs are missing, it will impact the testing results

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ma Xinjian <xinjianx.ma@intel.com>
---
 tools/testing/selftests/net/mptcp/config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 0faaccd21447..2b82628decb1 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -9,7 +9,6 @@ CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_NETLINK=m
 CONFIG_NF_TABLES=m
-CONFIG_NFT_COUNTER=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NETFILTER_XTABLES=m
 CONFIG_NETFILTER_XT_MATCH_BPF=m
-- 
2.20.1

