Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3C29CF4
	for <mptcp@lists.linux.dev>; Fri,  8 Nov 2024 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102183; cv=none; b=Olu4MXFNR64MI9h6g7of5YzmipHY0HHwMK39eLB/+vjR3EfoKk/EVI3NIwowRMBlZZxtmIi32ZzVypEjFNVYEV4+HGsrZ1xjNHAfLQAzpNPHy7ZlQuiGCcRnD4Be8uGcubNQ0XWE09kKY3fB3EcdoMhjcvi0CPYoBP2tWgeHgeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102183; c=relaxed/simple;
	bh=bOgIvEqIQP7aAWFCAUyT2Vzn/DkbaczDZuukumHrHmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bu22LJ6caOdxo3hLVjzUChkHpSYCVEMgNCEKPdmg0pHcWYHDo9h7Au3V3n0syuaR5COW6VhCG90MUcsfEd4iv4egIMOKN4CqSjPv9v9Fzl80YTtmz74s3FyNunxE5UHaHJSnfaFClQNtCB2u0NGty5XB9y92LzJzwoSK8OHo+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=CgoC3yPi; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="CgoC3yPi"
Received: from fpc (unknown [10.10.165.14])
	by mail.ispras.ru (Postfix) with ESMTPSA id D163A40B227F;
	Fri,  8 Nov 2024 21:42:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D163A40B227F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1731102177;
	bh=gfIh3bXKCybmNGisNtzYVK2moedKhWkf28cL8IRdeS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgoC3yPiQAYfVs+EyYyJgrVWnYsmQe6AUzYqXpLIMCvp8fIsikoptjmo17zyWJjJi
	 V3LfG1XpTwBmDJt2yMLSeID77J1V3l34HU3Ezzmp7+9UvCGNN/JK0sXUZNPmmxmvgM
	 xzZCOkUMYAE2ThbwPlx5zI7RNAWnQI1qcOPvxAWE=
Date: Sat, 9 Nov 2024 00:42:53 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Dmitry Kandybka <d.kandybka@gmail.com>, netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>, mptcp@lists.linux.dev,
	lvc-project@linuxtesting.org, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] mptcp: fix possible integer overflow in
 mptcp_reset_tout_timer
Message-ID: <20241109-46edd978694b7d9a2f89b9f6-pchelkin@ispras.ru>
References: <20241107103657.1560536-1-d.kandybka@gmail.com>
 <5f51673a-e19b-45e8-bb1c-a6d3427213c1@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f51673a-e19b-45e8-bb1c-a6d3427213c1@kernel.org>

Hi,

Cc'ing more people.

On Fri, 08. Nov 12:43, Matthieu Baerts wrote:
> Hi Dmitry,
> 
> On 07/11/2024 11:36, Dmitry Kandybka wrote:
> > In 'mptcp_reset_tout_timer', promote 'probe_timestamp' to unsigned long
> > to avoid possible integer overflow. Compile tested only.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
> > ---
> >  net/mptcp/protocol.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index e978e05ec8d1..ff2b8a2bfe18 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2722,8 +2722,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
> >  	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
> >  		return;
> >  
> > -	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
> > -			mptcp_close_timeout(sk);
> > +	close_timeout = (unsigned long)inet_csk(sk)->icsk_mtup.probe_timestamp -
> > +			tcp_jiffies32 + jiffies + mptcp_close_timeout(sk);
> 
> If I'm not mistaken, "jiffies" is an "unsigned long", which makes this
> modification not necessary, no?

inet_csk(sk)->icsk_mtup.probe_timestamp and tcp_jiffies32 are both of u32
type.

'inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32' will be computed
first in u32, only then the result will be converted to unsigned long for
further calculations with 'jiffies'.

Looking at how probe_timestamp is initialized, seems it will always be less
than the current tcp_jiffies32 value.

So 'inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32' will wrap in
u32, and then converted to unsigned long. It's not clear actually whether
this is considered to be an expected behavior... Goes all the way down to
76a13b315709 ("mptcp: invoke MP_FAIL response when needed").

> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
