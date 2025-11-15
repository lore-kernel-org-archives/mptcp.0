Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81346224D6
	for <mptcp@lists.linux.dev>; Sat, 15 Nov 2025 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763170306; cv=none; b=lsnwqWoOJrSKsrRAp9DofG7vvA/3/Grn8dQj062HSbYOnI/8NXtOap3P3mT/BPzsIDpqVWWdVtm9+N+j4Cv+xUlcM4aqgfTmKbdUtLX/nDdm+WKIv08CEMwSU0RaBoQpP/J4kmqq7R7+WATUQg9l5bFulTuoppLoUs7Mgpwnbd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763170306; c=relaxed/simple;
	bh=3LXluIQxC1q6YysRlu/xPD9KqZDikd9SwRulyG50A2E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I3gGjuEK3bcZv/ccPdeVG8+0LkXGny+7y3ndzWTvmwUqiHrAiahALcCY/hfm6BGYVjvu69fTk1cY2PxkgucVlvDLyaU1Bp0ReUS6yxXqfvtSbeGRdcFwL3UWuGPDbsPvmwO21+qNeLsbaX9ydBI5TZ3aMZVXaJaJTV3+kxrVAGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3vFs6yD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3vFs6yD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FADBC4CEF1;
	Sat, 15 Nov 2025 01:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763170306;
	bh=3LXluIQxC1q6YysRlu/xPD9KqZDikd9SwRulyG50A2E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=U3vFs6yDddSOsZBDQ2653VYMdh2sFG9x13uauNy9fQlJs+R9yh1S/gQMTlG8O2End
	 60zkmGCHYyiWMWF25fyGnvtdYVes81ikOWDdPLXUmgSmhtgXBrO4z3fz09gLvTLipb
	 Ozq1oWUbdPo4AZRvHHnBdwUlazze6OMpcqtF35bK1YSc178knFhBYbNQf0Ymka0W5c
	 9iNeKJMSWDhBklJgRdCw9LFIWKNIqQRKyXHDBNakbyDEc+byzlKG6GM3N45lGQruSn
	 ohJFvMfmBxJP+W1dPdi372QS7FPaQOdGqyMQUNrXzB6VeONOAnKZ05etBsp56nYKbg
	 /0G0X7K58j3zw==
Date: Fri, 14 Nov 2025 17:31:45 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v4 mptcp-next 1/6] trace: mptcp: add mptcp_rcvbuf_grow
 tracepoint
In-Reply-To: <3446e68d2b4ea00475f82f3630a3b0a33a4b7b56.1762940290.git.pabeni@redhat.com>
Message-ID: <27ba02c5-3724-bf37-4f9b-e338fa9c34a7@kernel.org>
References: <cover.1762940290.git.pabeni@redhat.com> <3446e68d2b4ea00475f82f3630a3b0a33a4b7b56.1762940290.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 12 Nov 2025, Paolo Abeni wrote:

> Similar to tcp, provide a new tracepoint to better understand
> mptcp_rcv_space_adjust() behavior, which presents many artifacts.
>
> Note that the used format string is so long that I preferred
> wrap it, contrary to guidance for quoted strings.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>  - use __entry->family; note that its value is show as raw number
>    instead of string, as show_family_name is available only to
>    net/core/ trace and I preferred not moving the mptcp traces
>    there as we need mptcp-specific helpers, too.
> ---
> include/trace/events/mptcp.h | 77 ++++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.c         |  3 ++
> 2 files changed, 80 insertions(+)

Reviewed-by: Mat Martineau <martineau@kernel.org>

