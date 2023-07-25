Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69A023BFE;
	Tue, 25 Jul 2023 18:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3213EC433C7;
	Tue, 25 Jul 2023 18:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690310099;
	bh=lnDJDryLE/s2hFOhlSzvGG+STqo8cq44OlY3Bnve82M=;
	h=From:Subject:Date:To:Cc:From;
	b=DyFAMNXOEEZyWJRP3y+wbiIdmDGMYhFOVA0NpIwMKeN9AyYBZ4tPX2OFcEykoB7uP
	 Hr8N6Ealk6wBjI/WdR3L3xHkvFShFvnrsxZAuFuCJHbhzWzksCAghjFYXpDPqHfnwu
	 P2BAxFbdALVU1tCdo8JPfTAydKsYp3XmVPPICAznH9Vtb06XhBh0yJA9QEAYQDvcx1
	 2zBegteRn7VKE5eFRqSJhuysw/Pj/OhSv3zMqGeg2TxOySx9SJ24eE5uCOEPQWfXi0
	 BEn3c61e8YnsZFv4byB/LX6VtuNhY0zYSQUFHynNFqMi+lRnYmDnckpQpOHdgcrs6u
	 R8Uy0wolpEu+w==
From: Mat Martineau <martineau@kernel.org>
Subject: [PATCH net 0/2] mptcp: More fixes for 6.5
Date: Tue, 25 Jul 2023 11:34:54 -0700
Message-Id: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM4VwGQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDcyNT3eLUvBTdvNQSXbiIqbllanKKibGRWaqFElBfQVFqWmYF2MxoJaB
 KpdjaWgDDbgfSaAAAAA==
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geliang Tang <geliang.tang@suse.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, stable@vger.kernel.org, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.3

Patch 1: Better detection of ip6tables vs ip6tables-legacy tools for 
self tests. Fix for 6.4 and newer.

Patch 2: Only generate "new listener" event if listen operation 
succeeds. Fix for 6.2 and newer.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Matthieu Baerts (1):
      selftests: mptcp: join: only check for ip6tables if needed

Paolo Abeni (1):
      mptcp: more accurate NL event generation

 net/mptcp/protocol.c                            | 3 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)
---
base-commit: 284779dbf4e98753458708783af8c35630674a21
change-id: 20230725-send-net-20230725-579ecd4326e8

Best regards,
-- 
Mat Martineau <martineau@kernel.org>

