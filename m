Content-Type: multipart/mixed; boundary="===============1564390018708677968=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add addr
 argument for del_addr"
Date: Fri, 12 Mar 2021 15:36:49 +0100
Message-ID: <06e6c623-6f6f-d1b4-247e-020f4e65295c@tessares.net>
In-Reply-To: CA+WQbwvjLR2ZFH36oTe1CnEgy8dicqxwj4rUk7cQYRuF3KM=yQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8118

--===============1564390018708677968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 12/03/2021 15:28, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B43=
=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8810:11=E5=86=99=E9=
=81=93=EF=BC=9A
>> On 12/03/2021 15:06, Geliang Tang wrote:
>>> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B4=
3=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:54=E5=86=99=E9=
=81=93=EF=BC=9A

(...)

>>>> Notes:
>>>>       to be squashed in "selftests: mptcp: add addr argument for del_a=
ddr"
>>>
>>> I think this patch should be a single standalone patch, not a squash-to
>>> one.
>>
>> If I do the modification you propose, should I not keep this as a
>> squash-to patch?
> =

> I think a standalone patch is better. Or squash to the other commit
> "selftests: mptcp: remove id 0 address testcases", not "selftests: mptcp:
> add addr argument for del_addr", WDYT?

The issue was visible with "selftests: mptcp: add addr argument for =

del_addr" but I understand the issue was already there before.

I can write a new patch to place before "selftests: mptcp: remove id 0 =

address testcases".

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1564390018708677968==--
