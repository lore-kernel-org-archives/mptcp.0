Content-Type: multipart/mixed; boundary="===============0203876839338000415=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 0/2] mptcp: fix deadlock in mptcp{,6}_release
Date: Wed, 03 Mar 2021 10:01:03 +0100
Message-ID: <ebe68b51-8bec-a4cb-d68b-0ee758659be0@tessares.net>
In-Reply-To: b4c859e-ee94-8a8c-5ded-e9b7788f57f9@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7990

--===============0203876839338000415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 03/03/2021 02:56, Mat Martineau wrote:
> On Tue, 2 Mar 2021, Paolo Abeni wrote:
> =

>> This address the issue the easy way: removing the bugged feature
>> (mcast support :).
>>
>> AFAICS the mcast related sockopt manipulate a global state, so there
>> could be existing working application doing setsockopt(mcast opt) on
>> TCP sockets. This is why I did not disable mcast at the inet level
>> for stream sockets.
>>
>> Still I'm wondering if we should take the opposite approach: explicitly
>> forbitting all setsockopt except the one we implement in
>> net/mptcp/protocol.c
>>
> =

> I think there was mailing list discussion about having an allowed list =

> of SOL_TCP options, but I think applying that idea to the inet level =

> slipped by. It does seem better to only allow the options we implement.

Yes and probably easier to maintain a list of what has been implemented =

and/or validated (who mentioned packetdrill???) than having to block one =

because it can cause warnings or crashes.

BTW thank you for looking at that!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0203876839338000415==--
