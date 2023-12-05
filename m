Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCA14F6F
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EG93SKUR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dr7Nl/VB/PRfB789F+rxoRa2FOQz6AMWPofOq6mvC/M=;
	b=EG93SKURQeb034zMqulpml5Tvduvaqiq5aVtBuGNpUVrYBBYciXMsbnMZnA5uyA9aj70XX
	SUoUwP47dMFd6OSYv71tX1zenbD3ieX2ezYfiIzAiyvWBeJIY7Sk3XxPv/0pYZ5u/9Mo+R
	Voe+E4SNEZzznYbFEkvgE6wBLHNJ//c=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 26/33] selftests: mptcp: simult flows: define missing vars
Date: Tue,  5 Dec 2023 15:01:13 +0800
Message-Id: <42eaff6ff5af81f73a4b4f98811e766db60762bf.1701759405.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1701759405.git.geliang.tang@linux.dev>
References: <cover.1701759405.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The variables 'large', 'small', 'sout', 'cout', 'capout' and 'size' are
used in multiple functions, so they should be defined as global variables.
This patch redefines them at the beginning of simult_flows.sh.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ef61cec3bf37..b82c083c934e 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -10,6 +10,12 @@ timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 bail=0
 slack=50
+large=""
+small=""
+sout=""
+cout=""
+capout=""
+size=0
 
 usage() {
 	echo "Usage: $0 [ -b ] [ -c ] [ -d ]"
-- 
2.35.3

