Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5127F3DEAEC
	for <mptcp@lists.linux.dev>; Thu,  2 Apr 2026 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125246; cv=none; b=eCCdf3dqmDJmywgyJPCY7CrdDDigv7K4gT5BJOhJW9oirZkl+DF2WC8DeeDsRghE05gPQubSsOoZKgd8uZuQdDUN8nWdXkmlq/o/uduRQrxMRO4KQIA6Hykhw0uyBAOw3/vlLRIqpCorExOpnBzLbkLdWCDwVJc2z6Vih41KkrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125246; c=relaxed/simple;
	bh=UeXKJksgI99yvR1k3VC1NTTZinaSsV0v0RE+EPcJKeQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FvB5ZaJpdfiBFFEHoPoLt2oCJOyh8bgkQK4L8zac3xgp49ILFAX9PKqKJulcnesri4xSH5tzGcEVhFc2Z+01IFY5n37h8y09FY2kKG0Z2SGjR0WpJwupgxeOV0TqHqwDyxNLRk/0tJJIfa2DkZAPGGVbaWOl5XQtFm+i2ZUTJAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVvee31j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVvee31j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AB7C116C6;
	Thu,  2 Apr 2026 10:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775125245;
	bh=UeXKJksgI99yvR1k3VC1NTTZinaSsV0v0RE+EPcJKeQ=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=mVvee31jMDBfa0c7cSDB3MvqA0Ce7csOKOCxWaBt/9NR9LyBB0slw/WHaTL/6RtPe
	 p5kVRAkvRIDEaO6+ZKvdlO1QsuL6LjRhMrN9Sq5GPjmqebnTKQgsklrbKcE8dyfbCx
	 np9+6wozf/ECCqYRRKJT+EVK2Xu2w5mQ9NAjP603Bh78vpSF/Cj+889h1XO3ZcvWeS
	 LTjIqHkTt7sgAzaiEEl2Zn4UqdKltTWngZzWm6XrMDan4zqQ55jKIFQfhCvMvcVYD9
	 rNvJM61yEe/Kcc2mE1BmmhhdWhB3wYg45sUAxAKlWcJFxHdGRhej7xTdrez4iwSGUM
	 eo3YTT7RG6PGQ==
Message-ID: <f0621cfde5423d780c9eb9210e38f71c8493dcb5.camel@kernel.org>
Subject: Re: [RFC mptcp-next v12 00/15] MPTCP KTLS support
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 02 Apr 2026 18:20:42 +0800
In-Reply-To: <0a9f16f7-6991-8e13-7e2e-80f361579e33@gmail.com>
References: <cover.1775115102.git.tanggeliang@kylinos.cn>
	 <0a9f16f7-6991-8e13-7e2e-80f361579e33@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2026-04-02 at 08:17 +0000, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build
> it.

Oops.

 protocol.c:(.text+0x2675f7): undefined reference to `lockdep_is_held'

I should use spin_is_locked(), not lockdep_is_held().

Will update this in the next version.

Thanks,
-Geliang

> 
> You can find more details there:
> 
>  
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/23890722509
> 
> Status: failure
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/88f07fcab32d
> Patchwork:
> https://patchwork.kernel.org/project/mptcp/list/?series=1076267
> 
> Feel free to reply to this email if you cannot access logs, if you
> need
> some support to fix the error, if this doesn't seem to be caused by
> your
> modifications or if the error is a false positive one.
> 
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (NGI0 Core)
