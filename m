Content-Type: multipart/mixed; boundary="===============4098012245337549340=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 7/7] mptcp: add netlink event support
Date: Wed, 20 Jan 2021 14:21:30 +0100
Message-ID: <58123b28-4ef8-8371-5064-c0a8cb6bed4b@tessares.net>
In-Reply-To: 20210120131450.GP19605@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 7446

--===============4098012245337549340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 20/01/2021 14:14, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> Hi Florian,
>>
>> On 20/01/2021 13:18, Florian Westphal wrote:
>>> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>>>> On Thu, 14 Jan 2021, Florian Westphal wrote:
>>>>> #define MPTCP_PM_NAME		"mptcp_pm"
>>>>> #define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
>>>>> +#define MPTCP_PM_EV_GRP_NAME    "mptcp_events"
>>>>
>>>> Suggest "mptcp_pm_events" instead.
>>>
>>> I don't mind changing it but it would mean one more change needed
>>> on mptcpd side vs. the out of tree kernel.
>>
>> Instinctively, I would prefer having different names just in case we nee=
d to
>> do something different from one implementation to another. In userspace,=
 we
>> would only have to try one or the other but at least we will know which =
one
>> we are connected to, "just in case" we need different behaviours for one=
 or
>> the other.
> =

> mptcp kernel uses "mptcp" as the genetlink name, not "mptcp_pm", so it
> already knows if its running on mptcp.org or upstream kernel.

Good point :)

Because the new "define" (MPTCP_PM_EV_GRP_NAME) has not the same name as =

in mptcp.org (MPTCP_GENL_EV_GRP_NAME) -- which makes sense -- I'm fine =

with either names, either prefixed with "mptcp_pm_" like the others here =

or the same as in mptcp.org. I guess the best is to wait for Ossama's =

point of view :)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4098012245337549340==--
