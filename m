Content-Type: multipart/mixed; boundary="===============1275200910547326059=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 4th of March 2021
Date: Sat, 06 Mar 2021 08:50:44 +0100
Message-ID: <c5846e56-5c37-91a7-8be4-504195d8da92@tessares.net>
In-Reply-To: CA+WQbwuZsU8WR6vswpDixm6Q46Y_QO_768oi0RHEra80BtHPzQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8058

--===============1275200910547326059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 05/03/2021 03:28, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2021=E5=B9=B43=
=E6=9C=885=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:40=E5=86=99=E9=81=
=93=EF=BC=9A

(...)

>>       - We will need to modify the IPRoute code too to delete the ID 0:
>> we need to specify the ADDR:
>>           - for ID0, we can have different addresses (it depends on the
>> interface)
>>           - it is different from the other IDs
>>           - we then need a special case
>>           - which is done with pm utility in the selftests but not in
>> IPRoute2 yet
>>           - *Geliang* : do you plan to do it? Should we create a new
>> ticket for this part?
>>
> =

> Hi Matt, I didn't plan to do this since I'm not good at modifying the
> IPRoute code. Please add a new ticket and close #140.

I'm sure you would be good at it :)
But anyway, it makes sense to open a new ticket just for that and close =

#140 once the different kernel patches have been merged. So here is the =

new ticket:

   https://github.com/multipath-tcp/mptcp_net-next/issues/171

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1275200910547326059==--
