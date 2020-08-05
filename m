Content-Type: multipart/mixed; boundary="===============6200860641259458102=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: be careful on subflow creation
Date: Wed, 05 Aug 2020 11:14:25 +0200
Message-ID: <6fa22193-b14d-e006-9128-aa2c77ca6147@tessares.net>
In-Reply-To: e197f22c62d4f1b78cee4f8a2a9b55a6bc807ede.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5476

--===============6200860641259458102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 05/08/2020 11:10, Paolo Abeni wrote:
> On Tue, 2020-08-04 at 21:25 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 04/08/2020 18:31, Paolo Abeni wrote:
>>> Nicolas reported the following oops:
>>
>> (...)
>>
>>> on some unconventional configuration.
>>>
>>> The MPTCP protocol is trying to create a subflow for an
>>> unaccepted server socket. That is allowed by the RFC, even
>>> if subflow creation will likely fail.
>>> Unaccepted sockets have still a NULL sk_socket field,
>>> avoid the issue by failing earlier.
>>>
>>> Reported-and-tested-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.n=
et>
>>> Fixes: 7d14b0d2b9b3 ("mptcp: set correct vfs info for subflows")
>>
>> Thank you for the patch, the addition in the code looks very good to me!
>>
>> But are you sure the commit you mention introduces the issue you fix her=
e?
> =

> AFAICS, the oops can be observed only with the mentioned commit - which
> unconditioanlly de-reference a NULL sk->sk_socket. [try to] create a
> subflow on server unaccepted socket is not a bug per-se, so I would not
> send the fix to older trees.

Sorry, my bad, I didn't see that in the mentioned commit, we were using =

sk->sk_socket without checking if it was not NULL...
Thank you for pointing that to me!

Bad idea to review patches on the evening :)

The patch is then good to go to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6200860641259458102==--
