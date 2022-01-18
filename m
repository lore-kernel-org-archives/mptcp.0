Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6392C9C
	for <mptcp@lists.linux.dev>; Tue, 18 Jan 2022 11:32:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(Authenticated sender: usama.anjum)
	with ESMTPSA id 97BD11F43EC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1642505521;
	bh=F9NkFS9pnDMRN1So8liCLv2iKRad2nzOipo3RDNWrNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XmusjG85edJRDNtqNh9O2PTz/ooSlJtSdZvp0jquX75g5Cp+TvgvYV0FZ+aWapkhF
	 nXRtsLWlkrXha0Xom2u3BRRz/zxqgcssEdv1IFg1s1Qc0cp00akYgFeZZkS8VlQb5h
	 8rFEcA3W1Kfaj7dnIfb7dZ72VQFHrlRwiw2nTJ3wNn02HBIQYQClNLip0yz/esO6Ji
	 hOLG3f08ioJLuo0K+lqB9S2ct6RJGEu3icZGC2Ux2AA3BPYDGmcapO25XNkiUZrdte
	 Jt4Voln00ttdD2Z7rSnnaFh3ZlYVUiFH6h5mh23Mf6v1qHE5YPAGOi4P09/dPvOfsw
	 3+FB/RiNmJ9Sg==
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
Subject: [PATCH 09/10] selftests: vm: Add the uapi headers include variable
Date: Tue, 18 Jan 2022 16:29:08 +0500
Message-Id: <20220118112909.1885705-10-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220118112909.1885705-1-usama.anjum@collabora.com>
References: <20220118112909.1885705-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Out of tree build of this test fails if relative path of the output
directory is specified. Remove the un-needed include paths and use
KHDR_INCLUDES to correctly reach the headers.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/vm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 7d100a7dc462..8dc428c8a3b0 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -23,7 +23,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
 # LDLIBS.
 MAKEFLAGS += --no-builtin-rules
 
-CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
+CFLAGS = -Wall $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
 LDLIBS = -lrt -lpthread
 TEST_GEN_FILES = compaction_test
 TEST_GEN_FILES += gup_test
-- 
2.30.2

