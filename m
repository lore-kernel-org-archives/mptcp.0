Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D0E13AD2F
	for <mptcp@lists.linux.dev>; Wed,  5 Jun 2024 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619907; cv=none; b=um1mLchNxaF0hjdwxGyPTsox9bg7DqxCO4LigplTgwk2l5gbb5u9fJuXRaH1MoKCv7a+ahLoVNvOfm6xTDyCMVgcyP5/QS7kx+OU6exCZq1PwSZdXpnHZOWwOJxteKpycKEpdGMoS7/tECcDxe3F9k44rREtMQnmV6+kRXOVPzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619907; c=relaxed/simple;
	bh=MJgJII98g5zA+p4MZqKkUbFymhXZby+fhPDQNEVUdUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+Pw/G3bia4dfn9T0wQOson3o7BaQHClnIxO5xRhXhtyd+YGQeoa2LYqsx5JRUHStOolS4/qMpi80EX3yh1VQUBjtNY3Un4yDbAAlvOsqGL/Qnfmb7L9LB/ExCLakqXgy5EzdbAXl7g4OK8JzrObLOvnAjdzzr71J/cOBcTW6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICxPkQBJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICxPkQBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58F5C2BD11;
	Wed,  5 Jun 2024 20:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717619906;
	bh=MJgJII98g5zA+p4MZqKkUbFymhXZby+fhPDQNEVUdUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ICxPkQBJUJUlSZxdEkkD5vgVPVZpBkeKLhtS7cb7MZTR8pkZ9YU7tR2lAhQmIfTIb
	 6mgmIernSpBub6LaiIFHAVIGuDpF0haOXIoVdySmht2eI37UCbfkt+oC2yVR66xPKx
	 KF0SERSLXgr19KDtLMDL2uws1sURgHq1x4Lo5q5musE7ZEVYE2kWuES7BNpgKB8l8n
	 gNMXWimm//fW4cv/hVQiBuKPBw8Hm3FxvGQ8s1YKe0xvcPn0SpR2Re9cXl/FNhJD+p
	 pKrL6+/RUebMr+TXwSZf2ofg05ed7e9eB519UJKecvsw20t/skoBX04lcK/R4kqOC4
	 QEIAgwGlTQf8A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Jun 2024 22:38:13 +0200
Subject: [PATCH mptcp-iproute 2/4] man: mptcp: clarify 'signal' and
 'subflow' flags
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-mptcp-user-feedback-v1-2-d2dc3b399643@kernel.org>
References: <20240605-mptcp-user-feedback-v1-0-d2dc3b399643@kernel.org>
In-Reply-To: <20240605-mptcp-user-feedback-v1-0-d2dc3b399643@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MJgJII98g5zA+p4MZqKkUbFymhXZby+fhPDQNEVUdUs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYMy9GF7v7B1ilfdkULF5qqkWzwcvNKtDg482d
 ryUNr4RHGeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmDMvQAKCRD2t4JPQmmg
 cwi3EADCMU6U+UTKATF48ceENQ1pTjMEakXC3VCq8TUWEGcSQMO3fxk3jj8LSo0O7dwl+BSERpk
 HwH76y//Gp4CLyUtOyArB6nZdIihulBLxHL/5wOYmc9Jr4rJGfLtMHuGkzEFCtB1RvEuiviE7L2
 9d+C+M/RBMOnby3ObtX4FIgPmJGzEC/Ux0YUCUKetn6dgYPQwAdLbl12MoRp1pS3dv3ZDec96ws
 DZywQHqvPTXY0/PGAM78UOgvqLzas990h7vOoqjvx4YNk5VoUNFUARmKCxkybv/dIxEgWXPhSHD
 qPG/39msRXF1Dh5eq+wXrISkwB+GWgzBUlZ/XHwlOFqL3T37WSLJ37C2Xo6wQyLgyjfghsrgwzz
 5XaNrBss15IE6MCXKJSnVmUPUe5sr7EaKzHJRdWVMSbNFLAYcmmjJmuTJ4Iy872eqPxp43Gd2Y4
 T51YY5TcqC3VieSqLknp9YG1oPVXKhF41QRSjz4fmYxskgT2sx3TcsUpRVpQFBBkyfPJkWRhBxD
 M/xNVc8LzFTNzcQyA4SIWqicFZcgDs2cFs0FwOhHgM4DAaqzqWVaj73uB864B3+pBB2f7GcC//L
 eyxA3L2XH7GF1Scjy+zysk3MCCgy8Nd06Ms13TdK3OEBrAlJbuXHmAJ4GWcUfR8bnrX4Ip9hYEL
 W8zjKAOfT43/bmQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

According to some bug reports on the MPTCP project, these options might
be a bit confusing for some.

Mentioning that the 'signal' flag is typically for a server, and the
'subflow' one is typically for a client should help the user knowing in
which context which flag should be picked.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 89fcb64f..2b693564 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -150,7 +150,8 @@ is a unique numeric identifier for the given endpoint
 .TP
 .BR signal
 The endpoint will be announced/signaled to each peer via an MPTCP ADD_ADDR
-sub-option. Upon reception of an ADD_ADDR sub-option, the peer can try to
+sub-option. Typically, a server would be responsible for this. Upon reception of
+an ADD_ADDR sub-option, the other peer, typically the client side, can try to
 create additional subflows, see
 .BR ADD_ADDR_ACCEPTED_NR.
 
@@ -158,7 +159,8 @@ create additional subflows, see
 .BR subflow
 If additional subflow creation is allowed by the MPTCP limits, the MPTCP
 path manager will try to create an additional subflow using this endpoint
-as the source address after the MPTCP connection is established.
+as the source address after the MPTCP connection is established. A client would
+typically do this.
 
 .TP
 .BR backup

-- 
2.43.0

