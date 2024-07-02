Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B134915B55E
	for <mptcp@lists.linux.dev>; Tue,  2 Jul 2024 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920012; cv=none; b=QWIsCwwgL3YJg+k3RdZqvkBcMmH3fSfqiJWkJ9BMuTjt2pZ/BhYqjTNTsCxSaQfe8BoqD6K9q092NxlILv6gyCM1N3taUISdegNdtZlvB57FttDZQKDx97OMINup6KRpbo58V5U+DRKQZcl0YcZDNaucmTeVOCaAwcdb7y/Wvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920012; c=relaxed/simple;
	bh=WQiuwDDoZehRrDSjUiALxlVpbCKwODdp3MxFrPhK1P0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=URt0snryBHOk3MTt9C2sDIpLjl+t6aNa15HbEM9r83x4ztxaVwXiAfgbNuOjjUzU9Ah1pqh/zsLqfdZhR77fhozXxaFv0rWb4L/77t6jULF75Y96JSHm/UUEOydlI0WQwEnGlnbo3RFQaSRlacdURHZFyKpfkZptTNq/0LiPRuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36683e57461f-b9e29;
	Tue, 02 Jul 2024 19:33:08 +0800 (CST)
X-RM-TRANSID:2ee36683e57461f-b9e29
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66683e573678-94de5;
	Tue, 02 Jul 2024 19:33:08 +0800 (CST)
X-RM-TRANSID:2ee66683e573678-94de5
From: Liu Jing <liujing@cmss.chinamobile.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing@cmss.chinamobile.com
Subject: [PATCH v2] selftests: mptcp: always close input's FD if opened
Date: Tue,  2 Jul 2024 12:05:18 +0800
Message-Id: <20240702040518.11058-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in main_loop_s function, when the open(cfg_input, O_RDONLY) function is run,
the last fd is not closed if the "--cfg_repeat > 0" branch is not taken.

Fixes: 05be5e273c84("selftests: mptcp: add disconnect tests").

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
Changes from v1
- add close function in main_loop_s function
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index d2043ec3bf6d..48b7389ae75b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1119,7 +1119,8 @@ int main_loop_s(int listensock)
 		if (cfg_input)
 			close(fd);
 		goto again;
-	}
+	} else
+		close(fd);
 
 	return 0;
 }
-- 
2.33.0



