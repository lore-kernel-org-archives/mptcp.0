Content-Type: multipart/mixed; boundary="===============6088875017777332943=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-net] mptcp: fix missing wakeup
Date: Thu, 25 Feb 2021 15:25:54 +0100
Message-ID: <6e0206d4-d852-6f31-4759-fd7f2060e157@tessares.net>
In-Reply-To: 4d31b9f59807913ba3eacf71dc939177027d6f5d.1614182254.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7954

--===============6088875017777332943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 24/02/2021 16:58, Paolo Abeni wrote:
> __mptcp_clean_una() can free write memory and should wake-up
> user-space processes when needed.
> =

> When such function is invoked by the MPTCP receive path, the wakeup
> is not needed, as the TCP stack will later trigger subflow_write_space
> which will do the wakeup as needed.
> =

> Other __mptcp_clean_una() call sites need an additional wakeup check
> Let's bundle the relevant code in a new helper and use it.

Thank you for the patch and the review! Now in our tree with Mat's RvB tag:

- 72f44322c161: mptcp: fix missing wakeup
- Results: 12ba6e545134..de59595c18b3

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6088875017777332943==--
