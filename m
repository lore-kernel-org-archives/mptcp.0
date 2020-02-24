Content-Type: multipart/mixed; boundary="===============0828204626502999534=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 7/9] mptcp: add netlink based PM
Date: Mon, 24 Feb 2020 19:31:11 +0100
Message-ID: <415469e83738415aa2d6e99a9237c8e5468ea23c.camel@redhat.com>
In-Reply-To: 911f9b0e-d348-c553-6c53-ccf649302593@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3762

--===============0828204626502999534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-24 at 18:58 +0100, Matthieu Baerts wrote:
> > The maximum number of received ADD_ADDR limit allows to easily model
> > the 'server' behaviour (max accepted =3D=3D 0). We could add an additio=
nal
> > max_subflows limit, but I think it's only relevant if we do the full-
> > mash strategy.
> =

> What the server will do with the received ADD_ADDR? The RFC allows the =

> server to initiate subflows but technically, is it possible for the =

> server to do that if the socket is in "LISTEN" mode and on "CONNECT" =

> mode on the client side?
> =

> If we limit the number of created subflows, we can limit the number of =

> subflows on both the client and the server. Is it possible to limit the =

> number of subflows on the server side with the current version? (It is =

> maybe not needed for the moment.)

I see! Yes, currently we can't limit the number of subflows created for
a single mptcp socket on a server. I'm unsure how bad that is, as
usually we allow each client to create an arbitrary high number of TCP
connection to the server (modulo syn flood).

Still I think adding the ability to impose such limit could be nice. It
requires an additional hook (from subflow_syn_recv_sock() towards the
PM). If we agree on that, I can try to cover in a separate
patch/series.

> When the ADD_ADDRv1 with the 'echo' will be available, does that mean we =

> will add an "important" delay for the creation of new subflows?
> =

> I guess at some points, we might want to have the possibility to:
> - send ADD_ADDR and MP_JOIN in parallel

We can do the above with the propososed infrastructure. We could
additionally create multiple subflows in paraller, but we can't
(currently) send multiple ADD_ADD "in parallel". =


The main concern I have to support the latter is adding to the msk data
structure new fields that related to the specific PM implementation.

(The ones currently present should be generic)

There are likely a bunch of items I missed in v4, so I suspect we will
move the discussion on that series.

Thanks,

Paolo

--===============0828204626502999534==--
