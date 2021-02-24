Content-Type: multipart/mixed; boundary="===============4056148291745480635=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-net] mptcp: fix missing wakeup
Date: Wed, 24 Feb 2021 17:20:47 +0100
Message-ID: <dfe2f1fc-d6d7-3a9f-e4f9-e1a3e1cda177@tessares.net>
In-Reply-To: 4d31b9f59807913ba3eacf71dc939177027d6f5d.1614182254.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7940

--===============4056148291745480635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

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

Thank you for the patch!

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/165

After a few iterations of mptcp_join.sh with only the test #11 ("signal =

addresses" - after having modified mptcp_join.sh to do only that), =

everything seems good, thanks for the fix! :-)

Tested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4056148291745480635==--
