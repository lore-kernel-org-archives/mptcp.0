Content-Type: multipart/mixed; boundary="===============9007602316370784745=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/2] Squash-to: "mptcp: allow picking
 different xmit subflows"
Date: Thu, 10 Sep 2020 10:38:37 +0200
Message-ID: <129b5abdc28694386fce1e02f80a77766eb5bfa8.camel@redhat.com>
In-Reply-To: alpine.OSX.2.23.453.2009091737010.4909@atenciom-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5782

--===============9007602316370784745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-09-09 at 17:40 -0700, Mat Martineau wrote:
> On Wed, 9 Sep 2020, Paolo Abeni wrote:
> =

> > This improves the current packet scheduler for scenarios
> > where the msk sockets is using different links with different
> > bandwith limits.
> > =

> > The commit comment should be changed into:
> > =

> > """
> > Update the scheduler to less trivial heuristic: cache
> > the last used subflow, and try to send on it a reasonably
> > long burst of data.
> > =

> > When the burst or the subflow send space is exhausted, pick
> > the subflow with the lower ratio between write space and
> > send buffer - that is, the subflow with the greater relative
> > amount of free space.
> > """
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > v1 -> v2:
> > - remove some unneeded magic number
> > - fix potential division by 0 - Florian
> > =

> > Note:
> > - subflows are now selected when sk_stream_memory_free(ssk),
> >  while before we used sk_stream_is_writeable(ssk). The current
> >  choice is closer to plain TCP and IMHO more correct, but
> >  even the old one should not be buggy.
> >  Anyhow I saw reproducible write error (EAGAIN) when using
> >  sk_stream_is_writeable() with this strategy, and I was unable
> >  to track them down, so possibly there is some other bug there
> >  I could not find.
> > - simuilt xmit self-tests are still failing, even if we are now
> >  closer to success. The failures are now caused by the high delay
> >  configured on the virtual link.
> >  This problem would be addressed by a larger initial send buffer,
> >  but the current xmit path is unable to cope with that correctly:
> >  with a larger send buffer it will send pkts outside the MPTCP
> >  window.
> >  To properly address the above we additionally need something alike
> >  "mptcp: keep track of receivers advertised window" from Florian,
> >  plus the ability to enqueue data at the MPTCP level and send it
> >  when the MPTCP level window is open.
> =

> Is this what the tcp_cleanup_rbuf() patch helps with?

There are 2 issues:

1) very long delay introduced by missing acks, addressed by
the tcp_cleanup_rbuf() patch

2) inability of current MPTCP xmit path code to handle with large
sndbuf - specifically larger then the send window. This latter needs
quite a bit of rework - which is in progress - comprising Florian's
snd_wnd patches and implementing the mptcp equivalent of
tcp_push_pending_frames()

Cheers,

Paolo

--===============9007602316370784745==--
