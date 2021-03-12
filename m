Content-Type: multipart/mixed; boundary="===============5810286304004719370=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] selftests: mptcp: avoid calling
 pm_nl_ctl with bad IDs
Date: Fri, 12 Mar 2021 17:06:12 +0100
Message-ID: <29b7ee8f-25c1-e719-d43b-2471fb0ac769@tessares.net>
In-Reply-To: CA+WQbwuTn0pSGr7+eaD9zNDQYX+MN3ZoguYCW5RamkyfC1MneA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8123

--===============5810286304004719370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 12/03/2021 16:27, Geliang Tang wrote:
> Hi Matt,
> =

> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B43=
=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:14=E5=86=99=E9=
=81=93=EF=BC=9A
> =

>>
>> IDs are supposed to be between 0 and 255.
>>
>> In pm_nl_ctl, for both the 'add' and 'get' instruction, the ID is casted
>> in a u_int8_t. So if we give 256, we will delete ID 0. Obviously, the
>> goal is not to delete this ID by giving 256.
>>
>> We could modify pm_nl_ctl and stop if the ID is negative or higher than
>> 255 but probably better not to increase the number of lines for such
>> things in this tool which is only used in selftests. Instead, we use it
>> within the limits.
>>
>> This modification also means that we will no longer add a new ID for the
>> 2nd entry. That's why we removed an expected entry from the dump and
>> introduced with
>> commit dc8eb10e95a8 ("selftests: mptcp: add testcases for setting the ad=
dress ID").
>>
>> So now we delete ID 9 like before and we add entries for IDs 10 to 255
>> that are deleted just after.
>>
>> Note that this could be seen as a fix but it was not really an issue so
>> far: we were simply playing with ID 0/1 once again. With the following
>> commit ("selftests: mptcp: add addr argument for del_addr"), it will be
>> different because ID 0 is going to required an address. We don't want
>> errors when trying to delete ID 0 without the address argument.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> =

> Thanks for your patch.
> =

> Acked-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>

Thank you for the review and the validation!

Now in our tree just before "selftests: mptcp: add testcases for setting =

the address ID" commit:

- efefe960f11c: selftests: mptcp: avoid calling pm_nl_ctl with bad IDs
- Results: 92c965f2a9d7..833f13d2c126

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5810286304004719370==--
