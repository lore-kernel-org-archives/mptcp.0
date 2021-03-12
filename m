Content-Type: multipart/mixed; boundary="===============4563826210013686058=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add addr
 argument for del_addr"
Date: Fri, 12 Mar 2021 15:55:47 +0100
Message-ID: <bdb08496-476d-4486-ffca-d97c8bbdb4d7@tessares.net>
In-Reply-To: CA+WQbwucg0LrQMikAjWSLxH8XwemL5K2qaaMv_hXx7smsXENmQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8120

--===============4563826210013686058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 12/03/2021 15:50, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B43=
=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8810:36=E5=86=99=E9=
=81=93=EF=BC=9A
>> On 12/03/2021 15:28, Geliang Tang wrote:
>>> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B4=
3=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8810:11=E5=86=99=E9=
=81=93=EF=BC=9A
>>>> On 12/03/2021 15:06, Geliang Tang wrote:
>>>>> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=
=B43=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:54=E5=86=99=
=E9=81=93=EF=BC=9A
>>
>> (...)
>>
>>>>>> Notes:
>>>>>>        to be squashed in "selftests: mptcp: add addr argument for de=
l_addr"
>>>>>
>>>>> I think this patch should be a single standalone patch, not a squash-=
to
>>>>> one.
>>>>
>>>> If I do the modification you propose, should I not keep this as a
>>>> squash-to patch?
>>>
>>> I think a standalone patch is better. Or squash to the other commit
>>> "selftests: mptcp: remove id 0 address testcases", not "selftests: mptc=
p:
>>> add addr argument for del_addr", WDYT?
>>
>> The issue was visible with "selftests: mptcp: add addr argument for
>> del_addr" but I understand the issue was already there before.
>>
>> I can write a new patch to place before "selftests: mptcp: remove id 0
>> address testcases".
> =

> Thanks Matt, please add my tag on the new patch:
> =

> Acked-by: Geliang Tang <geliangtang(a)gmail.com>

Because the new patch is going to be slightly different, I prefer you to =

give an Acked-by on the new patch if you don't mind :)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4563826210013686058==--
