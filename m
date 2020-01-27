Content-Type: multipart/mixed; boundary="===============7907998009785289180=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: MPTCP repository suggestion: 'fixes' and 'fixes-next'
 branches
Date: Mon, 27 Jan 2020 16:33:17 +0100
Message-ID: <62209241-35a6-73d5-7a9b-084de7ed99b7@tessares.net>
In-Reply-To: 20200124231321.GY795@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3523

--===============7907998009785289180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Florian,

On 25/01/2020 00:13, Florian Westphal wrote:
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>>
>> Now that we have a reasonable amount of code in net-next (and, soon enou=
gh,
>> in https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git), it w=
ould
>> help to have a couple of branches that bypass the topgit tree:
>>
>> fixes-next: Patches staged for the net-next tree
>> fixes: Patches staged for the net tree
> =

> Either that or follow the model used by other sub-maintainers, i.e.
> =

> add mptcp.git (tracking net.git), and mptcp-next.git (for net-next).

Maybe easier to work with branches? It's just because "mptcp.git" repo =

on Github currently points to the out-of-tree implementation. But we can =

also find new names.
The MAINTAINERS file has a ref to "mptcp_net-next.git" repo.

If we go with branches, we can have "fixes-net" and "fixes-net-next" to =

avoid confusions.

We can also put new commits at the "beginning" of the export branch if =

we are not in a hurry.
But I guess in general we don't need TopGit for these fixes because we =

want to send the ones for net and net-next ASAP, we don't plan to stack =

fixes for long.

>> This would give a location to share pending changes and run CI. Seem lik=
e a
>> good idea? I thought we discussed this in a meeting at some point but di=
dn't
>> see it in the notes.
> =

> Yes, good idea.  I do not have a preference of branches vs. completely
> distinct trees.

Sorry, I don't remember about this discussion but indeed, that would be =

easier for the CI if the fixes are stored in Git. Maybe having a hook to =

start a test automatically when one of these branches are updated by one =

of us? We could also rely public CI like Travis if we don't have to =

modify the git repo. The current CI job needs write access.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7907998009785289180==--
