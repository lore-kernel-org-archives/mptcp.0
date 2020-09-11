Content-Type: multipart/mixed; boundary="===============4185281576346982911=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 1/2] Squash-to: "mptcp: allow picking
 different xmit subflows"
Date: Fri, 11 Sep 2020 12:57:35 +0200
Message-ID: <59013220-92f5-77ef-2ef8-b0610e17f4aa@tessares.net>
In-Reply-To: 82a7c126-e2a6-bf73-b50a-261e65fb02cb@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5802

--===============4185281576346982911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 11/09/2020 12:36, Matthieu Baerts wrote:
> Hi Paolo,
> =

> Thank you for the patch!
> =

> On 09/09/2020 15:52, Paolo Abeni wrote:
>> This improves the current packet scheduler for scenarios
>> where the msk sockets is using different links with different
>> bandwith limits.
>>
>> The commit comment should be changed into:
>>
>> """
>> Update the scheduler to less trivial heuristic: cache
>> the last used subflow, and try to send on it a reasonably
>> long burst of data.
>>
>> When the burst or the subflow send space is exhausted, pick
>> the subflow with the lower ratio between write space and
>> send buffer - that is, the subflow with the greater relative
>> amount of free space.
>> """
>>
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> =

> (...)
> =

>> +=C2=A0=C2=A0=C2=A0 /* pick the best backup if no other subflow is activ=
e */
>> +=C2=A0=C2=A0=C2=A0 if (!nr_active)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 send_info[0].ssk =3D send_in=
fo[1].ssk;
>> -=C2=A0=C2=A0=C2=A0 /* use the looked-up subflow if the previusly one ha=
s exauted the =

>> burst
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * or is not writable
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 if (next_ssk && (!free || msk->snd_burst <=3D 0)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msk->last_snd =3D next_ssk;
>> +=C2=A0=C2=A0=C2=A0 pr_debug("msk=3D%p nr_active=3D%d ssk=3D%p:%lld back=
up=3D%p:%lld",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msk, nr_active, send_i=
nfo[0].ssk, send_info[0].ratio,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 send_info[1].ssk, send=
_info[1].ratio);
> =

> We could maybe have this pr_debug before "if (!nr_active)" just above to =

> avoid confusions but that's just a debug print. For me we can apply it =

> like that. I can also move this pr_debug when applying if you want to.

I did this small notification there:

- 88d1a56e2c6f: mptcp: move pr_debug before changes
- 2e7e0cdd7acd..2998848b5594: result

Feel free to revert if you prefer the other way!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4185281576346982911==--
