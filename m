Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E54028BABA
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135394; cv=none; b=qWahFJ5Ry8uXch4a2Wn44qF3E7DRxwvxbkANPrYUxlockZ5ZLP6Ef1wvqN3M1aB/FJOJp15P3Ft9iEI0qa9TySl0cFUGE5IuTHwJ8x6oPHkUDBUtP4LmFdZgSbNlJCgTHc5C4WBCcx/0Hvk9U0+3Oz8pRPku/Ay4ZVuhimn7jx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135394; c=relaxed/simple;
	bh=rFy77G+TF2gbk+q3EkMTXv8rUw6T19PVJ6JNN9Mnd6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+eNg+GqrT5qhcaY1LKukILR/sZ1QolZmOLDSNWwiwbf2zqFTpsaM2PnK7U5RGHHaHyvVAROad2YxVlZIOJnzOb6Sdpk+lIIHH05BMtJ51z56Uxgn43vb7sF8cVJQ6pt1yyaYqHkS1jjLSlCS8Cvw8FdBHaN7Qs5nc3piiuqSzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCzYxu06; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCzYxu06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05524C4CEF5;
	Thu, 10 Jul 2025 08:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752135394;
	bh=rFy77G+TF2gbk+q3EkMTXv8rUw6T19PVJ6JNN9Mnd6k=;
	h=From:To:Cc:Subject:Date:From;
	b=vCzYxu06k9CO8ti37ss5LiTdU6AJux482hrmWrs3Hdj+wf2TJf5O6aei3+V+Jcuhc
	 VNCmOMKCB2Lr1Q8AaKgzGx8JaAAQBwI6yGXUlqg6H6eKB+F5NVrcTdewo3bP2XPL2s
	 YNiG3DU7cfRroU51kLXrchPhPVe03yQyY1TGEvJVincQ9DsuLCoQ76k3yaP10s1TUR
	 sjqErpDmMglqk4m9BsMgVzhsUqYxYgZbfmwfvfp18Bj2ji4fBXZ50kbgs6oz0C1SQW
	 F8sPw4iq66l16o9Un1EdmAC+/IyG8Ox+EMytUF+hynRk28ofrPOFOf1EuDl5YM8mcL
	 7qFqh+rFBKIsQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/2] Squash to "implement mptcp read_sock" v8
Date: Thu, 10 Jul 2025 16:16:26 +0800
Message-ID: <cover.1752135065.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - use mptcp_recv_should_stop instead of
		if (sk->sk_err ||
		    sk->sk_state == TCP_CLOSE ||
		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
		    !timeo ||
		    signal_pending(current))
  in mptcp_recvmsg.

 - use mptcp_recv_should_stop instead of 
		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
		    signal_pending(current))
   in mptcp_splice_read.

v1:
 Drop "shutdown" parameter of mptcp_recv_should_stop.

Based-on: <cover.1752045499.git.tanggeliang@kylinos.cn>

Geliang Tang (2):
  Squash to "mptcp: add recv_should_stop helper"
  Squash to "mptcp: implement .splice_read"

 net/mptcp/protocol.c | 59 +++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

-- 
2.48.1

