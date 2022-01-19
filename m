Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13FF2CA5
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 10:16:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: usama.anjum)
	with ESMTPSA id 2D8DE1F4442D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1642587364;
	bh=dpLad+4CdJOaMlTWmTiAawK1sEdubzbwv8rkOkH0hpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X94KRF9XESjNH/MFzgeFityMIjUQybaERD8qsUFghk8zoDhqkES3+vIeeTefMBTlR
	 wSPtHkYEQg6WOxXZCIux4337NUprYwMy2nj4sUfAExaH0OxLP/w+mXgYq12JLzlpQh
	 TU/GM0DHMnSz+pgkV41s59PcN74BrMCdighGngQrGotdJgpfq25+X3F8zQJ3LH6mj5
	 lBvfCYNhVpJmpc4yqz/w7xfd5sMdbwqZnbz5Tff9Jc8tTIIpHSE5xblpi/M08aGPpS
	 nFELH7jgSeMGywoqv7n2Qp+eLH1vtTZpw9JCEMyBzMjq/Udx7ZlRgRI3j3x1MlXZ5O
	 1zZvb7mg3Y2Ww==
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	chiminghao <chi.minghao@zte.com.cn>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM)),
	linux-security-module@vger.kernel.org (open list:LANDLOCK SECURITY MODULE),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	mptcp@lists.linux.dev (open list:NETWORKING [MPTCP]),
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH V2 02/10] selftests: Add and export a kernel uapi headers path
Date: Wed, 19 Jan 2022 15:15:23 +0500
Message-Id: <20220119101531.2850400-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119101531.2850400-1-usama.anjum@collabora.com>
References: <20220119101531.2850400-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel uapi headers can be present at different paths depending upon
how the build was invoked. It becomes impossible for the tests to
include the correct headers directory. Set and export KHDR_INCLUDES
variable to make it possible for sub make files to include the header
files.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index a7b63860b7bc..21f983dfd047 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -129,8 +129,11 @@ ifneq ($(KBUILD_OUTPUT),)
   # $(realpath ...) resolves symlinks
   abs_objtree := $(realpath $(abs_objtree))
   BUILD := $(abs_objtree)/kselftest
+  KHDR_INCLUDES := -I${abs_objtree}/usr/include
 else
   BUILD := $(CURDIR)
+  abs_srctree := $(shell cd $(top_srcdir) && pwd)
+  KHDR_INCLUDES := -I${abs_srctree}/usr/include
   DEFAULT_INSTALL_HDR_PATH := 1
 endif
 
@@ -139,6 +142,7 @@ include $(top_srcdir)/scripts/subarch.include
 ARCH           ?= $(SUBARCH)
 export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
+export KHDR_INCLUDES
 
 # set default goal to all, so make without a target runs all, even when
 # all isn't the first target in the file.
-- 
2.30.2

