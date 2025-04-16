Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BC22301
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788579; cv=none; b=PbF/PbRL7dPqQFSELhLD5pSM3ANiawaS8dYkXdKMJN5+S9ZVvasET3vaRnws6TOYsObZC2gar5coohtf6Pf7hGHzDSX+KL6QyrmUqkbOdWcoTPc6K/2344RVjxH+jTb22QKMKBQ9NknU3WGXMvGOFBmaeHcWTtOg0Rzz2iTKwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788579; c=relaxed/simple;
	bh=TIChxUATx5DhX08LSREkhu77Qc8TJDta739s18CEga8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=oyUb9HM1nmUAfBYJ9rsRN7ihQM5w6HAayNZOWDsDuQKthAogm6ZNX2d5sBFo8PDyzZ5c2ryk09FUE8nHiW6DlvWRybl3oDpBZ1E725sT4Hdyxo60bxs77wmUN4fKsbLAN0b5d9uyTAf1pWZu/JP5RmHpbEiwSwk58mZzVMDZ678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHG0tN+X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHG0tN+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5689C4CEE2;
	Wed, 16 Apr 2025 07:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744788578;
	bh=TIChxUATx5DhX08LSREkhu77Qc8TJDta739s18CEga8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=ZHG0tN+XZtS9nHa3/fweVR4oEejeltUPgRsZdFUxs9UAXgtMwBjae9X/gEUK4V5Em
	 pQTfqkpIUc0ooVu9Ol/cCzyyaESMAld0K3y3RujF3OIxHk+aKPUs2aYadGXT7rhUgN
	 74NhEQCChtuDb4bNcrOiAX4l/t+IT6MBHIOJMLhhd3X0pEsf56CYU3mRktRNXaXQ5V
	 O3/XTiZDVA58ytql53zMlYZ5ChupwcD45HWvt7tjp7g7H/AdeL6e9RP36UiQ6n8yNm
	 1mW2tD6SDkhhxqgkppZDN1FhAdxPVzWmdwy97xubR2rMU5IOzcswG5Ow1j79hfhiVX
	 GAnSldIgo0oxQ==
Message-ID: <a51db524559756f66f544cfad08f2448b45d5080.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 0/5] BPF path manager, part 6
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
In-Reply-To: <ce0591ec28905dd087a74ea5abd762fb684fb17e.camel@kernel.org>
References: <cover.1743133948.git.tanggeliang@kylinos.cn>
	 <c81dfcab-0eee-45e2-8777-1b0c41e7f696@kernel.org>
	 <ce0591ec28905dd087a74ea5abd762fb684fb17e.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Apr 2025 15:29:26 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Evolution 3.52.3-0ubuntu1 
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2025-04-15 at 11:16 +0800, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, 2025-04-08 at 20:13 +0200, Matthieu Baerts wrote:
> > Hi Geliang,
> > 
> > On 28/03/2025 05:01, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > v6:
> > >  - squash accept_new_subflow patches into one.
> > >  - change "pm->subflows == subflows_max - 1" to
> > > 	pm->subflows + 1 == subflows_max.
> > >  - not to call accept_new_subflow under the PM lock.
> > >  - add mptcp_pm_accept_subflow helpers.
> > >  - drop READ_ONCE in mptcp_pm_worker.
> > >  - clear all the pm status flags once in mptcp_pm_worker.
> > 
> > Thank you for the new version.
> > 
> > FYI, I'm still thinking about how to handle PM lock should be
> > handled. I
> > will come back to you later. I might suggest a new version with
> > some
> > modifications if that's OK, that might be easier.
> 
> Thanks for helping me think about this part around the PM lock. Look
> forward to your feedback.

If you have time to take over this part around the PM lock, that would
be even better and I would be very grateful.

Thanks,
-Geliang

> 
> -Geliang
> 
> > 
> > Cheers,
> > Matt
> 
> 

