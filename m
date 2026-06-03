Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C02305687
	for <mptcp@lists.linux.dev>; Wed,  3 Jun 2026 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780462551; cv=none; b=VCKBPRkGM6pr95CUdzB9vwWhl/1PokhspqXEWivessgznVZCVtnJjhbCZw4bbOVWlJrgm6Bx7bjWJjXOHr6DoqlYF+BeazhwUQabuOWygp8GlQ23y1bM1Pn9QIfMYoaMjZ0h/s2PaFytqYXGD11m3Wwg7nRgUuKM6GR0bxEDa0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780462551; c=relaxed/simple;
	bh=slkgr+Pw+ZYEuAW7M49S2HZDFXLdO0f+jIp6S57JKTc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=leu9e6plT8a2O5O1xjOukeVwfuNzpCcb+6OVrTgb3NA3ASVPZpO+4spZoR4WjXMfmTak/VyV29fQbUOiefPUdJsE6ApePQtHSoS1EaqGZ1ElORXkBl5jx93JCSKVWkkChZ6G1zcnt4ywFkTJXkfTp8YNOpPjxyw6KfLX6aJNbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX0HnyQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX0HnyQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF5A1F00893;
	Wed,  3 Jun 2026 04:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780462549;
	bh=nYm9frN0oeoYOPsWAhZjk5B2HQ0yNYEEVRPCfEPaMu8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ZX0HnyQZA5F7gumb51EbVzSMIDA2AHY7y3ZpRvtvgyWCOcd2LT0sCUqRwv3MHKKJu
	 OJ2DsMts595Jm7dNULucCqViOZ8FhbcUxxpYvqlBwTHZoa5OT+OfeHCtrnr6Ol/uPG
	 0ofn7Mi2DhxG5hEIFndnNIVMNiDw1Fl6/biXRoorUsdG4lXCfWHbosEOetQ1WK3zvE
	 xTwOK/GxFBMoW3UcDj8ObFXIJk1hUYJbbpMQKQqauyl2I3DiwlvED+38EuyONpimLx
	 ioJL+iq8c8tc7CINlpE3WnLYgIZ4MMgVR0mMe2Y8vDl9mK3Yq2i/cS8BQuvWPqwsTQ
	 Dwbsp9aGK//GQ==
Date: Tue, 2 Jun 2026 21:55:49 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [Weekly meetings] Different time this week or cancel?
In-Reply-To: <30da2c98-fa53-4cf5-917e-d692b8bece6c@kernel.org>
Message-ID: <d61c1cb5-5289-adb8-691a-bd2d77bbef7e@kernel.org>
References: <30da2c98-fa53-4cf5-917e-d692b8bece6c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 2 Jun 2026, Matthieu Baerts wrote:

> Hello,
>
> Again this week, I'm not available at the usual time: 15:30 UTC (8.30am
> PST, 5.30pm CEST, 12.30am CST).
>
> I suggest either having it at a different time, e.g. on Thu at 0:30 UTC
> (Wed 5.30pm PST, Thu 2.30am CEST, Thu 8.30am CST, Thu 10.30am AEST). Or
> cancelling it. WDYT?
>
> If there are no new (major) topics compared to the last meeting, it is
> fine for me to cancel it.

The Thursday 0:30 UTC time doesn't work with my schedule this week, I'd 
prefer to cancel.

Thanks for checking in with us,

Mat
