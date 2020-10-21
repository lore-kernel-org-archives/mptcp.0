Content-Type: multipart/mixed; boundary="===============4361783177927533193=="
MIME-Version: 1.0
From: Geert Uytterhoeven <geert at linux-m68k.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: MPTCP_IPV6 should depend on IPV6 instead
 of selecting it
Date: Wed, 21 Oct 2020 11:43:08 +0200
Message-ID: <CAMuHMdW=1LfE8UoGRVBvrvrintQMNKUdTe5PPQz=PN3=gJmw=Q@mail.gmail.com>
In-Reply-To: 20201020205647.20ab7009@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 6385

--===============4361783177927533193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Wed, Oct 21, 2020 at 5:56 AM Jakub Kicinski <kuba(a)kernel.org> wrote:
> On Tue, 20 Oct 2020 11:26:34 +0200 Matthieu Baerts wrote:
> > On 20/10/2020 09:38, Geert Uytterhoeven wrote:
> > > MPTCP_IPV6 selects IPV6, thus enabling an optional feature the user m=
ay
> > > not want to enable.  Fix this by making MPTCP_IPV6 depend on IPV6, li=
ke
> > > is done for all other IPv6 features.
> >
> > Here again, the intension was to select IPv6 from MPTCP but I understand
> > the issue: if we enable MPTCP, we will select IPV6 as well by default.
> > Maybe not what we want on some embedded devices with very limited memory
> > where IPV6 is already off. We should instead enable MPTCP_IPV6 only if
> > IPV6=3Dy. LGTM then!
> >
> > Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>
> Applied, thanks!

My apologies, this fails for the CONFIG_IPV6=3Dm and CONFIG_MPTCP=3Dy
case:
  + error: net/mptcp/protocol.o: undefined reference to
`inet6_getname':  =3D> .rodata+0x19c)
  + error: net/mptcp/protocol.o: undefined reference to `inet6_ioctl':
 =3D> .rodata+0x1a4)
  + error: net/mptcp/protocol.o: undefined reference to
`inet6_recvmsg':  =3D> .rodata+0x1c4)
  + error: net/mptcp/protocol.o: undefined reference to
`inet6_release':  =3D> .rodata+0x188)
  + error: net/mptcp/protocol.o: undefined reference to
`inet6_sendmsg':  =3D> .rodata+0x1c0)
  + error: protocol.c: undefined reference to `inet6_destroy_sock':
=3D> .text+0x4994)
  + error: protocol.c: undefined reference to
`inet6_register_protosw':  =3D> .init.text+0xc6)
  + error: protocol.c: undefined reference to `inet6_stream_ops':  =3D>
.text+0x2bb0)
  + error: protocol.c: undefined reference to `tcpv6_prot':  =3D> .text+0x2=
ba8)
  + error: subflow.c: undefined reference to
`tcp_request_sock_ipv6_ops':  =3D> .text+0x8e2)
  + error: undefined reference to `ipv6_specific':  =3D> (.init.text+0xea)
  + error: undefined reference to `tcp_request_sock_ipv6_ops':  =3D>
(.init.text+0xc4)

So those issues have to be fixed first

Gr{oetje,eeting}s,

                        Geert

-- =

Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert(a)linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
--===============4361783177927533193==--
