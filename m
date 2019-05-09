Content-Type: multipart/mixed; boundary="===============3670731714409262564=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: refactor shudown/close
Date: Thu, 09 May 2019 14:29:12 +0200
Message-ID: <2c4e61ec1ba611e36ee47f88a91e5118508d617d.camel@redhat.com>
In-Reply-To: 1618f3ac-53a2-0b23-da21-cb4073140e3b@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1134

--===============3670731714409262564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-05-09 at 13:30 +0200, Matthieu Baerts wrote:
> On 09/05/2019 10:27, Paolo Abeni wrote:
> > Hi,
> > =

> > On Wed, 2019-05-08 at 17:45 -0700, Mat Martineau wrote:
> > > On Wed, 8 May 2019, Paolo Abeni wrote:
> > > =

> > > > Move the subflows list flushing to a dedicated helper, and use a pl=
ain
> > > > list_head for list entries.
> > > > =

> > > > This solves the scheduling while atomic splat on shutdown, but reta=
in
> > > > the RCU locking (and the need for synchronize RCU). The helper shou=
ld
> > > > simplify changing the locking schema on a later patch.
> > > =

> > > This seems like the right direction, but on my test VM it makes all t=
he =

> > > self tests fail with "copyfd_io: poll timed out" messages. I haven't =

> > > enabled more debug output yet to figure out what's going on.
> > =

> > This looks like the "unrelated issue" I mentioned in my previous patch.
> =

> Is it then OK for you if I squash this in the mentioned commit?

Whooops, I hope I'm still on time to self-nack this one. The patch has
indeed some problems: it should not flush nor release the subflow on
shutdown().

Since we can't protect the subflows list traversal and kern_shutdown()
with RCU nor with a spinlock, I think the easier way to fix the
scheduling-while-atomic issue is moving subflows list traversal (and
modification, too) under the mptcp socket lock. That would avoid also
the costly synchronize_rcu() call.

Paolo






--===============3670731714409262564==--
