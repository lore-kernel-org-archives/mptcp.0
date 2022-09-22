Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4EA2CA2
	for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 20:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F50BC433D6;
	Thu, 22 Sep 2022 20:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663877126;
	bh=MGbVyhewQ7VxXznFUjRgEqvL1s+44pP4F3IRDbTf/5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KrfxTNyQFtRJ78gmGC4KkzSEDtm7tsC9er9OGUCgIUGNRPtNzAhpJ6xwUNf11kdR3
	 dNFHXLxgc4uXKHFJncMp8EPpm6tlMHQ34aDPGWGx1XZ1kipq5xnEvWE+Hsx81OQ2jk
	 I+PdplmgO8sm1vs0L9hBwKNRPnjXBYCyReuRh7a4meT9/tifiQ6nAOJy+v+8SHnx4r
	 wx6i6stj4ZjAPRr3XuK6J7EBMZwt/J2f8mxXncXsNb3HDuMFFcKSt2i0hGmqWxMXMv
	 jyHDeBApQx+mwDUD+KHiptmZJSYPAD6XnZtzXYNBTY0nDsOPLlHOZTjqpaNqkaBbeY
	 aiWwttVG45EzA==
Date: Thu, 22 Sep 2022 13:05:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
 davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de,
 MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH net 2/3] can: gs_usb: gs_can_open(): fix race
 dev->can.state condition
Message-ID: <20220922130525.6b1a1104@kernel.org>
In-Reply-To: <20220922082338.a6mbf2bbtznr3lvz@pengutronix.de>
References: <20220921083609.419768-1-mkl@pengutronix.de>
	<20220921083609.419768-3-mkl@pengutronix.de>
	<84f45a7d-92b6-4dc5-d7a1-072152fab6ff@tessares.net>
	<20220922082338.a6mbf2bbtznr3lvz@pengutronix.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Sep 2022 10:23:38 +0200 Marc Kleine-Budde wrote:
> On 22.09.2022 10:04:55, Matthieu Baerts wrote:
> > FYI, we got a small conflict when merging -net in net-next in the MPTCP
> > tree due to this patch applied in -net:
> > 
> >   5440428b3da6 ("can: gs_usb: gs_can_open(): fix race dev->can.state
> > condition")
> > 
> > and this one from net-next:
> > 
> >   45dfa45f52e6 ("can: gs_usb: add RX and TX hardware timestamp support")
> > 
> > The conflict has been resolved on our side[1] and the resolution we
> > suggest is attached to this email.  

Thanks for the resolution! If you happen to remember perhaps throw
"manual merge" into the subject. That's what I search my inbox for
when merging, it will allow us to be even more lazy :)
