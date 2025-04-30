Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7802F5B
	for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 05:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992197; cv=none; b=H0YUHiH5061eJZfhMpYylphq6JGd2fUzW+idMzwiWya8TDRjvIHKoOZ24lH0o61AA+his3mbn8waNuWykp745fcwE4BVts2QNDv7+xc6j/f2AvqTrORHdeGcn2HLzQsbYC3g35eeIggYXWuotKPq+Me98UwNLkfOBTjhoa61+60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992197; c=relaxed/simple;
	bh=igiezey9IHpi5LcP8v/etVFyBzpmKtLj4SdEiY/jDyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9bllIqyJF44xDkbcRuWAfHdBvUGQlVBbZ/8so/dX7p/LniuREFMQAqaoxwlxwYC6wd7pFcmkqVuEZP6RdVtZ9oOwlx9YruHZCJFE2+At4LsFE9PUdNgot+DQnJkRA/oiNeFwHHSKS6CAeEKXHX38mtOQRx2hl8l8KfN15eBHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtz/rEQy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtz/rEQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2044C4CEE9;
	Wed, 30 Apr 2025 05:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745992197;
	bh=igiezey9IHpi5LcP8v/etVFyBzpmKtLj4SdEiY/jDyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qtz/rEQyWEhOEPSjbSk+b4ocIY55PflzRdtjxo+aGtEzbll7JlSDOCexkMBnGqIjA
	 ZWsBT6Iu9AGvTMeMAvloNDM/BRLojhad/E3ven2dOQaqM0YJA9Rp+xtzcPp3j2G3k1
	 vzkYePqAyOlLm4bvq/F/vLc8iR0z8798ZP9IPk4p0B3I49u676AaxMIQWWQWGvaAlt
	 /C45nY6XYEAWlgEsUUzK5/V6+LPLhR5b+gnFGZLKjjP6WntwB9mjyymB3KSfCHSSpl
	 vGBVCacrHnc2GrnhF9HYhNwiF25No+f9s5nsEPlZrvo34LrkWTmZGJclE8eF0G2hAV
	 NGCOV9JjuJWNQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next] mptcp: validate maxseg sockopt
Date: Wed, 30 Apr 2025 13:49:46 +0800
Message-ID: <b10aabf6c4529977b61e7662cf1f09db4752edaa.1745991826.git.geliang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745991978.git.geliang@kernel.org>
References: <cover.1745991978.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch validates the newly added TCP_MAXSEG sockopt.

Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 gtests/net/mptcp/sockopts/sockopt_maxseg.pkt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 gtests/net/mptcp/sockopts/sockopt_maxseg.pkt

diff --git a/gtests/net/mptcp/sockopts/sockopt_maxseg.pkt b/gtests/net/mptcp/sockopts/sockopt_maxseg.pkt
new file mode 100644
index 0000000..62492db
--- /dev/null
+++ b/gtests/net/mptcp/sockopts/sockopt_maxseg.pkt
@@ -0,0 +1,20 @@
+--tolerance_usecs=100000
+`../common/defaults.sh`
+
+0.0  socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
+
++0   bind(3, ..., ...) = 0
++0   listen(3, 1) = 0
+
++0   setsockopt(3, SOL_TCP, TCP_MAXSEG, [1000], 4) = 0
++0   getsockopt(3, SOL_TCP, TCP_MAXSEG, [1000], [4]) = 0
+
++0     <  S   0:0(0)         win 8000  <mss 1000, sackOK, nop, nop, nop, wscale 0, mpcapable v1 flags[flag_h] nokey>
++0     >  S.  0:0(0)  ack 1            <mss 1000, nop, nop, sackOK, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
++0.01  <   .  1:1(0)  ack 1  win 8000                                             <mpcapable v1 flags[flag_h] key[ckey=2, skey]>
++0   accept(3, ..., ...) = 4
+
++0   write(4, ..., 100) = 100
+
++0     >  P.  1:101(100)  ack 1             <dss dack4=1   dsn8=1 ssn=1 dll=100 nocs, nop, nop>
++0.01  <   .  1:1(0)      ack 101  win 256  <dss dack4=101 nocs>
-- 
2.43.0

