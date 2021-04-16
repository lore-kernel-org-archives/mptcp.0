Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EF02F85
	for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 22:38:19 +0000 (UTC)
IronPort-SDR: wv1L9IeMAARo+kZST0OK67flyrFdj/Sintm7eyoVJwAZNIEKuMARLVDJPs6tV6Q/jLc4O9k7au
 vxYErRf8sk8Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="175231657"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="175231657"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 15:38:17 -0700
IronPort-SDR: XmOvRnkwKhDW35UmaC5j6aNfDVotorvqye6LU5Dc3z//0QYFw1nBaeoUvSswXAYl9pc7+eIwD6
 jgTgiQiv6pIg==
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="462107387"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.43.70])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 15:38:17 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Nico Pache <npache@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	David Gow <davidgow@google.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/8] kunit: mptcp: adhere to KUNIT formatting standard
Date: Fri, 16 Apr 2021 15:38:01 -0700
Message-Id: <20210416223808.298842-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416223808.298842-1-mathew.j.martineau@linux.intel.com>
References: <20210416223808.298842-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nico Pache <npache@redhat.com>

Drop 'S' from end of CONFIG_MPTCP_KUNIT_TESTS in order to adhere to the
KUNIT *_KUNIT_TEST config name format.

Fixes: a00a582203db (mptcp: move crypto test to KUNIT)
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Nico Pache <npache@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/Kconfig  | 2 +-
 net/mptcp/Makefile | 2 +-
 net/mptcp/crypto.c | 2 +-
 net/mptcp/token.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index a014149aa323..20328920f6ed 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -22,7 +22,7 @@ config MPTCP_IPV6
 	depends on IPV6=y
 	default y
 
-config MPTCP_KUNIT_TESTS
+config MPTCP_KUNIT_TEST
 	tristate "This builds the MPTCP KUnit tests" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index d2642c012a6a..e54daceac58b 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -9,4 +9,4 @@ obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
 
 mptcp_crypto_test-objs := crypto_test.o
 mptcp_token_test-objs := token_test.o
-obj-$(CONFIG_MPTCP_KUNIT_TESTS) += mptcp_crypto_test.o mptcp_token_test.o
+obj-$(CONFIG_MPTCP_KUNIT_TEST) += mptcp_crypto_test.o mptcp_token_test.o
diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index b472dc149856..a8931349933c 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -78,6 +78,6 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hmac)
 	sha256(input, SHA256_BLOCK_SIZE + SHA256_DIGEST_SIZE, hmac);
 }
 
-#if IS_MODULE(CONFIG_MPTCP_KUNIT_TESTS)
+#if IS_MODULE(CONFIG_MPTCP_KUNIT_TEST)
 EXPORT_SYMBOL_GPL(mptcp_crypto_hmac_sha);
 #endif
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index feb4b9ffd462..8f0270a780ce 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -402,7 +402,7 @@ void __init mptcp_token_init(void)
 	}
 }
 
-#if IS_MODULE(CONFIG_MPTCP_KUNIT_TESTS)
+#if IS_MODULE(CONFIG_MPTCP_KUNIT_TEST)
 EXPORT_SYMBOL_GPL(mptcp_token_new_request);
 EXPORT_SYMBOL_GPL(mptcp_token_new_connect);
 EXPORT_SYMBOL_GPL(mptcp_token_accept);
-- 
2.31.1

