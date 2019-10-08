Content-Type: multipart/mixed; boundary="===============5175193774780699042=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Yet another rebase/squash/cleanup proposal
Date: Tue, 08 Oct 2019 16:33:03 -0700
Message-ID: <alpine.OSX.2.21.1910081620350.38700@crpeter1-mobl.amr.corp.intel.com>
In-Reply-To: 20191008144827.GA12731@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2061

--===============5175193774780699042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 8 Oct 2019, Florian Westphal wrote:

> Hi.
>
> Here is yet another rebase proposal, I've pushed it here:
> https://git.breakpoint.cc/cgit/fw/mptcp-next.git/log/?h=3Dexport_sendmsg_=
rebase_13
>
> Its also accessible via
> git fetch git://git.breakpoint.cc/fw/mptcp-next.git export_sendmsg_rebase=
_13
>
> In short:
> - folds two commits
> - fixes the kbuild warnings we got with rfcv2
> - gets rid of refcounting in mptcp_subflow_get_ref
>
> A full diff between export and this new branch is below.
>

Florian -

Thanks for updating the patch series. The refcounting change makes sense =

to me, and I don't see any code issues.

I pushed the branch to my repo to trigger an automated kbuild, and will =

share the results if any errors are generated.

--
Mat Martineau
Intel
--===============5175193774780699042==--
