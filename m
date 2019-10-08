Content-Type: multipart/mixed; boundary="===============6854394647433562457=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Yet another rebase/squash/cleanup proposal
Date: Tue, 08 Oct 2019 17:30:26 +0200
Message-ID: <4ee4e59d-d3b2-0e7c-2eb6-4c0c79ec15af@tessares.net>
In-Reply-To: 20191008152742.GF25052@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2057

--===============6854394647433562457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 08/10/2019 17:27, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> On 08/10/2019 16:48, Florian Westphal wrote:
>>> Here is yet another rebase proposal, I've pushed it here:
>>> https://git.breakpoint.cc/cgit/fw/mptcp-next.git/log/?h=3Dexport_sendms=
g_rebase_13
>>>
>>> Its also accessible via
>>> git fetch git://git.breakpoint.cc/fw/mptcp-next.git export_sendmsg_reba=
se_13
>>>
>>> In short:
>>> - folds two commits
>>> - fixes the kbuild warnings we got with rfcv2
>>> - gets rid of refcounting in mptcp_subflow_get_ref
>>
>> Wow, thanks for the work!
>>
>> Can I re-create the TopGit tree with that? I guess Paolo has already
>> reviewed the changes, right?
> =

> No, Paolo hasn't reviewed them. He suggested the refcount change
> and to check if it helps to squash sendmsg refactor patches,
> but he did not review this yet.

OK thank you for the clarification.
I will recreate the tree after Paolo's ACK.

>> [...]
>>
>>> Full diff of current export (ab35f6c5d8e3ed7a3c9603028d3b67c931af51b0)
>>> and this branch:
>>
>> I guess you mean 0c6f4f183e22dcd15d76ae5779f42e1737c26ddd (tag:
>> export/20191008T114531). The one you mention (tag:
>> export/20191008T010618) is the version from last night, before my rebase
>> I did today.
> =

> Oh, indeed, its 0c6f4f183e22dcd15d76ae5779f42e1737c26ddd.
> =

>> I just checked and I don't see "tcp: Expose tcp struct and routine for
>> MPTCP" and your version of "tcp: Export TCP functions and ops struct"
>> seems OK! All good then :)
> =

> Yes, I forgot to update the sha1 in my email template.

All good, thank you for having checked!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6854394647433562457==--
