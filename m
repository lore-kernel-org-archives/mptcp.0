Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274DE33E9
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 23:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653003043; x=1684539043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fpbu7J+T3sEY5KzKGDHOZcdSlNTcq4FmV5F0zYAzn2c=;
  b=MDoDV3r1VysIGkkrlOd8iEnkSzNhSUhCgZMfAJAbtP/0Lzx6smc3+muB
   nLJHWZkRqU5WdZUPIgWjZdSAoCzXBqUTo5SqVH//hqsALK9vQROtHPtP1
   6328qSI3+bUmfmD2+GOry4oabMPwYCnObd6/j+jshRs3eB4yVnGe3rlE4
   14fvdA0ixZa4aOaMaYQgwBNTv3QR2vuQsGPRzf8wyzupzCNYUy2IPTiIm
   nUNiucUovgka8ED4KnXZwd9EXFrhC8sAUIhfxDePLrTRqdxBtZEKI7jxv
   wyaKeUHLKXmmfSQl+jDYXGBa7BhR+paRiQysPnNCfwjHW0r/I3aWH5T2U
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272381763"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272381763"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 16:30:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="570491195"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.252.132.179])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 16:30:21 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH bpf-next v5 2/7] selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
Date: Thu, 19 May 2022 16:30:11 -0700
Message-Id: <20220519233016.105670-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519233016.105670-1-mathew.j.martineau@linux.intel.com>
References: <20220519233016.105670-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

CONFIG_IKCONFIG_PROC is required by BPF selftests, otherwise we get
errors like this:

 libbpf: failed to open system Kconfig
 libbpf: failed to load object 'kprobe_multi'
 libbpf: failed to load BPF skeleton 'kprobe_multi': -22

It's because /proc/config.gz is opened in bpf_object__read_kconfig_file()
in tools/lib/bpf/libbpf.c:

        file = gzopen("/proc/config.gz", "r");

So this patch enables CONFIG_IKCONFIG and CONFIG_IKCONFIG_PROC in
tools/testing/selftests/bpf/config.

Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/bpf/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 08c6e5a66d87..6840d4625e01 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -54,3 +54,5 @@ CONFIG_NF_DEFRAG_IPV6=y
 CONFIG_NF_CONNTRACK=y
 CONFIG_USERFAULTFD=y
 CONFIG_FPROBE=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
-- 
2.36.1

