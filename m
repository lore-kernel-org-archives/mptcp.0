Content-Type: multipart/mixed; boundary="===============6435407948391348089=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2] Squash-to: "mptcp: add netlink-based
 PM"
Date: Thu, 26 Mar 2020 12:37:12 +0100
Message-ID: <993bd818949c8845f6e690338a34e3975392638f.camel@redhat.com>
In-Reply-To: 03ea8345-c10a-7434-9a3e-37a7fd693fba@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4072

--===============6435407948391348089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-03-26 at 11:34 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 26/03/2020 11:19, Paolo Abeni wrote:
> > Let user space set a single limit at once and drop bogus
> > NL extack error message.
> =

> Thank you for the patch!
> =

> > v1 -> v2:
> >   - do not include dumb dbg messages
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> >   net/mptcp/pm_netlink.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > =

> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 743c3c58f826..caad73dfda64 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -702,10 +702,8 @@ static int parse_limit(struct genl_info *info, int=
 id, unsigned int *limit)
> >   {
> >   	struct nlattr *attr =3D info->attrs[id];
> >   =

> > -	if (!attr) {
> > -		GENL_SET_ERR_MSG(info, "missing announce accept limit");
> > -		return -EINVAL;
> > -	}
> > +	if (!attr)
> > +		return 0;
> =

> I guess we don't need to return an error if no attributes are given for =

> both RCV_ADD_ADDRS and SUBFLOWS, right?

yep

> >   =

> >   	*limit =3D nla_get_u32(attr);
> >   	if (*limit > MPTCP_PM_ADDR_MAX) {
> =

> Here below, the message is "announce accept limit greater than maximum". =

> Should we keep only "limit greater than maximum"?

agreed
> =

> > @@ -723,10 +721,12 @@ mptcp_nl_cmd_set_limits(struct sk_buff *skb, stru=
ct genl_info *info)
> >   	unsigned int rcv_addrs, subflows;
> >   	int ret;
> >   =

> > +	rcv_addrs =3D pernet->add_addr_accept_max;
> =

> I guess that's fine to always call the two WRITE_ONCE() here below even =

> if it is not needed, right?

I see no issue with that, but looking again at this, I guess it's
better wrap everthing with spin lock protection.

Additionally I need to relax the GENL_ADMIN_PERM on get commands.

Thanks for the feedback, v3 is coming ;)

/P

--===============6435407948391348089==--
