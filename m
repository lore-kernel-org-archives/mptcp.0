Content-Type: multipart/mixed; boundary="===============7681078291652307798=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 2/3] mptcp: fix race in release_cb
Date: Tue, 09 Feb 2021 15:26:14 +0100
Message-ID: <535bc837-9663-5315-22a3-96354c1040f1@tessares.net>
In-Reply-To: 25ae0379-e557-22ac-7a0c-0a6289d3d454@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7708

--===============7681078291652307798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/02/2021 15:22, Matthieu Baerts wrote:
> Hi Paolo,
> =

> Thank you for the patch!
> =

> On 09/02/2021 12:42, Paolo Abeni wrote:
>> If we receive a MPTCP_PUSH_PENDING even from a subflow when
>> mptcp_release_cb() is serving the previous one, the latter
>> will be delayed up to the next release_sock(msk).
>>
>> Address the issue implementing a test/serve loop for such
>> event.
>>
>> Additionally rename the push helper to __mptcp_push_pending()
>> to be more consistent with the existing code.
> =

> (...)
> =

>> @@ -2942,13 +2942,14 @@ static void mptcp_release_cb(struct sock *sk)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags, nflags;
>> -=C2=A0=C2=A0=C2=A0 /* push_pending may touch wmem_reserved, do it befor=
e the later
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * cleanup
>> -=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 if (test_and_clear_bit(MPTCP_CLEAN_UNA, &mptcp_sk(sk=
)->flags))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __mptcp_clean_una(sk);
>> -=C2=A0=C2=A0=C2=A0 if (test_and_clear_bit(MPTCP_PUSH_PENDING, &mptcp_sk=
(sk)->flags)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* mptcp_push_pending() acqu=
ires the subflow socket lock
>> +=C2=A0=C2=A0=C2=A0 for (;;) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_and_clear_bit(MPTCP=
_PUSH_PENDING, =

>> &mptcp_sk(sk)->flags))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flag=
s |=3D MPTCP_PUSH_PENDING;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!flags)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
> =

> This looks strange: "flags" is reset to 0 then set if the previous =

> condition is valid and we check what was done at the previous =

> instruction. Maybe clearer with "else" instead of "if (!flags)"?

My bad, I understand why after having looked at the next patch! I hit =

the send button too fast :)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7681078291652307798==--
