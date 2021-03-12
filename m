Content-Type: multipart/mixed; boundary="===============0572413718872347426=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "mptcp: clean-up the rtx
 path"
Date: Fri, 12 Mar 2021 14:03:55 +0100
Message-ID: <5e0bdf02-db39-cfcc-c099-78db60439d48@tessares.net>
In-Reply-To: ff57363a4812e030679ea4313a8994d2e6d96c07.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8113

--===============0572413718872347426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 12/03/2021 10:35, Paolo Abeni wrote:
> On Fri, 2021-03-12 at 09:35 +0100, Matthieu Baerts wrote:
>> The MPTCP_RETRANSMIT define is 9 and these tests should be testing if
>> BIT(9) is set instead of taking the number 9.
>>
>> This fix is similar to
>> commit fe202ab685d5 ("mptcp: fix bit MPTCP_PUSH_PENDING tests") by Dan
>> Carpenter.
>>
>> Luckily everything was OK before because the only other flag that was
>> set was "6", using different bits than "9". Note that BIT(6) is also
>> using different bits than "9".

(...)

> =

> LGTM, thanks for the quick turnaround!

Thank you for the quick review!

- 9afba9d654d0: "squashed" in "mptcp: clean-up the rtx path"
- 9509b50c18f1: "Signed-off-by" + "Co-developed-by"
- Results: 932a56a08a15..92c965f2a9d7

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0572413718872347426==--
