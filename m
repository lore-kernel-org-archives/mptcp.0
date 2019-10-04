Content-Type: multipart/mixed; boundary="===============4750643886225345323=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp:diag: prefix exposed items
Date: Fri, 04 Oct 2019 19:02:34 +0200
Message-ID: <2c9a6fc9af5a110fec21d20aaf4e7b35a6f3edb6.camel@redhat.com>
In-Reply-To: 06d26295-6bf7-4f82-dd6a-6249cb347669@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2017

--===============4750643886225345323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-10-03 at 11:41 +0200, Matthieu Baerts wrote:
> Hi Davide,
> =

> Thank you for your review!
> =

> On 03/10/2019 10:56, Davide Caratti wrote:
> > On Wed, 2019-10-02 at 21:08 +0200, Matthieu Baerts wrote:
> > > To conform with the rest.
> > > =

> > > Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> > =

> > yes, this makes sense. Minor nits below:
> > =

> > > ---
> > >  include/uapi/linux/mptcp.h | 18 +++++++++---------
> > >  net/mptcp/diag.c           | 22 +++++++++++-----------
> > >  net/mptcp/protocol.h       |  4 ++--
> > >  net/mptcp/subflow.c        |  4 ++--
> > >  4 files changed, 24 insertions(+), 24 deletions(-)
> > > =

> > > diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> > > index 2856b89cc36e..04bd134c1807 100644
> > > --- a/include/uapi/linux/mptcp.h
> > > +++ b/include/uapi/linux/mptcp.h
> > > @@ -4,15 +4,15 @@

[...]

> > > +#define MPTCP_SUBFLOW_FLAGS_4THACK	BIT(6)
> > > +#define MPTCP_SUBFLOW_FLAGS_CONNECTED	BIT(7)
> > > +#define MPTCP_SUBFLOW_FLAGS_MAPVALID	BIT(8)
> > =

> > but then names may become too long and might hurt eyes that read misc/s=
s.c
> > . Maybe the word 'FLAG' is pleonastic, since we are talking about BIT(x)
> > of a netlink attribute whose name is MPTCP_SUBFLOW_FLAGS.
> > =

> > What about MPTCP_SUBFLOW_F_<...> ?
> =

> I can understand that names can be too long. For me, that's fine, at
> least it is clear :-)

uAPI bits are going to stay forever, so it's worth finding a good
compromise.

> Regarding "FLAG", as you said it is useless here, we can clearly see it
> is a flag with BIT(x). But I think it makes sense to have it where we
> will use it. I guess we can at least remove the S from "_FLAGS_" :)
> But "_F_" is maybe not clear enough. People might think it is a variable
> just for Florian :-/

now I understand what that 'fw' means in net/sched/cls_fw.c :)

> Another idea could be to use "_SF_" instead of subflow. But still, I
> think the best is to have something clear for everybody and only remove
> the useless "S". But I am happy to short them more if it is needed!

just did a friday experiment with uAPI #defines:

$ while read -r a b _; do c=3D`echo $b | wc -c`; echo $c; done >data.txt <<=
-EOF
`grep -r '#define' include/uapi/linux/*`
EOF

roughly 95% of the values of $c are below 29 characters, which is the
length of MPTCP_SUBFLOW_FLAGS_CONNECTED. So, if we remove the useless 'S',
we can safely say that MPTCP is not a statistic anomaly.

then, I'm ok with MPTCP_SUBFLOW_FLAG_<xxx>.

> > [...]
> > =

> > > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > > index 25f62679903e..452e873dc722 100644
> > > --- a/net/mptcp/protocol.h
> > > +++ b/net/mptcp/protocol.h
> > > @@ -313,7 +313,7 @@ static inline bool before64(__u64 seq1, __u64 seq=
2)
> > >  =

> > >  #define after64(seq2, seq1)	before64(seq1, seq2)
> > >  =

> > > -size_t subflow_get_info_size(const struct sock *sk);
> > > -int subflow_get_info(const struct sock *sk, struct sk_buff *skb);
> > > +size_t mptcp_diag_subflow_get_info_size(const struct sock *sk);
> > > +int mptcp_diag_subflow_get_info(const struct sock *sk, struct sk_buf=
f *skb);
> > >  =

> > >  #endif /* __MPTCP_PROTOCOL_H */
> > > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > > index 0f4a2a19d246..99cbb8351584 100644
> > > --- a/net/mptcp/subflow.c
> > > +++ b/net/mptcp/subflow.c
> > > @@ -492,8 +492,8 @@ static struct tcp_ulp_ops subflow_ulp_ops __read_=
mostly =3D {
> > >  	.init		=3D subflow_ulp_init,
> > >  	.release	=3D subflow_ulp_release,
> > >  	.clone		=3D subflow_ulp_clone,
> > > -	.get_info	=3D subflow_get_info,
> > > -	.get_info_size	=3D subflow_get_info_size,
> > > +	.get_info	=3D mptcp_diag_subflow_get_info,
> > > +	.get_info_size	=3D mptcp_diag_subflow_get_info_size,
> > >  };
> > =

> > and here we can shorten the name of these two functions, getting rid of =

> > _get, since it's implicit for sock_diags.
> > =

> > WDYT?
> =

> I think longer is better. I mean here in this context of course!!
> At least it is clear it is designed to be used with "get_info" and
> "get_info_size" callbacks. It could also make sense to call them
> "mptcp_diag_subflow_ulp_get_info" and
> "mptcp_diag_subflow_ulp_get_info_size". We have room for that here ;-)

nevertheless, other members of subflow_ulp_ops don't have any mptcp prefix
(and don't need that, because they are declared static). =


Speaking of this, I exported these 2 functions in protocol.h, but maybe we
don't need this. Nobody is going to call them, unless he/she does indirect
call through subflow_ops. Then (thanks @Paolo for the suggestion) the two
functions can be made static in diag.c, and a single function like

void mtcp_diag_subflow_init(truct tcp_ulp_ops * ops);

that does:

void mtcp_diag_subflow_init(truct tcp_ulp_ops * ops)
{
	ops->get_info =3D subflow_get_info;
	ops->get_info_size =3D subflow_get_info_size;
}

can be exported from diag,c, and called in mptcp_subflow_init(), before
registering the ULP.

how does that sound?

thanks!
-- =

davide

--===============4750643886225345323==--
