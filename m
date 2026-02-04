Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B988E2E65D
	for <mptcp@lists.linux.dev>; Wed,  4 Feb 2026 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770169531; cv=none; b=UqlAHha/PR2GkO+rmur+RRs54refAJbW5sc3/ngmbAxPL29NKmOFo9js0mliTG/mB7FXUe/nDQhfwV1rDxPSPbj4D7Vjjwidf4+M96fiirro3soFZK7zD3GaX73smaPPnCMEmQMtCOL8/7N+oy1yjtLRIFS/SiqUOu51IWAa/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770169531; c=relaxed/simple;
	bh=O1XZdB6YGcONi2DHJvn/xOkL6EiQcFEc+n+lG9II8Mk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=STOtcWxZlbT1GnhB8MoY0i1nOhZdtshBOClQ6sUtqgFEPHXbnrM/2OsF8W+ydMSGwn0kikEn6qqlFZHXX2AIF1oDW+Ukq8OqNkwrAueGXRpy7JX/gjyXVQrVujQ9jb8y2e6IwD06ly4O+6NBIJKrhiyk/X/ut5CDLtGzL+52bA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkwxCo6L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkwxCo6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E489C116D0;
	Wed,  4 Feb 2026 01:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770169531;
	bh=O1XZdB6YGcONi2DHJvn/xOkL6EiQcFEc+n+lG9II8Mk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=qkwxCo6LVWagoG1X3sNvN9HWqctxt0wag9JQ1jcIDN7uFderceQ7fltVS5lUQbg1P
	 2G7g7wQbEuPlx7PVqFokRKjSZowXwsZDRDle+myE7E2RwFcS2KrtwQvASo7luU+KNA
	 6omhwJrt7WorNNtR5DS6WZNMfV5Zv7MVl4BcT8XPZSNSvs15ciHgmbEEh1xdIYRe6J
	 SZKp7DkFJp51F2d1x3N2PJ/1q2qY48fnAgyvshAWfWOIn/Mzr6Mpzb0mEeScSbBv10
	 v0GfDcb1QDX4pwbT58+Rhfg5T9nzESmLvowAwaEpwLZMiB9FcmkcwqVbYIrqSMpaPa
	 mE3JgjzSu7AWw==
Date: Tue, 3 Feb 2026 17:45:30 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
    syzbot+f56f7d56e2c6e11a01b6@syzkaller.appspotmail.com
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: pm: in-kernel: fix issue 606
In-Reply-To: <20260202-issue-606-mark-subflow-endp-avail-v2-0-7f9df0ae6157@kernel.org>
Message-ID: <b57d780e-8395-39c3-4758-61ba85967f3e@kernel.org>
References: <20260202-issue-606-mark-subflow-endp-avail-v2-0-7f9df0ae6157@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 2 Feb 2026, Matthieu Baerts (NGI0) wrote:

> The first patch fixes it, the other one clarify the code. I think both
> can go to -net.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v2:
> - Patch 1: avoid setting the bit twice + comment (Mat)
> - Link to v1: https://patch.msgid.link/20251215-issue-606-mark-subflow-endp-avail-v1-0-2f1b36da8993@kernel.org

Thanks for the v2 Matthieu, LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> ---
> Matthieu Baerts (NGI0) (2):
>      mptcp: pm: in-kernel: always set as unavail when removing addr
>      mptcp: pm: in-kernel: clarify mptcp_pm_remove_anno_addr()
>
> net/mptcp/pm_kernel.c | 29 ++++++++++++-----------------
> 1 file changed, 12 insertions(+), 17 deletions(-)
> ---
> base-commit: 1f27d14ad2803370bd6232df91f864f12f77ead7
> change-id: 20251212-issue-606-mark-subflow-endp-avail-ccc3322ff800
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
