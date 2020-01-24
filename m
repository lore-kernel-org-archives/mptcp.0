Content-Type: multipart/mixed; boundary="===============0038683118527880627=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] MPTCP repository suggestion: 'fixes' and 'fixes-next' branches
Date: Fri, 24 Jan 2020 15:08:34 -0800
Message-ID: <alpine.OSX.2.21.2001241405450.44811@ckubisia-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3505

--===============0038683118527880627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Now that we have a reasonable amount of code in net-next (and, soon =

enough, in =

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git), it would =

help to have a couple of branches that bypass the topgit tree:

fixes-next: Patches staged for the net-next tree
fixes: Patches staged for the net tree

This would give a location to share pending changes and run CI. Seem like =

a good idea? I thought we discussed this in a meeting at some point but =

didn't see it in the notes.

--
Mat Martineau
Intel
--===============0038683118527880627==--
