Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0619B679E5
	for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972915; cv=none; b=nMJJT3aBl5rJXIPu0uk9LwAUjmm23gLHLqEFX/ZYOgCBnEi83PtiITd/SVwfRybZ7pjspUEy/4SfgIIguIh45TKPgY9WfRQmCYby1NI4CNNmakhT6z2XR1NyX4U12W82d5cSR3ELNBQTS32fjPyBS73azbcSXkNxb2QLP/euybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972915; c=relaxed/simple;
	bh=o5ygYxUaz/REN0N6ddP0XFOGf1OantBx5C7vfhqcq1I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZcJbn14tJ73mNE2Um6Stj9MCTfv5iQSEWci8kseYfG3osPf1gCmZthaBuYZV2U9uL40VENMBotlrpFfAIQj1vlozRkEEpEz85809FHGWm3QOsjdSylP9Y7taS61Wq/dOilEIDB53KNMt9IssUkY2mZN/jRlMCWud0uJQHP0s4co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzUkiNVt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzUkiNVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9142FC433F1;
	Tue, 23 Jan 2024 01:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705972914;
	bh=o5ygYxUaz/REN0N6ddP0XFOGf1OantBx5C7vfhqcq1I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=fzUkiNVtByY7zD0yYoaudFyj5pc1k6IhGixVRoo1Y1l8ibbpqRdSg0mfhJ88oyB+a
	 k9viIJRcHmdNF8uZKnSSOpYEGc2omshdORZPZiEJQVwoy9LqEB8o9+hwMipQMeMR0B
	 yNZlV+50nCljK1aUbUlfXhYLM0EW/zCGAdgNtAxJ1v/2XaYa9WcWaBhPaTjTojj9z4
	 vWxutGaR/l6xJeTVYGCw609MAMvCvlPJEwKdOSXbx7fmdZHxjEwdsep9lNIQB+oS1B
	 87uyCFAOmF46r2LfHdCvwxK6vtUXb8jLFGhoJ0YT4mupYJPRPgkSTZO+YH5BOQ7ojJ
	 6tnaQGZxfrSHQ==
Date: Mon, 22 Jan 2024 17:21:54 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/5] mptcp: annotate lockless access
In-Reply-To: <cover.1705427537.git.pabeni@redhat.com>
Message-ID: <781e9eb6-ae85-81e6-3335-33b9558e8c2d@kernel.org>
References: <cover.1705427537.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 16 Jan 2024, Paolo Abeni wrote:

> This is the 2nd preparatory series for the TCP_NOTSENT_LOWAT support.
> The latter will need tracking more state under the msk data lock
>
> The mptcp locking schema is already quite complex. We need to clarify
> and make consistent the lockless access already there or later changes
> will be even harder to follow and understand.
>
> This series goes through all the msk fields accessed in the RX and TX
> path and makes the lockless annotation consistent with the in-use
> locking schema.
>
> As a bonus this should fix data races possibly found by fuzzers - even
> if we haven't seen many such reports so far.
>
> Patch 1/5 hints we could remove local_key and remote_key from the
> subflow context, and always use the ones in the msk socket, possibly
> reducing the context memory usage. That change is left over as a
> possible follow-up.
>

Thanks for the reply to my question on patch 2, series LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> Paolo Abeni (5):
>  mptcp: annotate access for msk keys
>  mptcp: annotate lockless access for the tx path
>  mptcp: annotate lockless access for RX path fields.
>  mptcp: annotate lockless access for token
>  mptcp: annotate lockless accesses around read-mostly fields
>
> net/mptcp/options.c    | 20 ++++++++---------
> net/mptcp/pm.c         |  2 +-
> net/mptcp/pm_netlink.c | 10 ++++-----
> net/mptcp/protocol.c   | 51 +++++++++++++++++++++---------------------
> net/mptcp/protocol.h   |  8 ++++---
> net/mptcp/sockopt.c    |  2 +-
> net/mptcp/subflow.c    | 10 +++++----
> 7 files changed, 54 insertions(+), 49 deletions(-)
>
> -- 
> 2.43.0
>
>
>
