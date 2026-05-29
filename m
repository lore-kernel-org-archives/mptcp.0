Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8796C17D6
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039690; cv=none; b=owc8r7A/cKSSgucLThJMQCmVJxHA47kLYXc+azHMOgJD7KoW+2E40rpvUU4CXs/28A8hn6rAk+URUs03nTIumdeWzAaYLqAyBK0hbEmmpoH8+l/MWNSagNGDXLSry59cwhSu1Jq/fIYa7TS0IdbTA2Xk8ru770agwb5WQbFdcHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039690; c=relaxed/simple;
	bh=UsRsrRy/sFaIfdGnaGz3/oQIC3/LYmjfaeuqurDr0UU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sbolr3qBcJhvanCzUQEr9L5gLvQkx0ASdmdziD4a9bKRDnIgB5kXKOFdv0wA09JfzdvFSVvBZ2FWc9XIMSyYd0mDG+VAl9JEOBTm+r70af6uU9P1ez3mfg016CSJ8zDUw2A/pMZstrKHfc5CeS8XlzaYyEVYjw67/tVTwRTjqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AILaFREJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AILaFREJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2901F00893;
	Fri, 29 May 2026 07:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780039689;
	bh=NqpJUChnpC9TudBz6iz5ixkioBKUW/kvHZrOkLQGAbk=;
	h=From:To:Cc:Subject:Date;
	b=AILaFREJAzIJViftxVe6fpvo7mW7zRl830wQvNQm6XRQLrzla3hnQ1Xr4+y5jhEsQ
	 mw9lceICpOu/S50rJD7Cvaf83oJjW+lJ5g3YKWUtjh8a87YwPWYygJ1AJsqv8oRohX
	 m6+bveSuAKGDeqvIeU8Don8lA9PKvzgml97y0Cm0DAnDfL1OX4ZkJGeYESDQ/dkCY4
	 3ieQEzeHORwTbuYXmAO+fOWlfsOb5yzbCuvXRNWdL65rkJkbs0d8jej5CicVlpdXLC
	 SR/Rk+lqr+znpPmFXK6SNlZRiMTgfegkqP5OOhWJSSFZcrxWaw9BWQXOMrHgLwnqi9
	 9SJSMzfHCsf0g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] mptcp: add TCP ULP module alias
Date: Fri, 29 May 2026 15:28:03 +0800
Message-ID: <c7f74bd00fd5073d39fae2818aaa12da102a3ad4.1780039666.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add MODULE_ALIAS_TCP_ULP("mptcp") to allow automatic loading of MPTCP
module when the "mptcp" ULP is requested via setsockopt(TCP_ULP, "mptcp").
This ensures the module is loaded on demand without requiring manual
modprobe.

Also add missing MODULE_LICENSE and MODULE_DESCRIPTION.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/subflow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d562e149606f..81b562ba81c0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2213,3 +2213,7 @@ void __init mptcp_subflow_v6_init(void)
 #endif
 }
 #endif
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MPTCP subflow");
+MODULE_ALIAS_TCP_ULP("mptcp");
-- 
2.53.0

