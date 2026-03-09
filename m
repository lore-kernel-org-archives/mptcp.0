Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9734BA2E
	for <mptcp@lists.linux.dev>; Mon,  9 Mar 2026 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081322; cv=none; b=cB4PsnBNVDckQfjf14XuGDiN5YCW3G+/jUb8tD10BG92iGJHQIRWBYNZtsMh3zPO7z2oA1OWadjobFEI/jg2ToRfQyoLFu18voP4H9VEOtPPajPF1dk0ajeozMf83+mbTYRBTXK79NjXe6z1F8jGN/QzQNdQLLec4rz7coZQ0Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081322; c=relaxed/simple;
	bh=srg+dxIhiAQAT4kVm4zitW6wSGv/aiVh6j6o8T2Wnnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osg5ppok4uq6A3bPWrE1WRIvJ6DB3jLLCIWQM7RUOfBi68KYVeqKMMfxOLVVZFpRTfb5DShrR0my/d7aerugecpIN0vBGEblN7LpmZQOJGTQEUjlIHRLL7oBbgwen2gm7uFPhTOyYhMvQsooBNmQ5yaXkHzpu+yioBuapNDLcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoctPFBD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoctPFBD"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439c6fc2910so4160242f8f.0
        for <mptcp@lists.linux.dev>; Mon, 09 Mar 2026 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773081320; x=1773686120; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHSASEtvOfEiBqmxuf7zhZcsqNoilbHkrVseGDfvsXw=;
        b=JoctPFBDYWyq5psZonOF9kFSZxE8Hs1u20t8OSmY7SGArSfpUtWKddv3zf6HlpHacv
         m6s/bR412k/JpPDG2nYPmh/WQDE5ad98O5fA7P5Yu7LUWyOw3uSOinr6O6dHwGZ70RYO
         oUSQdkEn+7Ng61aERkMlpbVdCmSUi50RMG3tSYlnCXtuwBSwFuCj2XKrZ1DdtX+BcH/n
         +AAJY6QeBucAqmhNPM45B/UsKhUB8LA+F3sJajDNfR84KBduDditxJBLJsvCs9gPj3GV
         k9lESvaUJ0xNkFgfk/icyeMkpuEyOSyhG3SDf5ToMUErWDB/lJYHbXse183K84ZXJRtg
         NsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773081320; x=1773686120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHSASEtvOfEiBqmxuf7zhZcsqNoilbHkrVseGDfvsXw=;
        b=WxrrR2KLW4BGJ/tTjlwS4Ymyn0ItWmGODnsgWZIuOUzjFr2AaXXQqwRHUkPzE/Cbui
         F2CT42EKS7PChKJt62Rbc5hWXI71Txrx/zpNjE6C6q8bGW6FfXdtBAuBY8ecO3Qb4Rzv
         GCekOsAFqwzObWoyJeqMLPtjBDybxwkYYOZ2MA6mO2+9lSFlMbMTopl27jpWHF8cj/mm
         EmVceFdzAZekZhvoTwANHqnIakk6RT4LhWnmJqytn2jppp5la62uFgjxIwIvcU0eqQKQ
         NwRU3JdnYO+MkLdEHQGVX+mmBPxyyCYaX3OGovx5p0BZZIYanOqA0DgPBZnZp26m1lCv
         7M7w==
X-Forwarded-Encrypted: i=1; AJvYcCX872pCAA0qNz9k7511EA7ZH3/6ykUJO5IdDieSqBXs6SVQPyFWY862ZQKcRwu51ssDdq8flQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSuiGnaBE67TcWijw1u2EnoigjHxcJ5Y0I5aRsk9a3YjiYSJfG
	9ZEC0Q4UZ8AgOrV5hpnLkpaxttQbE9Vcw3+Y8GiH0hDRq65cuqohY8vL
X-Gm-Gg: ATEYQzz121SkTPIeoLnSDHQTPbNIGP3zqOsNGREw4AsByPnesgmW1QQaGa3yjY8kRpO
	pQwj9PBKi7oVrGU9kkM9V0pvdhjcvxJmZppA93Zq3BeZRAhcK8M8PHNc1ClKpLnn4HV/NAFgfw+
	Rc/ajlUylT/vP2Kj1rtaXqkAJVzZFFq25mnkSd2i0Mz8ryVMeUtgdSqceOE+Wwgf3WXpKP2TpgS
	szRo7gEY8EZabDLkib4IyaY5fOscRYc3qCx+NuuHNKl+vmXFyZ4bR+u1QfkbzyKH341d0txZXMI
	lSFlCzUAvVLCAOoQ/ToNW6Mt9+m9UVZLLNuKVsErUATgkFkZPqSjetnxJNm7nbB3mfnfhLCr3sX
	cxXLjcvR23QYiG85esguM9JSi5mB21pN3a/+yk5jsMURZsxCK04vF0AtbE1G4OydPMaBcBmziGG
	F1PQDJv4P2yVW9N8K3JA1Q+u4KQ/ld5R1MGDvS5yt1Q3rlTBktr4dziWIYb+LtbOAFaBApPSmXY
	nSc2WWNgPc/uKvTaW+257s=
X-Received: by 2002:a05:6000:2285:b0:439:c67d:9fe8 with SMTP id ffacd0b85a97d-439da3526ddmr20856163f8f.22.1773081319621;
        Mon, 09 Mar 2026 11:35:19 -0700 (PDT)
Received: from gandalf.schnuecks.de (p200300c14f1996009e6b00fffe39b8a7.dip0.t-ipconnect.de. [2003:c1:4f19:9600:9e6b:ff:fe39:b8a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad1cb7csm29257753f8f.0.2026.03.09.11.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 11:35:19 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id AB67F30287C9; Mon, 09 Mar 2026 19:35:18 +0100 (CET)
Date: Mon, 9 Mar 2026 19:35:18 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com,
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/6] tcp: implement RFC 7323 window
 retraction receiver requirements
Message-ID: <aa8S5pEbxXIG5oZQ@gandalf.schnuecks.de>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-1-4c7f96b1ec69@gmail.com>
 <CANn89i+38t+PpB5duS_-FX_=PwyCQaN2HYohocJBAvZ7Cd8-KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+38t+PpB5duS_-FX_=PwyCQaN2HYohocJBAvZ7Cd8-KQ@mail.gmail.com>

Hi Eric,

thank you for the quick review.

On Mon, Mar 09, 2026 at 10:22:39AM +0100, Eric Dumazet wrote:
> On Mon, Mar 9, 2026 at 9:03???AM Simon Baatz via B4 Relay
> <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> >
> > From: Simon Baatz <gmbnomis@gmail.com>
> >
> > By default, the Linux TCP implementation does not shrink the
> > advertised window (RFC 7323 calls this "window retraction") with the
> > following exceptions:
> >
> > - When an incoming segment cannot be added due to the receive buffer
> >   running out of memory. Since commit 8c670bdfa58e ("tcp: correct
> >   handling of extreme memory squeeze") a zero window will be
> >   advertised in this case. It turns out that reaching the required
> >   memory pressure is easy when window scaling is in use. In the
> >   simplest case, sending a sufficient number of segments smaller than
> >   the scale factor to a receiver that does not read data is enough.
> >
> > - Commit b650d953cd39 ("tcp: enforce receive buffer memory limits by
> >   allowing the tcp window to shrink") addressed the "eating memory"
> >   problem by introducing a sysctl knob that allows shrinking the
> >   window before running out of memory.
> >
> > However, RFC 7323 does not only state that shrinking the window is
> > necessary in some cases, it also formulates requirements for TCP
> > implementations when doing so (Section 2.4).
> >
> > This commit addresses the receiver-side requirements: After retracting
> > the window, the peer may have a snd_nxt that lies within a previously
> > advertised window but is now beyond the retracted window. This means
> > that all incoming segments (including pure ACKs) will be rejected
> > until the application happens to read enough data to let the peer's
> > snd_nxt be in window again (which may be never).
> >
> > To comply with RFC 7323, the receiver MUST honor any segment that
> > would have been in window for any ACK sent by the receiver and, when
> > window scaling is in effect, SHOULD track the maximum window sequence
> > number it has advertised. This patch tracks that maximum window
> > sequence number rcv_mwnd_seq throughout the connection and uses it in
> > tcp_sequence() when deciding whether a segment is acceptable.
> >
> > rcv_mwnd_seq is updated together with rcv_wup and rcv_wnd in
> > tcp_select_window(). If we count tcp_sequence() as fast path, it is
> > read in the fast path. Therefore, rcv_mwnd_seq is put into rcv_wnd's
> > cacheline group.
> >
> > The logic for handling received data in tcp_data_queue() is already
> > sufficient and does not need to be updated.
> >
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> 
> ...
> 
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index f0ebcc7e287173be6198fd100130e7ba1a1dbf03..c86910d147f2394bf414d7691d8f90ed41c1b0e3 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -293,6 +293,7 @@ static u16 tcp_select_window(struct sock *sk)
> >                 tp->pred_flags = 0;
> >                 tp->rcv_wnd = 0;
> >                 tp->rcv_wup = tp->rcv_nxt;
> > +               tcp_update_max_rcv_wnd_seq(tp);
> 
> Presumably we do not need  tcp_update_max_rcv_wnd_seq() here ?

When we don't update here and are forced to accept a beyond-window
packet because the receive queue is empty, we can reach a state where

 rcv_mwnd_seq < rcv_wup + rcv_wnd == rcv_nxt 

I noticed this case when instrumenting the kernel and got violations
of the invariant rcv_wup + rcv_wnd <= rcv_mwnd_seq.

So, while not strictly needed (tcp_max_receive_window() would still
be 0 as rcv_nxt > rcv_mwnd_seq), I opted to include the call here to
keep rcv_mwnd_seq the actual maximum sequence number at all times.

> 
> Otherwise patch looks good, thanks.

-- 
Simon Baatz <gmbnomis@gmail.com>
