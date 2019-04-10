Content-Type: multipart/mixed; boundary="===============2810065366239969103=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH 4/4] mptcp: allow collapsing consecutive
 sendpages on the same substream
Date: Wed, 10 Apr 2019 22:59:13 +0200
Message-ID: <1d7100602d0433d44744b1be54a6e512f43ce87d.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1904100926070.26395@ztahiru-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1061

--===============2810065366239969103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-04-10 at 10:16 -0700, Mat Martineau wrote:
> On Wed, 10 Apr 2019, Paolo Abeni wrote:
> > uhmm... I thought a bit more about the above and the code in the patch
> > still LGTM: msk->last references the last subflow we enqueued new data
> > to, that is, the subflow with the higher/newer MPTCP write_seq...
> > =

> > > I think it would have to make sure the MPTCP-level sequence numbers a=
re
> > > contiguous before collapsing.
> > =

> > ... so this condition always held, when (msk->last =3D=3D ssk).
> > =

> > Am I missing something?
> > =

> =

> Resends will be a problem with the "last subflow written to" assumption.
> =

> In a case where you have multiple subflows S1 and S2, you might have a =

> scenario like this (sequence numbers are in the 64-bit MPTCP sequence =

> space):
> =

> 1. Send bytes 0-99 on S1
> =

> 2. Send bytes 100-199 on S2
> =

> 3. <time passes: S2 connection has a problem and data does not get =

> through>
> =

> 4. Send bytes 200-299 on S1
> =

> 5. MPTCP-level resend 100-199 on S1
> =

> 6. Send bytes 300-399 on S1
> =

> =

> When you get to step 6, the "last" send was on S1, but you need a new =

> MPTCP mapping header for bytes 300-399 because the previous byte in the S=
1 =

> stream is 199. It's important to know where the earlier mappings end so =

> you can create a new one without leaving a gap in the MPTCP sequence =

> space.

Ah, now I see! thank you for the detailed example! =


I'll take care in the next iteration, but I doubt I'll be able to send
a new version before the next mtg, because I'm travelling with no/very
limited time avail.

Thank you,

Paolo


--===============2810065366239969103==--
