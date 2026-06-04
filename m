Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638DD3B0AD9
	for <mptcp@lists.linux.dev>; Thu,  4 Jun 2026 04:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780546909; cv=none; b=ihHZTf9DLIGGGYNEFmXlBploxWy4l0t0WX/ZbnjN6t1yQAhI0L6wMazivqrTQqm23P5fNTTPYIhQxtJC17A/4AHRMLXgt68sxcmMBAZJG7oGtY1Zf+q+LMrUWkSAAiWGliLBD5IBHDxjXCJqf+XnFbq1BgFMfCDu7wUDc971fwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780546909; c=relaxed/simple;
	bh=eDub65zIUjGuO/W9mERRueutql9UBdlHcVndSYt1d2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/OYT9vQdjq3cNXC5H6guuX32b+RNjDs6LfyVbDUQypniPOgFu0PfMQy27ktsHvDnlK8dJPz0ViRcZ0I0QEOpHSVCLv2HzRayXVKGeyN0b+I4owS7GVvcKMeFGZ8FZFl/+WOv31LMxN6TuFrI+FAg1ptKjCUwPgU6U5PKKjekuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIZZi5SA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIZZi5SA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A681F00893;
	Thu,  4 Jun 2026 04:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780546908;
	bh=MVkF3Ab8cWP0cf/SXxqJpMxjSz+9NECDsKESm/pJJFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VIZZi5SAYtBGorjqpgG6ssIxNlaGqnTjazA71slXWZKtOkpEARzsDEc1gV9resnBp
	 wxFnJJSUSI0ltgP4tSmL5G7JgZ0ks9PPW4vo0gHtW/yon4GJ3m6jX5siY4+uaKBqGW
	 xnsp55I1XnJYVcQHJFy5jyJdyT9S1c3d9TECQw7Nfu8x2jAHGTxM8Msl4IK0BYRJBA
	 lWJANffHJbveJhXzJDZtK+L7EwjYQ3wk+S2t9vBfYp+8hDafyOhEQ2PO0vAyXzb2mO
	 TFN/7VCnlruiuOwZoKwf2v4mBx8jtnfURHD4kWxrDLf/9C2pHqqeU6p0ccw76hOWq/
	 LtX3IpBM83d0A==
Message-ID: <61b80757-6e99-40c2-8df3-6fd8499a0e31@kernel.org>
Date: Thu, 4 Jun 2026 14:21:40 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: pm: use timer_shutdown_sync() on free
 paths
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, pabeni@redhat.com, shardul.b@mpiricsoftware.com,
 janak@mpiric.us, kalpanjani009@gmail.com, shardulsb08@gmail.com,
 Li Xiasong <lixiasong1@huawei.com>, Li Xiasong <xiasonglee@gmail.com>
References: <20260603115634.2292342-1-kalpan.jani@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260603115634.2292342-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 03/06/2026 21:56, Kalpan Jani wrote:
> Replace sk_stop_timer_sync() (which wraps timer_delete_sync()) with
> timer_shutdown_sync() in mptcp_pm_del_add_timer() and
> mptcp_pm_free_anno_list() when freeing ADD_ADDR timer entries.
> 
> Issue #623 identified potential re-arming of ADD_ADDR timers
> after cancellation. While the code is currently safe via RCU
> protection and timer_delete_sync() retry loop, it relies on
> implementation details rather than the documented timer API contract.
> 
> The kernel's timer API documentation states: "Callers must prevent
> restarting of the timer, otherwise this function is meaningless."
> timer_shutdown_sync() is the documented API for this exact scenario
> - it sets timer->function = NULL, permanently preventing any
> re-arm attempts.
> 
> Benefits of this change:
> - Uses the proper, documented kernel API for shutdown scenarios
> - Prevents re-arms at the core level (sets timer->function = NULL)
> - Eliminates unsynchronized timer_done check in
>   mptcp_pm_free_anno_list
> - More robust against future kernel changes to timer internals
> - Removes reliance on timer_delete_sync() retry loop mechanism
> 
> The change is safe: current protections (RCU, timer_delete_sync
> retry loop) remain in place during the transition. This is a code
> quality improvement, not a bug fix for a live crash.

It looks like this patch is corrupted:

  error: corrupt patch at line 56

Plus, the CI tries to apply patches on top of the 'export' branch, it is
often easier if you are on top of this branch (or 'for-review').

Also, please sync with Li who is also trying to fix this issue:

  https://lore.kernel.org/20260526103647.732350-1-xiasong.lee@gmail.com

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

