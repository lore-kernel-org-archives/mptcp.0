Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AA15DA
	for <mptcp@lists.linux.dev>; Thu, 22 Jun 2023 01:34:03 +0000 (UTC)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 05982240027
	for <mptcp@lists.linux.dev>; Thu, 22 Jun 2023 03:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1687397642; bh=Qo7/utFY+AUkkN8SfWpvXJ8a9KR8TVuJ4Y5tbnHu3+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=YlnlaAI34bHCUo/26vKiKD82jyDjhGAqPilEQA+TsWXapMqacndcZ234eKx3d+uD4
	 lClYC2C17oBzQbAp2DUtxfy/whnV+TXqWJSPlXPp5/tzMRtbfo94zj4ao5/EOurRw/
	 d1xskKMxesmeDAoGBPiSeBa/dC2Scun8sjYQWNW35OqWDsxZT+EvNff6+VxJ0jUNoR
	 zpA5SRXTzhEcaMNYdvv926Mj55EAirapNI96d7G/6G4nbxV8pB5KcAwx40q7oltZ8g
	 fbXhuP1yQUkQoMloTuN6m/dLee1vHWtKXaQpmWPPX1LHLiZ/8/kfY6TqVZi0M97baV
	 TzfYmSKeffOUA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4QmjZV4L7Sz6twX;
	Thu, 22 Jun 2023 03:33:54 +0200 (CEST)
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kalle Valo <kvalo@kernel.org>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yueh-Shun Li <shamrocklee@posteo.net>
Subject: [PATCH 7/8] selftests: mptcp: connect: fix comment typo
Date: Thu, 22 Jun 2023 01:26:35 +0000
Message-Id: <20230622012627.15050-8-shamrocklee@posteo.net>
In-Reply-To: <20230622012627.15050-1-shamrocklee@posteo.net>
References: <20230622012627.15050-1-shamrocklee@posteo.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spell "transmissions" properly.

Found by searching for keyword "tranm".

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 773dd770a567..13561e5bc0cd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -809,7 +809,7 @@ run_tests_disconnect()
 
 	cat $cin $cin $cin > "$cin".disconnect
 
-	# force do_transfer to cope with the multiple tranmissions
+	# force do_transfer to cope with the multiple transmissions
 	sin="$cin.disconnect"
 	cin="$cin.disconnect"
 	cin_disconnect="$old_cin"
-- 
2.38.1

