Content-Type: multipart/mixed; boundary="===============2197871898146931414=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [mptcp-dev] [PATCH] mptcp: fix typo in
 mptcp_options_write() stub
Date: Wed, 27 Mar 2019 16:49:17 +0100
Message-ID: <3e5f2038b1c4289d4f125ac97c64fbb8e0146099.camel@redhat.com>
In-Reply-To: CAKuKrB=UHxybmhr1i7Cj+iPgKxfrgRuHBD52+NBE8-RW1KqQBA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 1036

--===============2197871898146931414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-03-27 at 15:20 +0100, Matthieu Baerts wrote:
> Hi Davide,
> =

> On Wed, Mar 27, 2019 at 2:59 PM Davide Caratti <dcaratti(a)redhat.com> wr=
ote:
> > it causes build errors when CONFIG_MPTCP is unset
> =

> Thank you for the patch.
> But I think you sent it to the wrong ML: mptcp-dev(a)listes.uclouvain.be
> (current implementation) vs mptcp(a)lists.01.org (upstream project, now
> in cc).

woops. sorry for the noise.

> Because what you want to fix has not been merged yet, feel free to
> directly report this typo there:
> https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/437402/9/inc=
lude/net/mptcp.h#218
> ;-)

... and thanks for the guidance :)

I think the current review status includes all the build errors I'm
getting now (and I see yesterday Mat already spotted the one in
tcp_output.c (
https://review.gerrithub.io/c/multipath-tcp/mptcp_net-next/+/437391/9 )

Last time I worked with gerrit, years ago, we used to put negative reviews
when we encountered  build issues and known bugs - hence my '-1' to the
above patchsets. Is that correct?

TIA,

-- =

davide


--===============2197871898146931414==--
