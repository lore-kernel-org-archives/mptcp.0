Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1893510F1
	for <mptcp@lists.linux.dev>; Thu,  9 Oct 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000525; cv=none; b=XHr0CUhPs/A+I9QRi/2QTnSoHg2Ju04Shd5NLPKAsKhjPqJWzrC/jmk9GgKJbDrT/ECls3L75J2FSA4iD+fXOWp6+yH2dH1U6L8m+f2PxiP7qZzYuUyTtVtq06A4O442bPN4cYieHhfgUfFIGQ37c1BmR2HoQ8N3BmApbPe4/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000525; c=relaxed/simple;
	bh=c19aO7lan29C8LZo2wYcGsbs2rHHAGBoOGwSSbSPQMM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPE+Q9eqAnfMbrJBuWg6oLGSOH7mb9RtHT3UN7SKXLe5RoiJBsCZ2TrkXFV7ZJJG0HmpcAO+5M+Cjqwe1kE06o22hyhSLIekf5PaxabOrUn1oruDpE8AXp/4eBhXaLjxllNmYcW/Hfx3Em0Dk1ggXMIEWNpYqdnMj1+quOyQMcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgBjPP7I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgBjPP7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98177C4CEE7;
	Thu,  9 Oct 2025 09:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760000524;
	bh=c19aO7lan29C8LZo2wYcGsbs2rHHAGBoOGwSSbSPQMM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=bgBjPP7Ijdbvy4mdo3fPlsic6+wyLeGXX4f0AeMsfFjNq9FitdyqfWwoKRmWXDJ0R
	 gMM9oTSew2CfVN0MoXHPlgcTxa/3ESrXWfKTmJerh4wd+XHVc8xrzvskNSNWIRbIRy
	 oV6mE/p3v90c3AVJhBXo6tJvSoYgwNCv71vEMmhiaEdZDqMHPOMXth4LckMdq+7uEX
	 HVermk6Vy36cy1Rm05Fb/VHCk+SXTZBCZD1/cJ6jJqvxLGeOoZDI7JXye35Z3MRQs9
	 WJ30/xblGufThUTxyvYj0L2rLOQ7H2+GOMeHuBHSpYGW6C5qq38gHYPzlbHsfdbvkf
	 A5+SNgXCzOgVQ==
Message-ID: <c53540268cb422a14d38745c6d0bdb440deb7c11.camel@kernel.org>
Subject: Re: [PATCH v5 mptcp-next 00/10] mptcp: introduce backlog processing
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	mptcp@lists.linux.dev
Date: Thu, 09 Oct 2025 17:02:00 +0800
In-Reply-To: <8a8feb1d-ad10-4ba4-a448-db8a0e45c7c3@redhat.com>
References: <cover.1759737859.git.pabeni@redhat.com>
	 <2c9f131e-ef34-4916-8aab-e1420e1ae90b@kernel.org>
	 <d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org>
	 <b90e5899-6473-4b3b-a239-9202c2e2cb03@redhat.com>
	 <2389029f56a9fa496b59be7655987e6d9c6362f2.camel@kernel.org>
	 <8a8feb1d-ad10-4ba4-a448-db8a0e45c7c3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Thu, 2025-10-09 at 09:52 +0200, Paolo Abeni wrote:
> On 10/9/25 8:54 AM, Geliang Tang wrote:
> > On Wed, 2025-10-08 at 09:30 +0200, Paolo Abeni wrote:
> > > On 10/8/25 5:07 AM, Geliang Tang wrote:
> > > > On Mon, 2025-10-06 at 19:07 +0200, Matthieu Baerts wrote:
> > > > > Hi Paolo,
> > > > > 
> > > > > On 06/10/2025 10:11, Paolo Abeni wrote:
> > > > > > This series includes RX path improvement built around
> > > > > > backlog
> > > > > > processing
> > > > > Thank you for the new version! This is not a review, but just
> > > > > a
> > > > > note
> > > > > to
> > > > > tell you patchew didn't manage to apply the patches due to
> > > > > the
> > > > > same
> > > > > conflict that was already there with the v4 (mptcp_init_skb()
> > > > > parameters
> > > > > have been moved to the previous line). I just applied the
> > > > > patches
> > > > > manually. While at it, I also used this test branch for
> > > > > syzkaller
> > > > > to
> > > > > validate them.
> > > > > 
> > > > > (Also, on patch "mptcp: drop the __mptcp_data_ready()
> > > > > helper",
> > > > > git
> > > > > complained that there is a trailing whitespace.)
> > > > 
> > > > Sorry, patches 9-10 break my "implement mptcp read_sock" v12
> > > > series. I
> > > > rebased this series on patches 1-8, it works well. But after
> > > > applying
> > > > patches 9-10, I changed mptcp_recv_skb() in [1] from
> > > 
> > > Thanks for the feedback, the applied delta looks good to me.
> > > 
> > > > # INFO: with MPTFO start
> > > > # 57 ns2 MPTCP -> ns1 (10.0.1.1:10054      ) MPTCP    
> > > > (duration
> > > > 60989ms) [FAIL] client exit code 0, server 124
> > > > # 
> > > > # netns ns1-RqXF2p (listener) socket stat for 10054:
> > > > # Failed to find cgroup2 mount
> > > > # Failed to find cgroup2 mount
> > > > # Failed to find cgroup2 mount
> > > > # Netid State    Recv-Q Send-Q Local Address:Port  Peer
> > > > Address:Port  
> > > > # tcp   ESTAB    0      0           10.0.1.1:10054    
> > > > 10.0.1.2:55516
> > > > ino:2064372 sk:1 cgroup:unreachable:1 <->
> > > > # 	 skmem:(r0,rb131072,t0,tb340992,f0,w0,o0,bl0,d0) sack
> > > > cubic
> > > > wscale:8,8 rto:206 rtt:5.026/10.034 ato:40 mss:1460 pmtu:1500
> > > > rcvmss:1436 advmss:1460 cwnd:10 bytes_sent:115312
> > > > bytes_retrans:1560
> > > > bytes_acked:113752 bytes_received:5136 segs_out:85 segs_in:16
> > > > data_segs_out:83 data_segs_in:4 send 23239156bps lastsnd:60939
> > > > lastrcv:61035 lastack:60912 pacing_rate 343879640bps
> > > > delivery_rate
> > > > 1994680bps delivered:84 busy:123ms sndbuf_limited:41ms(33.3%)
> > > > retrans:0/2 dsack_dups:2 rcv_space:14600 rcv_ssthresh:75432
> > > > minrtt:0.003 rcv_wnd:75520 tcp-ulp-mptcp flags:Mec
> > > > token:0000(id:0)/32ed0950(id:0) seq:2946228641406205031 sfseq:1
> > > > ssnoff:1349223625 maplen:5136
> > > > # mptcp LAST-ACK 0      0           10.0.1.1:10054    
> > > > 10.0.1.2:55516
> > > > timer:(keepalive,59sec,0) ino:0 sk:2 cgroup:unreachable:1 ---
> > > > # 	
> > > > skmem:(r0,rb131072,t0,tb345088,f4088,w352264,o0,bl0,d0)
> > > > subflows_max:2 remote_key token:32ed0950
> > > > write_seq:6317574787800720824
> > > > snd_una:6317574787800376423 rcv_nxt:2946228641406210168
> > > > bytes_sent:113752 bytes_received:5136 bytes_acked:113752
> > > > subflows_total:1 last_data_sent:60954 last_data_recv:61036
> > > > last_ack_recv:60913                                       
> > > 
> > > bytes_sent == bytes_sent, possibly we are missing a window-open
> > > event,
> > > which in turn should be triggered by a mptcp_cleanp_rbuf(), which
> > > AFAICS
> > > are correctly invoked in the splice code. TL;DR: I can't find
> > > anything
> > > obviously wrong :-P
> > > 
> > > Also the default rx buf size is suspect.
> > > 
> > > Can you reproduce the issue while capturing the traffic with
> > > tcpdump?
> > > if
> > > so, could you please share the capture?
> > 
> > Thank you for your suggestion. I've attached several tcpdump logs
> > from
> > when the tests failed.
> 
> Oh wow! the receiver actually sends the window open notification
> (packets 527 and 528 in the trace), but the sender does not react at
> all.
> 
> I have no idea/I haven't digged yet why the sender did not try a zero
> window probe (it should!), but it looks like we have some old bug in
> sender wakeup since MPTCP_DEQUEUE introduction (which is very
> surprising, why we did not catch/observe this earlier ?!?). That
> could
> explain also sporadic mptcp_join failures.
> 
> Could you please try the attached patch?

Thank you very much. I just tested this patch, but it doesn't work. The
splice test still fails and reports the same error.

-Geliang

> 
> /P
> 
> p.s. AFAICS the backlog introduction should just increase the
> frequency
> of an already possible event...

