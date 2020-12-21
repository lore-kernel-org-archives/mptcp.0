Content-Type: multipart/mixed; boundary="===============8002461570935046941=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v4 2/3] mptcp: pm nl: support IPv4
 mapped in v6 addresses
Date: Mon, 21 Dec 2020 12:48:32 +0100
Message-ID: <d28278e6-9961-c9dc-593e-c1b3f5436766@tessares.net>
In-Reply-To: CA+WQbwv2zbaVHv1gVPxbvRXOovJvfO_LNZKf6+8Sfa1w6XF6zQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7232

--===============8002461570935046941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

Thank you for reviewing these patches!

On 21/12/2020 11:16, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B412=
=E6=9C=8819=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=889:07=E5=86=99=E9=
=81=93=EF=BC=9A
>>
>> On one side, we can allow the creation of subflows between v4 mapped in
>> v6 and v4 addresses. For that we look for v4mapped addresses between the
>> local address we want to select and the remote one.
>>
>> On the other side, we also properly deal with received v4mapped
>> addresses, either announced ones or set via Netlink.

(...)

>> @@ -133,8 +138,8 @@ static bool lookup_subflow_by_saddr(const struct lis=
t_head *list,
>>   }
>>
>>   static struct mptcp_pm_addr_entry *
>> -select_local_address(const struct pm_nl_pernet *pernet,
>> -                    struct mptcp_sock *msk)
>> +select_local_address(const struct pm_nl_pernet *pernet, struct mptcp_so=
ck *msk,
>> +                    struct mptcp_addr_info *remote)
>>   {
>>          struct mptcp_pm_addr_entry *entry, *ret =3D NULL;
>>
> =

> I think we should avoid adding a new parameter here, we can call
> remote_address again in this function to get the remote address.

I agree we can build "remote" from the msk but I didn't do it because =

select_local_address() is only used at one place just after having built =

this "remote".
Do you think we still should rebuild "remote"?

>> @@ -144,11 +149,19 @@ select_local_address(const struct pm_nl_pernet *pe=
rnet,
>>                  if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
>>                          continue;
>>
>> +               if (entry->addr.family !=3D remote->family)
> =

> I think we should add a "{" here ...

Do you mean I should add them to avoid ambiguities? Checkpatch and the =

compiler are OK with both but I don't mind changing if it is clearer.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8002461570935046941==--
