Content-Type: multipart/mixed; boundary="===============2218791424249979849=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCHi iproute2] mptcp: add support for event monitoring
Date: Sat, 16 Jan 2021 14:51:21 +0100
Message-ID: <4a12d0f4-014c-55e0-49c4-4b2ea2a0007a@tessares.net>
In-Reply-To: 20210114173811.7854-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7413

--===============2218791424249979849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 14/01/2021 18:38, Florian Westphal wrote:
> Output will look similar to this:
> =

> [       CREATED] token=3D83f3a692 remid=3D0 locid=3D0 saddr4=3D10.0.1.2 d=
addr4=3D10.0.1.1 sport=3D58710 dport=3D10011
> [   ESTABLISHED] token=3D83f3a692 remid=3D0 locid=3D0 saddr4=3D10.0.1.2 d=
addr4=3D10.0.1.1 sport=3D58710 dport=3D10011
> [SF_ESTABLISHED] token=3D83f3a692 remid=3D0 locid=3D1 saddr4=3D10.0.2.2 d=
addr4=3D10.0.1.1 sport=3D40195 dport=3D10011 backup=3D0
> [        CLOSED] token=3D83f3a692

Thank you for this new feature, that's a good idea!

It looks good! Just the usage/man page to update I think! I just asked a =

few questions below if you don't mind looking :)

(...)

> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 321812307718..199b0c46ba70 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -36,6 +36,7 @@ enum {
>   /* netlink interface */
>   #define MPTCP_PM_NAME		"mptcp_pm"
>   #define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
> +#define MPTCP_PM_EV_GRP_NAME	"mptcp_events"

(just to be sure: we don't want to prefix with "_pm" to keep =

compatibility with mptcp.org kernel, right?)

>   #define MPTCP_PM_VER		0x1

I guess we don't need to change that, on older version of the kernel we =

can just check if "mptcp_events" has been added.

(...)

> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index e1ffafb3c658..4716aa9e62e8 100644
> --- a/ip/ipmptcp.c
> +++ b/ip/ipmptcp.c
> @@ -385,6 +385,104 @@ static int mptcp_limit_get_set(int argc, char **arg=
v, int cmd)
>   	return 0;
>   }

(...)

> +static void print_addr(const char *key, int af, struct rtattr *value)
> +{
> +	void *data =3D RTA_DATA(value);
> +	char str[INET6_ADDRSTRLEN];
> +
> +	if (inet_ntop(af, data, str, sizeof(str)))
> +		printf(" %s=3D%s", key, str);

Should we display an error in case of issue to parse the address? Or no =

need because it should not happen?

> +}
> +
> +static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
> +			     struct nlmsghdr *n, void *arg)
> +{
> +	const struct genlmsghdr *ghdr =3D NLMSG_DATA(n);
> +	struct rtattr *tb[MPTCP_ATTR_MAX + 1];
> +	int len =3D n->nlmsg_len;
> +
> +	len -=3D NLMSG_LENGTH(GENL_HDRLEN);
> +	if (len < 0)
> +		return -1;
> +
> +	if (n->nlmsg_type !=3D genl_family)
> +		return 0;
> +
> +	if (ghdr->cmd >=3D ARRAY_SIZE(event_to_str)) {
> +		printf("[UNKNOWN %u]\n", ghdr->cmd);
> +		fflush(stdout);
> +		return 0;

(detail: maybe good to have a goto here and below to do the fflush + =

return (+puts?) mainly for later not to forget that? Up to you, a detail)

(...)

 > +	printf(" token=3D%08x", rta_getattr_u32(tb[MPTCP_ATTR_TOKEN]));

If we are not the user ID 0, we cannot do the monitoring, right?

>   	if (argc =3D=3D 0)
> @@ -429,6 +527,14 @@ int do_mptcp(int argc, char **argv)
>   						   MPTCP_PM_CMD_GET_LIMITS);
>   	}
>   =

> +	if (matches(*argv, "monitor") =3D=3D 0) {

May you update the "usage()" function here above and the man page to =

reflect this new parameter please?

(...)

> diff --git a/lib/libgenl.c b/lib/libgenl.c
> index f2ce698fc711..4c51d47af46b 100644
> --- a/lib/libgenl.c
> +++ b/lib/libgenl.c
> @@ -67,6 +67,72 @@ int genl_resolve_family(struct rtnl_handle *grth, cons=
t char *family)
>   	return fnum;
>   }
>   =

> +static int genl_parse_grps(struct rtattr *attr, const char *name, unsign=
ed int *id)
> +{
> +	const struct rtattr *pos;
> +
> +	rtattr_for_each_nested(pos, attr) {
> +		struct rtattr *tb[CTRL_ATTR_MCAST_GRP_MAX + 1];
> +
> +		parse_rtattr_nested(tb, CTRL_ATTR_MCAST_GRP_MAX, pos);
> +
> +		if (tb[CTRL_ATTR_MCAST_GRP_NAME] && tb[CTRL_ATTR_MCAST_GRP_ID]) {
> +			if (strcmp(name, rta_getattr_str(tb[CTRL_ATTR_MCAST_GRP_NAME])) =3D=
=3D 0) {

Should we use strncmp()? (But not sure with which limit so probably no)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2218791424249979849==--
