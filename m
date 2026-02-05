Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5342B744;
	Thu,  5 Feb 2026 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306968; cv=none; b=D7O7TCSMJ7tCGMw2vvKl/JCzw5QF7vnDBI/UPQwKUjxGHPh4nTWMnesYd9Ekj4j+baObnuUK23oX0DfF/xZETgFiqIj09JtwOx77niJ/m8CAIXvz+VKLHR4GcjfLQN7wtA00wvjbcYt9fKKB+bzjTqr8wa6JHPhvVe4XrZNb+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306968; c=relaxed/simple;
	bh=JsMEdml05UXXO1TecyJMAgJegqNJqFJvEoxu8Sh3KiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRkPpbcu2dYA/b4zLo7qXRU+a3XPQOsGSGSa3/HmP8LbYzeRI2D78cjhLbN7Ei911n0xLaEmtiGMbBbcrCeN2RiEhsCNJaLp+PbN039A3C/0Ry37LzDrYqbzvz0AmVCNRmogfSwvlVDVfGAkmkh9NHFGKdKTpWulfUNkop/eqMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dhv8sfSs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dhv8sfSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED19C4CEF7;
	Thu,  5 Feb 2026 15:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770306967;
	bh=JsMEdml05UXXO1TecyJMAgJegqNJqFJvEoxu8Sh3KiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dhv8sfSs/6RteMCIQGiy2gyd5LNsb5jMsmlzIdShaca6u0IMHOrF5Eriv730NNNGH
	 Gdd/J930K/hWd++bC8zTB7eg7gqKw9k/Ig6saLHia4JgeMnFudVvrbEIRzyDqNES1u
	 NgTsD6Z+UEDY6cmM+iZh/5aJAsURJo7NmBcq+dCb1KxORyhimuJPq4D9rD6dEf9NIF
	 fzxBRvDX82bFvfvhEeMia4xxPqPHDrg5uX0DJ9ryK6VNE5fWOsvVSsNy1sS5eBs9bx
	 qXIFW5GpRUPCgw6TQfAhZOwVlzICQSaJhZaUBvkY+YJDdk6Q0VfjY/QZDIYgievVr0
	 HMYJfv/CZVDFA==
Date: Thu, 5 Feb 2026 07:56:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/4] mptcp: fix kdoc warnings
Message-ID: <20260205075606.5b94c492@kernel.org>
In-Reply-To: <f2f5c43d-bf6d-4fe9-9062-1f649d5c276b@kernel.org>
References: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-0-cb559fb6b50a@kernel.org>
	<20260204-net-mptcp-misc-fixes-6-19-rc8-v1-3-cb559fb6b50a@kernel.org>
	<f2f5c43d-bf6d-4fe9-9062-1f649d5c276b@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Feb 2026 11:56:39 +0100 Matthieu Baerts wrote:
> > diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
> > index c97d060ee90b..fe9863d75350 100644
> > --- a/include/uapi/linux/mptcp_pm.h
> > +++ b/include/uapi/linux/mptcp_pm.h
> > @@ -11,7 +11,7 @@
> >  #define MPTCP_PM_VER	1
> >  
> >  /**
> > - * enum mptcp_event_type
> > + * enum mptcp_event_type - Netlink MPTCP event types  
> 
> I forgot that this file was auto-generated from a YAML file.
> 
> Sorry for the noise, I will send a v2 also adapting the YAML file.

Hm, do we need some clever way to teach the codegen about short
descriptions?
