Content-Type: multipart/mixed; boundary="===============3834465320191636726=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/2] add support for mptcp netlink interface.
Date: Sun, 29 Mar 2020 21:02:09 -0700
Message-ID: <alpine.OSX.2.22.394.2003292048590.5396@shyampra-mobl1.amr.corp.intel.com>
In-Reply-To: f23b7145f3eb0f681172d4ebb129bd339b8f8cf3.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4105

--===============3834465320191636726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Mar 2020, Paolo Abeni wrote:

> On Thu, 2020-03-26 at 16:45 -0700, Mat Martineau wrote:
>> On Thu, 26 Mar 2020, Paolo Abeni wrote:
>>
>>> Implement basic commands to:
>>> - manipulate MPTCP local addresses list
>>> - manipulate MPTCP connection limits
>>>
>>> Examples:
>>> 1. Allows multiple subflows per MPTCP connection
>>>   $ ip mptcp limits subflows 2
>>>
>>> 2. Accept ADD_ADDR announcement from the peer (server):
>>>   $ ip mptcp limits add_addr_accepted 2
>>>
>>> 3. Add a ipv4 address to be annunced for backup subflows:
>>>   $ip mptcp address add 10.99.1.2 signal backup
>>>
>>> 4. Add an ipv6 address used as source for additional subflows:
>>>   $ip mptcp address add 2001::2 subflow
>>>
>>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>>> ---
>>> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
>>> new file mode 100644
>>> index 00000000..1ff66a7b
>>> --- /dev/null
>>> +++ b/ip/ipmptcp.c
>>> @@ -0,0 +1,446 @@
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
>>> +		"Usage:	ip mptcp address add <address> [dev <name>] [id <id>] [signa=
l] [subflow] [backup]\n"
>>> +		"	ip mptcp address del id <id>\n"
>>> +		"	ip mptcp address list\n"
>>> +		"	ip mptcp address get id <id>\n"
>>> +		"	ip mptcp address flush\n"
>>> +		"	ip mptcp limits [subflows <nr>] [add_addr_accepted <nr>]\n");
>>> +
>>> +	exit(-1);
>>> +}
>>> +
>>
>> Looking at the documentation for 'ip', there seem to be two command
>> styles:
>>
>> ip [ OPTIONS ] OBJECT { COMMAND }     # for most commands
>>
>> ip xfrm XFRM-OBJECT { COMMAND }       # for xfrm
>>
>>
>> and the above seems to fit the 'xfrm' style.
>>
>>
>> To avoid confusion with 'ip address', what about using "ip mptcp
>> adv-address" (or "advertise-addr"?) to clarify that these are addresses =
to
>> be advertised, rather than something that creates new addresses?
>
> ok to rename, but the addresses specified here could be used for
> advertise but also as source address for additional flows, so we would
> need something more generic (and nothing come to my mind beyond
> 'address').

Good point. Would something like "default-addr" be generic for that =

purpose while still getting the point across that we expect these IP =

addresses to exist already, and are telling MPTCP to use them for any =

connection?

>
>> For consistency with other commands, "ip mptcp address show id <id>" cou=
ld
>> be a better fit than 'get'.
>
> Ok, than is probably better also rename 'list' into 'show', so we will
> have a single 'getter' command with optional filter, WDYT?

Fine with me.


--
Mat Martineau
Intel
--===============3834465320191636726==--
