Content-Type: multipart/mixed; boundary="===============0080792212200434750=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 12/13] mptcp: keep track of advertised windows
 right edge
Date: Fri, 02 Oct 2020 18:20:02 +0200
Message-ID: <f6f40edc4d6aa808fe8be920ddb7ab383b04c45e.camel@redhat.com>
In-Reply-To: 20201002160850.GC12773@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 6169

--===============0080792212200434750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-10-02 at 18:08 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > @@ -950,6 +976,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, str=
uct sock *ssk,
> >  			avail_size =3D info->size_goal - skb->len;
> >  	}
> >  =

> > +	/* Zero window and all data acked? Probe. */
> > +	avail_size =3D mptcp_check_allowed_size(msk, data_seq, avail_size);
> > +	if (avail_size =3D=3D 0 && atomic64_read(&msk->snd_una) =3D=3D msk->s=
nd_nxt) {
> =

> This needs to check "!skb" (or !mpext) as well, now that this is not conn=
ected to
> previous conditional anymore.

Thanks for noticing! You already mentioned we could have retransmission
there, but I thought the 'no outstanding unacked data' condition (msk-
>snd_una =3D=3D msk->snd_nxt) would protect from them. But it's not enough.
I'll add the !skb check.

@Mat[ts]: do you want me to re-spin a v4 or can I send an incremental
patch? =


Thanks!

Paolo

--===============0080792212200434750==--
