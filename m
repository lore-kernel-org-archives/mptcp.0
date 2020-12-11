Content-Type: multipart/mixed; boundary="===============4907370198691672415=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 1/6] mptcp: add the outgoing
 MP_PRIO support
Date: Fri, 11 Dec 2020 12:21:11 +0800
Message-ID: <CA+WQbwvpfXaOZSxRuWXgn_ThPSH7905Dh4JdatoL5KREhiZK=A@mail.gmail.com>
In-Reply-To: c1dca286-6138-db33-58be-56a9c48439f@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7143

--===============4907370198691672415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Matt,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=B4=
12=E6=9C=8811=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=889:23=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Wed, 9 Dec 2020, Geliang Tang wrote:
>
> > This patch added the outgoing MP_PRIO logic:
> >
> > In mptcp_pm_nl_mp_prio_send_ack, find the related subflow and subsocket
> > according to the input parameter addr. Save the input priority value to
> > suflow's backup, then set subflow's send_mp_prio flag to true, and save
> > the input priority value to suflow's request_bkup. Finally, send out a
> > pure ACK on the related subsocket.
> >
> > In mptcp_established_options_mp_prio, check whether the subflow's
> > send_mp_prio is set. If it is, this is the packet for sending MP_PRIO.
> > So save subflow->request_bkup value to mptcp_out_options's backup, and
> > change the option type to OPTION_MPTCP_PRIO.
> >
> > In mptcp_write_options, clear the send_mp_prio flag and send out the
> > MP_PRIO suboption with mptcp_out_options's backup value.
> >
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> > net/mptcp/options.c    | 40 ++++++++++++++++++++++++++++++++++++++++
> > net/mptcp/pm_netlink.c | 34 ++++++++++++++++++++++++++++++++++
> > net/mptcp/protocol.h   |  8 +++++++-
> > 3 files changed, 81 insertions(+), 1 deletion(-)
>
> ...
>
> >
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 7cf9d110b85f..56ca90d8c7fe 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -23,7 +23,8 @@
> > #define OPTION_MPTCP_ADD_ADDR BIT(6)
> > #define OPTION_MPTCP_ADD_ADDR6        BIT(7)
> > #define OPTION_MPTCP_RM_ADDR  BIT(8)
> > -#define OPTION_MPTCP_FASTCLOSE       BIT(9)
> > +#define OPTION_MPTCP_PRIO    BIT(9)
> > +#define OPTION_MPTCP_FASTCLOSE       BIT(10)
>
> Hi Geliang -
>
> Thanks for the update from v2, I ran the tests and checked the pcaps,
> looks good for the export branch.
>
> Ok to leave OPTION_MPTCP_FASTCLOSE as BIT(9) and set OPTION_MPTCP_PRIO as
> BIT(10)? Maybe Matthieu could fix that up when adding to the topgit tree
> or a squash-to patch would work.

Sure, the squash-to patch for this has been sent out.

-Geliang

>
>
> Mat
>
>
> >
> > /* MPTCP option subtypes */
> > #define MPTCPOPT_MP_CAPABLE   0
> > @@ -59,6 +60,7 @@
> > #define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT     24
> > #define TCPOLEN_MPTCP_PORT_LEN                4
> > #define TCPOLEN_MPTCP_RM_ADDR_BASE    4
> > +#define TCPOLEN_MPTCP_PRIO           4
> > #define TCPOLEN_MPTCP_FASTCLOSE               12
> >
> > /* MPTCP MP_JOIN flags */
> > @@ -396,6 +398,7 @@ struct mptcp_subflow_context {
> >               map_valid : 1,
> >               mpc_map : 1,
> >               backup : 1,
> > +             send_mp_prio : 1,
> >               rx_eof : 1,
> >               can_ack : 1,        /* only after processing the remote a=
 key */
> >               disposable : 1;     /* ctx can be free at ulp release tim=
e */
> > @@ -550,6 +553,9 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *=
msk,
> >                               const struct mptcp_addr_info *addr);
> > void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
> > void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
> > +int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> > +                              struct mptcp_addr_info *addr,
> > +                              u8 bkup);
> > void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
> > struct mptcp_pm_add_entry *
> > mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> > --
> > 2.26.2
> > _______________________________________________
> > mptcp mailing list -- mptcp(a)lists.01.org
> > To unsubscribe send an email to mptcp-leave(a)lists.01.org
> >
>
> --
> Mat Martineau
> Intel
--===============4907370198691672415==--
