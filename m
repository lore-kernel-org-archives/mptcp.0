Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4E21755C
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987106; cv=none; b=JUTaA0a6KCrESBPBKTJM4cOsq+Sv1Ksuu6Y9H808vruUIPwkU4z4hlyLNwHygn7XKhDSAEVK0l3w5DK+/llLAeVknYpZ/fIdtjfDIvW6MtR0GNZmfJ5fgjttWvvgwZEnQvHngQDyJNT8vPSD6jNyMJ0I/Qe/UVxQANN9SBuXy1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987106; c=relaxed/simple;
	bh=XbTBvJIXJbPEfAhdI2OgsiOLd3CuSiKcTaRwM/Xy/2k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pmd6f/BG9EqJcxgSNqoD+GRWPE4yh+4rEghb8hZ0Eg4XjiS0AiS/zf8Qhef7VLeLeqixs3zaB/h4CmFhcY02pBb7zJ7YCJCWPDM0EDFuLDC/puy7Jsiw9JxTEaF76SJXaQ1kLjGKW1P2WaEjxl/SGKYddyQKeT16HSNHMe70HbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLEPHoM0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLEPHoM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0606DC4CEC3;
	Tue, 10 Sep 2024 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725987106;
	bh=XbTBvJIXJbPEfAhdI2OgsiOLd3CuSiKcTaRwM/Xy/2k=;
	h=From:Subject:Date:To:Cc:From;
	b=DLEPHoM0p4VlriNC49zzal0Dj0t5TPuelN0MwzMJCFaRMiB43wpdp1/Vc1zw7UKEw
	 BjWJHhsWevc816YSK4+7WzparIjAd8gvCs1aE048yqCcI9muypfP4S2+QeJUSiohRx
	 yKs695K5Rq3xdeBWqH+vqUfdZew61GKX4DZALqP2R1GXo18W8ZlKDmb92VnW1HFkQt
	 uLf97523Lbdd9PRnRtUog19B3c1RZfXLf0eX8abbP7mTmTFk7o16PKVRLC9+jZb+P+
	 m7w5febUi7p3UelkzSsiCVCE1XlLV40CwGWtXkHZUNzfd5j4IItJa2Hl6FF+bCMrPl
	 9laUS7ocj8MTA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/3] selftests: mptcp: misc. small fixes
Date: Tue, 10 Sep 2024 18:51:39 +0200
Message-Id: <20240910-selftests-mptcp-fix-install-v1-0-ed1fdb92aa02@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABt54GYC/yWMwQrCMBAFf6Xs2YW0FEr9FfGwJK91IcaQXUQo/
 XeDHocZ5iBDUxhdh4Ma3mr6Kh3Gy0DxIWUHa+pMU5jmsI6BDXlzmBs/q8fKm35Yi7nkzLLKjCR
 pSSFSP9SGrn/3G/3zAqf7eX4BjtBqB3gAAAA=
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XbTBvJIXJbPEfAhdI2OgsiOLd3CuSiKcTaRwM/Xy/2k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4HkheUcCzrzdAZXB/vzIeR3KvH6XdVk9WsPou
 iPlz+aR0n2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuB5IQAKCRD2t4JPQmmg
 cxdyEACMjUcN8tHO5EUr7TOXQ+fUqMwJAouXvARVl7rGgorsMXFTnm1z3Gj7OorfBevBvLRNnaS
 PENUWFzvHBytelpJhu1XvD6dp2q0rLFNNzxUF+WL9AE2wq4mfrk1Ii2ct0Ad8jC66a+GanMhHSF
 MNEXKNt//KE7RrWKCX2GTSpxQIejy+DAiRtjMkUivIC/z8nLqvWqurGsNe/ziLrwTrdmA32050u
 aRMhy1CE5XEEuFSovva+fl8QYmb26BdF0vgRBa7GdfMz9Vo4qiGN2Wqm+N8KzuQuLNOdvLpKpIl
 rm1rvGyQpT2nnP9I+4ZRrSnAG2UY0LZgC/vc+QRkLM9yZJPHj+9GV0V+46CHl/z6/XxXyZB7CwJ
 pu3WAkmvdjPZLI02+5uWkh+JGh6/OC/6v7oCzmud2uKaXyPbmotCR7vgGe+8WQMxTTgMP4qIZf6
 zLCfbxTs1xIdUEMuxhX1W/9VoQx/hjGHnI/UBRXFPCqg8qplORE+1wRv0SE26q76HzAftCYXXIy
 w1MLrbSNXwvO0nfWd25ugdA4MtH8ovXoci8C6m5F7hq7cJnIu4MU3J4v0tD3Bgvr3bEtexGh+i0
 ZOVdoc+6NbNXUsTFisb4axfKbfEukd+3AvC4inBCHDt/2sdbqkVmTyyhO2TSV8ZhGxGSaW51CD7
 oJLOdm2ex1VwrKw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are some various fixes for the MPTCP selftests.

Patch 1 fixes a recently modified test to continue to work as expected
on older kernels. This is a fix for a recent fix that can be backported
up to v5.15.

Patch 2 and 3 include dependences when exporting or installing the
tests. Two fixes for v6.11-rc1.

Because the fixes are quite straightforward, I suggest to send these
patches soon after to Netdev, hopefully to be included before the final
v6.11.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      selftests: mptcp: join: restrict fullmesh endp on 1st sf
      selftests: mptcp: include lib.sh file
      selftests: mptcp: include net_helper.sh file

 tools/testing/selftests/net/mptcp/Makefile      | 2 ++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)
---
base-commit: 085cc64096c367f8c90237934304f82384d37e5d
change-id: 20240910-selftests-mptcp-fix-install-a9a4edad7d0c

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

