Content-Type: multipart/mixed; boundary="===============3413710470018012593=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] Squash-to: "mptcp: remove
 addr and subflow in PM netlink v9" Part 2
Date: Fri, 18 Sep 2020 10:48:24 +0800
Message-ID: <CA+WQbwvohxAyiis46R+E4GVE7qRFHLDjhPzoEjBgJ0wSHWmMSg@mail.gmail.com>
In-Reply-To: b30f982b-eabd-260b-d758-299a51761c74@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5925

--===============3413710470018012593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B49=E6=
=9C=8817=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:10=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Geliang, Paolo,
>
> On 17/09/2020 12:12, Paolo Abeni wrote:
> > On Thu, 2020-09-17 at 17:19 +0800, Geliang Tang wrote:
> >> This patch fixed BUG in mptcp_pm_free_anno_list(). mptcp_pm_free_anno_=
list
> >> may be called when PM has not been inited, then we'll get the "NULL po=
inter
> >> dereference" BUG.
> >>
> >> This patch moved __mptcp_init_sock call before the !mptcp_is_enabled()
> >> check in mptcp_init_sock(). No matter mptcp is enabled or not, we all
> >> called __mptcp_init_sock to init the mptcp socket.
> >>
> >> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/90
> >> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> >
> > LGTM, thanks!
>
> Thank you for this patch and the review!
>
> - 3704fca5b32c: "squashed" in "mptcp: remove addr and subflow in PM netli=
nk"
> - ed4dddf22888..6ffedca7e3d7: result

Since we squash two patches to commit "mptcp: remove addr and subflow
in PM netlink",
please update its commit message entirely like this:

'''
This patch implements the remove announced addr and subflow logic in PM
netlink.

When the PM netlink removes an address, we traverse all the existing msk
sockets to find the relevant sockets.

We add a new list named anno_list in mptcp_pm_data, to record all the
announced addrs. In the traversing, we check if it has been recorded.
If it has been, we trigger the RM_ADDR signal.

We also check if this address is in conn_list. If it is, we remove the
subflow which using this local address.

Since we call mptcp_pm_free_anno_list in mptcp_destroy, we need to move
__mptcp_init_sock before the mptcp_is_enabled check in mptcp_init_sock.
'''

Thanks.

-Geliang

>
> Tests + export are in progress!
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============3413710470018012593==--
