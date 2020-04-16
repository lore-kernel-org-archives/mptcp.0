Content-Type: multipart/mixed; boundary="===============6773821899156719647=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 2/4] add support for mptcp netlink interface.
Date: Thu, 16 Apr 2020 12:22:53 +0200
Message-ID: <01f75ca9-3672-8783-4dfa-58fad7d44cc8@tessares.net>
In-Reply-To: 37735e390e29992531358a17afffbcb943972291.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4190

--===============6773821899156719647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for the answers!

On 15/04/2020 19:12, Paolo Abeni wrote:
> Hi,
> =

> Thank you for the usual very detailed review! ;)

I hope it is not too detailed and would slow you down! Please tell me if =

there are stuff I can skip in my future reviews :)

> =

> On Wed, 2020-04-15 at 18:28 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 15/04/2020 14:28, Paolo Abeni wrote:
>>> Implement basic commands to:
>>> - manipulate MPTCP endpoints list
>>> - manipulate MPTCP connection limits
>>>
>>> Examples:
>>> 1. Allows multiple subflows per MPTCP connection
>>>      $ ip mptcp limits set subflows 2
>>>
>>> 2. Accept ADD_ADDR announcement from the peer (server):
>>>      $ ip mptcp limits set add_addr_accepted 2
>>>
>>> 3. Add a ipv4 address to be annunced for backup subflows:
>>>      $ ip mptcp endpoint add 10.99.1.2 signal backup
>>>
>>> 4. Add an ipv6 address used as source for additional subflows:
>>>      $ ip mptcp endpoint add 2001::2 subflow
>>
>> Thank you for looking at that!
>>
>> (detail, there is a dot at the end of the subject)
>>
>> (...)
>>
>>> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
>>> new file mode 100644
>>> index 00000000..452629f4
>>> --- /dev/null
>>> +++ b/ip/ipmptcp.c
>>> @@ -0,0 +1,449 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include <stdio.h>
>>> +#include <string.h>
>>> +#include <rt_names.h>
>>> +#include <errno.h>
>>> +
>>> +#include <linux/genetlink.h>
>>> +#include <linux/mptcp.h>
>>> +
>>> +#include "utils.h"
>>> +#include "ip_common.h"
>>> +#include "libgenl.h"
>>> +#include "json_print.h"
>>> +
>>> +static void usage(void)
>>> +{
>>> +	fprintf(stderr,
>>> +		"Usage:	ip mptcp endpoint add <address> [dev <name>] [id <id>] [sign=
al] [subflow] [backup]\n"
>>> +		"	ip mptcp endpoint delete id <id>\n"
>>> +		"	ip mptcp endpoint show [id <id>]\n"
>>> +		"	ip mptcp endpoint flush\n"
>>> +		"	ip mptcp limits set [subflows <nr>] [add_addr_accepted <nr>]\n"
>>> +		"	ip mptcp limits show\n");
>>
>> detail: it seems to me that the arguments are usually presented with
>> capital letters, extra spaces and new lines when it is too long, e.g.
> =

> I think the 80 columns limit on code line is not enforced - actually
> breaking it will make 'help' more readable con common-size shell.

Indeed, I see in "ip link help" some lines that are longer than 80 chars =

but with a certain limit.

> =

> I propose to use capital letters and following indentation:
> =

> 		"Usage:	ip mptcp endpoint add ADDRESS [dev NAME] [id ID]\n"
> 		"				      [signal] [subflow] [backup]\n"
> 		"	ip mptcp endpoint delete id ID\n"
> 		"	ip mptcp endpoint show [id ID]\n"
> 		"	ip mptcp endpoint flush\n"
> 		"	ip mptcp limits set [subflows NR] [add_addr_accepted NR]\n"
> 		"	ip mptcp limits show\n");

When looking at the other help commands, it seems they prefer to have =

spaces on both sides of "[" and "]", so more like this:

		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
		"				      [ signal ] [ subflow ] [ backup ]\n"
		"	ip mptcp endpoint delete id ID\n"
		"	ip mptcp endpoint show [ id ID ]\n"
		"	ip mptcp endpoint flush\n"
		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
		"	ip mptcp limits show\n");

But maybe it is not mandatory.

> =

>>
>>       "Usage: ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
>>       "                                     [ signal ] [ subflow ]\n"
>>       "                                     [ backup ]\n"
>>       "       ip mptcp endpoint delete id ID\n"
>>       "       ip mptcp endpoint show [ id ID ]\n"
>>       "       ip mptcp endpoint flush\n"
>>       "       ip mptcp limits set { subflows | add_addr_accepted } NR\n"
> =

> If I read correctly, this is a little different from what we support,
> as we can set bot 'subflow' and 'add_addr_accepted' in the same
> command.
> =

> This should also answer a question on patch 4/4 ;)

Indeed sorry I forgot both arguments can be used.

> =

> =

>>       "       ip mptcp limits show\n");
>>
>> It seems you can also use an attribute expended later:
> =

> Yep, but I think it's not needed when the syntax is simple enough, as
> in this scenario.

Indeed but I am also fine with your FLAG-LIST :)

>>
>>       "Usage: ip mptcp endpoint add ADDRESS SELECTOR\n"
>>       "       ip mptcp endpoint delete id ID\n"
>>       (...)
>>       "SELECTOR :=3D [ dev NAME ] [ id ID ] [ signal ] [ subflow ]\n"
>>       "            [ backup ]\n"
>>
>>> +	exit(-1);
>>> +}
>>> +
>>> +/* netlink socket */
>>> +static struct rtnl_handle genl_rth =3D { .fd =3D -1 };
>>> +static int genl_family =3D -1;
>>> +
>>> +#define MPTCP_BUFLEN	4096
>>> +#define MPTCP_REQUEST(_req,  _cmd, _flags)	\
>>> +	GENL_REQUEST(_req, MPTCP_BUFLEN, genl_family, 0,	\
>>> +		     MPTCP_PM_VER, _cmd, _flags)
>>> +
>>> +/* Mapping from argument to address flag mask */
>>> +static const struct {
>>> +	const char *name;
>>> +	unsigned long value;
>>> +} mptcp_addr_flag_names[] =3D {
>>> +	{ "signal",		MPTCP_PM_ADDR_FLAG_SIGNAL },
>>> +	{ "subflow",		MPTCP_PM_ADDR_FLAG_SUBFLOW },
>>> +	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
>>> +};
>>> +
>>> +static void print_mptcp_addr_flags(unsigned int flags)
>>> +{
>>> +	unsigned int i;
>>> +
>>> +	for (i =3D 0; i < ARRAY_SIZE(mptcp_addr_flag_names); i++) {
>>> +		unsigned long mask =3D mptcp_addr_flag_names[i].value;
>>> +
>>> +		if (flags & mask) {
>>> +			print_string(PRINT_FP, NULL, "%s ",
>>> +				     mptcp_addr_flag_names[i].name);
>>> +			print_bool(PRINT_JSON,
>>> +				   mptcp_addr_flag_names[i].name, NULL, true);
>>> +		}
>>> +
>>> +		flags &=3D ~mask;
>>> +	}
>>> +
>>> +	if (flags) {
>>> +		/* unknown flags */
>>> +		SPRINT_BUF(b1);
>>> +
>>> +		snprintf(b1, sizeof(b1), "%02x", flags);
>>> +		print_string(PRINT_ANY, "rawflags", "rawflags %s ", b1);
>>
>> (it looks strange to me to end with a space even in json context but I
>> don't know the code of iproute2 :) )
> =

> It's just to keep the code simple, otherwise we have to check for 'last
> flag' condition.

Yes, JSON supports doesn't make the code easy to do.
It is maybe fine like that for upstream for the moment.

I was looking at print_flag() from ipmacsec.c. Some are also using =

arrays for JSON. We can wait for upstream feedback.

> =

>>> +	}
>>> +}
>>> +
>>> +static int get_flags(const char *arg, __u32 *flags)
>>> +{
>>> +	unsigned int i;
>>> +
>>> +	for (i =3D 0; i < ARRAY_SIZE(mptcp_addr_flag_names); i++) {
>>> +		if (strcmp(arg, mptcp_addr_flag_names[i].name))
>>
>> (can we use strcmp or do they force strncmp() for the flags? or matches(=
)?)
> =

> ip address uses 'strcmp', so that exact match is enforced, while e.g.
> ip neigh uses 'matches'. I guess either would be fine.

Fine for me as long as it is fine for upstream :-)

>>
>>> +			continue;
>>> +
>>> +		*flags |=3D mptcp_addr_flag_names[i].value;
>>> +		return 0;
>>> +	}
>>> +	return -1;
>>> +}
>>> +
>>> +static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n,
>>> +			 bool adding)
>>> +{
>>> +	struct rtattr *attr_addr;
>>> +	bool addr_set =3D false;
>>> +	inet_prefix address;
>>> +	bool id_set =3D false;
>>> +	__u32 index =3D 0;
>>> +	__u32 flags =3D 0;
>>> +	__u8 id =3D 0;
>>> +
>>> +	ll_init_map(&rth);
>>> +	while (argc > 0) {
>>> +		if (get_flags(*argv, &flags) =3D=3D 0) {
>>> +		} else if (!matches(*argv, "id")) {
>>> +			NEXT_ARG();
>>> +
>>> +			if (get_u8(&id, *argv, 0)) {
>>> +				invarg("invalid TTL\n", *argv);
>>
>> detail: do you mean ID instead of TTL?
> =

> yep!
>>
>>> +				return -1;
>>
>> detail: it seems "invarg()" already does a "exit(-1)". So we can remove
>> "return -1", same below.
>>
>> And it prints:
>>
>>     "Error: argument \"%s\" is wrong: %s\n", <2nd arg>, <1st arg>
>>
>>> +			}
>>> +			id_set =3D true;
>>> +		} else if (!matches(*argv, "dev")) {
>>> +			const char *ifname;
>>> +
>>> +			NEXT_ARG();
>>> +
>>> +			ifname =3D *argv;
>>> +
>>> +			if (check_ifname(ifname)) {
>>> +				invarg("name", ifname);
>>
>> Even if "invarg" already adds "\n", I see "\n" is always added at the
>> end of the 1st arg.
>>
>> And maybe here, we can say: "invalid interface name\n"
> =

> ok
>>
>>> +				return -1;
>>> +			}
>>> +
>>> +			index =3D ll_name_to_index(ifname);
>>> +
>>> +			if (!index) {
>>> +				invarg("name", ifname);
>>
>> maybe: "Device does not exist\n"
> =

> ok, but with initial lower case letter.

it would make more sense but I see this sentence with the uppercase is =

used a bit everywhere, never with "d" in fact.

> =

>>
>>> +				return -1;
>>> +			}
>>> +		} else if (get_addr(&address, *argv, AF_UNSPEC) =3D=3D 0) {
>>> +			addr_set =3D true;
>>> +		} else {
>>> +			invarg("unknown argument", *argv);
>>> +			usage();
> =

> here 'usage' is never reached, I'll drop it
> =

>>> +		}
>>> +		NEXT_ARG_FWD();
>>> +	}
>>> +
>>> +	if (!addr_set && adding) {
>>> +		fprintf(stderr, "mptcp: must set 'address' on add\n");
>>
>> detail: it seems you can use missarg("ADDRESS") here. It does an exit(-1=
).
> =

> ok
>>
>>> +		return -1;
>>> +	}
>>> +
>>> +	if (!id_set && !adding) {
>>> +		fprintf(stderr, "mptcp: must set 'id'\n");
>>
>> detail: same here with missarg("ID").
> =

> ok
> =

>>
>>> +		return -1;
>>> +	}
>>> +
>>> +	attr_addr =3D addattr_nest(n, MPTCP_BUFLEN,
>>> +				 MPTCP_PM_ATTR_ADDR | NLA_F_NESTED);
>>> +	if (id_set)
>>> +		addattr8(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_ID, id);
>>> +	if (flags)
>>> +		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_FLAGS, flags);
>>> +	if (index)
>>> +		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_IF_IDX, index);
>>> +	if (addr_set) {
>>> +		int type;
>>> +
>>> +		addattr16(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_FAMILY,
>>> +			  address.family);
>>> +		type =3D address.family =3D=3D AF_INET ? MPTCP_PM_ADDR_ATTR_ADDR4 :
>>> +						   MPTCP_PM_ADDR_ATTR_ADDR6;
>>> +		addattr_l(n, MPTCP_BUFLEN, type, &address.data,
>>> +			  address.bytelen);
>>> +	}
>>> +
>>> +	addattr_nest_end(n, attr_addr);
>>> +	return 0;
>>> +}
>>> +
>>> +static int mptcp_addr_modify(int argc, char **argv, int cmd)
>>> +{
>>> +	MPTCP_REQUEST(req, cmd, NLM_F_REQUEST);
>>> +	int ret;
>>> +
>>> +	ret =3D mptcp_parse_opt(argc, argv, &req.n, cmd =3D=3D MPTCP_PM_CMD_A=
DD_ADDR);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (rtnl_talk(&genl_rth, &req.n, NULL) < 0)
>>> +		return -2;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int print_mptcp_addrinfo(struct rtattr *addrinfo)
>>> +{
>>> +	struct rtattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
>>> +	__u8 family =3D AF_UNSPEC, addr_attr_type;
>>> +	const char *ifname;
>>> +	unsigned int flags;
>>> +	int index;
>>> +	__u16 id;
>>> +
>>> +	parse_rtattr_nested(tb, MPTCP_PM_ADDR_ATTR_MAX, addrinfo);
>>> +
>>> +	open_json_object(NULL);
>>> +	if (tb[MPTCP_PM_ADDR_ATTR_FAMILY])
>>> +		family =3D rta_getattr_u8(tb[MPTCP_PM_ADDR_ATTR_FAMILY]);
>>> +
>>> +	addr_attr_type =3D family =3D=3D AF_INET ? MPTCP_PM_ADDR_ATTR_ADDR4 :
>>> +					     MPTCP_PM_ADDR_ATTR_ADDR6;
>>> +	if (tb[addr_attr_type]) {
>>> +		print_string(PRINT_ANY, "address", "%s ",
>>
>> (same here, is it OK to have a space at then end in a JSON context? Same
>> below)
> =

> 'fdb' does the same. I guess it's ok.

OK for me!

> =

>>> +{
>>> +	if (argc =3D=3D 0)
>>> +		usage();
>>> +
>>> +	if (!matches(*argv, "help"))
>>
>> It is maybe just me but it looks strange to see "!matches" when the goal
>> is to see if it matches :-)
>>
>> Maybe clearer with "matches(...) =3D=3D 0" like in most of the code?
>> (same below and above in this file)
> =

> ok
> =

>>> +		usage();
>>> +
>>> +	if (genl_init_handle(&genl_rth, MPTCP_PM_NAME, &genl_family))
>>> +		exit(1);
>>> +
>>> +	if (!matches(*argv, "endpoint")) {
>>> +		NEXT_ARG_FWD();
>>> +		if (argc =3D=3D 0)
>>> +			return mptcp_addr_show(0, NULL);
>>> +
>>> +		if (!matches(*argv, "add"))
>>> +			return mptcp_addr_modify(argc-1, argv+1,
>>> +						 MPTCP_PM_CMD_ADD_ADDR);
>>> +		if (!matches(*argv, "delete"))
>>> +			return mptcp_addr_modify(argc-1, argv+1,
>>> +						 MPTCP_PM_CMD_DEL_ADDR);
>>> +		if (!matches(*argv, "show"))
>>> +			return mptcp_addr_show(argc-1, argv+1);
>>> +		if (!matches(*argv, "flush"))
>>> +			return mptcp_addr_flush(argc-1, argv+1);
>>> +
>>> +		goto unknown;
>>> +	}
>>> +
>>> +	if (!matches(*argv, "limits")) {
>>> +		NEXT_ARG_FWD();
>>> +		if (argc =3D=3D 0)
>>> +			return mptcp_limit_get_set(argc-1, argv+1,
>>
>> Is it OK here with "argc-1" =3D=3D -1?
> =

> It's ok because mptcp_limit_get_set checks for positive argc value,
> anyhow I'll change to '0, NULL'.

Thank you for having checked!

>>
>> Cheers,
>> Matt
>>
>>> +						   MPTCP_PM_CMD_GET_LIMITS);
>>> +
>>> +		if (!matches(*argv, "set"))
>>> +			return mptcp_limit_get_set(argc-1, argv+1,
>>> +						   MPTCP_PM_CMD_SET_LIMITS);
>>> +		if (!matches(*argv, "show"))
>>> +			return mptcp_limit_get_set(argc-1, argv+1,
>>> +						   MPTCP_PM_CMD_GET_LIMITS);
>>> +	}
>>> +
>>> +unknown:
>>> +	fprintf(stderr,
>>> +		"Command \"%s\" is unknown, try \"ip mptcp help\".\n",
>>> +		*argv);
>>> +	exit(-1);
> =

> and here invarg("unknown", *argv) would fit.

It seems this last fprintf() is used almost everywhere. Maybe better not =

to use invarg() here?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6773821899156719647==--
