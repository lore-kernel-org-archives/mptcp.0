Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84663A53
	for <mptcp@lists.linux.dev>; Tue,  5 Sep 2023 22:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C8DC433C7;
	Tue,  5 Sep 2023 22:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693953355;
	bh=/GWunoocQWmqOKdlBUi2iPiIIA0I5Hl4racCvDh8qfo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Z7JjwyJcxWEA/Hm4i/3Jp1GwrbUj+5Tq2Ij+MB0TtBnDA9oX83UZ0aKt2UqQhYxge
	 fkr9lElJJ/FKyhTxWbRZ5DdvQujsZ3S5VJitykOFRY0y2Pf4zI+lXrU7virQsNxfiw
	 IyA9JkIzVhXlg1tDVZmP58zsrsa7u/+Yly45+O8b/AvMsHYiBKlxJN2ff06oEBTlzO
	 UFbxxnedAEjAa5RICEl7GhwJnoCLP1c5AA1Z5i2mmTrnJ8n2TahlcfTUu9/2NLfn8L
	 WQWOxRMOkey3yCRztx4ZyG94dAWXAtlw+9cW05ZgrC3L86BpfsL2tjIRwh42DhmAVc
	 gZGA5jRm4VGug==
Date: Tue, 5 Sep 2023 15:35:49 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Alexander Witte <alexander.witte@blueflag.consulting>
cc: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
Subject: Re: Subflows for specific types of traffic?
In-Reply-To: <37779FCF-34D3-449F-B966-925845496DA5@blueflag.consulting>
Message-ID: <2686ea81-0ae3-4c3f-92fc-59cb9275829a@kernel.org>
References: <37779FCF-34D3-449F-B966-925845496DA5@blueflag.consulting>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-918701208-1693953354=:11419"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-918701208-1693953354=:11419
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 5 Sep 2023, Alexander Witte wrote:

> Hi!
>
> Couple questions (brace yourself, they might be dumb):
>

Hi Alexander -

No problem, happy to help.

> 1. If we want to direct specific types of application traffic to 
> specific MPTCP subflows, would this be the role of a custom developed 
> packet scheduler?  If so, I am also assuming that there is no userspace 
> way to make changes on the fly..?  The use-case is around defining rules 
> like: "send all HTTP traffic across these specific links, send all 
> OTHER_TCP traffic on those specific links"
>

Each MPTCP connection only has one data stream, so in your example a HTTP 
connection would have an entire MPTCP connection to itself. OTHER_TCP 
traffic would be on separate MPTCP sockets.

This sounds like a job for the path manager. The connections for HTTP 
would presumably be using well known HTTP/HTTPS ports. If your initial 
connection is to port 80 or 443, you could establish new subflows to your 
designated HTTP links. Initial connections to other port numbers could go 
to dedicated non-HTTP links.

> 2. Another thing we might want to do is weight traffic based on some 
> business criteria ie. “80% of HTTP traffic goes on sub flow #1 and 20% 
> on sub flow #2 (because subflow #1 uses a cheaper cellular provider”). 
> From reading, it also appears like this would be the job of the packet 
> scheduler where we cannot dynamically make changes from userspace?

Yes, this is the packet scheduler's job. We're working on a BPF packet 
scheduler framework that would allow customizing these per-packet 
decisions.


- Mat
--0-918701208-1693953354=:11419--
