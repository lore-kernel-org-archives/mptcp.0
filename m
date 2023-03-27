Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1E3C0F
	for <mptcp@lists.linux.dev>; Mon, 27 Mar 2023 15:30:49 +0000 (UTC)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0607D37E;
	Mon, 27 Mar 2023 15:30:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0607D37E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1679931043; bh=XO9ObxSwSUHuoTConErq8w3ZLhO2VmWJEPLigLiermo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fN+vjMoRDUqEliXEHD+l6iOZR1Cg8vrNvzwlYDcpqKJijL/xI979OQZTM0WX1vFfY
	 rZIY/XEiWLiGHAjtCljofGySwqNsUG+kqOoWsVCIY+b2sJUR4uRgG0mtrqtPHjCpcW
	 NUVSH2cGNrRYVicOdxYR1oRtpIcogIXcnuMKe6Hkkp91sy1bL7GPFPeViHJdwpVXtn
	 arAjo0w1J86YrbO5C8J+YbI+vevDAShuYU3YMAJZD/8fPh7yZP1Z1fMSKzSOu7r3yC
	 Je7X2t2ioLJPQtwivKBVqchCdMyy0K+/0+JDcJikQmDLvXttP4HA4cBuZ0pyHOu7Bb
	 8kIXM93LiTfqg==
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>, Matthieu Baerts
 <matthieu.baerts@tessares.net>, Andy Whitcroft <apw@canonical.com>, Joe
 Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>, Kai =?utf-8?Q?Wasserb=C3=A4ch?=
 <kai@dev.carbon-project.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
Subject: Re: [PATCH v2 1/2] docs: process: allow Closes tags with links
In-Reply-To: <073d5ee7-64e7-7ced-44cc-2f7f00a8b238@leemhuis.info>
References: <20230314-doc-checkpatch-closes-tag-v2-0-f4a417861f6d@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v2-1-f4a417861f6d@tessares.net>
 <29b2c9c1-f176-5e42-2606-94b4bc6d4c45@leemhuis.info>
 <9462668e-dbaf-8df8-8ba2-86f9511294ac@tessares.net>
 <073d5ee7-64e7-7ced-44cc-2f7f00a8b238@leemhuis.info>
Date: Mon, 27 Mar 2023 09:30:42 -0600
Message-ID: <87cz4unrdp.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

>> If we do that, would it be blocking to have this included in v6.3?
>
> You mean if this still can go in for 6.3? Well, the patches afaics needs
> to be ACKed by the right people first (Joe for checkpatch I guess, Jon
> for docs). It likely also depends on how this discussion continues and
> the opinion of the maintainer(s?) that picks up the patches.

We're at -rc4, I wouldn't really consider this for 6.3 at this point.
There's no reason to try to rush it.

Thanks,

jon
