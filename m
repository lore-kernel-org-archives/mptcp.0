Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2270A3238
	for <mptcp@lists.linux.dev>; Fri,  8 Jul 2022 17:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657300460; x=1688836460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dDFcKsL9kB1Uqm+n86u6isMH3J6Z2PbdfW1/uIBATOc=;
  b=n+P8dGIefs65IFTfPn9M4TeBwe+DcU5gbdwD/JU4wY8o/SM8lp7tUGQo
   C4bLodU7WPdK9Au7G8hfZMPgJ8z2B1xSNdX1p/5enC2TKrCNtF64uoi6a
   ky0jWZc3wRp8SdI0Aq0sqQKWMey49mX5dNI4X1cCZN7wWk2zkJnfeY6nL
   xz9glcT2OXmyP8t40YXxeBZ6rIGnQwzUdeRQtNu9BT+BOoyPy175PYoO3
   gxQyWY0QikvdEk/ygzzJYeydI2oPfsYvtx2F/LVsKhg1icGpxcPRIACbG
   DmCiFQgwy/5IvHg52GkXqBLB5t5T2pVvQvON7nrMxsUwZCxEAdkOd5QZr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="285069095"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="285069095"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 10:14:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="651641498"
Received: from aroras-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.1.203])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 10:14:18 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/6] selftests: mptcp: tweak simult_flows for debug kernels
Date: Fri,  8 Jul 2022 10:14:09 -0700
Message-Id: <20220708171413.327112-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220708171413.327112-1-mathew.j.martineau@linux.intel.com>
References: <20220708171413.327112-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The mentioned test measures the transfer run-time to verify
that the user-space program is able to use the full aggregate B/W.

Even on (virtual) link-speed-bound tests, debug kernel can slow
down the transfer enough to cause sporadic test failures.

Instead of unconditionally raising the maximum allowed run-time,
tweak when the running kernel is a debug one, and use some simple/
rough heuristic to guess such scenarios.

Note: this intentionally avoids looking for /boot/config-<version> as
the latter file is not always available in our reference CI
environments.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Co-developed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index f441ff7904fc..ffa13a957a36 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -12,6 +12,7 @@ timeout_test=$((timeout_poll * 2 + 1))
 test_cnt=1
 ret=0
 bail=0
+slack=50
 
 usage() {
 	echo "Usage: $0 [ -b ] [ -c ] [ -d ]"
@@ -52,6 +53,7 @@ setup()
 	cout=$(mktemp)
 	capout=$(mktemp)
 	size=$((2 * 2048 * 4096))
+
 	dd if=/dev/zero of=$small bs=4096 count=20 >/dev/null 2>&1
 	dd if=/dev/zero of=$large bs=4096 count=$((size / 4096)) >/dev/null 2>&1
 
@@ -104,6 +106,16 @@ setup()
 	ip -net "$ns3" route add default via dead:beef:3::2
 
 	ip netns exec "$ns3" ./pm_nl_ctl limits 1 1
+
+	# debug build can slow down measurably the test program
+	# we use quite tight time limit on the run-time, to ensure
+	# maximum B/W usage.
+	# Use kmemleak/lockdep/kasan/prove_locking presence as a rough
+	# estimate for this being a debug kernel and increase the
+	# maximum run-time accordingly. Observed run times for CI builds
+	# running selftests, including kbuild, were used to determine the
+	# amount of time to add.
+	grep -q ' kmemleak_init$\| lockdep_init$\| kasan_init$\| prove_locking$' /proc/kallsyms && slack=$((slack+550))
 }
 
 # $1: ns, $2: port
@@ -241,7 +253,7 @@ run_test()
 
 	# mptcp_connect will do some sleeps to allow the mp_join handshake
 	# completion (see mptcp_connect): 200ms on each side, add some slack
-	time=$((time + 450))
+	time=$((time + 400 + slack))
 
 	printf "%-60s" "$msg"
 	do_transfer $small $large $time
-- 
2.37.0

