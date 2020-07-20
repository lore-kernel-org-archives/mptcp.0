Content-Type: multipart/mixed; boundary="===============8953758231240947157=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 12/12] mptcp: Safely store sequence
 number when sending data
Date: Mon, 20 Jul 2020 11:31:51 +0200
Message-ID: <cc7e26641a85b855c9d151163e3ec5e660cbe7a1.camel@redhat.com>
In-Reply-To: alpine.OSX.2.23.453.2007171151490.39222@kdpetti-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5097

--===============8953758231240947157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-07-17 at 12:16 -0700, Mat Martineau wrote:
> On Thu, 16 Jul 2020, Paolo Abeni wrote:
> =

> > On Wed, 2020-07-15 at 17:20 -0700, Mat Martineau wrote:
> > > The MPTCP socket's write_seq member can be read without the msk lock
> > > held, so use WRITE_ONCE() to store it.
> > > =

> > > Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> > > ---
> > >  net/mptcp/protocol.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > =

> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 30c5810771dd..ed3ca80d72f8 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -797,7 +797,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, st=
ruct sock *ssk,
> > >  out:
> > >  	if (!retransmission)
> > >  		pfrag->offset +=3D frag_truesize;
> > > -	*write_seq +=3D ret;
> > > +	WRITE_ONCE(*write_seq, *write_seq + ret);
> > >  	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D ret;
> > =

> > I think the msk lock should be already held here ?!?
> =

> Yes, but write_seq might be concurrently read by another CPU, and we want =

> don't want the compiler to invent stores as described in =

> memory-barriers.txt

Yep, you are right. I misread the commit message and wend ahead too
hastly. The patch LGTM.

Thanks,

Paolo

--===============8953758231240947157==--
