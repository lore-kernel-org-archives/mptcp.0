Content-Type: multipart/mixed; boundary="===============8907919706961138548=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-net] mptcp: fix missing wakeup
Date: Wed, 24 Feb 2021 19:10:00 +0100
Message-ID: <ce1f907f-ced3-e5d2-d2b8-f61a416357b6@tessares.net>
In-Reply-To: dfe2f1fc-d6d7-3a9f-e4f9-e1a3e1cda177@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7945

--===============8907919706961138548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 24/02/2021 17:20, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 24/02/2021 16:58, Paolo Abeni wrote:
>> __mptcp_clean_una() can free write memory and should wake-up
>> user-space processes when needed.
>>
>> When such function is invoked by the MPTCP receive path, the wakeup
>> is not needed, as the TCP stack will later trigger subflow_write_space
>> which will do the wakeup as needed.
>>
>> Other __mptcp_clean_una() call sites need an additional wakeup check
>> Let's bundle the relevant code in a new helper and use it.
> =

> Thank you for the patch!
> =

>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/165
> =

> After a few iterations of mptcp_join.sh with only the test #11 ("signal =

> addresses" - after having modified mptcp_join.sh to do only that), =

> everything seems good, thanks for the fix! :-)
> =

> Tested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

All good even with the real test #11! ("multiple flows, signal, link =

failure")

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8907919706961138548==--
