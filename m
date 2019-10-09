Content-Type: multipart/mixed; boundary="===============0177439721731850341=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Yet another rebase/squash/cleanup proposal
Date: Wed, 09 Oct 2019 09:43:09 +0200
Message-ID: <24d17ab7-f320-75d5-7b00-f211a6e00466@tessares.net>
In-Reply-To: 0dcd0966e91af6124ebccf286c893bc0d27b2c2a.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2065

--===============0177439721731850341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 09/10/2019 09:42, Paolo Abeni wrote:
> On Tue, 2019-10-08 at 17:28 +0200, Paolo Abeni wrote:
>> On Tue, 2019-10-08 at 17:20 +0200, Matthieu Baerts wrote:
>>> Hi Florian,
>>>
>>> On 08/10/2019 16:48, Florian Westphal wrote:
>>>> Hi.
>>>>
>>>> Here is yet another rebase proposal, I've pushed it here:
>>>> https://git.breakpoint.cc/cgit/fw/mptcp-next.git/log/?h=3Dexport_sendm=
sg_rebase_13
>>>>
>>>> Its also accessible via
>>>> git fetch git://git.breakpoint.cc/fw/mptcp-next.git export_sendmsg_reb=
ase_13
>>>>
>>>> In short:
>>>> - folds two commits
>>>> - fixes the kbuild warnings we got with rfcv2
>>>> - gets rid of refcounting in mptcp_subflow_get_ref
>>>
>>> Wow, thanks for the work!
>>>
>>> Can I re-create the TopGit tree with that? I guess Paolo has already
>>> reviewed the changes, right?
>>
>> I'm still reviewing it. So far so good. I will add an explicit ack here
>> when completed.
> =

> The squash LGTM,
> =

> refcount changes look good and correct

Thank you for your review!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0177439721731850341==--
