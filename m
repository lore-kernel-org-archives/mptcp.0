Content-Type: multipart/mixed; boundary="===============3921286545902889461=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 2/4] add support for mptcp netlink interface.
Date: Wed, 15 Apr 2020 18:28:55 +0200
Message-ID: <0713b9b4-722f-31e5-50ee-ddc8f769cdbf@tessares.net>
In-Reply-To: 2d7af8c97f735a585831c47c3687425d2132edb2.1586953702.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4174

--===============3921286545902889461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 15/04/2020 14:28, Paolo Abeni wrote:
> Implement basic commands to:
> - manipulate MPTCP endpoints list
> - manipulate MPTCP connection limits
> =

> Examples:
> 1. Allows multiple subflows per MPTCP connection
>     $ ip mptcp limits set subflows 2
> =

> 2. Accept ADD_ADDR announcement from the peer (server):
>     $ ip mptcp limits set add_addr_accepted 2
> =

> 3. Add a ipv4 address to be annunced for backup subflows:
>     $ ip mptcp endpoint add 10.99.1.2 signal backup
> =

> 4. Add an ipv6 address used as source for additional subflows:
>     $ ip mptcp endpoint add 2001::2 subflow

Thank you for looking at that!

(detail, there is a dot at the end of the subject)

(...)

> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> new file mode 100644
> index 00000000..452629f4
> --- /dev/null
> +++ b/ip/ipmptcp.c
> @@ -0,0 +1,449 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <rt_names.h>
> +#include <errno.h>
> +
> +#include <linux/genetlink.h>
> +#include <linux/mptcp.h>
> +
> +#include "utils.h"
> +#include "ip_common.h"
> +#include "libgenl.h"
> +#include "json_print.h"
> +
> +static void usage(void)
> +{
> +	fprintf(stderr,
> +		"Usage:	ip mptcp endpoint add <address> [dev <name>] [id <id>] [signal=
] [subflow] [backup]\n"
> +		"	ip mptcp endpoint delete id <id>\n"
> +		"	ip mptcp endpoint show [id <id>]\n"
> +		"	ip mptcp endpoint flush\n"
> +		"	ip mptcp limits set [subflows <nr>] [add_addr_accepted <nr>]\n"
> +		"	ip mptcp limits show\n");

detail: it seems to me that the arguments are usually presented with =

capital letters, extra spaces and new lines when it is too long, e.g.

     "Usage: ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
     "                                     [ signal ] [ subflow ]\n"
     "                                     [ backup ]\n"
     "       ip mptcp endpoint delete id ID\n"
     "       ip mptcp endpoint show [ id ID ]\n"
     "       ip mptcp endpoint flush\n"
     "       ip mptcp limits set { subflows | add_addr_accepted } NR\n"
     "       ip mptcp limits show\n");

It seems you can also use an attribute expended later:

     "Usage: ip mptcp endpoint add ADDRESS SELECTOR\n"
     "       ip mptcp endpoint delete id ID\n"
     (...)
     "SELECTOR :=3D [ dev NAME ] [ id ID ] [ signal ] [ subflow ]\n"
     "            [ backup ]\n"

> +	exit(-1);
> +}
> +
> +/* netlink socket */
> +static struct rtnl_handle genl_rth =3D { .fd =3D -1 };
> +static int genl_family =3D -1;
> +
> +#define MPTCP_BUFLEN	4096
> +#define MPTCP_REQUEST(_req,  _cmd, _flags)	\
> +	GENL_REQUEST(_req, MPTCP_BUFLEN, genl_family, 0,	\
> +		     MPTCP_PM_VER, _cmd, _flags)
> +
> +/* Mapping from argument to address flag mask */
> +static const struct {
> +	const char *name;
> +	unsigned long value;
> +} mptcp_addr_flag_names[] =3D {
> +	{ "signal",		MPTCP_PM_ADDR_FLAG_SIGNAL },
> +	{ "subflow",		MPTCP_PM_ADDR_FLAG_SUBFLOW },
> +	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
> +};
> +
> +static void print_mptcp_addr_flags(unsigned int flags)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(mptcp_addr_flag_names); i++) {
> +		unsigned long mask =3D mptcp_addr_flag_names[i].value;
> +
> +		if (flags & mask) {
> +			print_string(PRINT_FP, NULL, "%s ",
> +				     mptcp_addr_flag_names[i].name);
> +			print_bool(PRINT_JSON,
> +				   mptcp_addr_flag_names[i].name, NULL, true);
> +		}
> +
> +		flags &=3D ~mask;
> +	}
> +
> +	if (flags) {
> +		/* unknown flags */
> +		SPRINT_BUF(b1);
> +
> +		snprintf(b1, sizeof(b1), "%02x", flags);
> +		print_string(PRINT_ANY, "rawflags", "rawflags %s ", b1);

(it looks strange to me to end with a space even in json context but I =

don't know the code of iproute2 :) )

> +	}
> +}
> +
> +static int get_flags(const char *arg, __u32 *flags)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(mptcp_addr_flag_names); i++) {
> +		if (strcmp(arg, mptcp_addr_flag_names[i].name))

(can we use strcmp or do they force strncmp() for the flags? or matches()?)

> +			continue;
> +
> +		*flags |=3D mptcp_addr_flag_names[i].value;
> +		return 0;
> +	}
> +	return -1;
> +}
> +
> +static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n,
> +			 bool adding)
> +{
> +	struct rtattr *attr_addr;
> +	bool addr_set =3D false;
> +	inet_prefix address;
> +	bool id_set =3D false;
> +	__u32 index =3D 0;
> +	__u32 flags =3D 0;
> +	__u8 id =3D 0;
> +
> +	ll_init_map(&rth);
> +	while (argc > 0) {
> +		if (get_flags(*argv, &flags) =3D=3D 0) {
> +		} else if (!matches(*argv, "id")) {
> +			NEXT_ARG();
> +
> +			if (get_u8(&id, *argv, 0)) {
> +				invarg("invalid TTL\n", *argv);

detail: do you mean ID instead of TTL?

> +				return -1;

detail: it seems "invarg()" already does a "exit(-1)". So we can remove =

"return -1", same below.

And it prints:

   "Error: argument \"%s\" is wrong: %s\n", <2nd arg>, <1st arg>

> +			}
> +			id_set =3D true;
> +		} else if (!matches(*argv, "dev")) {
> +			const char *ifname;
> +
> +			NEXT_ARG();
> +
> +			ifname =3D *argv;
> +
> +			if (check_ifname(ifname)) {
> +				invarg("name", ifname);

Even if "invarg" already adds "\n", I see "\n" is always added at the =

end of the 1st arg.

And maybe here, we can say: "invalid interface name\n"

> +				return -1;
> +			}
> +
> +			index =3D ll_name_to_index(ifname);
> +
> +			if (!index) {
> +				invarg("name", ifname);

maybe: "Device does not exist\n"

> +				return -1;
> +			}
> +		} else if (get_addr(&address, *argv, AF_UNSPEC) =3D=3D 0) {
> +			addr_set =3D true;
> +		} else {
> +			invarg("unknown argument", *argv);
> +			usage();
> +		}
> +		NEXT_ARG_FWD();
> +	}
> +
> +	if (!addr_set && adding) {
> +		fprintf(stderr, "mptcp: must set 'address' on add\n");

detail: it seems you can use missarg("ADDRESS") here. It does an exit(-1).

> +		return -1;
> +	}
> +
> +	if (!id_set && !adding) {
> +		fprintf(stderr, "mptcp: must set 'id'\n");

detail: same here with missarg("ID").

> +		return -1;
> +	}
> +
> +	attr_addr =3D addattr_nest(n, MPTCP_BUFLEN,
> +				 MPTCP_PM_ATTR_ADDR | NLA_F_NESTED);
> +	if (id_set)
> +		addattr8(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_ID, id);
> +	if (flags)
> +		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_FLAGS, flags);
> +	if (index)
> +		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_IF_IDX, index);
> +	if (addr_set) {
> +		int type;
> +
> +		addattr16(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_FAMILY,
> +			  address.family);
> +		type =3D address.family =3D=3D AF_INET ? MPTCP_PM_ADDR_ATTR_ADDR4 :
> +						   MPTCP_PM_ADDR_ATTR_ADDR6;
> +		addattr_l(n, MPTCP_BUFLEN, type, &address.data,
> +			  address.bytelen);
> +	}
> +
> +	addattr_nest_end(n, attr_addr);
> +	return 0;
> +}
> +
> +static int mptcp_addr_modify(int argc, char **argv, int cmd)
> +{
> +	MPTCP_REQUEST(req, cmd, NLM_F_REQUEST);
> +	int ret;
> +
> +	ret =3D mptcp_parse_opt(argc, argv, &req.n, cmd =3D=3D MPTCP_PM_CMD_ADD=
_ADDR);
> +	if (ret)
> +		return ret;
> +
> +	if (rtnl_talk(&genl_rth, &req.n, NULL) < 0)
> +		return -2;
> +
> +	return 0;
> +}
> +
> +static int print_mptcp_addrinfo(struct rtattr *addrinfo)
> +{
> +	struct rtattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
> +	__u8 family =3D AF_UNSPEC, addr_attr_type;
> +	const char *ifname;
> +	unsigned int flags;
> +	int index;
> +	__u16 id;
> +
> +	parse_rtattr_nested(tb, MPTCP_PM_ADDR_ATTR_MAX, addrinfo);
> +
> +	open_json_object(NULL);
> +	if (tb[MPTCP_PM_ADDR_ATTR_FAMILY])
> +		family =3D rta_getattr_u8(tb[MPTCP_PM_ADDR_ATTR_FAMILY]);
> +
> +	addr_attr_type =3D family =3D=3D AF_INET ? MPTCP_PM_ADDR_ATTR_ADDR4 :
> +					     MPTCP_PM_ADDR_ATTR_ADDR6;
> +	if (tb[addr_attr_type]) {
> +		print_string(PRINT_ANY, "address", "%s ",

(same here, is it OK to have a space at then end in a JSON context? Same =

below)

> +			     format_host_rta(family, tb[addr_attr_type]));
> +	}
> +	if (tb[MPTCP_PM_ADDR_ATTR_ID]) {
> +		id =3D rta_getattr_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
> +		print_uint(PRINT_ANY, "id", "id %u ", id);
> +	}
> +	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS]) {
> +		flags =3D rta_getattr_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
> +		print_mptcp_addr_flags(flags);
> +	}
> +	if (tb[MPTCP_PM_ADDR_ATTR_IF_IDX]) {
> +		index =3D rta_getattr_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
> +		ifname =3D index ? ll_index_to_name(index) : NULL;
> +
> +		if (ifname)
> +			print_string(PRINT_ANY, "dev", "dev %s ", ifname);
> +	}
> +
> +	close_json_object();
> +	print_string(PRINT_FP, NULL, "\n", NULL);
> +	fflush(stdout);
> +
> +	return 0;
> +}
> +
> +static int print_mptcp_addr(struct nlmsghdr *n, void *arg)
> +{
> +	struct rtattr *tb[MPTCP_PM_ATTR_MAX + 1];
> +	struct genlmsghdr *ghdr;
> +	struct rtattr *addrinfo;
> +	int len =3D n->nlmsg_len;
> +
> +	if (n->nlmsg_type !=3D genl_family)
> +		return 0;
> +
> +	len -=3D NLMSG_LENGTH(GENL_HDRLEN);
> +	if (len < 0)
> +		return -1;
> +
> +	ghdr =3D NLMSG_DATA(n);
> +	parse_rtattr_flags(tb, MPTCP_PM_ATTR_MAX, (void *) ghdr + GENL_HDRLEN,
> +			   len, NLA_F_NESTED);
> +	addrinfo =3D tb[MPTCP_PM_ATTR_ADDR];
> +	if (!addrinfo)
> +		return -1;
> +
> +	ll_init_map(&rth);
> +	return print_mptcp_addrinfo(addrinfo);
> +}
> +
> +static int mptcp_addr_dump(void)
> +{
> +	MPTCP_REQUEST(req, MPTCP_PM_CMD_GET_ADDR, NLM_F_REQUEST | NLM_F_DUMP);
> +
> +	if (rtnl_send(&genl_rth, &req.n, req.n.nlmsg_len) < 0) {
> +		perror("Cannot send show request");
> +		exit(1);
> +	}
> +
> +	new_json_obj(json);
> +
> +	if (rtnl_dump_filter(&genl_rth, print_mptcp_addr, stdout) < 0) {
> +		fprintf(stderr, "Dump terminated\n");
> +		delete_json_obj();
> +		fflush(stdout);
> +		return -2;
> +	}
> +
> +	close_json_object();
> +	fflush(stdout);
> +	return 0;
> +}
> +
> +static int mptcp_addr_show(int argc, char **argv)
> +{
> +	MPTCP_REQUEST(req, MPTCP_PM_CMD_GET_ADDR, NLM_F_REQUEST);
> +	struct nlmsghdr *answer;
> +	int ret;
> +
> +	if (!argv)
> +		return mptcp_addr_dump();
> +
> +	ret =3D mptcp_parse_opt(argc, argv, &req.n, false);
> +	if (ret)
> +		return ret;
> +
> +	if (rtnl_talk(&genl_rth, &req.n, &answer) < 0)
> +		return -2;
> +
> +	return print_mptcp_addr(answer, stdout);
> +}
> +
> +static int mptcp_addr_flush(int argc, char **argv)
> +{
> +	MPTCP_REQUEST(req, MPTCP_PM_CMD_FLUSH_ADDRS, NLM_F_REQUEST);
> +
> +	if (rtnl_talk(&genl_rth, &req.n, NULL) < 0)
> +		return -2;
> +
> +	return 0;
> +}
> +
> +static int mptcp_parse_limit(int argc, char **argv, struct nlmsghdr *n)
> +{
> +	bool set_rcv_add_addrs =3D false;
> +	bool set_subflows =3D false;
> +	__u32 rcv_add_addrs =3D 0;
> +	__u32 subflows =3D 0;
> +
> +	while (argc > 0) {
> +		if (!matches(*argv, "subflows")) {
> +			NEXT_ARG();
> +
> +			if (get_u32(&subflows, *argv, 0)) {
> +				invarg("invalid subflows\n", *argv);
> +				return -1;
> +			}
> +			set_subflows =3D true;
> +		} else if (!matches(*argv, "add_addr_accepted")) {
> +			NEXT_ARG();
> +
> +			if (get_u32(&rcv_add_addrs, *argv, 0)) {
> +				invarg("invalid add_addr_accepted\n", *argv);
> +				return -1;
> +			}
> +			set_rcv_add_addrs =3D true;
> +		} else {
> +			invarg("unknown argument", *argv);
> +			usage();
> +		}
> +		NEXT_ARG_FWD();
> +	}
> +
> +	if (set_rcv_add_addrs)
> +		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ATTR_RCV_ADD_ADDRS,
> +			  rcv_add_addrs);
> +	if (set_subflows)
> +		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ATTR_SUBFLOWS, subflows);
> +	return set_rcv_add_addrs || set_subflows;
> +}
> +
> +static int print_mptcp_limit(struct nlmsghdr *n, void *arg)
> +{
> +	struct rtattr *tb[MPTCP_PM_ATTR_MAX + 1];
> +	struct genlmsghdr *ghdr;
> +	int len =3D n->nlmsg_len;
> +	__u32 val;
> +
> +	if (n->nlmsg_type !=3D genl_family)
> +		return 0;
> +
> +	len -=3D NLMSG_LENGTH(GENL_HDRLEN);
> +	if (len < 0)
> +		return -1;
> +
> +	ghdr =3D NLMSG_DATA(n);
> +	parse_rtattr(tb, MPTCP_PM_ATTR_MAX, (void *) ghdr + GENL_HDRLEN, len);
> +
> +	open_json_object(NULL);
> +	if (tb[MPTCP_PM_ATTR_RCV_ADD_ADDRS]) {
> +		val =3D rta_getattr_u32(tb[MPTCP_PM_ATTR_RCV_ADD_ADDRS]);
> +
> +		print_uint(PRINT_ANY, "add_addr_accepted",
> +			   "add_addr_accepted %d ", val);
> +	}
> +
> +	if (tb[MPTCP_PM_ATTR_SUBFLOWS]) {
> +		val =3D rta_getattr_u32(tb[MPTCP_PM_ATTR_SUBFLOWS]);
> +
> +		print_uint(PRINT_ANY, "subflows", "subflows %d ", val);

(same here, OK to have the trailing whitespace for JSON?)

> +	}
> +	print_string(PRINT_FP, NULL, "%s", "\n");
> +	fflush(stdout);
> +	close_json_object();
> +	return 0;
> +}
> +
> +static int mptcp_limit_get_set(int argc, char **argv, int cmd)
> +{
> +	bool do_get =3D cmd =3D=3D MPTCP_PM_CMD_GET_LIMITS;
> +	MPTCP_REQUEST(req, cmd, NLM_F_REQUEST);
> +	struct nlmsghdr *answer;
> +	int ret;
> +
> +	ret =3D mptcp_parse_limit(argc, argv, &req.n);
> +	if (ret < 0)
> +		return -1;
> +
> +	if (rtnl_talk(&genl_rth, &req.n, do_get ? &answer : NULL) < 0)
> +		return -2;
> +
> +	if (do_get)
> +		return print_mptcp_limit(answer, stdout);
> +	return 0;
> +}
> +
> +int do_mptcp(int argc, char **argv)
> +{
> +	if (argc =3D=3D 0)
> +		usage();
> +
> +	if (!matches(*argv, "help"))

It is maybe just me but it looks strange to see "!matches" when the goal =

is to see if it matches :-)

Maybe clearer with "matches(...) =3D=3D 0" like in most of the code?
(same below and above in this file)

> +		usage();
> +
> +	if (genl_init_handle(&genl_rth, MPTCP_PM_NAME, &genl_family))
> +		exit(1);
> +
> +	if (!matches(*argv, "endpoint")) {
> +		NEXT_ARG_FWD();
> +		if (argc =3D=3D 0)
> +			return mptcp_addr_show(0, NULL);
> +
> +		if (!matches(*argv, "add"))
> +			return mptcp_addr_modify(argc-1, argv+1,
> +						 MPTCP_PM_CMD_ADD_ADDR);
> +		if (!matches(*argv, "delete"))
> +			return mptcp_addr_modify(argc-1, argv+1,
> +						 MPTCP_PM_CMD_DEL_ADDR);
> +		if (!matches(*argv, "show"))
> +			return mptcp_addr_show(argc-1, argv+1);
> +		if (!matches(*argv, "flush"))
> +			return mptcp_addr_flush(argc-1, argv+1);
> +
> +		goto unknown;
> +	}
> +
> +	if (!matches(*argv, "limits")) {
> +		NEXT_ARG_FWD();
> +		if (argc =3D=3D 0)
> +			return mptcp_limit_get_set(argc-1, argv+1,

Is it OK here with "argc-1" =3D=3D -1?

Cheers,
Matt

> +						   MPTCP_PM_CMD_GET_LIMITS);
> +
> +		if (!matches(*argv, "set"))
> +			return mptcp_limit_get_set(argc-1, argv+1,
> +						   MPTCP_PM_CMD_SET_LIMITS);
> +		if (!matches(*argv, "show"))
> +			return mptcp_limit_get_set(argc-1, argv+1,
> +						   MPTCP_PM_CMD_GET_LIMITS);
> +	}
> +
> +unknown:
> +	fprintf(stderr,
> +		"Command \"%s\" is unknown, try \"ip mptcp help\".\n",
> +		*argv);
> +	exit(-1);
> +}

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3921286545902889461==--
