Content-Type: multipart/mixed; boundary="===============7311337832414538114=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: refactor shudown/close
Date: Thu, 09 May 2019 10:27:28 +0200
Message-ID: <f9259a5a644f8316c889bf6d4a5960d0d5a0cf4b.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1905081735400.36102@ldraghi-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1132

--===============7311337832414538114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2019-05-08 at 17:45 -0700, Mat Martineau wrote:
> On Wed, 8 May 2019, Paolo Abeni wrote:
> =

> > Move the subflows list flushing to a dedicated helper, and use a plain
> > list_head for list entries.
> > =

> > This solves the scheduling while atomic splat on shutdown, but retain
> > the RCU locking (and the need for synchronize RCU). The helper should
> > simplify changing the locking schema on a later patch.
> =

> This seems like the right direction, but on my test VM it makes all the =

> self tests fail with "copyfd_io: poll timed out" messages. I haven't =

> enabled more debug output yet to figure out what's going on.

This looks like the "unrelated issue" I mentioned in my previous patch.

Note that since this patch has semantic effect only on socket close and
shutdown, is unlikely that it affects directily timeout events.
Possibly you are observing them because, without the splat that this
patch fixes, the execution is "faster" and more "race prone".

The netns based self-test never completed successfully here, on the
'vanilla' git repo.

I *think* this is related to the mptcp code incrementing the MPTCP-
level sequence number _after_ that the user-space receives the relevant
data.

The new MPTCP seq number can be delivered to the peer only after acking
more ingress TCP data. But the TCP window could be closed at that
point, and we could have to wait dup-ack - assuming that the MPTCP
option is refreshed for dup-acks, I'm unsure about that.

*if* the above held, a possible solution would be moving MPTCP seq
number management from recvmsg() to BH processing. I also think this is
sort of required for implementing MP_JOIN.

Paolo


--===============7311337832414538114==--
