Content-Type: multipart/mixed; boundary="===============1390148068381728466=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: refactor shudown/close
Date: Thu, 09 May 2019 14:45:13 +0200
Message-ID: <a6a7ecb5-f35d-2595-47fb-a2b8c71b9e04@tessares.net>
In-Reply-To: 2c4e61ec1ba611e36ee47f88a91e5118508d617d.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1135

--===============1390148068381728466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/05/2019 14:29, Paolo Abeni wrote:
> On Thu, 2019-05-09 at 13:30 +0200, Matthieu Baerts wrote:
>> On 09/05/2019 10:27, Paolo Abeni wrote:
>>> Hi,
>>>
>>> On Wed, 2019-05-08 at 17:45 -0700, Mat Martineau wrote:
>>>> On Wed, 8 May 2019, Paolo Abeni wrote:
>>>>
>>>>> Move the subflows list flushing to a dedicated helper, and use a plain
>>>>> list_head for list entries.
>>>>>
>>>>> This solves the scheduling while atomic splat on shutdown, but retain
>>>>> the RCU locking (and the need for synchronize RCU). The helper should
>>>>> simplify changing the locking schema on a later patch.
>>>>
>>>> This seems like the right direction, but on my test VM it makes all th=
e =

>>>> self tests fail with "copyfd_io: poll timed out" messages. I haven't =

>>>> enabled more debug output yet to figure out what's going on.
>>>
>>> This looks like the "unrelated issue" I mentioned in my previous patch.
>>
>> Is it then OK for you if I squash this in the mentioned commit?
> =

> Whooops, I hope I'm still on time to self-nack this one. The patch has
> indeed some problems: it should not flush nor release the subflow on
> shutdown().
> =

> Since we can't protect the subflows list traversal and kern_shutdown()
> with RCU nor with a spinlock, I think the easier way to fix the
> scheduling-while-atomic issue is moving subflows list traversal (and
> modification, too) under the mptcp socket lock. That would avoid also
> the costly synchronize_rcu() call
Good catch!

Take your time, I was waiting for an approval before adding the patch in
the repo ;-)

Note that I am sure it is fine to add fixes of fixes in our repo :-)

Cheers,
Matthieu
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1390148068381728466==--
