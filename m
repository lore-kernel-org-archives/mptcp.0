Content-Type: multipart/mixed; boundary="===============6939335518073359327=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/2] add support for mptcp netlink interface.
Date: Thu, 26 Mar 2020 16:45:07 -0700
Message-ID: <alpine.OSX.2.22.394.2003261538040.29004@spazoki-mobl.amr.corp.intel.com>
In-Reply-To: 65a08c10aa83d4cc6861b1c2b9534fa8b9e1cae1.1585234717.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4085

--===============6939335518073359327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 26 Mar 2020, Paolo Abeni wrote:

> Implement basic commands to:
> - manipulate MPTCP local addresses list
> - manipulate MPTCP connection limits
>
> Examples:
> 1. Allows multiple subflows per MPTCP connection
>   $ ip mptcp limits subflows 2
>
> 2. Accept ADD_ADDR announcement from the peer (server):
>   $ ip mptcp limits add_addr_accepted 2
>
> 3. Add a ipv4 address to be annunced for backup subflows:
>   $ip mptcp address add 10.99.1.2 signal backup
>
> 4. Add an ipv6 address used as source for additional subflows:
>   $ip mptcp address add 2001::2 subflow
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---


> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> new file mode 100644
> index 00000000..1ff66a7b
> --- /dev/null
> +++ b/ip/ipmptcp.c
> @@ -0,0 +1,446 @@
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
> +		"Usage:	ip mptcp address add <address> [dev <name>] [id <id>] [signal]=
 [subflow] [backup]\n"
> +		"	ip mptcp address del id <id>\n"
> +		"	ip mptcp address list\n"
> +		"	ip mptcp address get id <id>\n"
> +		"	ip mptcp address flush\n"
> +		"	ip mptcp limits [subflows <nr>] [add_addr_accepted <nr>]\n");
> +
> +	exit(-1);
> +}
> +

Looking at the documentation for 'ip', there seem to be two command =

styles:

ip [ OPTIONS ] OBJECT { COMMAND }     # for most commands

ip xfrm XFRM-OBJECT { COMMAND }       # for xfrm


and the above seems to fit the 'xfrm' style.


To avoid confusion with 'ip address', what about using "ip mptcp =

adv-address" (or "advertise-addr"?) to clarify that these are addresses to =

be advertised, rather than something that creates new addresses?

For consistency with other commands, "ip mptcp address show id <id>" could =

be a better fit than 'get'.


For the limit changes, how about:

ip mptcp limit set [subflows <nr>] [add_addr_accepted <nr>]

ip mptcp limit get
or
ip mptcp limit show


Do you think the 'ip mptcp' command will be extended in the future for =

managing per-connection settings? That probably still works with the above =

syntax, for example by adding [connection <token>] to 'ip mptcp address =

add'.


--
Mat Martineau
Intel
--===============6939335518073359327==--
