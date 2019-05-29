Content-Type: multipart/mixed; boundary="===============2207821932949375715=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp v4] mptcp: switch sublist to mptcp socket
 lock protection
Date: Wed, 29 May 2019 17:40:36 +0200
Message-ID: <ceba6ece-fc88-d81b-4431-48cbafc64c58@tessares.net>
In-Reply-To: ce4256d7830e49e2e4bc0842457df164282b0751.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1266

--===============2207821932949375715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo, Mat, Peter,

On 29/05/2019 01:49, Peter Krystad wrote:
> On Tue, 2019-05-28 at 17:57 +0200, Matthieu Baerts wrote:
>> Hi Florian, Paolo,
>>
>> Thank you for the new version of the patch and the review!
>>
>> Hi Peter, Mat,
>>
>> I know you were interested by (re-)reviewing this patch. Is it also
>> looking good to you? If you don't have time to look at it now, maybe we
>> can already apply it in our repo as it is a consequent patch and propose
>> fixes later. WDYT?
> =

> I'm fine with v4 of this change.

Again, thank you for the patch and the review.

Just added at the end:

https://github.com/multipath-tcp/mptcp_net-next/commits/export

And kselftests are OK:

	ok 1 selftests: mptcp: mptcp_connect.sh

Cheers,
Matt

> Peter.
> =

>> Cheers,
>> Matt
>>
>> On 28/05/2019 11:38, Paolo Abeni wrote:
>>> Hi all,
>>>
>>> On Mon, 2019-05-27 at 00:24 +0200, Florian Westphal wrote:
>>>> The mptcp sublist is currently guarded by rcu, but this comes with
>>>> several artifacts that make little sense.
>>>>
>>>> 1. There is a synchronize_rcu after stealing the subflow list on
>>>>    each mptcp socket close.
>>>>
>>>>    synchronize_rcu() is a very expensive call, and should not be
>>>>    needed.
>>>>
>>>> 2. There is a extra spinlock to guard the list, ey we can't use
>>>>    the lock in some cases because we need to call functions that
>>>>    might sleep.
>>>>
>>>> 3. There is a 'mptcp_subflow_hold()' function that uses
>>>>    an 'atomic_inc_not_zero' call.  This wasn't needed even with
>>>>    current code:  The owning mptcp socket holds references on its
>>>>    subflows, so a subflow socket that is still found on the list
>>>>    will always have a nonzero reference count.
>>>>
>>>> This changes the subflow list to always be guarded by the owning
>>>> mptcp socket lock.  This is safe as long as no code path that holds
>>>> a mptcp subflow tcp socket lock will try to lock the owning mptcp
>>>> sockets lock.
>>>>
>>>> The inverse -- locking the tcp subflow lock while holding the
>>>> mptcp lock -- is fine.
>>>>
>>>> mptcp_subflow_get_ref() will have to be altered later when we
>>>> support multiple subflows so it will pick a 'preferred' subflow
>>>> rather than the first one in the list.
>>>>
>>>> v4: - remove all sk_state changes added in v2/v3, they do not
>>>>     belong here -- it should be done as a separate change.
>>>>     - prefer mptcp_for_each_subflow rather than list_for_each_entry.
>>>>
>>>> v3: use BH locking scheme in mptcp_finish_connect, there is no
>>>>     guarantee we are always called from backlog processing.
>>>>
>>>> Signed-off-by: Florian Westphal <fw(a)strlen.de>
>>>
>>> LGTM, thanks Florian.
>>>
>>> Paolo
>>>
>>> _______________________________________________
>>> mptcp mailing list
>>> mptcp(a)lists.01.org
>>> https://lists.01.org/mailman/listinfo/mptcp
>>>
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============2207821932949375715==--
