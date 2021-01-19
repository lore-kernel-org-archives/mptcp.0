Content-Type: multipart/mixed; boundary="===============2464898113374875594=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: net-next currently broken ?!?
Date: Tue, 19 Jan 2021 11:13:44 +0100
Message-ID: <596012dc-0c29-5563-40fb-f117d3ce0476@tessares.net>
In-Reply-To: CA+WQbwu0PBEySU6h0SEahJgiS_UvixCCQUZy-iAkH-EZTzJUHw@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7421

--===============2464898113374875594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 19/01/2021 05:22, Geliang Tang wrote:
> Hi Paolo,
> =

> Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8819=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=887:07=E5=86=99=E9=81=93=EF=BC=9A
>>
>> (or it's just me lacking coffee?!?)
>>
>> I just tried plain net-next at
>>
>> commit 213b97b125808aa220ba460a7af09d8f3772f669
>> Merge: 20efd2c79afb 1fef8544bf41
>> Author: Jakub Kicinski <kuba(a)kernel.org>
>> Date:   Sat Jan 16 19:06:01 2021 -0800
>>
>>      Merge branch 'net-fix-the-features-flag-in-sctp_gso_segment'
>>
>> selftests mptcp_connect.sh randomly fail with data corruption: the
>> amount of transferred data is correct, the fail contains some chunk of
>> random data.
>>
>> Can anybody else replicate the above?
> =

> I just tested it, and got the mptcp_connect.sh failure too. I'll try to
> find out which commit breaks it today, and give you the feedback.

It is failing for me too.

In fact, my CI also reported the issue but it was "hidden" by another =

one we have (issue #138) :)

It looks like it was introduced recently. Build with 9ab7e76aefc9 ("GTP: =

add support for flow based tunneling API") didn't have this issue but =

213b97b12580 ("Merge branch =

'net-fix-the-features-flag-in-sctp_gso_segment'") had that.

A quick "git bisect" launched during meetings pointed me to: =

dbd50f238dec ("net: move the hsize check to the else block in skb_segment")

If I revert it on top of export, I no longer have the corruption.
Do we need to adapt MPTCP code or is there an issue with this commit?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2464898113374875594==--
