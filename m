Content-Type: multipart/mixed; boundary="===============2713332544384036244=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: refactor shudown/close
Date: Thu, 09 May 2019 13:30:08 +0200
Message-ID: <1618f3ac-53a2-0b23-da21-cb4073140e3b@tessares.net>
In-Reply-To: f9259a5a644f8316c889bf6d4a5960d0d5a0cf4b.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1133

--===============2713332544384036244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Paolo,

Thank you for the patch, the review and the great explanations!

On 09/05/2019 10:27, Paolo Abeni wrote:
> Hi,
> =

> On Wed, 2019-05-08 at 17:45 -0700, Mat Martineau wrote:
>> On Wed, 8 May 2019, Paolo Abeni wrote:
>>
>>> Move the subflows list flushing to a dedicated helper, and use a plain
>>> list_head for list entries.
>>>
>>> This solves the scheduling while atomic splat on shutdown, but retain
>>> the RCU locking (and the need for synchronize RCU). The helper should
>>> simplify changing the locking schema on a later patch.
>>
>> This seems like the right direction, but on my test VM it makes all the =

>> self tests fail with "copyfd_io: poll timed out" messages. I haven't =

>> enabled more debug output yet to figure out what's going on.
> =

> This looks like the "unrelated issue" I mentioned in my previous patch.

Is it then OK for you if I squash this in the mentioned commit?

Cheers,
Matthieu

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============2713332544384036244==--
