Content-Type: multipart/mixed; boundary="===============4463619398421426981=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 3/3] mptcp: retransmit
 ADD_ADDR when timeout
Date: Mon, 21 Sep 2020 19:53:46 +0200
Message-ID: <05497891-40c7-c0d4-0271-5ac24c649a53@tessares.net>
In-Reply-To: b70fa4b2babfb3753750c89b0f3d0298f3c5e121.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5970

--===============4463619398421426981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Paolo

On 21/09/2020 12:24, Paolo Abeni wrote:
> Hi,
> =

> Thank you for the prompt turn-over. There is still a somewhat relevant
> item - the last comment in this patch. The others comments are mostly
> nit picking, but nice to have.
> =

> On Mon, 2020-09-21 at 15:30 +0800, Geliang Tang wrote:
>> This patch implemented the retransmition of ADD_ADDR when no ADD_ADDR
>> echo
>> is received. It added a timer with the announced address. When
>> timeout
>> occurs, ADD_ADDR will be retransmitted.
>>
>> Suggested-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

As discussed on IRC, I just applied this patch + the "squash to" one:

- a972ed5d1ec5: mptcp: add struct mptcp_pm_add_entry
- 39a25e21cbca: mptcp: add sk_stop_timer_sync helper
- e83b080276ea: mptcp: retransmit ADD_ADDR when timeout

Paolo's ACK has been added to these three patches. I applied these =

patches after Geliang' selftests patches because the timeout feature is =

not validated by any kselftests.

- fe8df13fc5d3..8c5acf4c1ab3: result

Note that it would maybe be more interesting to add packetdrill test to =

validate this feature.

Tests + export are going to be started soon.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4463619398421426981==--
