Content-Type: multipart/mixed; boundary="===============2573147916369131794=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 2/3] mptcp: check the
 removing initial subflow
Date: Wed, 03 Mar 2021 15:45:41 +0800
Message-ID: <CA+WQbwsqjN+rQT6gE76_dabz-dP2TtnX34N5iA4-j5rmKbYSAA@mail.gmail.com>
In-Reply-To: 483ee3c5-c9be-1391-5574-cc8ba928c294@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7984

--===============2573147916369131794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2021=E5=B9=B4=
3=E6=9C=883=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=889:44=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Tue, 2 Mar 2021, Geliang Tang wrote:
>
> > If the removing address id is 0, the initial subflow needs to be remove=
d.
> > Since the initial subflow's both local_id and remote_id are all zeros,
> > this patch checks them to make sure it's now removing the right subflow.
> >
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> > net/mptcp/pm_netlink.c | 5 +++++
> > 1 file changed, 5 insertions(+)
> >
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index eaac9824f444..439c9ee57566 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -629,6 +629,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct =
mptcp_sock *msk,
> >                       if (rm_list.ids[i] !=3D id)
> >                               continue;
> >
> > +                     if (!rm_list.ids[i]) {
> > +                             if (subflow->local_id || subflow->remote_=
id)
> > +                                     continue;
> > +                     }
> > +
>
> In my reply to v2, I commented that I did not see the initial subflow
> closed. But that does not mean that RM_ADDR 0 should only affect the
> initial subflow. There may be other subflows involving that address id
> that need to be closed.
>
> Without this commit, do some self tests fail only because all of the
> subflows got closed?  <--- (I am interested in the answer to this and
> having a discussion before making more code changes)

When I ran the test in v2, some self tests got the poll timeout failures
since all of the subflows got closed. When I ran the test in v3, without
this commit, no self test fail.

The original removing code can deal with id 0 address well, only the
"break" in mptcp_pm_nl_rm_addr_or_subflow needs to be dropped. Since this
"break" prevents the iteration to the next subflow involving that address.
I fixed this in v4.

>
> If peer A sends RM_ADDR 0 and all of the subflows are using local_id 0 on
> peer A's side, then it seems like it is expected that all of the subflows=
 will
> close. We would want to test RM_ADDR 0 when there are subflows that will
> stay open because they do not use ID 0 on the side that is sending
> RM_ADDR. Is this what is going on with the tests or is there a different
> issue that is solved by the added code in this patch?

I thought that removing id 0 was just removing the initial subflow, so I
added this patch. As mentioned above, all the subflows involving the id 0
address need to be removed. So this patch need to be dropped.

Thanks.

-Geliang

>
> Thanks,
>
> Mat
>
>
> >                       pr_debug(" -> %s rm_list_ids[%d]=3D%u local_id=3D=
%u remote_id=3D%u",
> >                                type =3D=3D RM_ADDR ? "address" : "subfl=
ow", i, rm_list.ids[i],
> >                                subflow->local_id, subflow->remote_id);
> > --
> > 2.29.2
> > _______________________________________________
> > mptcp mailing list -- mptcp(a)lists.01.org
> > To unsubscribe send an email to mptcp-leave(a)lists.01.org
> >
>
> --
> Mat Martineau
> Intel
--===============2573147916369131794==--
