Content-Type: multipart/mixed; boundary="===============0507942619218282014=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Thu, 03 Oct 2019 10:12:51 +0200
Message-ID: <01b35a0bb501816a157e9c6681d2ee59d86278af.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1910021737190.33041@syitbare-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2008

--===============0507942619218282014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On Wed, 2019-10-02 at 17:39 -0700, Mat Martineau wrote:
> On Wed, 2 Oct 2019, Mat Martineau wrote:
> > On Wed, 2 Oct 2019, Mat Martineau wrote:
> > > On Wed, 2 Oct 2019, Matthieu Baerts wrote:
> > > > On my side, I think our last "export" branch is ready: all the patc=
hes
> > > > we previously mentioned are merged, it is rebased on latest net-nex=
t,
> > > > tests are all good. I think it is ready to be sent! I just tagged
> > > > netdev-rfcv2 but feel free to modify it if it is not OK :)
> > > > =

> > > > With a bit of luck, if you have time to send it and if nothing is
> > > > missing, we might have the first feedbacks before the meeting tomor=
row!
> > > > Or yeah, more likely for the week after. But we never know :)
> > > =

> > > I just sent the 45 (!) patch series to netdev. Thanks for all of your=
 work =

> > > to prepare the branch, Matthieu.
> > > =

> > > I will also push the branch to my git.kernel.org repo to trigger a =

> > > LKP/0-day automated build.
> > > =

> > =

> > ...and I just figured out that I generated the .patch files from the wr=
ong =

> > commits :(
> > =

> > Regenerating those and resending. Sorry!
> > =

> =

> Based on Dave's feedback, it looked like a bad idea to repost the correct =

> 43 patches today. Sorry again about the error on my part, we can discuss =

> how to partition the patch series (and possibly squash some more patches) =

> at the meeting tomorrow.

First things first,  _thank you_ so much for the several extra miles
you just did! - I'll ask my real boss if that makes you eligible for an
additional 17% discount for your first reservation in this nice Tuscany
B&B ;)

At least we good some real feedback based on the code. =


I do agree with Florian suggestion:

> I would suggest to make another RFC submission on Friday or Monday,
> consisting only of the non-mptcp patches, i.e.:
>
>      net: Make sock protocol value checks more specific
>      sock: Make sk_protocol a 16-bit value
>      tcp: Define IPPROTO_MPTCP
>      tcp, ulp: Add clone operation to tcp_ulp_ops
>      tcp: Prevent coalesce/collapse when skb has MPTCP extensions
>      tcp: Export low-level TCP functions
>      tcp: Check for filled TCP option space before SACK
>      tcp: clean ext on tx recycle
>      tcp: Expose tcp struct and routine for MPTCP

I think that:

       tcp: clean ext on tx recycle

does have some minimal mptcp dependencies that can't be removed without
making such patch a no-op, so perhaps we should also include some very
minimal MPTCP stub definitions:

       tcp: Add MPTCP option number
       mptcp: Add MPTCP to skb extensions

I *think* we can also do a bolder step and send this next iteration as
_NOT_ RFC, aiming at inclusion. My [mis]understanding is that we
should post later chunks after the first one is merged, easily.

Anyhow it looks like we will have some big topic for today's mtg! :)

Cheers,

Paolo

--===============0507942619218282014==--
