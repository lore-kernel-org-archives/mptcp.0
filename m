Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1852F27
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 01:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643850232; x=1675386232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lx38d9fhYiCL1gyKi+5TqLDwjarXqB2FJolRnno2uwY=;
  b=F1hwAjsIJ8huaKGwpbc8i09QewFL96AXS7nBdt1lWeS1BNHKe7n3F7fx
   5vPXs+mYNOTMdPGQS52DnTWrvvmjdcjxZo2bZuFKnj+/SdBHRQfF7iByR
   a5NIXXWkh+2igh3v+KQBcmcS3ETZyPNyYb6xyjl2pAm0nVPVAAzJEqlr6
   BmxUk8twJPKFN78xlq9JtEZVBNFmiOtt8hxfqA5vzJTld8h0XJrTBpR9K
   IrKtS7vNkrAdBYJs5zm3i/EBRxCYhwRbpAK0S9Opk15is63dQYgHqXUiR
   F7eCxSDWeudFAQx70DYK0nDdRGVLYyT4gz4UW5r46U4jT362AKlswNn3T
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228023384"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="228023384"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 17:03:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="483070830"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.1.6])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 17:03:48 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/7] mptcp: clarify when options can be used
Date: Wed,  2 Feb 2022 17:03:39 -0800
Message-Id: <20220203010343.113421-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203010343.113421-1-mathew.j.martineau@linux.intel.com>
References: <20220203010343.113421-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

RFC8684 doesn't seem to clearly specify which MPTCP options can be used
together.

Some options are mutually exclusive -- e.g. MP_CAPABLE and MP_JOIN --,
some can be used together -- e.g. DSS + MP_PRIO --, some can but we
prefer not to -- e.g. DSS + ADD_ADDR -- and some have to be used
together at some points -- e.g. MP_FAIL and DSS.

We need to clarify this as a base before allowing other modifications.

For example, does it make sense to send a RM_ADDR with an MPC or MPJ?
This remains open for possible future discussions.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ab054c389a5f..7345f28f3de1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1267,8 +1267,27 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 	const struct sock *ssk = (const struct sock *)tp;
 	struct mptcp_subflow_context *subflow;
 
-	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
-	 * see mptcp_established_options*()
+	/* Which options can be used together?
+	 *
+	 * X: mutually exclusive
+	 * O: often used together
+	 * C: can be used together in some cases
+	 * P: could be used together but we prefer not to (optimisations)
+	 *
+	 *  Opt: | MPC  | MPJ  | DSS  | ADD  |  RM  | PRIO | FAIL |  FC  |
+	 * ------|------|------|------|------|------|------|------|------|
+	 *  MPC  |------|------|------|------|------|------|------|------|
+	 *  MPJ  |  X   |------|------|------|------|------|------|------|
+	 *  DSS  |  X   |  X   |------|------|------|------|------|------|
+	 *  ADD  |  X   |  X   |  P   |------|------|------|------|------|
+	 *  RM   |  C   |  C   |  C   |  P   |------|------|------|------|
+	 *  PRIO |  X   |  C   |  C   |  C   |  C   |------|------|------|
+	 *  FAIL |  X   |  X   |  C   |  X   |  X   |  X   |------|------|
+	 *  FC   |  X   |  X   |  X   |  X   |  X   |  X   |  X   |------|
+	 *  RST  |  X   |  X   |  X   |  X   |  X   |  X   |  O   |  O   |
+	 * ------|------|------|------|------|------|------|------|------|
+	 *
+	 * The same applies in mptcp_established_options() function.
 	 */
 	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
 		struct mptcp_ext *mpext = &opts->ext_copy;
-- 
2.35.1

