Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57AC36075D
	for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 21:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697900; cv=none; b=PIoVO/kH55D96effpkUleXrdbeam4DYi1VPP455n0vtSu+th1LhC2W7XNoc9m1WknpZC4AGKMYaCI1Sc7JuulRyL+vPYKTnklNwnUIZtciWkwf2UZqviR/zcSVgG8GBF29M0lv3yv3SGCEa1JXFagB+ErD6B5Fzvvz9pDowYhUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697900; c=relaxed/simple;
	bh=22FQQziovkybfpoEgGEar4XKtg0Elmc86WdBJzgy3AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIzPvlxc8dJPg6a1YInEDQSFsJko/2QQaMWwF4iLrlta5BM9G/fjTIU7olmNJwn1Gcgvl01aAE0VinENwTC+la4bavTlt7JQo4AhSUB6brpMfw0S8DWYvEM2rfgfTQs+oMabcbCnpXnx/RZOea/hRiEr4JnDUzZiRsYx89XCYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VA5UKu9W; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA5UKu9W"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48538c5956bso1424365e9.0
        for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773697897; x=1774302697; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj1cmcN77XR2dLCOZTKXheeb7KLeaY6rrHsbkVnSpso=;
        b=VA5UKu9W7RY+erjSYQnRpAkLqHOF4rw7oVKi/NxrIkTS6e7Hmc6qnzX7qZy1q5a6fd
         iRz+DM+sek14e1cFbCKrq/DgQDMqnmnxJ3GAes8tRSGNTnyAWDqJ47l8iLaTTFV36kLs
         tzsP/dyJbbUcmU0a38CGKLOwjndeCGymuic6mJ3NK8PGhp/Lqh0Zg7eAshNY1pfuTdD8
         3b/DzQNaE+f/ghrHLGFkYs+lCE7QDOX18W4B4OMJV65D3FOZ1KfNKpjg+wqqqgLzaxmN
         DzC6sS2KnaurJxg6zuWnO4E7Aj91us0FoxNPcQun1OU7lXd5a7k4r/47jtmiUQIXhPHY
         L2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773697897; x=1774302697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sj1cmcN77XR2dLCOZTKXheeb7KLeaY6rrHsbkVnSpso=;
        b=Sb/LSn9nEity/W/EEvmiHlZZue7Aw236D36p08itKFRx/SLVyaS43NCByz7sWFua6x
         y3oUVdQXZIEDfmlBR2r1kFiM/HLF2AUJ9VdQqr0ZUIuxKYql+i/dDSDjEsQqsvq5BLKO
         Gbc4aDgNIvNZj//RsoklW5y1hA49r0of2XMDv4VPYkpHMP6OCAcpNm+WpH3bKfrwMugL
         ESYCpqNcmWafZt0Qz5vEXC7LlkUFbtfRa6/RV5wBB7MKHz2FdPy/NJdggpd93qaaYxgA
         xNLhQ630wVF2+jcmNPYZjLdV7Mj7Hzs+k4DgYt4G3a9XXBZuY26E5iOjpA4SKFGcfwvF
         odgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGiuBrpHsaHZmU9o7wjnqJo8qC0kS3BJq/Azdlhjx4U0l5JrCxuhqHcqtFYl2AyxbL5LnV1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8KFLQiQqfTwzof5ERhYPiy8eB0MvQRkX9RIScRMxxHdV8kkSz
	TnDt+u5lj524b7TVmzRfAFZyQ2ccFZMcf2ppKGyLYs5j7NAIKThxbxYo
X-Gm-Gg: ATEYQzzUyW6vwG8vksR7hkotyIqk1VKiCVUvhFJlGs6zB4KUXf4CMGj1APCNDzeks35
	k8C4lS8CfZTFvVlqQwNprGO5Rn92Dt1IYhk+sGQnYB/c/KG+PfQHBBjLGUodfycBrE+VGi0UQfq
	X2pqlAXsrHgofO8Ex3j96PbnoPOzc7gFUBojMAH8QIGzTsV9fk+fW22WG51Znkoekcq5hjHIeID
	AcWdnpRXjJZX4yGBnN5uq/2GIS4mtUliF+lMcct8iFxFqh2pzVqScaz37Kem94sH7fltEpWom8L
	SiHedY6YEI542JhpVRepUzW0AsmYpcReJZ4Ejn0X/pYuczLJ9Wa99YJuO1whzCfj/bVCY0VOb9B
	SoGkjiwgXKtqYKy9t7GR5LkmU3j6xomFWFeQVOV+NueSb3MyH/c9XRhM0Vumlf2IwV9cbtVkegs
	3SnxbYj6/hxUZcBGV38T+OiU4KG3I2G+4ti5dPmMLaEOPWMOeBp7BDeDlP1yC0wAcmW8rx7xMi3
	i+my6VEcqI7alMbotTO1po=
X-Received: by 2002:a05:600c:3e1a:b0:485:3428:774c with SMTP id 5b1f17b1804b1-4856eab522emr17811775e9.4.1773697896899;
        Mon, 16 Mar 2026 14:51:36 -0700 (PDT)
Received: from gandalf.schnuecks.de (p200300c14f1996009e6b00fffe39b8a7.dip0.t-ipconnect.de. [2003:c1:4f19:9600:9e6b:ff:fe39:b8a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eae3037sm20082795e9.11.2026.03.16.14.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:51:36 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 903633040F3A; Mon, 16 Mar 2026 22:51:35 +0100 (CET)
Date: Mon, 16 Mar 2026 22:51:35 +0100
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
Message-ID: <abh7Z5GEhEzty18d@gandalf.schnuecks.de>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
 <CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com>
 <abCkmiCSPkmxzECa@gandalf.schnuecks.de>
 <CANn89iKYxs644ardFFSKo8d0EXL_2A5eUQjWZ3yp9-Q4tVLKzQ@mail.gmail.com>
 <abWVuS1XJaKrndJw@gandalf.schnuecks.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abWVuS1XJaKrndJw@gandalf.schnuecks.de>

On Sat, Mar 14, 2026 at 06:07:05PM +0100, Simon Baatz wrote:
> Hi Eric,
> 
> On Sat, Mar 14, 2026 at 04:58:28AM +0100, Eric Dumazet wrote:
> > On Wed, Mar 11, 2026 at 12:09???AM Simon Baatz <gmbnomis@gmail.com> wrote:
> > >
> > > Hi Eric,
> > >
> > > On Tue, Mar 10, 2026 at 09:54:58AM +0100, Eric Dumazet wrote:
> > > > On Mon, Mar 9, 2026 at 9:03???AM Simon Baatz via B4 Relay
> > > > <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> > > > >
> > > > > From: Simon Baatz <gmbnomis@gmail.com>
> > > > >
> > > > > The test ensures we correctly apply the maximum advertised window limit
> > > > > when rcv_nxt advances past rcv_mwnd_seq, so that the "usable window"
> > > > > is properly clamped to zero rather than becoming negative.
> > > > >
> > > > > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > > > > ---
> > > > >  .../net/packetdrill/tcp_rcv_neg_window.pkt         | 26 ++++++++++++++++++++++
> > > > >  1 file changed, 26 insertions(+)
> > > > >
> > > > > diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > > > > new file mode 100644
> > > > > index 0000000000000000000000000000000000000000..15a9b4938f16d175ac54f3fd192ed2b59b0a4399
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > > > > @@ -0,0 +1,26 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +
> > > > > +--mss=1000
> > > > > +
> > > > > +`./defaults.sh`
> > > > > +
> > > > > +// Establish a connection.
> > > > > +   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> > > > > +   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> > > > > +   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) = 0
> > > > > +   +0 bind(3, ..., ...) = 0
> > > > > +   +0 listen(3, 1) = 0
> > > > > +
> > > > > +   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
> > > > > +   +0 > S. 0:0(0) ack 1 win 18980 <mss 1460,nop,wscale 0>
> > > > > +  +.1 < . 1:1(0) ack 1 win 257
> > > > > +
> > > > > +   +0 accept(3, ..., ...) = 4
> > > > > +
> > > > > +// A too big packet is accepted if the receive queue is empty
> > > > > +   +0 < P. 1:20001(20000) ack 1 win 257
> > > >
> > > > We do not see the answer, it seems this test is not complete ?
> > >
> > > Actually we do not want to see an answer.  The packet won't trigger
> > > an immediate ACK (it is larger than the advertised window, but does
> > > not cause immediate memory pressure).
> > >
> > > When we then send a RST before the delayed ACK would be generated:
> > >
> > > > > +// Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq update yet
> > > > > +   +0 < R. 20001:20001(0) ack 1 win 257
> > >
> > > We are in a state where rcv_wup, rcv_wnd, and rcv_mwnd_seq have not
> > > been updated yet, but we must still accept the RST
> > > (rcv_nxt == 20001 > rcv_mwnd_seq, tcp_max_receive_window() == 0)
> > >
> > > > > +
> > > > > +  +.1 %{ assert tcpi_state == TCP_CLOSE, tcpi_state }%
> > >
> > > And we verify that we accepted the RST here.
> > >
> > > Given how subtle this sequence is, and considering the limited value
> > > of this test, I am also fine with dropping it if it is too fragile or
> > > confusing.
> > 
> > Sorry I missed your answer.
> > 
> > Ok then please use :
> > 
> > // A too big packet is accepted if the receive queue is empty
> >    +0 < P. 1:20001(20000) ack 1 win 257
> >    +0 %{ assert tcpi_bytes_received == 20000, tcpi_bytes_received;
> > assert tcpi_bytes_acked == 0, tcpi_bytes_acked }%
> 
> Unfortunately, tcpi_bytes_acked is the TX direction, it will always
> be 0 here.
> 
> Instead, we can still test that the oversized packet is accepted and
> indirectly verify that no immediate ACK is sent by eliciting and
> checking a RST:
> 
> // A too big packet is accepted if the receive queue is empty, but does not trigger
> // an immediate ACK.
>    +0 < P. 1:20001(20000) ack 1 win 257
>    +0 %{ assert tcpi_bytes_received == 20000, tcpi_bytes_received; }%
> 
> // Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq update yet
>    +0 < R. 20001:20001(0) ack 1 win 257
> 
> // Verify that the RST was accepted. Indirectly this also verifies that no immediate
> // ACK was sent for the data packet above.
>    +0 < . 20001:20001(0) ack 1 win 257
>     * > R 1:1(0)
> 
> As the series is merged now (thank you!), I will send this
> separately, as suggested.

Patch is at: https://lore.kernel.org/netdev/20260316-improve_tcp_neg_usable_wnd_test-v1-1-f16d5e365107@gmail.com/

-- 
Simon Baatz <gmbnomis@gmail.com>
