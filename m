Content-Type: multipart/mixed; boundary="===============1406323093607667777=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] Revert tcp_skb_cb to it's original size and
 cleanup main TCP Rx code from MPTCP specific code.
Date: Tue, 27 Jun 2017 16:35:19 -0700
Message-ID: <alpine.OSX.2.21.1706271623190.10721@jvshah-mobl3.amr.corp.intel.com>
In-Reply-To: 613f420f-a82e-2a7e-38bc-143578a9305a@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 59

--===============1406323093607667777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Rao,

On Tue, 27 Jun 2017, Rao Shoaib wrote:

> I am actually wondering how folks do code review on Linux based on the =

> patch that is submitted. There is no context diff or anything else, I am =

> used to very sophisticated tools.

When I'm dealing with a large patch or a lot of unfamiliar context, I =

usually apply the patches to a branch in a git workspace and work from =

there. I export the email (or patch set email thread) to an mbox file and =

use 'git am' to apply them as regular git commits. This does still require =

typing and reading reviews in an email client, but it's helpful to have my =

usual set of tools for diffs and searching.

--
Mat Martineau
Intel OTC

--===============1406323093607667777==--
