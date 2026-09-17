Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E379519900
	for <mptcp@lists.linux.dev>; Thu, 17 Sep 2026 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650828; cv=none; b=JLe7stnKol4qwGwjPlOfd1l4aDGN/CXvtITlOZskohZO1XsgckgOQVJSWDLRjV3OHJ45quYBlGG7QprOWwgDd3x9/ooGiu5BduMWFhi+kWm/NXkKNUmwRWeoCzWed+ijW0K/DbH0ZEBMdEfl28aFcMr7DT6PGMcgVeHC7UHSZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650828; c=relaxed/simple;
	bh=YbrHuHx5DgQmoc74M4m/3WPvDRRWqgDXoB35dalTY9c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=memrzwUvsWuPj+kT1jHzo2WWkFJVmue4bm69xDzRVnihChVJWIqAD+p9tij/MKjS0ubTOgsIxUDpMxR741pc8vaAfgUsJeU4dw1b9PevGQjTFOQdyWgRb5TTr3h3R3Tz17fCj0ItrDOWjp4mCOALIchmEVvTVDkoc4Way0IkxT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjILk7I/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjILk7I/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEA11F000FF;
	Thu, 17 Sep 2026 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650826;
	bh=/vrT+eyi4iTocKX0XlwethX1cOYaufpAZSbtDWjGpMs=;
	h=From:Subject:Date:To:Cc;
	b=RjILk7I/YtmQLRkM8Ybofa/V1H6OrV0NJWlhxi7FsmH8tQxTi8s+twCg9/qGRQIBs
	 Bd27RUsPZh2vt1XUI9dUNVBMTey8ReBmD0ih89OH3WTwfzhVcul4r2gGDMFg41zgnU
	 6SfoNeEQXp3PXd4xQv4ahlHhiqAXS7w9R82obTsfONbfZgQNanS9f/DWXLjJHMaqh/
	 cO80H7iJyhO01Y35YnULVpSLGdq/+Qnpa5OlkedY/hXWqn+zJK7SwQpZA8yEeogcX5
	 joNBN0ArNaJLosITD1UdQvdSC8lwS5psFyHLRndQMMCFVwUh14ws91z0KWe2roaVed
	 MGeefhQq/6j9g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/2] Fixes for "mptcp: misc fixes for v7.3-rc4"
Date: Thu, 17 Sep 2026 15:13:12 +0200
Message-Id: <20260917-mptcp-fixes-7-3-rc4-v2-v1-0-1553391e7815@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKz7oBJjZpeRbrQONopNA2ZKIJ49
 6a6fLz//g5CkUngUewQaWXhr8+gbgW4V+9nQh4zgy51XVrV4CckF3DijQQbvGN0Fa4aK2PaerS
 2NZOCHIdI5ya3HVyNpy3B83KyDG9y6f8Mx/EDYJ0nV4YAAAA=
X-Change-ID: 20260917-mptcp-fixes-7-3-rc4-v2-45586d9985f1
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=754; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YbrHuHx5DgQmoc74M4m/3WPvDRRWqgDXoB35dalTY9c=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJWP2+v3XL8JJt0P6eM9MZ/QhzLVq9irZrQOCVITbL4V
 E1fu0toRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERu7Gb4X7Aj7cVW8b8n9ffd
 W7c/8txflu+NUalbLuS+6FdadOe9ixsjw7Sjk80/xM5feXqHU+2amao2TzOunVb8wtcu76iwcFN
 wIgsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are some fixes for a previous series.

Already sent to netdev, hopefully not to delay them by one more week
because of Clashiko being a bit picky. See the ongoing discussion about
Clashiko blocking subsystem maintainers.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (2):
      Squash-to: "mptcp: avoid unneeded actions on subflow reset"
      mptcp: fix bad accounting in __mptcp_subflow_push_pending()

 net/mptcp/protocol.c | 7 ++++---
 net/mptcp/subflow.c  | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)
---
base-commit: bedb886c7c67296d93549ab0f5ae6255be0846ae
change-id: 20260917-mptcp-fixes-7-3-rc4-v2-45586d9985f1

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

