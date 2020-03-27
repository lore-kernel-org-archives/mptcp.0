Content-Type: multipart/mixed; boundary="===============2265744736469463616=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/2] add support for mptcp netlink interface.
Date: Fri, 27 Mar 2020 15:31:33 +0100
Message-ID: <b1e93702-ee14-a257-682b-ddd88de43723@tessares.net>
In-Reply-To: alpine.OSX.2.22.394.2003261538040.29004@spazoki-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4086

--===============2265744736469463616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 27/03/2020 00:45, Mat Martineau wrote:
> =

> On Thu, 26 Mar 2020, Paolo Abeni wrote:
> =

>> Implement basic commands to:
>> - manipulate MPTCP local addresses list
>> - manipulate MPTCP connection limits
>>
>> Examples:
>> 1. Allows multiple subflows per MPTCP connection
>> =C2=A0 $ ip mptcp limits subflows 2
>>
>> 2. Accept ADD_ADDR announcement from the peer (server):
>> =C2=A0 $ ip mptcp limits add_addr_accepted 2
>>
>> 3. Add a ipv4 address to be annunced for backup subflows:
>> =C2=A0 $ip mptcp address add 10.99.1.2 signal backup
>>
>> 4. Add an ipv6 address used as source for additional subflows:
>> =C2=A0 $ip mptcp address add 2001::2 subflow
>>
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> ---

Thank you for the good work!

> =

>> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
>> new file mode 100644
>> index 00000000..1ff66a7b
>> --- /dev/null
>> +++ b/ip/ipmptcp.c
>> @@ -0,0 +1,446 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <stdio.h>
>> +#include <string.h>
>> +#include <rt_names.h>
>> +#include <errno.h>
>> +
>> +#include <linux/genetlink.h>
>> +#include <linux/mptcp.h>
>> +
>> +#include "utils.h"
>> +#include "ip_common.h"
>> +#include "libgenl.h"
>> +#include "json_print.h"
>> +
>> +static void usage(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 fprintf(stderr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Usage:=C2=A0=C2=A0=C2=A0 ip=
 mptcp address add <address> [dev <name>] [id =

>> <id>] [signal] [subflow] [backup]\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0 ip mptcp=
 address del id <id>\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0 ip mptcp=
 address list\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0 ip mptcp=
 address get id <id>\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0 ip mptcp=
 address flush\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0 ip mptcp=
 limits [subflows <nr>] [add_addr_accepted =

>> <nr>]\n");
>> +
>> +=C2=A0=C2=A0=C2=A0 exit(-1);
>> +}
>> +
> =

> Looking at the documentation for 'ip', there seem to be two command style=
s:
> =

> ip [ OPTIONS ] OBJECT { COMMAND }=C2=A0=C2=A0=C2=A0=C2=A0 # for most comm=
ands
> =

> ip xfrm XFRM-OBJECT { COMMAND }=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # for=
 xfrm
> =

> =

> and the above seems to fit the 'xfrm' style.
> =

> =

> To avoid confusion with 'ip address', what about using "ip mptcp =

> adv-address" (or "advertise-addr"?) to clarify that these are addresses =

> to be advertised, rather than something that creates new addresses?

+1

> For consistency with other commands, "ip mptcp address show id <id>" =

> could be a better fit than 'get'.

+1

> =

> For the limit changes, how about:
> =

> ip mptcp limit set [subflows <nr>] [add_addr_accepted <nr>]
> =

> ip mptcp limit get
> or
> ip mptcp limit show

+1

> Do you think the 'ip mptcp' command will be extended in the future for =

> managing per-connection settings? That probably still works with the =

> above syntax, for example by adding [connection <token>] to 'ip mptcp =

> address add'.

Good idea. It will be possible to retrieve these tokens with "ss". It =

can be useful for the debugging.

For the rest mptcpd will be needed to track the connections.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2265744736469463616==--
