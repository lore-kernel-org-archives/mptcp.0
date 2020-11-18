Content-Type: multipart/mixed; boundary="===============8740640996710374834=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 1/6] mptcp: separate accouting for wmem forward
 alloc mem
Date: Wed, 18 Nov 2020 10:37:20 +0100
Message-ID: <007e2c964d8ed2856e33b25309bd38ee1135c788.camel@redhat.com>
In-Reply-To: 66b2f6a8-315-e498-94c1-229e6164c6cd@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6767

--===============8740640996710374834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-11-17 at 13:07 -0800, Mat Martineau wrote:
> On Tue, 17 Nov 2020, Paolo Abeni wrote:
> =

> > On Tue, 2020-11-17 at 11:47 +0100, Florian Westphal wrote:
> > > Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > > As mentioned before, one possible follow-up to this series is open-=
code
> > > > a MPTCP-specific variant of lock_sock()/release_sock() which will a=
llow
> > > > performing some additional/MPTCP specific actions under the msk lev=
el
> > > > spinlock.
> > > > =

> > > > Specifically:
> > > > =

> > > > - in recevmsg(), in lock_sock(), splice sk->sk_receive_queue in msk-
> > > > > receive_queue
> > > > - still in recvmsg(), in release_sock(), update the bulk freed rmem
> > > > =

> > > > Overall this 2 will allow acquiring no additional spinlock at all in
> > > > the average case for recvmsg()
> > > > =

> > > > - in sendmsg(), in lock_sock(), move as much memory as needed from
> > > > sk_forward_memory to wforward_memory, eventually allocating it.
> > > > - in sendmsg(), in release_sock(), move again the unused
> > > > wforward_memory to sk_forward_memory.
> > > > =

> > > > Overall this 2 will allow acquiring no additional spinlock at all in
> > > > the average case for sendmsg() and will avoid artifacts due to the
> > > > sk_forward_memory/wforward_memory separation.
> > > > =

> > > > But they additionally will allow replacing the wforward_memory field
> > > > with a local variable.
> > > > =

> > > > So I'm wondering if I should already code the above, to avoid
> > > > introducing this additional new msk field just to remove it in a few
> > > > patches !?!
> > > =

> > > Tricky.
> > =

> > The trickest part is probably getting a corret estimate for the wmem we
> > are going to use. But we don't really need to be very accurate.
> > =

> > > Do you have hunch of how much additional code churn that
> > > means?
> > > =

> > > If its not too much 'rewrite', I would prefer to do it later on
> > > even if that means axing the newly added field.
> > > =

> > > If it means to rewrite most of this again then its probably
> > > better to do it right away.
> > =

> > eh... the only way I had for a reasonable answer to the above was...
> > trying to code it, do I did it ;)
> > =

> > In the end I had to retain the newly added field - with a slightly
> > different semantic and name:
> > =

> > https://github.com/pabeni/mptcp/tree/worker_must_die_6
> > =

> > I think overall it cleans things more than a bit...
> > =

> =

> Yes, I find the version of this patch in
> https://github.com/pabeni/mptcp/tree/worker_must_die_6.1 to be cleaner =

> than the version posted here without mptcp_lock_sock().

That was my impression, too ;)

> Did you intend to use __sk in the body of the mptcp_lock_sock() macro?

That is typo on my side! Thanks for finding it. The macro actually
works only because a 'sk' variable is always available in the scopes
where the macro is used/invoked. I'll fix that.

Since looks like _6 is a viable option I'll post a v3 with that, ok?

Thanks!

Paolo

--===============8740640996710374834==--
