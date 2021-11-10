Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0B2C80
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 11:37:53 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mklvL-0001oe-Iu; Wed, 10 Nov 2021 12:37:51 +0100
Date: Wed, 10 Nov 2021 12:37:51 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/3] mptcp: add SIOCINQ, OUTQ and OUTQNSD
 ioctls
Message-ID: <20211110113751.GG16363@breakpoint.cc>
References: <7bfe33f96550ffd6efaa3266f6027a8d7c500b70.camel@redhat.com>
 <67929b99f9baaf448457bf2cd5efce430dd1a2d9.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67929b99f9baaf448457bf2cd5efce430dd1a2d9.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> Whoops, I omitted the ML in my reply, sorry...
> 
> @Florian: sorry for the dups! please reply to this one, if needed, to
> re-include properly the ML into the thread.
> 
> On Wed, 2021-11-10 at 09:53 +0100, Florian Westphal wrote:
> > Paolo Abeni <pabeni@redhat.com> wrote:
> > > > +	if (sk->sk_state == TCP_LISTEN)
> > > > +		return -EINVAL;
> > > > +
> > > > +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> > > > +		return 0;
> > > > +
> > > > +	delta = READ_ONCE(msk->write_seq) - v;
> > > 
> > > This is under the msk socket lock and write_seq is protected by the
> > > full/plain msk socket lock so READ_ONCE should not be necessary, I
> > > think. The same for 'snd_nxt' below. 
> > 
> > Then why is write_seq updated with WRITE_ONCE in lots of places?
> 
> 'write_seq' is read outside the msk socket lock scope in a few places. 

Bah.  You are right. TBH I do not understand READ|WRITE_ONCE usage in
mptcp anymore.  Maybe its correct, who knows.

The different locking schemes are not easy to follow for me.

> BTW this always reports '1' on fallback sockets after shutdown, as
> after shutdown write_seq is incremented by 1, but snd_una/snd_nxt are
> not incremented when receiving the TCP fin. I guess the fix not
> strictly related to this patch.

That should be ok, we should return nonzero inq hint when next read()
would indicate EOF.
