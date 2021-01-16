Content-Type: multipart/mixed; boundary="===============8613917683583291904=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCHi iproute2] mptcp: add support for event monitoring
Date: Sat, 16 Jan 2021 18:57:32 +0100
Message-ID: <20210116175732.GK19605@breakpoint.cc>
In-Reply-To: 4a12d0f4-014c-55e0-49c4-4b2ea2a0007a@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7414

--===============8613917683583291904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> Hi Florian,
> =

> On 14/01/2021 18:38, Florian Westphal wrote:
> > Output will look similar to this:
> > =

> > [       CREATED] token=3D83f3a692 remid=3D0 locid=3D0 saddr4=3D10.0.1.2=
 daddr4=3D10.0.1.1 sport=3D58710 dport=3D10011
> > [   ESTABLISHED] token=3D83f3a692 remid=3D0 locid=3D0 saddr4=3D10.0.1.2=
 daddr4=3D10.0.1.1 sport=3D58710 dport=3D10011
> > [SF_ESTABLISHED] token=3D83f3a692 remid=3D0 locid=3D1 saddr4=3D10.0.2.2=
 daddr4=3D10.0.1.1 sport=3D40195 dport=3D10011 backup=3D0
> > [        CLOSED] token=3D83f3a692
> =

> Thank you for this new feature, that's a good idea!
> =

> It looks good! Just the usage/man page to update I think! I just asked a =
few
> questions below if you don't mind looking :)

Right, will update this for the netdev submission.

> > diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> > index 321812307718..199b0c46ba70 100644
> > --- a/include/uapi/linux/mptcp.h
> > +++ b/include/uapi/linux/mptcp.h
> > @@ -36,6 +36,7 @@ enum {
> >   /* netlink interface */
> >   #define MPTCP_PM_NAME		"mptcp_pm"
> >   #define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
> > +#define MPTCP_PM_EV_GRP_NAME	"mptcp_events"
> =

> (just to be sure: we don't want to prefix with "_pm" to keep compatibility
> with mptcp.org kernel, right?)

Only change needed on userspace side is use of "mptcp_pm" instead of
plain "mptcp" for the genl name.

Mandation use of "mptcp_pm_events" would mean a second change and I do
not see a good reason for it.

> >   #define MPTCP_PM_VER		0x1
> =

> I guess we don't need to change that, on older version of the kernel we c=
an
> just check if "mptcp_events" has been added.

On old kernel the subscription request will fail.
I would only increment this in case of incompatible changes, which
should be avoided anyway.


> > +static void print_addr(const char *key, int af, struct rtattr *value)
> > +{
> > +	void *data =3D RTA_DATA(value);
> > +	char str[INET6_ADDRSTRLEN];
> > +
> > +	if (inet_ntop(af, data, str, sizeof(str)))
> > +		printf(" %s=3D%s", key, str);
> =

> Should we display an error in case of issue to parse the address? Or no n=
eed
> because it should not happen?

I don't think it makes sense to handle errors here.
The only error message we could display here would be something like
"kernel netlink abi is broken".

I can do that (plus abort()) in the next iteration.

> > +	if (ghdr->cmd >=3D ARRAY_SIZE(event_to_str)) {
> > +		printf("[UNKNOWN %u]\n", ghdr->cmd);
> > +		fflush(stdout);
> > +		return 0;
> =

> (detail: maybe good to have a goto here and below to do the fflush + retu=
rn
> (+puts?) mainly for later not to forget that? Up to you, a detail)

Ok, I can change it.

> > +	printf(" token=3D%08x", rta_getattr_u32(tb[MPTCP_ATTR_TOKEN]));
> =

> If we are not the user ID 0, we cannot do the monitoring, right?

No, netlink mcast subscription will fail with -EPERM in that case.

> >   	if (argc =3D=3D 0)
> > @@ -429,6 +527,14 @@ int do_mptcp(int argc, char **argv)
> >   						   MPTCP_PM_CMD_GET_LIMITS);
> >   	}
> > +	if (matches(*argv, "monitor") =3D=3D 0) {
> =

> May you update the "usage()" function here above and the man page to refl=
ect
> this new parameter please?

Yes, sorry I forgot.

> > +static int genl_parse_grps(struct rtattr *attr, const char *name, unsi=
gned int *id)
> > +{
> > +	const struct rtattr *pos;
> > +
> > +	rtattr_for_each_nested(pos, attr) {
> > +		struct rtattr *tb[CTRL_ATTR_MCAST_GRP_MAX + 1];
> > +
> > +		parse_rtattr_nested(tb, CTRL_ATTR_MCAST_GRP_MAX, pos);
> > +
> > +		if (tb[CTRL_ATTR_MCAST_GRP_NAME] && tb[CTRL_ATTR_MCAST_GRP_ID]) {
> > +			if (strcmp(name, rta_getattr_str(tb[CTRL_ATTR_MCAST_GRP_NAME])) =3D=
=3D 0) {
> =

> Should we use strncmp()? (But not sure with which limit so probably no)

No, the string is part of the abi, so it will always match "mptcp_event"
in case the feature is present.
--===============8613917683583291904==--
