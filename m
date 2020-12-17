Content-Type: multipart/mixed; boundary="===============6679190907484862331=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 1/2] mptcp: convert IPv4
 address to IPv4-mapped
Date: Thu, 17 Dec 2020 15:16:57 -0800
Message-ID: <64ff69a4-642e-4058-cdeb-9c65145dcb67@linux.intel.com>
In-Reply-To: d3cbdcc0-4471-7a4d-1b1e-d69be80d231c@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7209

--===============6679190907484862331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Dec 2020, Matthieu Baerts wrote:

> Hi Geliang, Mat,
>
> On 17/12/2020 01:23, Mat Martineau wrote:
>> On Wed, 16 Dec 2020, Geliang Tang wrote:
>> =

>>> Currently, PM doesn't create subflow with IPv4-mapped IPv6 socket. This
>>> patch converts the IPv4 address to IPv4-mapped IPv6 address to fix it.
>>> =

>>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>>> ---
>>> net/mptcp/pm_netlink.c | 25 ++++++++++++++++++++++---
>>> 1 file changed, 22 insertions(+), 3 deletions(-)
>>> =

>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index cc4ca013a06b..987e83cdee11 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>>> @@ -145,6 +158,8 @@ select_local_address(const struct pm_nl_pernet =

>>> *pernet,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(entry->addr.flags & MP=
TCP_PM_ADDR_FLAG_SUBFLOW))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cont=
inue;
>>> =

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_pm_addr_convert_v4map=
ped(msk, &entry->addr);
>>> +
>> =

>> This is modifying the contents of pernet->local_addr_list, not a copy of =

>> the entry, when the msk has a v4mapped address. I'm not sure that's the =
way =

>> to fix this, and might leave some corner cases unaddressed.
>> =

>> Did you look at modifying addresses_equal() so it can detect equivalent =

>> IPv4 and v4mapped addresses?
>
> Maybe something like that the patch I joined?
>
> I didn't try much but maybe more what we want?
>

I haven't tested it out, but yes, that's what I had in mind.

--
Mat Martineau
Intel

--===============6679190907484862331==--
