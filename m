Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680168;
	b=F9dTtU/7kI82LAJmxkb7hUDPH3AspDFDujUV9mn6jl3a2Zwyg9QuSnFjKygHdX2E+bPP
	 y4Rdv8MT7JxHXjyKlKBmeOu5KD1lpKAo17Mx4cm+zb6bdQxlKvVCUPerptt/52qwuO5Fx
	 e7BNWojA1gAJdvXqvKJ8fDvEVqMwm5apVvtbqLyt+XhMDvRT/E7fJiHsADjTk8tU6WRHD
	 Ug8ujul+7vCLMlPAPBqblWlzD8kXKCaYXuwZijElMEKR8crjK1kcURrhkEFwGzWGTrgIR
	 YM3T6ETRzYbrPmcljmU2k8HI8Aqm9WgGZnUfCbd36j5uGm+Qwt3E5F+KE0RpMmM9jZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680168;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3amme4EOeMOIAraLZQm058zC476khBE1m4TAbgTskCw=;
	b=HH2PCNtoSWnrn4okNXjaYYGAw0BPeWipnMeQ6UsiyN6aVysoc5ctjiYgaTEryKbwQwAn
	 Hh3N5br4UDqbbp2LGFPXAmZ8uSH/tj3Drd5PXYyPLxtS/FLts4+zf542Zf3KdY//B1Uex
	 FnCJR7At6eLdyWT4TvhFFAu94ot4PwyOeJzNL1B9Mskq6msXvVXWcqYt6sJFTGcCLVI3A
	 XGvEtyurQH6NjB+1Trb22I6maw1SxDABgM0UOI9onsNCpTz3xdf4wvyPT+HgBznQjMHOu
	 nIkz06ZNzFmdobptTDVNMmcazreKkI0aSx5VVKjuy977RWD71kWOoN3sm14A52KyPGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yh9RKGkd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C9606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yh9RKGkd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406811F000D1;
	Thu, 26 Nov 2026 08:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795680168;
	bh=3amme4EOeMOIAraLZQm058zC476khBE1m4TAbgTskCw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Yh9RKGkda7wfLWlenHUzi+BK55kO/4z3YPT/bh3LE7ta1CqIYafy09xc2dR8iAdv+
	 QZABStU8CIPOj9IaSg7g7szv3O8SNtJpm2NiEdC/GC0gTOwfTyFE6935QN3okSo+YQ
	 yspEgnqctjFcKvetCNE6Lrsd5725uSsiVh7pXxfunmU0RpvLSEuL/IQENfRaDAzFcC
	 boYtoM+sKYWJrmioFQhTeOMulPjJEKu8eWIAa3+5uRTTfbh5mBAndh9am0g2rz6czh
	 669PbwR8qxPQ7FaX1KvK0nPiefnmi+ZiG7/9Lmxx10lKWkmJTw7FnabF2uDvupTvXy
	 aWNQEfTRX+uQQ==
Message-ID: <825b47898c5d29088dd0c5683ef78199c34e6658.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 18/50] mptcp: no fastclose reset from
 SYN_SENT subflows
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Date: Thu, 26 Nov 2026 16:02:42 +0800
In-Reply-To: <434088a0-a6aa-4257-9371-faeb229ec154@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
	 <20261124-mptcp-cmason-fixes-v3-18-416c0920c73f@kernel.org>
	 <50f4d21d44f291853805421d84e2a4ac3f25010f.camel@kernel.org>
	 <434088a0-a6aa-4257-9371-faeb229ec154@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2026-11-26 at 08:35 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the reviews!
> 
> On 26/11/2026 08:04, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Tue, 2026-11-24 at 22:59 +0100, Matthieu Baerts (NGI0) wrote:
> > > mptcp_do_fastclose() sends a reset with an MP_FASTCLOSE on each subflow
> > > not in LISTEN or CLOSE, also on the ones in SYN_SENT, while TCP sends no
> > > reset in this state, see tcp_need_reset() used by tcp_disconnect(). On a
> > > disconnect in SYN_SENT, e.g. with connect(AF_UNSPEC), an MPTCP client
> > > then sends a reset with an MP_FASTCLOSE carrying an unknown key, 0. With
> > > TCP_FASTOPEN_CONNECT, this reset is even sent before any SYN.
> > > 
> > > Before the commit below, these resets were sent by tcp_disconnect(), so
> > > not in SYN_SENT. Skip them again in this state, as TCP does, but move
> > > the subflow to TCP_CLOSE at once, as tcp_disconnect() does: a SYN-ACK
> > > received before the end of the close cannot complete the connection, and
> > > a later one gets a reset from the stack.
> > > 
> > > This issue has been found by an AI code review agent, while reviewing
> > > "mptcp: clear DEFER_CONNECT on disconnect", and confirmed with a new
> > > Packetdrill test: a disconnect in SYN_SENT, then the SYN-ACK. Without
> > > this patch, a reset with MPTCP options was sent at the disconnect,
> > > before the one replying to the SYN-ACK:
> > > 
> > >   disconnect_in_syn_sent.pkt:16: error handling packet: live packet field ipv4_total_length: expected: 40 (0x28) vs actual: 56 (0x38)
> > > 
> > > Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > > v2: new, for an issue found by a review agent
> > > v3: move the subflow to TCP_CLOSE at once, not to complete the
> > >     connection with a SYN-ACK received in between (Clashiko)
> > > ---
> > >  net/mptcp/protocol.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 87f6da0f6cab..6c712f677220 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -3321,6 +3321,12 @@ static void mptcp_do_fastclose(struct sock *sk)
> > >  
> > >  		subflow->send_fastclose = 1;
> > >  
> > > +		/* no reset in SYN_SENT, but a close at once, as TCP does */
> > > +		if (ssk->sk_state == TCP_SYN_SENT) {
> > > +			tcp_set_state(ssk, TCP_CLOSE);
> > > +			goto unlock;
> > > +		}
> > > +
> > 
> > The existing check for LISTEN and CLOSE states in this function uses
> > 
> > 		if ((1 << ssk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)).
> > 
> > For consistency, it would be better to use the same style for the SYN_SENT
> > check here:
> > 
> > 		if ((1 << ssk->sk_state) & TCPF_SYN_SENT)
> > 
> > This keeps the code style uniform throughout the function. WDYT?
> 
> It's good to keep the code style uniform, but I don't think doing that
> here is interesting: converting the state to a bitmap is good to check
> for multiple states, but not just for one where we can directly compare
> the state. Plus it looks this conversion is never done to compare just
> one state (except in sock_map_sk_state_allowed() but that feels wrong).
> 
> So I think we should better not change this, no?

You're right, using "ssk->sk_state == TCP_SYN_SENT" is more efficient here.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> Cheers,
> Matt
