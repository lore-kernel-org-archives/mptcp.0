Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5905F37106D
	for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 23:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773184158; cv=none; b=ZT46/pM/77DcikvBGOsp+q5OJ+13LNlCarA9JiRzckY2lmy0gh4IClRJU9zm8gG/L+4F/C8SbLZKOm8qONjrswS2wTHH8FR1aHDbbvi+bMw2BiXhHoqa75o5da+BdPrgJYhK+JedJlz4RB05PnLQwuJxkr5qkGjIATHLPegJRCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773184158; c=relaxed/simple;
	bh=pZ58cNGp7FiVPONqDxgEYxZYyOKBMFQVjpjV6yX9SsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da6xsAbqZCUrMJUp97dkuXWkmKJNBdGg9aIc0n6tDNtpoB+4SpzPwRHzg8dOvyUzPkbjOacWHT1U16jMiGvFp4i3usdANnbrTvglMAdLSyDtayDNa7vuvll+bIdakjaFjBYH0NOisVDle9T/mhmTUKSiOV1o54LIB4yYXA4wwi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhTXrR6k; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhTXrR6k"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-485445e80bdso10956275e9.0
        for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 16:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773184156; x=1773788956; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DbJBr0HEiXYCW71Jk8MuoGm/RlPukS0X9H3Qzzqpl0U=;
        b=QhTXrR6k22TxwBxeehKN6IaGbiSTcEX+4Kb/QNMDshJ4vlBzFAQElQaOdbo8ZtAsfR
         vmWyn4hOJuJR9Pt1wrW6OT3k3poGtDsM7xv1q89T1dLchVcJh6/bm7F1wGQd7xgPaD/+
         qUH4X/DJDJyWMgvLwaG10rWHoabHxwAT9UhVEsKx7pPD36c8k5ZVMkRnJlE8sc697u/h
         D1lu/cgWTVxQQNpJOaTxQ8C1X0VJ3YSbR9mVaTDmkdMssm3FwlwgBd1TEyO7Wu05Mhs+
         uf3PP/jNeNKf/Rbdb+WdExnebiIwxkVTb5tEZE5Rc5qKpdI46GcFjsJxc78gzH1OSBKy
         z2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773184156; x=1773788956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbJBr0HEiXYCW71Jk8MuoGm/RlPukS0X9H3Qzzqpl0U=;
        b=QUhjuSrwcW08EWGWLYgk+EK9rRkCc6rybHd/Ve8IeB4jZ+6Khz00lSuFCUFipsyQ93
         j9CdP3llCYbtV5ENIYv2e/bmrxiEmRw88sTiKhQszNdEH5HpkacAegU5DLFUJKQoBlnn
         tVIjAcikBSfpGAxkCBH2r0c1Y8OeQLgNXyLs5L83O9u27/Kr9Kot4eMKpXIpzAalNOOm
         xrhvI4KNUetYPMj5bEldyau6XCZy43kK3xZna6ybbQwmo0FewpI8lRXhM8KjcCrILYnk
         BSyvGUeptUDDNtXnS9DFMqB79tzg88EAYD4guV6ZecT7G0TPgnubi1CQtPOfZLocJRay
         TXJA==
X-Forwarded-Encrypted: i=1; AJvYcCUYkWx5WuviTXjMSlEg/vXfrJTRHSGuC2KgUrVqZQnM0Dmrp0ZkJqtMhTj876aWicsTrZCJmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzG/uzjgnrTD5wHGp/G2ucbhRb8LNCal7Xlew82RKzmPhmOUp8P
	doxsluuF2OhdNLoGNElWxAgLM+dbV5y0I5eorcdSwvxnI7Y5306O9QiY
X-Gm-Gg: ATEYQzyuiUWlfTzslvkHddnLRgbSKoEQZ5SBHlICAzOvibHpAh7I1hvW0h8SKrETIfQ
	4Oc7Leu0i7G0f9EgqXBildu0AIBZTRcCEup8UKPAQVdfuxEE5oSNrsDGh7xxZCti+RM5/o2P+VI
	18V08hsjrlRUoxFkVzOvAmeanNouYK0ReF5V1chJ8SzvtEaZRo/I0mE86VmrRHZgKMunG+R2xLW
	xzldNSNvP+2lNRzCD3KfFPusTrzyWZzzt6goZ6a6XOwOWKwUWnBFiG5nt05WohrEGPPVFTb2UbZ
	W3kNWzpwSm2N6JYCThpv60FvB1vLzIh+nfJOdlBTrSymx/6Rez9OJeyekfdQK4XhCNFb0I33I/e
	Zk+tiz1TD/rGT53I5z4/kB+dJIAh3X/P5GRvxFehFzoQzJ1/qKwliMfoO3Xv+8vxVmC28Q9MfSk
	IXtXKW20cAzJ/c0wbB5BOJT7xLnOMYUN4TbsJh2jZ0DSvbcFkktFZSmFc0q8QwMQ==
X-Received: by 2002:a05:600c:4710:b0:485:3b00:f939 with SMTP id 5b1f17b1804b1-4854b0bafa5mr8549225e9.8.1773184155268;
        Tue, 10 Mar 2026 16:09:15 -0700 (PDT)
Received: from gandalf.schnuecks.de (p5b2e2ef5.dip0.t-ipconnect.de. [91.46.46.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a18bcf4sm11438625e9.0.2026.03.10.16.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:09:14 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 390E7302C898; Wed, 11 Mar 2026 00:09:14 +0100 (CET)
Date: Wed, 11 Mar 2026 00:09:14 +0100
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
Subject: Re: [PATCH net-next v3 6/6] selftests/net: packetdrill: add
 tcp_rcv_neg_window.pkt
Message-ID: <abCkmiCSPkmxzECa@gandalf.schnuecks.de>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
 <CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com>

Hi Eric,

On Tue, Mar 10, 2026 at 09:54:58AM +0100, Eric Dumazet wrote:
> On Mon, Mar 9, 2026 at 9:03???AM Simon Baatz via B4 Relay
> <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> >
> > From: Simon Baatz <gmbnomis@gmail.com>
> >
> > The test ensures we correctly apply the maximum advertised window limit
> > when rcv_nxt advances past rcv_mwnd_seq, so that the "usable window"
> > is properly clamped to zero rather than becoming negative.
> >
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > ---
> >  .../net/packetdrill/tcp_rcv_neg_window.pkt         | 26 ++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..15a9b4938f16d175ac54f3fd192ed2b59b0a4399
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > @@ -0,0 +1,26 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +--mss=1000
> > +
> > +`./defaults.sh`
> > +
> > +// Establish a connection.
> > +   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> > +   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> > +   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) = 0
> > +   +0 bind(3, ..., ...) = 0
> > +   +0 listen(3, 1) = 0
> > +
> > +   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
> > +   +0 > S. 0:0(0) ack 1 win 18980 <mss 1460,nop,wscale 0>
> > +  +.1 < . 1:1(0) ack 1 win 257
> > +
> > +   +0 accept(3, ..., ...) = 4
> > +
> > +// A too big packet is accepted if the receive queue is empty
> > +   +0 < P. 1:20001(20000) ack 1 win 257
> 
> We do not see the answer, it seems this test is not complete ?

Actually we do not want to see an answer.  The packet won't trigger
an immediate ACK (it is larger than the advertised window, but does
not cause immediate memory pressure).

When we then send a RST before the delayed ACK would be generated:
 
> > +// Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq update yet
> > +   +0 < R. 20001:20001(0) ack 1 win 257

We are in a state where rcv_wup, rcv_wnd, and rcv_mwnd_seq have not
been updated yet, but we must still accept the RST 
(rcv_nxt == 20001 > rcv_mwnd_seq, tcp_max_receive_window() == 0)

> > +
> > +  +.1 %{ assert tcpi_state == TCP_CLOSE, tcpi_state }%

And we verify that we accepted the RST here.

Given how subtle this sequence is, and considering the limited value
of this test, I am also fine with dropping it if it is too fragile or
confusing.
