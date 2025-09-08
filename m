Received: from caracal.birch.relay.mailchannels.net (caracal.birch.relay.mailchannels.net [23.83.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F005535947
	for <mptcp@lists.linux.dev>; Mon,  8 Sep 2025 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352803; cv=pass; b=RskDSLahcNrwZXLJl5P/samQskF5AA8EmgztwttpEjbsNq97k23roZ6lRrS0d7Ld0pjNxWbH4W+dS86h64n3Qh7LDkaxe5mcJKm/RfP3Wm+TKMX7z5wJVUHKv9oZcG4LUEC71gA8yq4to5U0RwGTpu5xYFOcMy5xmHIkRj9pRdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352803; c=relaxed/simple;
	bh=y+gok38nCHl8fHKbqQb9duk0EFb2ClPsu/Ttl/kBa/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozaM1TN8cKVyWKdhZczKAHSbHxI+4VngYC77ZoatdYZoO09H7gTiQxOr1sxfYN5FQaPwmv4scwMna0at2QLA99MW8ox1T3jIkbLLedKPWL/yeWptP01XkcwM1orHs69+SP+RaAPZKLeNu7+yHmbrndJfVYCWcaWPZq7BxzQk2Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=fs8fKFq4; arc=pass smtp.client-ip=23.83.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="fs8fKFq4"
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DD07423855
	for <mptcp@lists.linux.dev>; Mon,  8 Sep 2025 17:25:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (trex-blue-7.trex.outbound.svc.cluster.local [100.107.5.250])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7756523689
	for <mptcp@lists.linux.dev>; Mon,  8 Sep 2025 17:25:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757352354; a=rsa-sha256;
	cv=none;
	b=QLQYglXCvsHJzkmY7kxG4I4ZOcTzsKv+m4spOHxvFvWIfK7HoQA9JOOy2F6qJfq8imN9U/
	zgNLKXvMitdp6MP2HTDtE6+GBvlgL3fvDzsLaUDKZGCZ2WWurPLk4uu3ovyT6tcxoTtPWC
	d1ZWUSY+fC23oj+GU/O0rs8mxAWB1SY6xiG2/EmQj3bC0NU0SRdksXr8n0rz1R6My5iuCm
	0QM8AfKk1Q/2/E5s1ftFqdw9fxeqoSWueULwFxK0yMp/ZFU/Y3ZWhjRkhw4YCawMpsD5un
	1Sz3Fa60xnOzrVKf50+UXtn7OFw0HaUMq4ID/jPFj0uXbG8JOwY4a1wx/fq/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757352354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gwa7Mfpih4MWlxuBxr9prkEft/umFWYN2yjVkeDZXEo=;
	b=1/mosEVhOfVxzvujmZ46ADb708NHmN1mCTw7jSMIevCHdogYckViTsibr0gnJRmARhVZe8
	YZNLTYOZ4rDTHEYkFfVMrQozKj1A2mxUwjifNl6AwvwWYmCtzwGmKiqQql5V2sruM3GQJO
	zsUE/P1fxO+EwpzT+GXkqIb+dh9HiuVFEeaRJC4cGlxLCUQ5H9ALGVDGWeoxogpR7zfYQz
	CBBqEZ8wSPKbJNbwjWJb1yV7Xr/nJ7fQHkWDgNwPPvznSQae829ZfrsZ0ieMFKAy6hdP5Y
	qCYWmu5OzMWD0Lu01lB7CZyC+A820Vpd+oQG2Z/g9EcT1UXPJwcqPwRMcBoK/w==
ARC-Authentication-Results: i=1;
	rspamd-9968f48fc-xqc6l;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Soft: 7f3fcbb63d638151_1757352354713_926931797
X-MC-Loop-Signature: 1757352354713:3825436888
X-MC-Ingress-Time: 1757352354713
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.5.250 (trex/7.1.3);
	Mon, 08 Sep 2025 17:25:54 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4cLDPZ1sGfzPZ
	for <mptcp@lists.linux.dev>; Mon,  8 Sep 2025 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1757352354;
	bh=gwa7Mfpih4MWlxuBxr9prkEft/umFWYN2yjVkeDZXEo=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=fs8fKFq4pLlYJHd322+Pi7ceL1f/Zy3kwJO/Uyl/MO7aXSgBouOyqFCVHflsSPBXT
	 0C6S1rNp3GmSObk8K7/AwbUGMHkvmYTHtijwFM7fgfrJ1DcQJ36htuI991rugeL7gA
	 mlImXfNUQxi0L9LR/xiDmHa8RABSebIJmWXzDGj/2eHAYU2YBZTLQqRsecQ0EJK24p
	 h46HQ7UYpSDka3rc4Bf5udhmbbVqcYbzUZD1gglI9LM8ZdBG+GnLFuTwVcqDhEWTx3
	 N5o50KuXmVG3rlutqh04o/OC+6m/C6xrbdbVy80TK2FywB0JvBQ9khYz6h64c1fYfM
	 jLP6IilFxomkA==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e01fb
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.13);
	Mon, 08 Sep 2025 10:25:53 -0700
Date: Mon, 8 Sep 2025 10:25:53 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, David Reaver <me@davidreaver.com>
Subject: Re: [PATCH mptcp] mptcp: sockopt: make sync_socket_options propagate
 SOCK_KEEPOPEN
Message-ID: <aL8RoSniweGJgm3h@templeofstupid.com>
References: <aLuDmBsgC7wVNV1J@templeofstupid.com>
 <ab6ff5d8-2ef1-44de-b6db-8174795028a1@kernel.org>
 <83191d507b7bc9b0693568c2848319932e6b974e.camel@kernel.org>
 <78d4a7b8-8025-493a-805c-a4c5d26836a8@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78d4a7b8-8025-493a-805c-a4c5d26836a8@kernel.org>

On Mon, Sep 08, 2025 at 07:13:12PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 07/09/2025 02:51, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Sat, 2025-09-06 at 15:26 +0200, Matthieu Baerts wrote:
> >> Hi Krister,
> >>
> >> On 06/09/2025 02:43, Krister Johansen wrote:
> >>> Users reported a scenario where MPTCP connections that were
> >>> configured
> >>> with SO_KEEPALIVE prior to connect would fail to enable their
> >>> keepalives
> >>> if MTPCP fell back to TCP mode.
> >>>
> >>> After investigating, this affects keepalives for any connection
> >>> where
> >>> sync_socket_options is called on a socket that is in the closed or
> >>> listening state.  Joins are handled properly. For connects,
> >>> sync_socket_options is called when the socket is still in the
> >>> closed
> >>> state.  The tcp_set_keepalive() function does not act on sockets
> >>> that
> >>> are closed or listening, hence keepalive is not immediately
> >>> enabled.
> >>> Since the SO_KEEPOPEN flag is absent, it is not enabled later in
> >>> the
> >>> connect sequence via tcp_finish_connect.  Setting the keepalive via
> >>> sockopt after connect does work, but would not address any
> >>> subsequently
> >>> created flows.
> >>>
> >>> Fortunately, the fix here is straight-forward: set SOCK_KEEPOPEN on
> >>> the
> >>> subflow when calling sync_socket_options.
> >>>
> >>> The fix was valdidated both by using tcpdump to observe keeplaive
> >>> packets not being sent before the fix, and being sent after the
> >>> fix.  It
> >>> was also possible to observe via ss that the keepalive timer was
> >>> not
> >>> enabled on these sockets before the fix, but was enabled
> >>> afterwards.
> >>
> >>
> >> Thank you for the fix! Indeed, the SOCK_KEEPOPEN flag was missing!
> >> This
> >> patch looks good to me as well:
> >>
> >> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >>
> >>
> >> @Netdev Maintainers: please apply this patch in 'net' directly. But I
> >> can always re-send it later if preferred.
> > 
> > nit:
> > 
> > I just noticed his patch breaks 'Reverse X-Mas Tree' order in
> > sync_socket_options(). If you think any changes are needed, please
> > update this when you re-send it.
> 
> Sure, I can do the modification and send it with other fixes we have.

Thanks for the reviews, Geliang and Matt.  If you'd like me to fix the
formatting up and send a v2, I'm happy to do that as well.  Just let me
know.

-K
