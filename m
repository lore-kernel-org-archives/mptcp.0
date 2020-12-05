Content-Type: multipart/mixed; boundary="===============6144464954842773057=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] mptcp: add the address ID
 assignment bitmap
Date: Sat, 05 Dec 2020 21:47:38 +0800
Message-ID: <CA+WQbws+Y80F3XLeR+M_T0k0mmo+d8jP4KTWfGHvRbCHPhFuDQ@mail.gmail.com>
In-Reply-To: 06b47a4071c049ad0595f1bcfa970cec83f4fb6f.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7062

--===============6144464954842773057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thanks for your review.

Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B412=E6=9C=883=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 2020-12-01 at 19:58 +0800, Geliang Tang wrote:
> > Currently the address ID set by the netlink PM from user-space is
> > overridden by the kernel. This patch added the address ID assignment
> > bitmap to allow user-space to set the address ID.
> >
> > Use a per netns bitmask id_bitmap (256 bits) to keep track of in-use ID=
s.
> > And use next_id to keep track of the highest ID currently in use. If the
> > user-space provides an ID at endpoint creation time, try to use it. If
> > already in use, endpoint creation fails. Otherwise pick the first ID
> > available after the highest currently in use, with wrap-around.
> >
> > Test:
> >
> >  # pm_nl_ctl add 10.0.0.1
> >  # pm_nl_ctl add 10.0.0.2
> >  # pm_nl_ctl add 10.0.0.3 id 100
> >  # pm_nl_ctl add 10.0.0.4
> >  # pm_nl_ctl add 10.0.0.5 id 254
> >  # pm_nl_ctl add 10.0.0.6
> >  # pm_nl_ctl add 10.0.0.7
> >  # pm_nl_ctl add 10.0.0.8
> >  # pm_nl_ctl dump
> >  id 1 flags  10.0.0.1
> >  id 2 flags  10.0.0.2
> >  id 3 flags  10.0.0.7
> >  id 4 flags  10.0.0.8
> >  id 100 flags  10.0.0.3
> >  id 101 flags  10.0.0.4
> >  id 254 flags  10.0.0.5
> >  id 255 flags  10.0.0.6
> >
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/117
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> >  net/mptcp/pm_netlink.c | 63 +++++++++++++++++++++++++++---------------
> >  1 file changed, 41 insertions(+), 22 deletions(-)
> >
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 54c6b6359144..0463a6b38633 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -37,6 +37,9 @@ struct mptcp_pm_add_entry {
> >       u8                      retrans_times;
> >  };
> >
> > +#define MAX_ADDR_ID          255
> > +#define BITMAP_SZ DIV_ROUND_UP(MAX_ADDR_ID + 1, 8 * sizeof(long))
>                                                    ^^^^^^^
> You can use the BITS_PER_LONG macro above. Not a big deal anyway.
>
> [...]
> > @@ -1076,35 +1092,37 @@ static int mptcp_nl_cmd_dump_addrs(struct sk_bu=
ff *msg,
> >                                  struct netlink_callback *cb)
> >  {
> >       struct net *net =3D sock_net(msg->sk);
> > -     struct mptcp_pm_addr_entry *entry;
> >       struct pm_nl_pernet *pernet;
> > -     int id =3D cb->args[0];
>
> Why are you ignoring the callback argument? I think this will not work
> if the dump exceeds the a single skbuff size.

Add back the callback argument in v2.

>
> > -     void *hdr;
> > +     int id;
> >
> >       pernet =3D net_generic(net, pm_nl_pernet_id);
> >
> >       spin_lock_bh(&pernet->lock);
> > -     list_for_each_entry(entry, &pernet->local_addr_list, list) {
> > -             if (entry->addr.id <=3D id)
> > -                     continue;
> > -
> > -             hdr =3D genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
> > -                               cb->nlh->nlmsg_seq, &mptcp_genl_family,
> > -                               NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
> > -             if (!hdr)
> > -                     break;
> > +     for (id =3D 0; id < MAX_ADDR_ID + 1; id++) {
> > +             if (test_bit(id, pernet->id_bitmap)) {
> > +                     struct mptcp_pm_addr_entry *entry;
> > +                     void *hdr;
>
> It's not clear to me why this chunk is needed ?!? We can still traverse
> the existing addresses using the list. There is no guarantee that the
> dumped list will be sorted by id.

The orignal cmd_dump_addrs dosen't work in this case:

# pm_nl_ctl add 10.0.0.0 id 100
# pm_nl_ctl add 10.0.0.1 id 10
# pm_nl_ctl dump
id 100 flags  10.0.0.0

This id 10 item is lost since this code:

             if (entry->addr.id <=3D id)
                     continue;

Here id =3D 100, entry->addr.id =3D 10.

So we need to sort the list by id.

-Geliang

>
> Thanks!
>
> Paolo
>
--===============6144464954842773057==--
