Content-Type: multipart/mixed; boundary="===============8039880568702888200=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: MPTCP repository suggestion: 'fixes' and 'fixes-next'
 branches
Date: Sat, 25 Jan 2020 00:13:21 +0100
Message-ID: <20200124231321.GY795@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.2001241405450.44811@ckubisia-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3506

--===============8039880568702888200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> =

> Now that we have a reasonable amount of code in net-next (and, soon enoug=
h,
> in https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git), it wo=
uld
> help to have a couple of branches that bypass the topgit tree:
> =

> fixes-next: Patches staged for the net-next tree
> fixes: Patches staged for the net tree

Either that or follow the model used by other sub-maintainers, i.e.

add mptcp.git (tracking net.git), and mptcp-next.git (for net-next).

> This would give a location to share pending changes and run CI. Seem like=
 a
> good idea? I thought we discussed this in a meeting at some point but did=
n't
> see it in the notes.

Yes, good idea.  I do not have a preference of branches vs. completely
distinct trees.
--===============8039880568702888200==--
