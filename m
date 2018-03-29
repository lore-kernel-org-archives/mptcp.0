Content-Type: multipart/mixed; boundary="===============2040857095286325515=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Patch does not apply
Date: Wed, 28 Mar 2018 18:46:20 -0700
Message-ID: <ad8326d2-0a99-d265-1ad9-fe8d6e9fcc04@oracle.com>
In-Reply-To: 20180328231840.12410-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 462

--===============2040857095286325515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I am unable to apply the 6th patch.

rshoaib(a)caduceus5:/home/mptcp/sock_mptcp/linux.old(master)$git am =

"/tmp/mails/[MPTCP] [RFC PATCH 03_16] mptcp: Add MPTCP socket stubs - =

Mat Martineau <mathew.j.martineau(a)linux.intel.com> - 2018-03-28 1618.eml"
Applying: mptcp: Add MPTCP socket stubs
.git/rebase-apply/patch:87: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

rshoaib(a)caduceus5:/home/mptcp/sock_mptcp/linux(master)$git am =

"/tmp/mails/[MPTCP] [RFC PATCH 06_16] tcp: expose tcp routines and =

structs for MPTCP - Mat Martineau <mathew.j.martineau(a)linux.intel.com> - =

2018-03-28 1618.eml"
Applying: tcp: expose tcp routines and structs for MPTCP
error: patch failed: include/net/inet_common.h:35
error: include/net/inet_common.h: patch does not apply
Patch failed at 0001 tcp: expose tcp routines and structs for MPTCP
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

rshoaib(a)caduceus5:/home/mptcp/sock_mptcp/linux(master|AM 1/1)$git remote =
-v
origin =

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git (fetch)
origin =

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git (push)

Shoaib


--===============2040857095286325515==--
