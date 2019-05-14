Content-Type: multipart/mixed; boundary="===============4751757232039185881=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp] net: mptcp: fix memory leak in case slab
 allocation fails
Date: Tue, 14 May 2019 09:59:25 +0200
Message-ID: <f0f987fd1ff1e04c24ecb0ef2043bb80900cb044.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1905131632540.11725@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 1157

--===============4751757232039185881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-05-13 at 16:36 -0700, Mat Martineau wrote:
> On Mon, 13 May 2019, Davide Caratti wrote:
> =

> > slab_name is allocated, but not freed, when slab allocation fails: ensu=
re
> > it is freed in the error path of kmem_cache_create(...). While at it, f=
ix
> > reverse christmas tree in subflow_ops-init() local variable declaration=
s.
> =

> Davide -
> =

Thanks for the leak fix. Looks good to me.

hi Mat, thanks a lot for reviewing.
I forgot to mention, this can be squashed into
aedec94346fb ("mptcp: Create SUBFLOW socket for incoming connections").

regards,
-- =

davide


--===============4751757232039185881==--
