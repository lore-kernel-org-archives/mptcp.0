Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DC92C80
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 22:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641506806; x=1673042806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=byM8QVPpbwIKbaJxlpVhaFNX3ZO8Mil0UItZLC5oa4M=;
  b=cy9NGjOmS4YZ208fBZVdmOb7QUbNRa5Oaef4fZRVnJQxkhNQx0DNQQes
   pMI31kbPf2+Q7f2vLa00Q1wvzKlRRB9ZWlPmZgViTYV/1Ot5aAboWy0WM
   I0hY2xZvGtqo/V+zR7UHYmINMHTzNCvs+fDac8oXtf9/CM/d7l/FIFv46
   q7fFmLyRsJIe06RX66ky9Fr+ghXENXhPHMA3bGPxuZOcG8TSQedRc7cN3
   0KW00bOyanyKXTbhFq/ddaWppDadwDRBTAeS5QrQ7Uvmzt4GItazCn/3t
   UefkjbFP1O7qzXGZXWa9SdzXCJdxp8ZSsPL4u+QPb4B4vTlh7NsQrbO1Y
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240303707"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="240303707"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 14:06:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="618479813"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.94.200])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 14:06:43 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	geliang.tang@suse.com,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 1/3] mptcp: fix opt size when sending DSS + MP_FAIL
Date: Thu,  6 Jan 2022 14:06:36 -0800
Message-Id: <20220106220638.305287-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106220638.305287-1-mathew.j.martineau@linux.intel.com>
References: <20220106220638.305287-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

When these two options had to be sent -- which is not common -- the DSS
size was not being taken into account in the remaining size.

Additionally in this situation, the reported size was only the one of
the MP_FAIL which can cause issue if at the end, we need to write more
in the TCP options than previously said.

Here we use a dedicated variable for MP_FAIL size to keep the
WARN_ON_ONCE() just after.

Fixes: c25aeb4e0953 ("mptcp: MP_FAIL suboption sending")
Acked-and-tested-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index fe98e4f475ba..96c6efdd48bc 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -821,10 +821,13 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, remaining, opts))
 		ret = true;
 	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts)) {
+		unsigned int mp_fail_size;
+
 		ret = true;
-		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
-			*size += opt_size;
-			remaining -= opt_size;
+		if (mptcp_established_options_mp_fail(sk, &mp_fail_size,
+						      remaining - opt_size, opts)) {
+			*size += opt_size + mp_fail_size;
+			remaining -= opt_size - mp_fail_size;
 			return true;
 		}
 	}
-- 
2.34.1

