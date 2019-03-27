Content-Type: multipart/mixed; boundary="===============4386608957765665058=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [mptcp-dev] [PATCH] mptcp: fix typo in
 mptcp_options_write() stub
Date: Wed, 27 Mar 2019 16:50:49 +0100
Message-ID: <CAKuKrBnyQAWw5SFen_h8xG_zdBDrL=tnmPa3kBywxi8X4rDbLA@mail.gmail.com>
In-Reply-To: e1c758792f5da70cf83589bb181ceff92255f57b.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1037

--===============4386608957765665058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2019 at 4:44 PM Davide Caratti <dcaratti(a)redhat.com> wrot=
e:
>
> On Wed, 2019-03-27 at 15:20 +0100, Matthieu Baerts wrote:
> > Hi Davide,
> >
> > On Wed, Mar 27, 2019 at 2:59 PM Davide Caratti <dcaratti(a)redhat.com> =
wrote:
> > > it causes build errors when CONFIG_MPTCP is unset
> >
> > Thank you for the patch.
> > But I think you sent it to the wrong ML: mptcp-dev(a)listes.uclouvain.be
> > (current implementation) vs mptcp(a)lists.01.org (upstream project, now
> > in cc).
>
> woops. sorry for the noise.
>
> > Because what you want to fix has not been merged yet, feel free to
> > directly report this typo there:
> > https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/437402/9/i=
nclude/net/mptcp.h#218
> > ;-)
>
> ... and thanks for the guidance :)

You are welcome!

> I think the current review status includes all the build errors I'm
> getting now (and I see yesterday Mat already spotted the one in
> tcp_output.c (
> https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/437391/9 )

Thank you for having tested this case!

> Last time I worked with gerrit, years ago, we used to put negative reviews
> when we encountered  build issues and known bugs - hence my '-1' to the
> above patchsets. Is that correct?

That looks correct to me!

Cheers,
Matt

> TIA,
> --
> davide
>
>
>


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

Disclaimer: https://www.tessares.net/mail-disclaimer/

--===============4386608957765665058==--
