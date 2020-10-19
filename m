Content-Type: multipart/mixed; boundary="===============2694188984135209736=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next 0/2] init ahmac and port of
 mptcp_options_received
Date: Mon, 19 Oct 2020 13:40:48 -0700
Message-ID: <20201019134048.11c75c9a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 7766357d-0838-1603-9967-8910aa312f65@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6356

--===============2694188984135209736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Oct 2020 18:27:55 +0200 Matthieu Baerts wrote:
> Hi Geliang,
> =

> On 19/10/2020 12:23, Geliang Tang wrote:
> > This patchset deals with initializations of mptcp_options_received's two
> > fields, ahmac and port.
> > =

> > Geliang Tang (2):
> >    mptcp: initialize mptcp_options_received's ahmac
> >    mptcp: move mptcp_options_received's port initialization  =

> =

> Thank you for these two patches. They look good to me except one detail: =

> these two patches are for -net and not net-next.
> =

> I don't know if it is alright for Jakub to apply them to -net or if it =

> is clearer to re-send them with an updated subject.
> =

> If it is OK to apply them to -net without a re-submit, here is my:
> =

> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Thanks, I can apply to net.

> Also, if you don't mind and while I am here, I never know: is it OK for =

> you the maintainers to send one Acked/Reviewed-by for a whole series -- =

> but then this is not reflected on patchwork -- or should we send one tag =

> for each patch?

It's fine, we propagate those semi-manually, but it's not a problem.
Hopefully patchwork will address this at some point :(
--===============2694188984135209736==--
