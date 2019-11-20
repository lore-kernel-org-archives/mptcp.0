Content-Type: multipart/mixed; boundary="===============6752416094231919830=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Warn + crash in mptcp_sendmsg_frag()
Date: Wed, 20 Nov 2019 16:26:40 +0100
Message-ID: <527335624c27e60fe5456e0adae54348b7bb0067.camel@redhat.com>
In-Reply-To: 11db3e0f-1ac1-ddf2-55ab-7160b1aa40f6@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2616

--===============6752416094231919830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-20 at 11:57 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 20/11/2019 11:18, Paolo Abeni wrote:
> > On Wed, 2019-11-20 at 10:51 +0100, Matthieu Baerts wrote:
> > > Hi Paolo,
> > > =

> > > On 18/11/2019 12:07, Paolo Abeni wrote:
> > > > On Sat, 2019-11-16 at 13:59 +0100, Matthieu Baerts wrote:
> > > > > On 15/11/2019 23:39, Paolo Abeni wrote:
> > > > > > On Fri, 2019-11-15 at 22:06 +0100, Matthieu Baerts wrote:
> > > > > > > If skb is NULL, mpext is NULL too (even if it could unlikely =
also be
> > > > > > > even if skb is no NULL but sounds more like a bug I guess) and
> > > > > > > can_collapse is False.
> > > > > > =

> > > > > > Uhm... I don't think this is the case. mpext is NULL even when
> > > > > > do_tcp_sendpages() did not collapsed the data - that is in the =
above
> > > > > > scenario.
> > > > > =

> > > > > I get the OOPS I got was because mpext was NULL, no?
> > > > > =

> > > > > BUG: kernel NULL pointer dereference, address: 0000000000000014
> > > > > =

> > > > > I didn't check with pahole but maybe linked to this instruction:
> > > > > =

> > > > >      mpext->data_len +=3D ret;
> > > > =

> > > > Sorry, I was not clear.
> > > > =

> > > > yes, very likely the crash is due to mpext, but I don't think mpext=
 is
> > > > NULL because skb is NULL. I think it's NULL because there was no
> > > > coalescing on skb (and thus no prior mpext in place).
> > > =

> > > Thank you, it is clearer!
> > > =

> > > I was not able to reproduce this bug by running the selftests for a f=
ew
> > > days so I guess this bug has been fixed. Sorry for the noise!
> > =

> > Uhm... if the diagnosys is correct, the bug is still there. It's just
> > very difficult to trigger... expecially without pktdrill ;)
> =

> Indeed, sorry.
> If it is very difficult to trigger, should we simply add a return/goto =

> if the WARN condition is valid? We can fix it properly later if it =

> really seen somewhere?

I have a tentative fix - but I can't test it ;)

Will try to push soon.

Cheers,

Paolo

--===============6752416094231919830==--
