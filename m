Content-Type: multipart/mixed; boundary="===============1907192650566431589=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2] mptcp: Make MPTCP socket block/wakeup ignore
 sk_receive_queue
Date: Thu, 29 Aug 2019 18:30:22 +0200
Message-ID: <41b88dcf7d0234302d36ef958c3eb93ef110f208.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1908221405400.27597@gargpiyu-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1762

--===============1907192650566431589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-22 at 14:14 -0700, Mat Martineau wrote:
> On Thu, 22 Aug 2019, Paolo Abeni wrote:
> =

> > On Fri, 2019-08-02 at 17:16 -0700, Mat Martineau wrote:
> > > The MPTCP-level socket doesn't use sk_receive_queue, so it was possib=
le
> > > for mptcp_recvmsg() to remain blocked when there was data ready for it
> > > to read. When the MPTCP socket is waiting for additional data and it
> > > releases the subflow socket lock, the subflow may have incoming packe=
ts
> > > ready to process and it sometimes called subflow_data_ready() before =
the
> > > MPTCP socket called sk_wait_data().
> > > =

> > > This change adds a new function for the MPTCP socket to use when wait=
ing
> > > for a data ready signal. Atomic bitops with memory barriers are used =
to
> > > set, test, and clear a MPTCP socket flag that indicates waiting subfl=
ow
> > > data. This flag replaces the sk_receive_queue checks used by other
> > > socket types.
> > > =

> > > Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> > =

> > (sorry for lagging behind so much)
> > =

> > The patch LGTM, but I have some related questions: how do you reproduce
> > the issue fixed here? can we add that to the self-tests? (I assume/sort
> > of recall the patch fix the issue in your scenario).
> > =

> =

> I was seeing the issue between the multipath-tcp.org kernel and ours, wit=
h =

> a couple of simple test programs. The multipath-tcp.org system had a =

> program running that would do a recvmsg() and then immediately send =

> anything it received, and the prototype system would send data and then =

> try to read it back. The prototype system could get stuck waiting for a =

> blocked recvmsg() to return even though the peer had sent the data.
> =

> It may have been timing-dependent, I'll see if I can make it happen in a =

> self test.

Ok, I think that a self-test here is not strictly required. =


I think we can merge this patch as is.

Paolo


--===============1907192650566431589==--
