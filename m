Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F718EAB
	for <mptcp@lists.linux.dev>; Sat, 15 Nov 2025 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763170342; cv=none; b=q7phaEH4GV37hQ/jE+0su9MOs/RribhIow87xql7nuD8A4D7n9bdKB5daPPXfC2mfNcUx63gPLEbEgdsKB5sEehp4GlO4Vzteptc30r1BU/FBccYWsKnsfG2/kqZ8DLuFiXR+zx+xAvavla8RWaO2D5mCg+VDWhr6P7Kde6yjgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763170342; c=relaxed/simple;
	bh=FIQbt3OADdh3ZIG+Ki3zkj+vSJrn6YA9QfnI3XaPzik=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l9UrpkER/rzjUCEqmTdmezK9wZOny1LDCBMmYBh8dhMrFgtVCCaNm+y/6FVsM4FaNS7F5O/XoF6qoalf8onVoXlUSDjwnKUXhQWXkj23pd0DSvgKxtNm30vlHl3P5Vj1FxedgYdxnBp1PUaNoa36ZCcEwYjEO45BOJY0eU+ftyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW2CWhJB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW2CWhJB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2BCC4CEF1;
	Sat, 15 Nov 2025 01:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763170341;
	bh=FIQbt3OADdh3ZIG+Ki3zkj+vSJrn6YA9QfnI3XaPzik=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jW2CWhJBajL74PFX4SH5JNnFKl7YwKiOdD3vByB69gn83Bi7QHWVp58g3Exp53Xkm
	 GNBhQg9dwkNzmms6gOyU0zPCezdtBsX7/8ZwkJ1LUeS2C3FMDiQJ/Lceln8If1Wjy+
	 jgsg5qhtAw17U4r+AdI295MVWmPiR/zjYi2of7HXWa0+p8MHao8gfzCZXv0MyD+t1o
	 LTRvX0R6Boe9ikewCRAB/BMM2kHIE/ezqA1yefGKuVTdQHX53sJ7NDME2/4x/m6Mtu
	 hWQIN7lpdkvXkGCI9gTGUUhDD2BkU231rw0wvhLhK+bobXiPgZV8T7pAQIlbZB7NMU
	 6/sJhAveh9fkg==
Date: Fri, 14 Nov 2025 17:32:21 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v4 mptcp-next 3/6] mptcp: consolidate rcv space init
In-Reply-To: <c47f74f0d2e80d6734afe9a3607ad2537fcf9987.1762940290.git.pabeni@redhat.com>
Message-ID: <ee31c68b-3491-0da5-3ecb-20b36d8c6876@kernel.org>
References: <cover.1762940290.git.pabeni@redhat.com> <c47f74f0d2e80d6734afe9a3607ad2537fcf9987.1762940290.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 12 Nov 2025, Paolo Abeni wrote:

> MPTCP uses several calls of the mptcp_rcv_space_init() helper
> to initialize the receive space, with a catch-up call in
> mptcp_rcv_space_adjust().
>
> Drop all the other strictly not needed invocations and move constant
> fields initialization at socket init/reset time.
>
> This removes a bit of complexity and will simplify the following patches.
> No functional changes intended.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - split helper consolidation out of v1 patch
>  - additionally move 'copied' and 'rtt_us' initialization out of
>    mptcp_rcv_space_init()
> ---
> net/mptcp/protocol.c | 34 +++++++++++++++++-----------------
> net/mptcp/protocol.h |  1 -
> net/mptcp/subflow.c  |  2 --
> 3 files changed, 17 insertions(+), 20 deletions(-)

Reviewed-by: Mat Martineau <martineau@kernel.org>

