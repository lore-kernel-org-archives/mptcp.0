Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC12E739D
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732323; cv=none; b=Lm7cTZpP57RDyxSqHh7qej2TvV1uZmjM8ASULd0YlHm10O41jUvZX4dEqs9ePo94mJH5RX7MQTMoy31QvLIntTTfqvQDju0ykT7cOaktPapk3dexSzRowEDnswlB6jtAiX8kvk9GwanDAayXKTwLRLaXWtRdpq0DJlaZMGwZ9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732323; c=relaxed/simple;
	bh=6GMPT6SJLHpHrvFsJ4Z/vVSp4NxCLpgqBghOY+mj9Jk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mfB/1p1o431J4D93sUW3qpEvnpi7YTfj7JP7igj2moH1qSc+M+Ms0fcbmDlZBWD4IW1AzQKs5b1dXEFmxJXuPJdDgL8cwG37ntdLq+sY0Rceasnr41jaA93HqNIprt1/hMwJn26pdtFeSz7lBMW2YSwlVKwgsSdNvNgnp4uIK98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsGzZAkR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsGzZAkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED881F000E9;
	Fri, 14 Aug 2026 18:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786732322;
	bh=H8Zpys+4SMGWx/b5aaLknh1hZgr5BpzgB4LDu/0JQuY=;
	h=From:Subject:Date:To:Cc;
	b=WsGzZAkRrv/SnNJvrXmkvUZxxGlc7DJn2rXNBVDLcK3oNFz5AhA7N6VO6Gv8Un3fr
	 zj12j5jDMTsQal3lgNWtPD+rgZPJM/ouSU+EUDqtHdZWx/fhM2qCAu5PF0GWsac/2m
	 wS/ziQRV/mFFtqH01ZNLRf2Vexn5HhhBjdLeQNWZkm+8zY0tlYik/9t6EqXvnXqG21
	 C9Go+nvv3GG3Ks9HT+sAQGJm4X3Ly4hICnW3SWscU1HWLlKE0y/wJJY6zv6BT60wHG
	 vMydZYmxTTjSkf0WknO8ig4n3j3cKtfL9ADH+zGQ8bsX5ByUW+BGq9TLxviACQdG2H
	 i/VENfsWh+icw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next RFC 0/3] mptcp: reset fully_estab after fallback
 & reject MPJ earlier
Date: Fri, 14 Aug 2026 20:31:53 +0200
Message-Id: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQrCQAxEf6XkbKBdilqvgh/gVTzUbKopul2SV
 Sql/+7W3uYx82YCYxU2OBQTKH/EZAgZqk0B9GjDnVF8ZnCl25b7qsZXTBRR2Tjl3CO3+vyiJ9r
 52jfOdw1kNyp3Mv5/L7Aqgce0VOfTEa7rxN63nikt/zDPPxrYdK6MAAAA
X-Change-ID: 20260814-mptcp-reset-mpj-early-dcc7d4d92df9
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Chenguang Zhao <chenguang.zhao@linux.dev>, gang.yan@linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6GMPT6SJLHpHrvFsJ4Z/vVSp4NxCLpgqBghOY+mj9Jk=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGp/Xx6jQRuccMl8EM4ffgVe23fAVNBn73hfkB3WjxKg6+9uJ
 Yh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmp/Xx4ACgkQfCLwwvNHCpeYnwD/VXXI
 RSqR/WTiGposmXn8qgJoJBeGG4ZaTuPUmGRMYv8BAN6NAoFjAjpSDroqIQ6JU4yMWNGY3cY8aou
 NgNjeIo8K
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is a small RFC series to present my idea: it seems better with some
code than describing it.

I suggest bailing out early when we can: reset the fully established
when a fallback is done, then reject the MPJ earlier, and finally stop
processing connections early with the in-kernel PM.

I didn't check if any of those should be backported, probably not.

Only very lightly tested.

@Chenguang / @Gang: feel free to take over this series if you want to
extend it, or if fixes are needed.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      mptcp: no longer fully_established after a fallback
      mptcp: reject MP_JOIN earlier
      mptcp: pm: kernel: skip operating on closing connections

 net/mptcp/mib.c                                 |  1 +
 net/mptcp/mib.h                                 |  1 +
 net/mptcp/pm_kernel.c                           | 16 +++++++++++-----
 net/mptcp/protocol.c                            |  1 +
 net/mptcp/subflow.c                             | 19 ++++++++++++++++---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 25 +++++++++++++++++--------
 6 files changed, 47 insertions(+), 16 deletions(-)
---
base-commit: d536472a82d18356d323227213acb5603bb9050c
change-id: 20260814-mptcp-reset-mpj-early-dcc7d4d92df9

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

