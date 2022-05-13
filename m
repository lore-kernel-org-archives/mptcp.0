Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03892586
	for <mptcp@lists.linux.dev>; Fri, 13 May 2022 22:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652482116; x=1684018116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fpbu7J+T3sEY5KzKGDHOZcdSlNTcq4FmV5F0zYAzn2c=;
  b=iWGTzy4wIOkzXUIAPHxhoEzF4Tfd5Q9irKEpB+sPYtNVXE6bNwEXkBRI
   mLwHRWwUTy2MFDuLm4wP18k0/kWVhUMw9KCeehI2VF23PjtzSra2fSohJ
   uOYy1vvcfd3E0gJ+h0s3BIEj29ZQ5hy/TT0t/rGRgFkexsTBbwFtxOoX7
   tobVHnAu40NhQsrYUimWVxH/d6qX/tqel07m5XdtSBLt/tgaU48f4TeQ5
   XPLuzXo7BXeXHRf7OaDcREEWzWVVbJvldNXK/t6JHMYAIO34mMebXC22r
   8NIlm83whKkkiIVzqEJwvTjEXXW+bKOhIv6m2EBt5Im9LNXG9veJJVhhW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="333462011"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="333462011"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 15:48:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="815588248"
Received: from clakshma-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.160.121])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 15:48:33 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH bpf-next v4 2/7] selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
Date: Fri, 13 May 2022 15:48:22 -0700
Message-Id: <20220513224827.662254-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220513224827.662254-1-mathew.j.martineau@linux.intel.com>
References: <20220513224827.662254-1-mathew.j.martineau@linux.intel.com>
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

