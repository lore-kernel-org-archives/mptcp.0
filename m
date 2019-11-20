Content-Type: multipart/mixed; boundary="===============4437942232198427228=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 3/4] mptcp: warn once if exceeding tcp opt
 space for dss/mp_capable
Date: Wed, 20 Nov 2019 21:30:30 +0100
Message-ID: <213bb7e7df0bcf3691eb8848a268a862a0af2ca4.camel@redhat.com>
In-Reply-To: eceb6d48-f6e4-cdb0-af56-64d388c40365@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2633

--===============4437942232198427228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-20 at 20:13 +0100, Matthieu Baerts wrote:
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 38c0cbd4c77b..bf43d61f792b 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -499,16 +499,10 @@ bool mptcp_established_options(struct sock *sk, s=
truct sk_buff *skb,
> > =

> >          *size +=3D opt_size;
> >          remaining -=3D opt_size;
> > -
> =

> I had to manually apply the patch and I see I didn't remove this line. =

> Do you want me to remove it?

whoops... yes, it would be better, thanks1

--===============4437942232198427228==--
