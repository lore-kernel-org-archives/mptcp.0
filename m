Content-Type: multipart/mixed; boundary="===============8467152025041678320=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 7/7] mptcp: add netlink event support
Date: Wed, 20 Jan 2021 14:01:09 +0100
Message-ID: <6318158a-6810-3e26-38ff-640ce7823b39@tessares.net>
In-Reply-To: 20210120121852.GN19605@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 7444

--===============8467152025041678320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 20/01/2021 13:18, Florian Westphal wrote:
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>> On Thu, 14 Jan 2021, Florian Westphal wrote:
>>> #define MPTCP_PM_NAME		"mptcp_pm"
>>> #define MPTCP_PM_CMD_GRP_NAME	"mptcp_pm_cmds"
>>> +#define MPTCP_PM_EV_GRP_NAME    "mptcp_events"
>>
>> Suggest "mptcp_pm_events" instead.
> =

> I don't mind changing it but it would mean one more change needed
> on mptcpd side vs. the out of tree kernel.

Instinctively, I would prefer having different names just in case we =

need to do something different from one implementation to another. In =

userspace, we would only have to try one or the other but at least we =

will know which one we are connected to, "just in case" we need =

different behaviours for one or the other.

Of course, if we are sure we are doing the same thing is both, that's =

fine to have the same name. I'm maybe feeling less confident just =

because there is no RFC for these events :)
(arf, I'm being influenced by the IETF :-O But I'm also fine with =

"mptcp_events" if we prefer!)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8467152025041678320==--
