Content-Type: multipart/mixed; boundary="===============8852642916186885672=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] selftests: mptcp: support capture with
 other options
Date: Tue, 09 Mar 2021 23:27:23 +0100
Message-ID: <174ef962-253e-6e72-1a9a-0e9229f8b24a@tessares.net>
In-Reply-To: 2cea1861-6798-da83-432c-7cc4868fec5@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8082

--===============8852642916186885672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 08/03/2021 20:11, Mat Martineau wrote:
> =

> On Mon, 8 Mar 2021, Matthieu Baerts wrote:
> =

>> A capture was not started when multiple short options were combined,
>> e.g.
>>
>> =C2=A0./mptcp_join.sh -fc
>>
>> A regex is now used to handle this case.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>
>> Notes:
>> =C2=A0=C2=A0 If we want to reduce the number of commits, we might want t=
o squash =

>> this
>> =C2=A0=C2=A0 one in "selftests: mptcp: Restore packet capture option in =
join tests"
>> =C2=A0=C2=A0 commit we have in our tree.
>> =C2=A0=C2=A0 Either is fine for me.
>>
> =

> Thanks for fixing that - would be best to squash it, please update tags =

> for attribution!

Thank you for the review!

- e2c177867c77: "squashed" in "selftests: mptcp: Restore packet capture =

option in join tests"
- 9d1789345096: "Signed-off-by" + "Co-developed-by"
- Results: 433f124e57a9..808bd0248f2f

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8852642916186885672==--
