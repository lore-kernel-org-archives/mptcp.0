Content-Type: multipart/mixed; boundary="===============5950077561579937340=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Remove request_version field from
 subflow_request_sock
Date: Thu, 12 Dec 2019 14:23:19 -0800
Message-ID: <b2c7750964ea43d50bab0abb4442fc44619ed359.camel@linux.intel.com>
In-Reply-To: 330403f5-48da-bdcb-cae7-027773d25982@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2898

--===============5950077561579937340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Matt -

On Thu, 2019-12-12 at 23:11 +0100, Matthieu Baerts wrote:
> Hi Peter, Paolo,
> =

> On 12/12/2019 05:54, Peter Krystad wrote:
> > Since only a single version is supported this fields presence
> > is misleading, it dates from when it was thought the version would
> > be configurable. The actual requested version is hard-coded in
> > mptcp_write_options().
> > =

> > squashto: Associate MPTCP context with TCP socket
> =

> Thank you for the patch and the review!
> =

> I just have a question below:
> =

> [...]
> =

> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index ddb3a7581d41..93d6c41b76d5 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -48,8 +48,7 @@ static inline struct mptcp_sock *mptcp_sk(const struc=
t sock *sk)
> >   =

> >   /* MPTCP subflow context */
> >   struct mptcp_subflow_context {
> > -	u32	request_mptcp : 1,  /* send MP_CAPABLE */
> > -		request_version : 4;
> > +	u32	request_mptcp : 1;  /* send MP_CAPABLE */
> =

> When removing these 4 bits, at the end of the series, we now only use 13 =

> bits. Should we switch to u16? I didn't check with pahole if it would =

> really reduce the size of the structure, I don't think so and maybe we =

> don't really need to reduce this bit field but I prefer to ask :)

We could go back to u16, but then I would want to move it to the end of the
struct (or just before local_id), but that would create a lot of work
resolving conflicts as the fields are introduced one by one. Size isn't as
critical for subflow_context because it doesn't affect every tcp_sock, only
MPTCP sockets.

Peter.

> Cheers,
> Matt

--===============5950077561579937340==--
