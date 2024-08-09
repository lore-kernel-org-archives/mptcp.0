Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CBC1DFF5
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207084; cv=none; b=ZH26qsud4OPYuLgr5PdW5sCDtItWO5/BkItoGxt0CxmYdkc5T1niQAQH7WcpbG6tl6xbKgMAtaicBZOugO8u65TlXD22YAx/szLsH8LukIlrHaGG83FbdfvZVMz27BQ8QmJsE/Vuc9GXhCzbI6vKq7hi7+g6GnQS2N8zXDGkQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207084; c=relaxed/simple;
	bh=XpW0nWNy49OzQ7pVOF9AyiVfb81nhGIsjRbpT760rLY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UQc+pGXSpv7uqqP6kdc7acMgbs79ytbb4hUtwtwb8/CpSbZ46CHDPvACGHjjinMj1iknQiy9YhJBZsBuvLsr3wg8rHrq2a0CPFX5ujZWRf//Ajk+0fhn+060KIZcmWlvT6azsKtUcyTqlHuXF3lFBcezkfhhydy8yM7ZHLCMCjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufLZs7HF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufLZs7HF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEBCC32782;
	Fri,  9 Aug 2024 12:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723207083;
	bh=XpW0nWNy49OzQ7pVOF9AyiVfb81nhGIsjRbpT760rLY=;
	h=From:Subject:Date:To:Cc:From;
	b=ufLZs7HFXOv5X4jV9xZ2ZbU8MxOTcSXZro0/uSwRihttFL8ws5UxrDgwYoD2OeSm5
	 QdxvaoFkoWaWQNOePrHbPWhGw5zqi/kbjD65I1J5EbR60Ivsi5qZEo9+t7daxnIO++
	 QCd72cTox1+pkbea74ZvotpKEyLpect5GKN8zPhtMiLW4sV6a7N4/qGrNMdiRmzz5x
	 39JTj3XNqNI7AI07UabxlvQ6I23lygvEFrTwSVJBpOgo7xyg3gCGNpbrcY3SGnOKFf
	 LEiQwox+wMAjbYODeolKcSyp/S6ZkNIPT1MOyItvQEsGh2Zp4DQoZj4C9E2M0FTPGm
	 g9todMCUAFl8A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v7 0/3] mptcp: pm: more fixes around the ID 0
Date: Fri, 09 Aug 2024 14:37:48 +0200
Message-Id: <20240809-mptcp-pm-avail-v7-0-3d0916ba39b4@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwNtmYC/2XOwW7DIAwG4FepOI8pBgyhp73H1EMIpkVrk4hEq
 FOVdx/LJjUbR8v/99sPNlOKNLPj4cES5TjHcSiDeTmw/tINZ+LRl5mJRqhGi4bfpqWf+HTjXe7
 ilQckadE4UgpYQVOiEO9b4Tv7yQ60sFNZXeK8jOlzO5VhC/y2wv/WDLzhTlvhkVxrHb59UBro+
 jqm89aVxdMbwMqL4kOPgNJ5CJoqL/feVl4WT1Y7RAs9eVl5tfNCVF4VD+iCN9KTbFXlce915fH
 7fwcAxnuioCuvn75t6vu6eKuV62xPwtjwx6/r+gUtmgrb+AEAAA==
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XpW0nWNy49OzQ7pVOF9AyiVfb81nhGIsjRbpT760rLY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtg2q2tpdrJSzuCnN3xxyuFrUKQH+kqB7CJemy
 rU8ks70HHaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrYNqgAKCRD2t4JPQmmg
 c/k+EACekDpZOm1oDXN1Wm6axYSLbZCBMDIsBuW2MifU7Rwb/QhObuneuc37SoKZJZ+l+8xzTJ0
 yql4p2BdRHowHrF4mJ6FoYRfsdYYwFjDkK7RIz4pPMU9F/Ok7BzQ3VfIzCxEOu4VtrbnH2yKB4/
 gzKHf1MLtq0radhUbeBrqd9cyJ69qu0SXt5PEfRumHIERqoSXhwv7B6eidCh5NJC/02vwclVpqQ
 qQLV5UK38uJnz3g3eSB87YqKu1reQujpLAN09zB5Sq7ucOATbPipetZ4Odv+jP9Q3JxyoE27UI1
 4Ljl9N2meONECFmNKGrYI0P0bjxFeYNy3Nu6V5WzhEVmMT5N1iB/UY9SHP7koHWHkXWBPjO9oeL
 M6Q6HetgUQF76ebb2fjM7FUvJnDErtGetrMumzaFbIkoJrlQgnPXMCwR7pp710PKmDy6mahjc+r
 5RCW4aeahewNP47CKG+VnoXjCBJQUo3vcfEKvsrOW2NNJawbX563AXNy4zT1NtYa54wE2FU5FTB
 I7KnIzkht3/AyNVMgABWOa+C8WUbJGTUR72x3D9SGvCRfjhDrhWlrAvoxTBBEg6h6/hZ815oP6g
 zklvZcU9MleGj3l1vXOyWDFJhRhaJopspXSPUWJimWFxJQlGyCsrRZPM4vk/y8oTZkzXG7E8MwS
 oEIRhzwWfra6IhQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 8 first patches from the previous version have already been applied.

Last fix: the subflow is not closed when receiving a TCP+FIN, when there
are other available subflows.

The last patch is not for -next. Something that sounds better to do.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v7:
- See the individual changelog.
- Link to v6: https://lore.kernel.org/r/20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org

---
Matthieu Baerts (NGI0) (3):
      mptcp: close subflow when receiving TCP+FIN
      selftests: mptcp: join: cannot rm sf if closed
      mptcp: pm: send ACK on non stale subflows

 net/mptcp/pm_netlink.c                          | 14 +++++++++++---
 net/mptcp/protocol.c                            |  5 ++++-
 net/mptcp/subflow.c                             |  8 ++++++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++-------
 4 files changed, 25 insertions(+), 13 deletions(-)
---
base-commit: beede3e0f15d8869512b5b51e580829ab6939f92
change-id: 20240620-mptcp-pm-avail-f5e3957be441

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

