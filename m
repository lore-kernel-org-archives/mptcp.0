Content-Type: multipart/mixed; boundary="===============5973328197049022298=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp] subflow: place outgoing connections on the
 join list
Date: Tue, 25 Feb 2020 17:28:55 +0100
Message-ID: <5de72499-6b84-229d-e55b-8c06112cb027@tessares.net>
In-Reply-To: 72608929bc3b314de71a87502e091acff140953c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3790

--===============5973328197049022298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 20/02/2020 17:00, Paolo Abeni wrote:
> On Tue, 2020-02-04 at 16:35 +0100, Florian Westphal wrote:
>> squashto: subflow: place further subflows on new 'join_list'
>>
>> in case the subflow can't be established (timeout, reset) the subflow
>> socket is leaked.
>>
>> Add it to the join list for now.  This isn't nice because the socket
>> will be added while its known to not be established, and its not removed
>> at any time even if its not useable.
>>
>> The list_del_init() call can be removed because the subflow context
>> ->node is still unused / not on a list in all cases.
>>
>> On a different note:
>>
>> I think it makes sense to remove the 'splice join to conn list' approach
>> and instead have the worker check the join and conn lists:
>>
>> 1. subflows are added from join to conn list once they are established.
>> 2. subflows on join list that are still in SYN_SENT are ignored
>> 3. subflows on join and/or conn list that are closed already are removed
>> and free'd.
>>
>> Alternatively, we could probably extend the sk_state_change callback
>> to do this and keep checking outside of send/receive code paths.

[...]

> whooops ... this one fell outside my radar for a long time.
> =

> mp_join self-tests (WIP) demonstrated the need for this one!
> =

> LGTM, thanks Florian!

Sorry for the delay, I missed that too at first and got other things =

scheduled after. Please insist if a patch has been reviewed but not =

applied! :)

- f20d350cb8d5: "squashed" in "subflow: place further subflows on new =

'join_list'"
- 676a5c51ff36..8b57e57b1ba4: result

Tests + export are going to be launched soon.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5973328197049022298==--
