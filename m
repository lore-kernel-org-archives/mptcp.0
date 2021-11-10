Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075872
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 08:53:21 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mkjM1-00015i-DP; Wed, 10 Nov 2021 09:53:13 +0100
Date: Wed, 10 Nov 2021 09:53:13 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/3] mptcp: add SIOCINQ, OUTQ and OUTQNSD
 ioctls
Message-ID: <20211110085313.GD16363@breakpoint.cc>
References: <20211108105711.16200-1-fw@strlen.de>
 <20211108105711.16200-4-fw@strlen.de>
 <b467d2f950e6dd6c3f8e6c745b4c9a884625c77f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b467d2f950e6dd6c3f8e6c745b4c9a884625c77f.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> > +	if (sk->sk_state == TCP_LISTEN)
> > +		return -EINVAL;
> > +
> > +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> > +		return 0;
> > +
> > +	delta = READ_ONCE(msk->write_seq) - v;
> 
> This is under the msk socket lock and write_seq is protected by the
> full/plain msk socket lock so READ_ONCE should not be necessary, I
> think. The same for 'snd_nxt' below. 

Then why is write_seq updated with WRITE_ONCE in lots of places?
