Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29644426EC5;
	Wed, 10 Jun 2026 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104955; cv=none; b=tiE4H94YPsoJUsY2yvyM4oGX5N3FCynPTIK792en7VBfiPvexPlwEQXjTOvAXlGVX93SrWBWn5n+5+7Kdsmwiktplqdh3ACAi0hjKBT47ptfjuxYnyFzAL80WRog74LD848HA1arVeIW4hCH8Yl1vtDvuXqLNKZcQG0vkN8Ny5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104955; c=relaxed/simple;
	bh=+JK8R/7VtnPPWu0kAeq9/YQZvg1IJIk8ICcVdv06DO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8+91zV6QVYuV4u1Xhigo1bwwh6ex9fZuDU5AtmhuAykB+PvtjcBiDrI10EmhE4XCxOSjtHXjLTk+yZ2rRxWMLSgjfP3M9IM4RxcTqDqfrLDQgqeDjDwX0r9eI24juJVSIFPKbilD3gHOjg6jVCJE2dbUqTqigiE5L+ee5pavfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS6PxtTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS6PxtTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DB21F00893;
	Wed, 10 Jun 2026 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104953;
	bh=1z+b6EFtad9PbYUN1KmvNW1k3GO6SZb8m9ge86o3v+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HS6PxtTgczGOj0boeuGs2k4xaiBszzZcoRNwdf9EDDPB/Ey5xslpVTfEUcFCNCpZo
	 pI1+arO84XD96jJQXZAmuUc8OC2IibcKcxkYy3biGS/8YFehKd0gWlNpwo2IhRJ0Ez
	 50BlnUgkQbqfXnYuO+Vatgi7H+/CP+ZIE4GPuzJH91m+AvCKQEeAtIE/SZ6DPKgrwk
	 HPo+UDK3Rhs2oRUO3D4ujt05fjM9zBSfS2U/3gW4X3AzKlgfDAcBBNp9/FiYzQaua7
	 17laYPwKaq+NfPyjJLK/dE9PD4AdFgm1mUOccEWYemf0NbuHOK+oSP9Q2pIaNLpk9z
	 myIuhPcmCvj6w==
Date: Wed, 10 Jun 2026 08:22:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/15] mptcp: pm: drop TCP TS with
 ADD_ADDRv6 + port
Message-ID: <20260610082232.50d2a31b@kernel.org>
In-Reply-To: <17ecf803-4ee9-4dbc-ae9f-34da6460b163@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
	<20260605-net-next-mptcp-add-addr6-port-ts-v2-6-758e7ca73f4d@kernel.org>
	<17ecf803-4ee9-4dbc-ae9f-34da6460b163@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 17:13:54 +0200 Matthieu Baerts wrote:
> Hello,
> 
> On 05/06/2026 19:21, Matthieu Baerts (NGI0) wrote:
> > With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
> > taking 30 bytes, the 40-byte limit for the TCP options is reached. In
> > this case, it is then not possible to send the signal.
> > 
> > To be able to send this ADD_ADDR, the TCP timestamps option can now be
> > dropped. This is done, when needed by setting the *drop_ts parameter
> > from mptcp_established_options. This feature is controlled by a new
> > net.mptcp.add_addr_v6_port_drop_ts sysctl knob, enabled by default.
> > 
> > It is important to keep in mind that dropping the TCP timestamps option
> > for one packet of the connection could eventually disrupt some
> > middleboxes: even if it should be unlikely, they could drop the packet
> > or even block the connection. That's why this new feature can be
> > controlled by a sysctl knob.  
> FYI, Sashiko's new comments about this patch [1] are suggesting issues
> when MPTCP is used in parallel with TCP MD5. But MPTCP cannot be used
> with MD5 because there is not enough space in the TCP options. That's
> why there is an explicit rejection when initiating the connection.
> 
> So I think we can ignore these comments saying that more options could
> be dropped, and the size can be negative.
> 
> https://sashiko.dev/#/patchset/20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d%40kernel.org?part=6

I'll probably pull today, but to explain the delay - Sashiko made me
read the code and while I think the reports are false positives - 
the option handling does not read like awesome code. So the series fell
down the priority list.
