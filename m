Content-Type: multipart/mixed; boundary="===============3982561406701215339=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 1/2] mptcp: convert IPv4
 address to IPv4-mapped
Date: Sat, 19 Dec 2020 09:51:33 +0100
Message-ID: <e5913768-0ad4-042e-689f-a5f3cbbe06b9@tessares.net>
In-Reply-To: 20201218112718.GA11566@MiBook
X-Status: 
X-Keywords:                  
X-UID: 7225

--===============3982561406701215339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 18/12/2020 12:27, Geliang Tang wrote:
> Hi Matt,
> =

> On Fri, Dec 18, 2020 at 12:06:51AM +0100, Matthieu Baerts wrote:
>> Hi Geliang, Mat,
>>
>> On 17/12/2020 01:23, Mat Martineau wrote:
>>> On Wed, 16 Dec 2020, Geliang Tang wrote:
>>>
>>>> Currently, PM doesn't create subflow with IPv4-mapped IPv6 socket. This
>>>> patch converts the IPv4 address to IPv4-mapped IPv6 address to fix it.
>>>>
>>>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>>>> ---
>>>> net/mptcp/pm_netlink.c | 25 ++++++++++++++++++++++---
>>>> 1 file changed, 22 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>>> index cc4ca013a06b..987e83cdee11 100644
>>>> --- a/net/mptcp/pm_netlink.c
>>>> +++ b/net/mptcp/pm_netlink.c
>>>> @@ -145,6 +158,8 @@ select_local_address(const struct pm_nl_pernet
>>>> *pernet,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(entry->addr.flags & =
MPTCP_PM_ADDR_FLAG_SUBFLOW))
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
ntinue;
>>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_pm_addr_convert_v4ma=
pped(msk, &entry->addr);
>>>> +
>>>
>>> This is modifying the contents of pernet->local_addr_list, not a copy of
>>> the entry, when the msk has a v4mapped address. I'm not sure that's the
>>> way to fix this, and might leave some corner cases unaddressed.
>>>
>>> Did you look at modifying addresses_equal() so it can detect equivalent
>>> IPv4 and v4mapped addresses?
>>
>> Maybe something like that the patch I joined?
>>
>> I didn't try much but maybe more what we want?
> =

> Thanks for your help. Your patch is much better than mine. I added your
> code in v3 with only a slightly change in addresses_equal. I added your
> Co-developed-by tag in v3 if you don't mind:

Of course I don't mind, that's the proper tag when a code is modified by =

different people!

> @@ -66,12 +66,11 @@ static bool addresses_equal(const struct mptcp_addr_i=
nfo *a,
>   #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>                  else
>                          addr_equals =3D !ipv6_addr_cmp(&a->addr6, &b->ad=
dr6);
> -       } else if (a->family =3D=3D AF_INET6) {
> -               if (b->family =3D=3D AF_INET && ipv6_addr_v4mapped(&a->ad=
dr6))
> -                       addr_equals =3D a->addr6.s6_addr32[3] =3D=3D b->a=
ddr.s_addr;
> -       } else if (b->family =3D=3D AF_INET6) {
> +       } else {
>                  if (a->family =3D=3D AF_INET && ipv6_addr_v4mapped(&b->a=
ddr6))
>                          addr_equals =3D a->addr.s_addr =3D=3D b->addr6.s=
6_addr32[3];
> +               if (b->family =3D=3D AF_INET && ipv6_addr_v4mapped(&a->ad=
dr6))
> +                       addr_equals =3D a->addr6.s6_addr32[3] =3D=3D b->a=
ddr.s_addr;

I will need to check to verify if we can safely assume that if the =

families are not the same, the only possibility is one in v4 and the =

other one in v6. If we cannot assume that, we cannot really call =

ipv6_addr_v4mapped() without checking if it is v6. Could we have there a =

non initialised one (family =3D=3D 0)? Or something else?

>   #endif
>          }
> =

> And I added the following code in mptcp_info2sockaddr to deal with the
> IPv4-mapped back to IPv4 case too:

I see, good point!
But now I wonder if we need to support v4mapped addresses on the PM =

side. This seems to increase the complexity because the PM would then =

have to check if the local address is v4, v4 mapped in a v6 or a real =

v6. Just to avoid asking to connect from a (real) v6 to v4 or the opposite.

> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1082,7 +1082,10 @@ static void mptcp_info2sockaddr(const struct mptcp=
_addr_info *info,
>          if (addr->ss_family =3D=3D AF_INET) {
>                  struct sockaddr_in *in_addr =3D (struct sockaddr_in *)ad=
dr;
> =

> -               in_addr->sin_addr =3D info->addr;
> +               if (info->family =3D=3D AF_INET)
> +                       in_addr->sin_addr =3D info->addr;
> +               else
> +                       in_addr->sin_addr.s_addr =3D info->addr6.s6_addr3=
2[3];

Link to my previous comment: we might need to be careful that if "info" =

has a real IPv6 address, we will not do what we want here.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3982561406701215339==--
