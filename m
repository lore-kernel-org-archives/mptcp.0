Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C04371862
	for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266894; cv=none; b=FeKpJbDj939OxOO0n6UiqHP33GPKDyFH23q7d9k3OFOq7manYsqW/oB3N8x6+Lxyb1OYhFhhXhNdwtqD6VBqv9kcUALlbVGcfNIVZYMIeZJohRKbCJHdfDlnB/zfIRpECZgUDHGVxJMuBPEvpaf2DaBCBON1posV3R2kHMBe4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266894; c=relaxed/simple;
	bh=eckzTySEcXipLe+VU78GzpoVPoQ+1K7RQ8jMl1qup7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLxwwCDefsThkNqYUsxdliBcF+Zc/J5fVCMcQOtVqS41GoBxSJ1XFl8P6kGPMI1mi2+1afsTYTNgfmhuVy+c372lSbm5FrAOchZkvQgrkGwiX8gbBxbNUIV8NR/3Z14NkW5d7YzGc+M9nLO7JfVRHCQbxZhgcNhzteCRcOZHcos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNGH3bT2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNGH3bT2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852a8482fcso2268855e9.3
        for <mptcp@lists.linux.dev>; Wed, 11 Mar 2026 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773266890; x=1773871690; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jXJIXQ3qsiPhJua6yI0vMRP9sGOp7VDYpCWyFHFNhZU=;
        b=BNGH3bT2vxNfg7QUGcQbXIJ2Ln79FVnsZ6JzQcaRzAVmmWkUmpOoe6KB12lPKj9903
         NIfSRNm8evvNT1/YqXsdlfB1P2xdDQ2DB6H6ogJy7hoRXOZZj9utQ1I6Ub8E7huPpyNR
         CIcF6SEccfotAXa28EFiJsVJBL5EjOL8QCLPgKHyS7t1RXRjzN4/SQ/KPAeBuLq5+a3n
         IgLic4xD8xv6r2JSRic8ogCIqrNszAwUaLpTbjrL7c7lOqoWHvfSQjs3WxcCcFNygOSH
         6DkVLDDaajBud5YSGLvPXryzdoCMBMPt1g8fVqHcKy1dXrXMd/sM1OC1BJWFwxsNwYfW
         +atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773266890; x=1773871690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXJIXQ3qsiPhJua6yI0vMRP9sGOp7VDYpCWyFHFNhZU=;
        b=pishreQoXI1Zk7M/NZrOEQgAEnPyBxia+jCBKbaaV4Hjz46Mmb9VeEKxRI7vCh8fqB
         WX4qmw9QTW8SpO5PcoOHrkDQigLlcK3yVj2AQK+qjLzG3S34ARAxZVp0fc/o5W2p9Rbf
         s0sP6tuq7huOMZfTDTT5sDYLnz1mHjfB93Mqgedpc6RyTbVKvf1fGQVCXugwVUsGssrx
         oCfBueRjwB9rfobnCMTDnCrJk6/Lov5bwULm3YDmNFPz0Sf8IzoCkX/KBWXbW3f2Kowc
         mBjjp/fPL10RUIJfWrdw0if8JPvet5UJAgrPJJA0w0PFP+e1sKGdOeAo7DPBi4yQbmZV
         Eldg==
X-Forwarded-Encrypted: i=1; AJvYcCUoIm2F0wVvnGQDX/5KrH7njwRFacxXd0pdIUCsGLf/NTUQjbHgFEIv2nQHcySibQDZp4IG+w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzq9nYlrXDZOiS9snbLXvMGaz/CCpNB4+P5g/wyYM6DrnNIjrCD
	3REBXrAVg1IioroSlnvgVk3Taw5miFGodGWwLN4jMgvAFb0MnV2tTYGB
X-Gm-Gg: ATEYQzymMzMk48L64oudWc03bi+NmCiYxQfI/+oybLmYKYMLO+NB+w3HiC7VNgOebq7
	aPk+1CNczQx0CV6VmgepswwdwDTSf7W92NAIbBzRU97UH9LTc78PEJkVDKZM3UBJQzb98FxUh1B
	uvx1KMMCET4zistuN+4ipyKfJ3oCFiT00tV3hQGaNK68+0BYpws5KkvnkYQ+WoP8z49SFKfcfM5
	ccslJ1AmrMXrMXsDE2rMqqLbw4vA8Guo8MVdnzXmvw5LNRwwUmhRZnTkhBKpoXvsWgPGYarvFXZ
	6Tpzyt5gXYYfbW0+LJe7MpvVBmDZRuX2meZE1M2NeFimGiyize3/kTOu38mt5iTdG8Mt7/GHc1Z
	RupyLM/8ZjWalvZ0gUG5CbbcgFhbsaktzJTS1DGYOBrutZEL4xSUgEnl9CAP1rrNZUCtMI/zChL
	SH9RFBZPfDrHE8YtnAkSOBmXUL8vuycesrIW7EukyaIQ6qNGQ8ASHzc3RF4ff/MWByHQQXR9oi
X-Received: by 2002:a05:600c:3b16:b0:485:3e6c:aabc with SMTP id 5b1f17b1804b1-4854b107dddmr62988565e9.19.1773266889508;
        Wed, 11 Mar 2026 15:08:09 -0700 (PDT)
Received: from gandalf.schnuecks.de (p5b2e2ef5.dip0.t-ipconnect.de. [91.46.46.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73dasm512043875e9.2.2026.03.11.15.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 15:08:09 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 989BA302FC8A; Wed, 11 Mar 2026 23:08:08 +0100 (CET)
Date: Wed, 11 Mar 2026 23:08:08 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com,
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH net-next v3 2/6] mptcp: keep rcv_mwnd_seq in sync with
 subflow rcv_wnd
Message-ID: <abHnyJInqmGNIWiq@gandalf.schnuecks.de>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-2-4c7f96b1ec69@gmail.com>
 <334053df-9824-4bfe-b37c-8711d0a5a9bd@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <334053df-9824-4bfe-b37c-8711d0a5a9bd@kernel.org>

Hi Matt,

On Wed, Mar 11, 2026 at 07:27:34PM +0100, Matthieu Baerts wrote:
> Hi Simon,
> 
> On 09/03/2026 09:02, Simon Baatz via B4 Relay wrote:
> > From: Simon Baatz <gmbnomis@gmail.com>
> > 
> > MPTCP shares a receive window across subflows and applies it at the
> > subflow level by adjusting each subflow's rcv_wnd when needed.  With
> > the new TCP tracking of the maximum advertised window sequence,
> > rcv_mwnd_seq must stay consistent with these subflow-level rcv_wnd
> > adjustments.
> 
> Thank you for these modifications!
> 
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > ---
> >  net/mptcp/options.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 43df4293f58bfbd8a8df6bf24b9f15e0f9e238f6..8a1c5698983cff3082d68290626dd8f1e044527f 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> 
> (...)
> 
> > @@ -1338,8 +1339,9 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
> >  		 */
> >  		rcv_wnd_new = rcv_wnd_old;
> >  		win = rcv_wnd_old - ack_seq;
> > -		tp->rcv_wnd = min_t(u64, win, U32_MAX);
> > -		new_win = tp->rcv_wnd;
> > +		new_win = min_t(u64, win, U32_MAX);
> > +		tp->rcv_wnd = new_win;
> 
> Out of curiosity, why did you change the two lines above?
> (even if it makes sense, the diff is a bit confusing, and the commit
> message doesn't mention this :) )

I wanted to keep tcp_update_max_rcv_wnd_seq() calls close to the
respective update sites (same pattern everywhere).  In the original
form

tp->rcv_wnd = min_t(u64, win, U32_MAX);
tcp_update_max_rcv_wnd_seq(tp);
new_win = tp->rcv_wnd;

the ordering suggests that tcp_update_max_rcv_wnd_seq() might modify
tp->rcv_wnd.

So, I changed it for legibility.  Now, I realize it made the
diff harder to read.  I might have optimized the wrong metric here ;-)

> 
> > +		tcp_update_max_rcv_wnd_seq(tp);
> 
> 
> This patch adding this new helper each time rcv_wnd is modified looks
> good to me:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> 
> Note: just in case a new version is needed, checkpatch reported an error
> in patch 4/6 because of a trailing whitespace (+ No space is necessary
> after a cast in patch 1/6), see:
> 
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/22844479818

Thanks. I will change that if there is a v4.


-- 
Simon Baatz <gmbnomis@gmail.com>
