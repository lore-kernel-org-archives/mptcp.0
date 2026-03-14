Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D2132D0FC
	for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508030; cv=none; b=h/w+lRJVWmtMMbnq4DBx7kps/SqT3m4l1lW1B0LCKSblGfKYeBhN/OGt+7Guo7Lm//4bJRbSXZoOmDK7lnnnMA28MghmjGhnGMl9xDi4tCRbtJkTMBkg09KsQh/1tIjI5ADQ7q9iGZI0e7nUvES59ISCqv678NoASLC4howu/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508030; c=relaxed/simple;
	bh=JmwWTR8tdLBqN2ZJaJyR7rVbXUX1qdfFYCxVt/hEa7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbMpaXNyLXHK/tszCcOHfTKzEqcmn2BFQLigNjN9FhZT5hHc3N8SwYE+wiCY6B+/FDSKwSK97XUB9Kf5UkdnHAK3HXuDs9UgSrdSHDUViHA7MN5OtJ4Qm1BfqRwCHG1k+foDNH9b3xMEXE/KdDxmNEGtXcv1jeiKh4p7RB4jPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7TgU32T; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7TgU32T"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439c5b40f60so2569776f8f.0
        for <mptcp@lists.linux.dev>; Sat, 14 Mar 2026 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773508027; x=1774112827; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5sXk7QR4yMzNPBEKkRLre6dWWa+kcD2gx8NHV2qKsY=;
        b=g7TgU32Tv74JO85KQBWjo8Dxq80wd8rlP3jL9u9tyP+TVTPau9JpA3Ks8d1VTUM1U+
         RSbrlNXfpbF/tuMZ724to/Ts+lkrKzVZuMX9XNhlGq0XHy8RupH5LVIN7kXX9MYX/98V
         s72kXS5ulnNIw0IdYEt7GFjm5k1dIlKGO2t6eVXvF/kxVcqw8VD5cLz03WSgNydkjBLl
         wmS7VeWRsxm7XgU7sTCFt8Zz1skTMUWyCJ8BtwHEzbgeNgGjXCW4TU8idyHTD13jd1yT
         SfihzA8xEhpz7HToPBqQyQ3QqT027A8bg+M229K0Gu1HDidgwrao1IjJw9GJ93qbxENU
         cmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773508027; x=1774112827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5sXk7QR4yMzNPBEKkRLre6dWWa+kcD2gx8NHV2qKsY=;
        b=cK5HQ0eVVN2cMu7UGYzG3iPQhFc78xmi6plmltzuRi3ZvpP8pshZd4E2PFI7pVhsJR
         aBOTdtJ1eXwLYPazD8hxlRs9kynGkwLndU6CTBjHxJRSB582J1qh3ZBktw3RBnolieAt
         piFzCpWh/ywiiImF3AViuasrg8gg5rC3+z2I1z8xD1htZZaChpbn5tIyNhiKwbvVRAQZ
         dNoIpYE1WpPHw+HP766ew5i512ZbUW2LMA4NfhRBZuVrdah1DwUsv+FQnaJbk83wuntz
         E409mjTClcVe6BzCh1KYvF2ugiuCVs9J+T+1vYZ/vPlME3n1sNIyM4nu3g9sbITTglK+
         w2sw==
X-Forwarded-Encrypted: i=1; AJvYcCX+P7oikRwBm7SKyLPkIWRWIqBfURp92xhtIdpzJopWKoihnOrQWKTSgfRza4QTwyevdp1RdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOYPAFIvBio7VE1SPBqc4gwPzb7fMVaGgyoq1xMRuy46Cpy4i8
	ys94tOUEO4CaELeX9xrMz46aXqDUOnnFcEuFx6URZyAG/EmgDdifwVcp
X-Gm-Gg: ATEYQzzEqt0RQr7VgoWCUKsx3gOtjLxHoU9Ip1dBMaNXkyzkE4YiX0G/uhUOQ9Ios+I
	gsEGgl8+jkKHnSf/D8cmgIGnMt0nU4iR946Sx+hjuTnnPQtzTvJ6xyikatKViT9p4RwmmgCFGkq
	xSu3SR1WBJyjkUlmxp2U2iI8aT6lU3FpfuSczqbm6lzvC7KYenFwFXUIDvJoiI7bI67MDII1pvV
	UT3cSjlJIK0R0rYwr1t9v4eWhzMIeFoFxKKsr9saCKjxUEuBjkQsT4UReJzsXy7nbhiEVH3mJZ8
	Mar9R5OnbVLCJa+vCRgqiWHnFFTeo5nT9CErw0ZlsRJ8UiAFkMUvNji1thpxeThvDQ6g7rmU9YF
	ErZXGlSY4P9jU8GFm1KrMY9TfOVPtA5NWrGtMf0sQYRxZKTqA09AO5rP4msj67zvI3ryMJGS+WV
	UaVRQ0CgP4989WLyGwpBSRcDHOAZokqSC1Hcidw302fjE/yIGfPRvsje/3lmDc0IOnKOVU9TE1q
	7IP5x3gItip1NZ+j/wLUIQ=
X-Received: by 2002:a05:6000:2dc2:b0:439:d74f:2109 with SMTP id ffacd0b85a97d-43a04dc36c8mr12532240f8f.49.1773508026649;
        Sat, 14 Mar 2026 10:07:06 -0700 (PDT)
Received: from gandalf.schnuecks.de (p200300c14f1996009e6b00fffe39b8a7.dip0.t-ipconnect.de. [2003:c1:4f19:9600:9e6b:ff:fe39:b8a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2186e3sm31604155f8f.26.2026.03.14.10.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:07:06 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id A232730395F4; Sat, 14 Mar 2026 18:07:05 +0100 (CET)
Date: Sat, 14 Mar 2026 18:07:05 +0100
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
Message-ID: <abWVuS1XJaKrndJw@gandalf.schnuecks.de>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
 <CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com>
 <abCkmiCSPkmxzECa@gandalf.schnuecks.de>
 <CANn89iKYxs644ardFFSKo8d0EXL_2A5eUQjWZ3yp9-Q4tVLKzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKYxs644ardFFSKo8d0EXL_2A5eUQjWZ3yp9-Q4tVLKzQ@mail.gmail.com>

Hi Eric,

On Sat, Mar 14, 2026 at 04:58:28AM +0100, Eric Dumazet wrote:
> On Wed, Mar 11, 2026 at 12:09???AM Simon Baatz <gmbnomis@gmail.com> wrote:
> >
> > Hi Eric,
> >
> > On Tue, Mar 10, 2026 at 09:54:58AM +0100, Eric Dumazet wrote:
> > > On Mon, Mar 9, 2026 at 9:03???AM Simon Baatz via B4 Relay
> > > <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> > > >
> > > > From: Simon Baatz <gmbnomis@gmail.com>
> > > >
> > > > The test ensures we correctly apply the maximum advertised window limit
> > > > when rcv_nxt advances past rcv_mwnd_seq, so that the "usable window"
> > > > is properly clamped to zero rather than becoming negative.
> > > >
> > > > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > > > ---
> > > >  .../net/packetdrill/tcp_rcv_neg_window.pkt         | 26 ++++++++++++++++++++++
> > > >  1 file changed, 26 insertions(+)
> > > >
> > > > diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..15a9b4938f16d175ac54f3fd192ed2b59b0a4399
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > > > @@ -0,0 +1,26 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +--mss=1000
> > > > +
> > > > +`./defaults.sh`
> > > > +
> > > > +// Establish a connection.
> > > > +   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> > > > +   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> > > > +   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) = 0
> > > > +   +0 bind(3, ..., ...) = 0
> > > > +   +0 listen(3, 1) = 0
> > > > +
> > > > +   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
> > > > +   +0 > S. 0:0(0) ack 1 win 18980 <mss 1460,nop,wscale 0>
> > > > +  +.1 < . 1:1(0) ack 1 win 257
> > > > +
> > > > +   +0 accept(3, ..., ...) = 4
> > > > +
> > > > +// A too big packet is accepted if the receive queue is empty
> > > > +   +0 < P. 1:20001(20000) ack 1 win 257
> > >
> > > We do not see the answer, it seems this test is not complete ?
> >
> > Actually we do not want to see an answer.  The packet won't trigger
> > an immediate ACK (it is larger than the advertised window, but does
> > not cause immediate memory pressure).
> >
> > When we then send a RST before the delayed ACK would be generated:
> >
> > > > +// Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq update yet
> > > > +   +0 < R. 20001:20001(0) ack 1 win 257
> >
> > We are in a state where rcv_wup, rcv_wnd, and rcv_mwnd_seq have not
> > been updated yet, but we must still accept the RST
> > (rcv_nxt == 20001 > rcv_mwnd_seq, tcp_max_receive_window() == 0)
> >
> > > > +
> > > > +  +.1 %{ assert tcpi_state == TCP_CLOSE, tcpi_state }%
> >
> > And we verify that we accepted the RST here.
> >
> > Given how subtle this sequence is, and considering the limited value
> > of this test, I am also fine with dropping it if it is too fragile or
> > confusing.
> 
> Sorry I missed your answer.
> 
> Ok then please use :
> 
> // A too big packet is accepted if the receive queue is empty
>    +0 < P. 1:20001(20000) ack 1 win 257
>    +0 %{ assert tcpi_bytes_received == 20000, tcpi_bytes_received;
> assert tcpi_bytes_acked == 0, tcpi_bytes_acked }%

Unfortunately, tcpi_bytes_acked is the TX direction, it will always
be 0 here.

Instead, we can still test that the oversized packet is accepted and
indirectly verify that no immediate ACK is sent by eliciting and
checking a RST:

// A too big packet is accepted if the receive queue is empty, but does not trigger
// an immediate ACK.
   +0 < P. 1:20001(20000) ack 1 win 257
   +0 %{ assert tcpi_bytes_received == 20000, tcpi_bytes_received; }%

// Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq update yet
   +0 < R. 20001:20001(0) ack 1 win 257

// Verify that the RST was accepted. Indirectly this also verifies that no immediate
// ACK was sent for the data packet above.
   +0 < . 20001:20001(0) ack 1 win 257
    * > R 1:1(0)

As the series is merged now (thank you!), I will send this
separately, as suggested.

- Simon

-- 
Simon Baatz <gmbnomis@gmail.com>
