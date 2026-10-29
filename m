Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316128;
	b=Yuwk+9SAImrDO+W/526tUb0wgFXg83inONPdeCfNw8dcoKjf+5Ir0FZ3KDyVMv1009vk
	 HnfY+t4LVJjrsCeODeTFeG5BYI+HMsURQeER6uRg7VAS9K3Ou+1r134zfjJspNDZOvFSI
	 OZURqcbgXz4MMdNk3AzevkNuH9c+aaK/YZ3gAgv82no+LWM5Nw7KzhwLiiRp3GhVhBDT/
	 k6kjjfLSx84AssWHemkP2Hzj+J6KsVbYNuOLrEGAKJ8O7rmkd/5jqLg6pooNYDFzBJEEy
	 0b+H4PUsLb1mRk/BTJ6pWIM2tMVjIOVE+vO1lldQOih2pSlBoY3zIvGR+4oF6+DS3Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316128;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3VTdkt1O229KG/ISNAW3+0LwXDDNMTJjTkclfDGrSAo=;
	b=GHOBj8uM5K7D43mt7IVW37x8eMJlqPUzfvBuRvFWNxTAHFJy83kwJpnpXwGsZ/CuRIfB
	 jgWd8GDD4EIL1lGr+1+pUyCFJqU+GTbvaT/6B81NeL+73C02ferEVdDV5E5Po2Op+C4mK
	 68/kPWul+rSgO9TdqLQNss/7aDhEXxEbTreeXRY0KsdxNSirAItpMPuuFH0bZIfjtyyrL
	 Hl0c1WjiR5qdsB3gIH4+VP20gqXGpiIi2nrKOl06mQz6ivbBTB5o+Sr9utv5QOW6FNKte
	 iNKZ6OwdGBDmznMsamn1XoEAg+qDZWEZc9/b6XinlhBbeNIOMoNtoMM0xhO8ZwipJKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnaMfjan;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC1A606A31D
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnaMfjan
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3B31F01825;
	Thu, 29 Oct 2026 23:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793316127;
	bh=3VTdkt1O229KG/ISNAW3+0LwXDDNMTJjTkclfDGrSAo=;
	h=From:Subject:Date:To:Cc;
	b=bnaMfjanAO0fcFYhulFW+4LO9gv+kNSbILNj8uQPv69NZQ1w/82KO3LWGGUPTngiV
	 lbbfo0KwFa+y3pdlFWIm8FJKJjkSXB3PBV4eJQN3+0Zeuq8ciIM7AO8e1WIm7mKW2T
	 rjEvhbFuoLmi8lZ1Qdt8UTZqqyIKE4mxq8R03HHjI2F74XKrZxkvwTX8F/hyOM5qQX
	 JkIGXyT/Jaccsx3M0fvm88Z5iUITkDgwTsGNO/zJSSBTp4ETgZIk/FMtBEehvXYQTB
	 E3QS3501DidYw1LybSlH6OxkkNzBWuPJuQfnAMaZSZO0tGw4MHTTd6GdnSTvDEe7Mn
	 aeI1qzKLzHSEw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 0/5] mptcp: reset fully_estab after fallback
 & reject MPJ earlier
Date: Fri, 30 Oct 2026 00:21:38 +0100
Message-Id: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOwQ6CMBBEf4Xs2TVQGhFP/IfhgO0CRSxkWwmE8
 O8W+ABvM5l5s7uCIzbk4BGtwDQZZwYbjLhEoNrKNoRGBw8iFrf4nkj8jF6NyOTIB90hVdwvqJX
 KtNS50HUOgR2ZajMfu084EUuzh/LM3PfVkfL78N5ujfMDL8cTU3Iwf+5NCcaYqioNrTqXmSzex
 Jb668ANlNu2/QBMURwo2QAAAA==
X-Change-ID: 20260814-mptcp-reset-mpj-early-dcc7d4d92df9
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Chenguang Zhao <chenguang.zhao@linux.dev>, Gang Yan <gang.yan@linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yWXtGqzQjRuujCUgXxsMTsUc8bH7OgUYqk5QAJQ72Yo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIeXxVneRBQLn1PcXmd4OLtd9drP3jqO2GD5TPjBF6++
 vcHqt90dpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwkYhEjw/69J3i0c/LDSv6c
 nbTnRK/FMs6nuSFbfBbOjVfdzjSbt4GR4fXSz2x8bgn1742Ni9jKT3a5c+To1MyYEHg56ebixCI
 uTgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Bailing out early when we can: reset the fully established when a
fallback is done, then reject the MPJ earlier, and finally stop
processing connections early with the in-kernel PM. Plus two
refactoring patches.

Maybe the first patch should be backported? Eventually the second
and fourth ones if we find related issues? (That's why I put the
refactoring patches after.)

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- patch 2: why the new racy check is OK, +ed, support old kernels & synC
- patch 3: new
- patch 4: safer approach
- patch 5: new
- Link to v1: https://patch.msgid.link/20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org

---
Matthieu Baerts (NGI0) (5):
      mptcp: no longer fully_established after a fallback
      mptcp: reject MP_JOIN earlier
      mptcp: subflow: split subflow_check_req()
      mptcp: pm: kernel: skip operating on closing connections
      mptcp: pm: kernel: avoid mptcp_pm_is_userspace checks

 net/mptcp/mib.c                                 |   1 +
 net/mptcp/mib.h                                 |   1 +
 net/mptcp/pm_kernel.c                           |  18 +-
 net/mptcp/protocol.c                            |   1 +
 net/mptcp/subflow.c                             | 210 +++++++++++++-----------
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  55 +++++--
 6 files changed, 171 insertions(+), 115 deletions(-)
---
base-commit: bcc5638fabf418e763621a432840cf55287e604d
change-id: 20260814-mptcp-reset-mpj-early-dcc7d4d92df9

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

