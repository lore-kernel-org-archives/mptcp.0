Content-Type: multipart/mixed; boundary="===============4524259602292281972=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] crypto: refactor sha code
Date: Fri, 22 Nov 2019 17:47:18 +0100
Message-ID: <bad06b40-dd69-3f76-fa29-63408fe5d33f@tessares.net>
In-Reply-To: abff213ce18a292773abcbb848deb5ccb95f9900.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2668

--===============4524259602292281972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 22/11/2019 17:41, Paolo Abeni wrote:
> On Fri, 2019-11-22 at 17:26 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 22/11/2019 15:30, Paolo Abeni wrote:
>>> On Fri, 2019-11-22 at 15:26 +0100, Paolo Abeni wrote:
>>>> patch 1/4 refactor the crypto code to make it easier transitioning to
>>>> sha256. It includes feedback from Peter about helper renaming.
>>
>> Thank you for this new version!
>>
>> It looks good to me after a very very quick review (but the first patch
>> is hard to read).
>>
>>>> The following patches update the rest of the tree to the new helper na=
me.
>>>> Overall this should generate 3 conflicts along the rebase.
>>>
>>> Addendum:
>>>
>>> The squashed tree is avaialble here:
>>>
>>> https://github.com/pabeni/mptcp/tree/sha_cleanup_2
>>>
>>> I verified the new code ensuring that the genrated seq number matched
>>> the expectation of the wireshark dissector.
>>
>> Great!
>>
>> Because it looks OK and you checked different stuffs, do you want me to:
>> - replace the tree with the commits from your branch? (if needed, we can
>> of course do other fixes later)
>> - stop the CI job, wait for a proper review and then replace the tree?
>> - or wait for a proper review and then I apply the changes, looking at
>> your branch in case of conflict but doing all of that with TopGit to
>> ease the review? :)
> =

> I think the first 2 options are the better ones.
> =

> It would be nice if someone give this an additional review ;)

OK for me!

I just paused the CI job then. I hope not for too long :-)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4524259602292281972==--
