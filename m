Content-Type: multipart/mixed; boundary="===============3874897330713041064=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix bogus sendmsg() return code under
 pressure
Date: Mon, 03 Aug 2020 17:30:33 +0200
Message-ID: <6673051c-6e55-5a2d-6f83-4fb9ea026634@tessares.net>
In-Reply-To: 63d451ecf32a5eb3c2d49ccc5468734be1898a61.1596214315.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5444

--===============3874897330713041064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 31/07/2020 18:53, Paolo Abeni wrote:
> In case of memory pressure, mptcp_sendmsg() may call
> sk_stream_wait_memory() after succesfully xmitting some
> bytes. If the latter fails we currently return to the
> user-space the error code, ignoring the succeful xmit.
> =

> Address the issue always checking for the xmitted bytes
> before mptcp_sendmsg() completes.

Thank you for the patch! It looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3874897330713041064==--
