Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436623505E
	for <mptcp@lists.linux.dev>; Wed, 10 Dec 2025 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765354362; cv=none; b=kbZO4ZaJgELG8dQ/LTvm5yDKjfSyHiXPuO67hFTA/UcqQi7kZ84j1eL8LXpvAujhE2kHxgEmMs3vRGt0MS45JcC6sJpJH+yuwL+BSzsdK/16yL/feDr5G9R1853LVYESD12pouHxO13VVgTCyk9raY4/VTDdUesGgPjXnNm3zTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765354362; c=relaxed/simple;
	bh=R9sPI8meh4qs55tTPWGe1JyDWtYktOdWk/cPLQhRriQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kgtU4pnrwIxTYECWEEu9S7hUIxD56AMjgpWRBEP3PGstq4XPrk57T/CJIfZ8c3m49MgyiCmLOPDA5L3YRoeZwVJzwyfdZoWlIDLl3iIWUxSnOx8FaQTzdklPUTfhZC3VYMxFxqUaH42oOHt9eSimwoODrwLw7IYLOvx1T5JoxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGQUcRlA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGQUcRlA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C14C4CEF1;
	Wed, 10 Dec 2025 08:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765354361;
	bh=R9sPI8meh4qs55tTPWGe1JyDWtYktOdWk/cPLQhRriQ=;
	h=From:To:Cc:Subject:Date:From;
	b=RGQUcRlAw9U7aWaTTFbvC9dQBwxgdePbVF2590g5oGJSyPGPmdHAcJCLvpgIm0ODU
	 +OYf+k+Iof23k8J0qKwP1pFoAYpmjSHlg+o7aOv/Mc0ovibuinFb6STGmXwuWd28LM
	 h52jkYaE/U8zNstMTLQW5bWRaRG/atNwMshmKVEEuaywBL7Hi0RV2KkKaMZJiV9srC
	 vTodxQpaH+6I+UFQb/oh3OWWwS/rVmESI3+jE7BRPuOWnMHyX0mK0EIw6n7f+ewF1K
	 j27ZxW0FFizFZkdcGgdd3FnkHphefcfk1qEarHy4iMpFS08+JCMxP5hHhXnMNbDWb8
	 QRsx2uzB9VW9Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] add sk_is_msk helper
Date: Wed, 10 Dec 2025 16:12:34 +0800
Message-ID: <cover.1765354225.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This set introduces a sk_is_msk() helper.

Geliang Tang (2):
  mptcp: use sk_is_tcp helper
  mptcp: add sk_is_msk helper

 include/net/mptcp.h  | 12 ++++++++++++
 net/mptcp/bpf.c      |  4 ++--
 net/mptcp/protocol.h |  4 ++--
 3 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.51.0

