Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E0F3EBF3A
	for <mptcp@lists.linux.dev>; Tue, 27 Jan 2026 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496566; cv=none; b=jlKL1lVTb1ukGaNmRpfhDusLtvAe9muUe4g8B71ZJVzbeWPdK9cKWaZ0IHs7JNiVg+cWKop2lYwyW0SLzcoS5krH1JX3zO0ECNjncChe+mZ27q4y5ujfTxkMgY3iJgvlv9kXmE3am7v9n7gI7UkXDNFB1wVUAneGizfbvbJomZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496566; c=relaxed/simple;
	bh=lbB/PXyCZrVbU/5TFFsqHuiK2IZIXOHQPYRbxz7cnOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kCd4018aJikvCOnQmJzz1pzgNO4efLhDph1x1n7d7cHQJiy8RTsnskhEQPp6stsuvYjGxWGoaoXWVNXN3fE4LDU36iTLWbcxdRy2hkIQW6G2EXRfiAfTcB9wtBHT1dUUywtGx1lWO6GMu38+OJ+aDBe6pX+0VMuKeCPdnqZtmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaQc0Cyl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaQc0Cyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DF9C116C6;
	Tue, 27 Jan 2026 06:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769496565;
	bh=lbB/PXyCZrVbU/5TFFsqHuiK2IZIXOHQPYRbxz7cnOQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iaQc0CylCTWV5xSbX9pAB4j66sEqyt0rpH1gePe3t36JyxvndPYWtpvtJ710krqkL
	 rV31uWXVfy9z8hnIRg0OElkHP17i9YdDrY3XGAKUKJ8UtZw6NXcB7eoFNjwd037rdZ
	 gogHM/ZmoCV6K7lG9gxQ9ZORc30ul1ijM+bN2dc12GCaZSgzmOO/NYBT4mrqO+2W7Z
	 mlT31geEt++QM2QFkjbtDfvg+Ng3i0WhjF/zTNV0NeAer6GH7V22bywFsfBGh/YayX
	 nmlwBVnoHM/bkQ8cI7zMkKrg5zsrKEyGSEdRnaFVdTABhenHGAnbPB/vgPkdIl3iZe
	 Qu5zN3l0z6ZRA==
Message-ID: <2ce6fadb135d3d2227032c8b5f553f328f5c96ce.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 00/11] mptcp: avoid dup events + error +
 misc.
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Cc: Marco Angaroni <marco.angaroni@italtel.com>
Date: Tue, 27 Jan 2026 14:49:18 +0800
In-Reply-To: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
References: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this v2.

On Mon, 2026-01-26 at 20:18 +0100, Matthieu Baerts (NGI0) wrote:
> There are two fixes with their tests:
> 
> - a subflow closed event can be visible multiple times, see issue
> #603
> 
> - the subflow closed event didn't contain the error as expected.
> 
> The 4 first patches are for -net, the rest are small fixes and
> improvements for net-next. Some tests should be quicker now.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to me.

Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
> Changes in v2:
> - Small updates on patches 1, 2, 3 and 5 (Geliang)
> - Add Geliang RvB tags.
> - Link to v1:
> https://patch.msgid.link/20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org
> 
> ---
> Matthieu Baerts (NGI0) (11):
>       mptcp: avoid dup SUB_CLOSED events after disconnect
>       selftests: mptcp: check no dup close events after error
>       mptcp: only reset subflow errors when propagated
>       selftests: mptcp: check subflow errors in close events
>       selftests: mptcp: join: wait for estab event instead of MPJ
>       selftests: mptcp: join: fix wait_mpj helper
>       selftests: mptcp: join: userspace: wait for new events
>       selftests: mptcp: join chk_stale_nr: avoid dup stats
>       selftests: mptcp: join: avoid declaring i if not used
>       selftests: mptcp: connect: fix maybe-uninitialize warn
>       selftests: mptcp: connect cleanup TFO setup
> 
>  net/mptcp/protocol.c                              |  13 +-
>  tools/testing/selftests/net/mptcp/mptcp_connect.c |  19 ++-
>  tools/testing/selftests/net/mptcp/mptcp_join.sh   | 149
> +++++++++++++++-------
>  3 files changed, 121 insertions(+), 60 deletions(-)
> ---
> base-commit: b8bb952910af48167681524c5b217996c16382c1
> change-id: 20251222-mptcp-issue-603-d85d967f7c0a
> 
> Best regards,
