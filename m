Content-Type: multipart/mixed; boundary="===============5599352438251712295=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] tcp: fix syn cookied MPTCP request socket leak
Date: Fri, 02 Oct 2020 11:12:06 +0200
Message-ID: <873c3b3b-1940-abb1-6164-265d9b2e1d42@tessares.net>
In-Reply-To: CA+WQbwsVq8n6-0f6qun9q2cVjTyXO3Nk72jCGQ536Y79ueLKsg@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6149

--===============5599352438251712295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Geliang,

On 02/10/2020 01:31, Geliang Tang wrote:
> Hi Paolo,
> =

> Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:32=E5=86=99=E9=81=93=EF=BC=9A
>>
>> If a syn-cookies request socket don't pass MPTCP-level
>> validation done in syn_recv_sock(), we need to release
>> it immediatelly, or it will be leaked.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/89
>> Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in=
 use")
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> --
>> Note: I still see some mptcp_join.sh self-tests failures, but
>>   I can observe them with and without this patch
> =

> Thanks, I have tested this patch, it works.
> =

> Reported-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>

Thank you for the patch and the validation!

I just added it to our Git tree with Geliang's tag, my Reviewed-by tag =

and I fixed a typo reported by checkpatch --codespell (immediatelly):

- 43495174d6ac: tcp: fix syn cookied MPTCP request socket leak

Tests + export have been queued. It might take ~1h to get the results.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5599352438251712295==--
