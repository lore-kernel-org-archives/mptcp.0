Content-Type: multipart/mixed; boundary="===============2997000444295556577=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Patch does not apply
Date: Thu, 29 Mar 2018 08:40:49 -0700
Message-ID: <alpine.OSX.2.21.1803290816510.35193@mjmartin-mac01.local>
In-Reply-To: ad8326d2-0a99-d265-1ad9-fe8d6e9fcc04@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 466

--===============2997000444295556577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Rao -

On Wed, 28 Mar 2018, Rao Shoaib wrote:

> I am unable to apply the 6th patch.
>
> rshoaib(a)caduceus5:/home/mptcp/sock_mptcp/linux.old(master)$git am =

> "/tmp/mails/[MPTCP] [RFC PATCH 03_16] mptcp: Add MPTCP socket stubs - Mat =

> Martineau <mathew.j.martineau(a)linux.intel.com> - 2018-03-28 1618.eml"
> Applying: mptcp: Add MPTCP socket stubs
> .git/rebase-apply/patch:87: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
>
> rshoaib(a)caduceus5:/home/mptcp/sock_mptcp/linux(master)$git am =

> "/tmp/mails/[MPTCP] [RFC PATCH 06_16] tcp: expose tcp routines and struct=
s =

> for MPTCP - Mat Martineau <mathew.j.martineau(a)linux.intel.com> - 2018-0=
3-28 =

> 1618.eml"
> Applying: tcp: expose tcp routines and structs for MPTCP
> error: patch failed: include/net/inet_common.h:35
> error: include/net/inet_common.h: patch does not apply
> Patch failed at 0001 tcp: expose tcp routines and structs for MPTCP
> The copy of the patch that failed is found in: .git/rebase-apply/patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> rshoaib(a)caduceus5:/home/mptcp/sock_mptcp/linux(master|AM 1/1)$git remot=
e -v
> origin https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.gi=
t =

> (fetch)
> origin https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.gi=
t =

> (push)

If you cloned my git.kernel.org repo (which appears to be the case from =

your 'git remote -v' output), you shouldn't need to apply the patches from =

email. Instead:

$ git checkout -t origin/mptcp-proposal

will get you the commits directly from the git server.


Just to be specific, to apply the patches from email instead of directly =

checking out, you would clone =

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git and =

apply the patches to that repository. In addition, I'm not 100% sure 'git =

am' understands .eml files - the man page for the latest git release =

mentions maildir, mbox, mboxrd, stgit, stgit-series and hg as supported =

email formats.

Hope this helps!

--
Mat Martineau
Intel OTC

--===============2997000444295556577==--
